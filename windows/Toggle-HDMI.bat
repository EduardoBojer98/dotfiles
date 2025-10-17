@echo off
REM ------------------------------------------------------------
REM Toggle-HDMI.bat
REM
REM Description:
REM   Wrapper batch file that runs the `Toggle-HDMI.ps1` PowerShell script
REM   to toggle the monitor's HDMI input (uses the MonitorConfig module).
REM
REM Usage:
REM   Double-click this file or run it from a command prompt. It will
REM   launch PowerShell with the following options:
REM     -NoProfile           : don't load the user's PowerShell profile
REM     -ExecutionPolicy Bypass : allow running the script even if the
REM                              system policy would normally block it
REM     -File <path>         : the path to `Toggle-HDMI.ps1` (expected at
REM                              the same desktop path by default)
REM
REM Notes:
REM   - The PowerShell script `Toggle-HDMI.ps1` must exist at
REM     C:\Users\User\Desktop\Toggle-HDMI.ps1 or update the path below.
REM   - The script requires the MonitorConfig PowerShell module and DDC/CI
REM     enabled on the monitor. See the header of the PowerShell script for
REM     additional configuration options (InstanceName, HDMI codes, logging).
REM   - This batch file pauses after running so you can read any output or
REM     error messages from the PowerShell script.
REM ------------------------------------------------------------

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\User\Desktop\Toggle-HDMI.ps1"
pause
