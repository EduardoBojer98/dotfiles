#!/bin/bash

WALLPAPER_DIR="/home/eduardo/Pictures/wallpaper-bank"
DISPLAYS=("HDMI-A-1" "DP-1" "eDP-1")

while true; do
    # Pick a random image
    IMG=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n1)

    for DISPLAY in "${DISPLAYS[@]}"; do
        hyprctl hyprpaper wallpaper "$DISPLAY,$IMG"
    done

    sleep 15
done
