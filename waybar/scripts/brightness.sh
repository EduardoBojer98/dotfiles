#!/bin/bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$((brightness * 100 / max_brightness))

# Nerd Font icons for brightness
if [ "$percent" -le 20 ]; then
  icon="󰛩"  # low
elif [ "$percent" -le 50 ]; then
  icon="󰛨"  # medium
elif [ "$percent" -le 80 ]; then
  icon="󰛧"  # high
else
  icon="󰛦"  # full
fi

echo "$icon ${percent}%"
