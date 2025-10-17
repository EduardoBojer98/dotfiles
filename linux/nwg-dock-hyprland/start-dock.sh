#!/bin/bash

# Check if HDMI-A-1 is connected using hyprctl
if hyprctl monitors | grep -q "Monitor HDMI-A-1"; then
  MONITOR="HDMI-A-1"
else
  MONITOR="eDP-1"
fi

# Run nwg-dock-hyprland on the selected monitor
nwg-dock-hyprland -o "HDMI-A-1" -i 38 -mb 4 -w 2 -x -c "rofi -config ~/.config/rofi/config.rasi -show drun"
