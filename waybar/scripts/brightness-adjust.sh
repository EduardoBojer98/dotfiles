#!/bin/bash

direction="$1"

if [ "$direction" = "up" ]; then
    brightnessctl -d amdgpu_bl1 set +5%
else
    brightnessctl -d amdgpu_bl1 set 5%-
fi
