#!/bin/bash

chosen=$(printf "󰍃 Logout\n󰜉 Reboot\n Shutdown" | wofi --dmenu --width 200 --height 150 --prompt "Power")

case "$chosen" in
  "󰍃 Logout") hyprctl dispatch exit ;;
  "󰜉 Reboot") systemctl reboot ;;
  " Shutdown") systemctl poweroff ;;
esac
