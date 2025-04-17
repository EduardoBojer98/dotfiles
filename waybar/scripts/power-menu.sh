#!/bin/bash

choice=$(printf "  Shutdown\n  Reboot\n  Lock\n󰤄  Suspend\n󰗽  Logout" | wofi --dmenu --cache-file /dev/null --prompt "Power Menu")

case "$choice" in
    "  Shutdown") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Lock") hyprlock ;;
    "󰤄  Suspend") systemctl suspend ;;
    "󰗽  Logout") hyprctl dispatch exit ;;
esac
