#!/bin/bash

# Get CPU temperature and strip decimal part
CPU=$(sensors | grep -m 1 -E 'Package id 0:|Tctl:' | awk '{for(i=1;i<=NF;i++) if ($i ~ /^\+[0-9]+\.[0-9]+°C$/) { gsub(/\+|°C/, "", $i); printf "%d", $i } }')

# Get GPU temperature
GPU=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

# Fallback if GPU is not available
[ -z "$GPU" ] && GPU="N/A"

echo " CPU ${CPU:-N/A}°C | 󰘚 GPU ${GPU}°C"
