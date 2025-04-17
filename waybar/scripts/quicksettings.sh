#!/bin/bash

wofi --show dmenu --style="$HOME/.dotfiles/waybar/styles/quicksettings.css" --cache-file /dev/null --prompt "Quick Settings" <<EOF
󰍹  Notifications
  Toggle Wi-Fi
  Toggle Bluetooth
󰃟  Brightness +
󰃞  Brightness -
  Volume +
  Volume -
󰍬  Switch Audio Output
󰍬  Switch Audio Input
EOF
choice=$(...)

case "$choice" in
  *"Notifications"*) foot -e less ~/.cache/dunst_notifications ;;
  *"Wi-Fi"*) nmcli radio wifi off && notify-send "Wi-Fi turned off" || nmcli radio wifi on && notify-send "Wi-Fi turned on" ;;
  *"Bluetooth"*) bluetoothctl power toggle ;;
  *"Brightness +"*) brightnessctl set +10% ;;
  *"Brightness -"*) brightnessctl set 10%- ;;
  *"Volume +"*) pamixer -i 5 ;;
  *"Volume -"*) pamixer -d 5 ;;
  *"Output"*) wpctl set-default "$(wpctl status | grep -A1 "Audio Output" | tail -n1 | awk '{print $2}')" ;;
  *"Input"*) wpctl set-default "$(wpctl status | grep -A1 "Audio Input" | tail -n1 | awk '{print $2}')" ;;
esac
