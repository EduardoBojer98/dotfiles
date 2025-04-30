#!/bin/bash

# Script to toggle monitor input between HDMI 1 (17) and HDMI 2 (18)

# Set display index (check with: ddcutil detect)
DISPLAY_INDEX=1  # Use 1 or 2 depending on your setup

# Get current input source
CURRENT_SOURCE=$(sudo ddcutil --display $DISPLAY_INDEX getvcp 60 | grep -oP 'current value = \K\d+')

# Debug print
echo "Current input source: $CURRENT_SOURCE"

# Toggle between HDMI 1 (17) and HDMI 2 (18)
if [ "$CURRENT_SOURCE" == "17" ]; then
    echo "Switching to HDMI 2"
    sudo ddcutil --display $DISPLAY_INDEX setvcp 60 18
elif [ "$CURRENT_SOURCE" == "18" ]; then
    echo "Switching to HDMI 1"
    sudo ddcutil --display $DISPLAY_INDEX setvcp 60 17
else
    echo "Unknown source ($CURRENT_SOURCE), setting to HDMI 1 by default"
    sudo ddcutil --display $DISPLAY_INDEX setvcp 60 17
fi
