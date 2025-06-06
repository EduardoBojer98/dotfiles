@echo off

@REM Step 1: Switch the external monitor input (to input 17)
"C:\Users\eugen\Documents\dotfiles-and-tools\monitor-switcher\windows\controlmymonitor\ControlMyMonitor.exe" /SetValue "\\.\DISPLAY2\Monitor0" 60 17

@REM Step 2: Wait for monitor to switch
timeout /t 3 /nobreak >nul

@REM Step 3: Extend the display
DisplaySwitch.exe /extend