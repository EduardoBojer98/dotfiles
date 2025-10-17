#!/bin/bash

# Get CPU temperature
CPU_TEMP="N/A"
for zone in /sys/class/thermal/thermal_zone*/temp; do
    if [ -f "$zone" ]; then
        temp=$(cat "$zone")
        if [[ $temp -gt 1000 ]]; then
            CPU_TEMP=$((temp / 1000))
            break
        fi
    fi
done

# Get GPU temperature (NVIDIA)
GPU_TEMP="N/A"
if command -v nvidia-smi &> /dev/null; then
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
    if [[ -n "$gpu_temp" ]]; then
        GPU_TEMP="$gpu_temp"
    fi
fi

# Icons (using Nerd Font icons or similar)
CPU_ICON=""  # Microchip icon
GPU_ICON=""   # Graphics card icon
DEGREE_ICON="°"

# Output JSON
echo "{\"text\": \"$CPU_ICON ${CPU_TEMP}$DEGREE_ICON $GPU_ICON ${GPU_TEMP}$DEGREE_ICON\", \"tooltip\": \"$CPU_ICON CPU: ${CPU_TEMP}$DEGREE_ICON\n$GPU_ICON GPU: ${GPU_TEMP}$DEGREE_ICON\", \"class\": \"temperature\"}"