@echo off

@REM Step 1: Switch the external monitor input
"C:\Users\eugen\Documents\dotfiles-and-tools\monitor-switcher\windows\controlmymonitor\ControlMyMonitor.exe" /SetValue "\\.\DISPLAY2\Monitor0" 60 18

@REM Step 2: Wait a bit for the monitor to switch
timeout /t 3 /nobreak >nul

@REM Step 3: Switch to internal (built-in) display only
DisplaySwitch.exe /internal
