#!/bin/bash

# Check if keyboard is running
if pgrep -x "wvkbd-mobintl" > /dev/null; then
    # If running, try to hide it with SIGUSR2 first
    pkill -SIGUSR2 -x "wvkbd-mobintl"
    # If still running after 0.5s, kill it completely
    sleep 0.5
    if pgrep -x "wvkbd-mobintl" > /dev/null; then
        pkill -x "wvkbd-mobintl"
    fi
else
    # If not running, launch it
    wvkbd-mobintl -H 550 --fn 'JetBrainsMono Nerd Font 20' --alpha 200 &
fi