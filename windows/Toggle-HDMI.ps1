# Toggle-HDMI-Robust.ps1
# Requires MonitorConfig module
# https://github.com/MartinGC94/MonitorConfig
# Install-Module MonitorConfig

# First ensure MonitorConfig is available and imported
if (-not (Get-Module -ListAvailable -Name MonitorConfig)) {
    Write-Host "MonitorConfig module not found. Installing..."
    Install-Module MonitorConfig -Force -Scope CurrentUser
}
Import-Module MonitorConfig -ErrorAction Stop

# -----------------------------
# CONFIGURATION
# -----------------------------
$monitorPath = "\\.\DISPLAY2"
$instanceName = 'DISPLAY\ACR09CA\5&1a47702c&0&UID265'

$vcpCode = 0x60          # VCP code for input source
$hdmi1 = 0x11            # HDMI 1
$hdmi2 = 0x12            # HDMI 2
$logFile = "$PSScriptRoot\HDMI_toggle_log.txt"

# -----------------------------
# LOGGING FUNCTION
# -----------------------------
function Log-Message($message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "$timestamp - $message"
    Write-Host $line
    Add-Content -Path $logFile -Value $line
}

# -----------------------------
# MAIN SCRIPT
# -----------------------------
try {
    # Set to extended display first for HDMI detection
    & "C:\Windows\System32\DisplaySwitch.exe" /extend
    Start-Sleep -Seconds 2  # Give Windows time to apply the display change
    
    # Get monitor object
    $monitor = Get-Monitor | Where-Object InstanceName -eq $instanceName
    if ($null -eq $monitor) {
        Log-Message "ERROR: Monitor not found. Make sure the monitor is connected and the path is correct."
        exit
    }
    
    # Get current input
    $response = Get-MonitorVCPResponse -Monitor $monitor -VCPCode $vcpCode

    if ($null -eq $response) {
        Log-Message "ERROR: Unable to read current input. Make sure DDC/CI is enabled on the monitor."
        exit
    }

    # Extract numeric value
    $currentInput = if ($response.PSObject.Properties.Match('CurrentValue')) { 
        $response.CurrentValue 
    }
    else { 
        [int]($response -replace '[^\d]', '') 
    }

    Log-Message "Current input source: $currentInput"

    # Decide which HDMI to switch to
    switch ($currentInput) {
        $hdmi1 {
            $newInput = $hdmi2
            Log-Message "Switching to HDMI 2..."
            # Set display to internal only
            & "C:\Windows\System32\DisplaySwitch.exe" /internal
            Log-Message "Display mode set to internal only"
            Start-Sleep -Seconds 2  # Give Windows time to apply the display change
        }
        $hdmi2 {
            Log-Message "Switching to HDMI 1..."
            # First set display to extended mode
            & "C:\Windows\System32\DisplaySwitch.exe" /extend
            Log-Message "Display mode set to extended"
            Start-Sleep -Seconds 2  # Give Windows time to apply the display change
            
            # Now set the input to HDMI 1
            $newInput = $hdmi1
        }
        default {
            # If some other input, switch to HDMI1 by default
            Log-Message "Unknown input detected. Switching to HDMI 1..."
            # First set display to extended
            & "C:\Windows\System32\DisplaySwitch.exe" /extend
            Log-Message "Display mode set to extended"
            Start-Sleep -Seconds 2  # Give Windows time to apply the display change
            
            # Now set the input to HDMI 1
            $newInput = $hdmi1
        }
    }

    # Apply new input
    Set-MonitorVCPValue -Monitor $monitor -VCPCode $vcpCode -Value $newInput
    Log-Message "Input source changed successfully to $newInput."

}
catch {
    Log-Message "ERROR: $_"
}
