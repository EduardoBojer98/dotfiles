#!/bin/bash

if pgrep wvkbd-mobintl > /dev/null; then
  # If running, send SIGUSR2 to hide/close it
  pkill -SIGUSR2 wvkbd-mobintl
else
  # If not running, launch with your options
  wvkbd-mobintl -H 550 --fn 'JetBrainsMono Nerd Font 20' --alpha 200 &
fi
