#!/bin/bash

# Try to get CPU temp from thermal zones (first valid reading)
CPU_TEMP=""
for zone in /sys/class/thermal/thermal_zone*/temp; do
    if [ -f "$zone" ]; then
        temp=$(cat "$zone")
        # If temp is a reasonable value (>1000 millidegrees)
        if [[ $temp -gt 1000 ]]; then
            # Convert millidegrees to degrees Celsius
            CPU_TEMP=$((temp / 1000))
            break
        fi
    fi
done

# Fallback to empty if nothing found
CPU_TEMP=${CPU_TEMP:-""}

# Get GPU temp from nvidia-smi (if available)
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
GPU_TEMP=${GPU_TEMP:-""}

echo "{\"cpu\": \"$CPU_TEMP\", \"gpu\": \"$GPU_TEMP\"}"
