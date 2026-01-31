# Toggle-HDMI-Robust.ps1
# Requires MonitorConfig module
# https://github.com/MartinGC94/MonitorConfig
# Install-Module MonitorConfig

# ----------------------------------
# CONFIGURATION
# ----------------------------------
# Short: Variables you can change to configure which monitor and inputs are used,
#        and whether the script writes a log file.

$EnableLogging = $false                         # Set to $false to disable log file creation
$InstanceName  = 'DISPLAY\ACR09CA\5&1a47702c&0&UID265'
$VCPCode       = 0x60                          # Input source VCP code
$HDMI1         = 0x11
$HDMI2         = 0x12
$LogFile       = "$PSScriptRoot\HDMI_toggle_log.txt"

# ----------------------------------
# LOGGING FUNCTION
# ----------------------------------
# Short: Helper that prints messages to the console and optionally appends them to a log file.

function Log-Message {
    param([string]$Message)

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Line = "$Timestamp - $Message"

    # Always show in console
    Write-Host $Line

    # Only write to file if logging is enabled
    if ($EnableLogging) {
        Add-Content -Path $LogFile -Value $Line
    }
}

# ----------------------------------
# MODULE CHECK
# ----------------------------------
# Short: Ensure the required MonitorConfig module is installed and imported.
if (-not (Get-Module -ListAvailable -Name MonitorConfig)) {
    Write-Host "MonitorConfig module not found. Installing..."
    Install-Module MonitorConfig -Force -Scope CurrentUser
}

Import-Module MonitorConfig -ErrorAction Stop

# ----------------------------------
# MAIN SCRIPT
# ----------------------------------
# Short: The main flow — detects current input, decides which HDMI to switch to,
#        sets display mode briefly for detection, and applies the new input.
try {
    Log-Message "Script started. Checking monitors..."

    # Set extended display first for HDMI detection
    & "C:\Windows\System32\DisplaySwitch.exe" /extend
    Start-Sleep -Seconds 2
    
    # Get monitor object
    $Monitor = Get-Monitor | Where-Object InstanceName -eq $InstanceName
    if ($null -eq $Monitor) {
        Log-Message "ERROR: Monitor not found. Verify connection and instance name."
        exit
    }

    # Read current input source
    $Response = Get-MonitorVCPResponse -Monitor $Monitor -VCPCode $VCPCode
    if ($null -eq $Response) {
        Log-Message "ERROR: Unable to read current input. Ensure DDC/CI is enabled."
        exit
    }

    # Extract numeric value safely
    $CurrentInput = if ($Response.PSObject.Properties.Match('CurrentValue')) {
        $Response.CurrentValue
    } else {
        [int]($Response -replace '[^\d]', '')
    }

    Log-Message "Current input source: $CurrentInput"

    # ----------------------------------
    # SWITCH LOGIC
    # ----------------------------------
    switch ($CurrentInput) {
        $HDMI1 {
            $NewInput = $HDMI2
            Log-Message "Switching to HDMI 2..."
            & "C:\Windows\System32\DisplaySwitch.exe" /internal
            Log-Message "Display mode set to internal only."
            Start-Sleep -Seconds 2
        }
        $HDMI2 {
            $NewInput = $HDMI1
            Log-Message "Switching to HDMI 1..."
            & "C:\Windows\System32\DisplaySwitch.exe" /extend
            Log-Message "Display mode set to extended."
            Start-Sleep -Seconds 2
        }
        default {
            $NewInput = $HDMI1
            Log-Message "Unknown input detected. Defaulting to HDMI 1..."
            & "C:\Windows\System32\DisplaySwitch.exe" /extend
            Log-Message "Display mode set to extended."
            Start-Sleep -Seconds 2
        }
    }

    # Apply the new input source
    Set-MonitorVCPValue -Monitor $Monitor -VCPCode $VCPCode -Value $NewInput
    Log-Message "Input source successfully changed to $NewInput."
    Log-Message "Script finished successfully."

} catch {
    Log-Message "ERROR: $($_.Exception.Message)"
}