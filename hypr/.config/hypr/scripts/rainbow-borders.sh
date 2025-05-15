#!/bin/bash
# Darker, slower rainbow border animation for Hyprland

function random_darker_hex() {
    # Generate random color (6 hex digits)
    local hex=$(openssl rand -hex 3)

    # Extract RGB components (two hex digits each)
    local r=${hex:0:2}
    local g=${hex:2:2}
    local b=${hex:4:2}

    # Convert hex to decimal
    local r_dec=$((16#$r))
    local g_dec=$((16#$g))
    local b_dec=$((16#$b))

    # Scale down each component to 50% brightness (you can adjust 0.5 to other values)
    local r_dark=$(printf "%02x" $((r_dec / 2)))
    local g_dark=$(printf "%02x" $((g_dec / 2)))
    local b_dark=$(printf "%02x" $((b_dec / 2)))

    # Return as 0xffRRGGBB format (include alpha FF for full opacity)
    echo "0xff${r_dark}${g_dark}${b_dark}"
}

while true; do
    hyprctl keyword general:col.active_border \
        $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) \
        $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) $(random_darker_hex) 270deg
    sleep 1.5  # slower animation - 1 second delay
done
