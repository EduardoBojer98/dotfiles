#!/bin/bash

CPU=$(sensors | grep -m 1 'Package id 0:' | awk '{print $4}')
GPU=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

echo " $CPU |  ${GPU:-N/A}°C"
