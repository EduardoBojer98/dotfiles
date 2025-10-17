#!/bin/bash
# Smooth, slower rainbow border animation for Hyprland with gradual color transitions

# Convert hex color (RRGGBB) to decimal RGB array
hex_to_rgb() {
    local hex=$1
    echo $((16#${hex:0:2})) $((16#${hex:2:2})) $((16#${hex:4:2}))
}

# Convert decimal RGB to hex color (RRGGBB)
rgb_to_hex() {
    printf "%02x%02x%02x" $1 $2 $3
}

# Generate a random darker hex color (RRGGBB)
random_darker_hex() {
    local hex=$(openssl rand -hex 3)
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    # Darken by 50%
    r=$((r / 2))
    g=$((g / 2))
    b=$((b / 2))

    rgb_to_hex $r $g $b
}

# Interpolate between two values
interp() {
    local start=$1
    local end=$2
    local step=$3
    local max_steps=$4
    echo $((start + (end - start) * step / max_steps))
}

# Interpolate RGB colors
interp_rgb() {
    local -n start_rgb=$1
    local -n end_rgb=$2
    local step=$3
    local max_steps=$4
    local r=$(interp ${start_rgb[0]} ${end_rgb[0]} $step $max_steps)
    local g=$(interp ${start_rgb[1]} ${end_rgb[1]} $step $max_steps)
    local b=$(interp ${start_rgb[2]} ${end_rgb[2]} $step $max_steps)
    echo $r $g $b
}

# Number of colors in the gradient (Hyprland expects 10 colors)
num_colors=10

# Steps per transition
steps=30

# Delay between steps (seconds)
delay=0.1

# Initialize start and end colors arrays (each element is an RGB triple)
declare -a start_colors
declare -a end_colors

# Initialize start_colors and end_colors with random darker colors
for ((i=0; i<num_colors; i++)); do
    start_colors[i]=$(random_darker_hex)
    end_colors[i]=$(random_darker_hex)
done

# Convert hex colors in arrays to RGB arrays for interpolation
hex_arr_to_rgb_arr() {
    local -n hex_arr=$1
    local -n rgb_arr=$2
    for ((i=0; i<num_colors; i++)); do
        read r g b <<< $(hex_to_rgb ${hex_arr[i]})
        rgb_arr[i*3]=$r
        rgb_arr[i*3+1]=$g
        rgb_arr[i*3+2]=$b
    done
}

# We'll keep current colors as RGB decimals
declare -a current_colors_rgb
declare -a start_colors_rgb
declare -a end_colors_rgb

hex_arr_to_rgb_arr start_colors start_colors_rgb
hex_arr_to_rgb_arr end_colors end_colors_rgb
hex_arr_to_rgb_arr start_colors current_colors_rgb

while true; do
    for ((step=0; step<=steps; step++)); do
        colors_hex=()
        for ((i=0; i<num_colors; i++)); do
            local r=$(interp ${start_colors_rgb[i*3]} ${end_colors_rgb[i*3]} $step $steps)
            local g=$(interp ${start_colors_rgb[i*3+1]} ${end_colors_rgb[i*3+1]} $step $steps)
            local b=$(interp ${start_colors_rgb[i*3+2]} ${end_colors_rgb[i*3+2]} $step $steps)

            colors_hex[i]=$(printf "0xff%02x%02x%02x" $r $g $b)
        done

        # Set the colors on the active_border with a fixed angle (270deg)
        hyprctl keyword general:col.active_border ${colors_hex[*]} 270deg

        sleep $delay
    done

    # After completing a transition, set start_colors = end_colors
    for ((i=0; i<num_colors; i++)); do
        start_colors_rgb[i*3]=${end_colors_rgb[i*3]}
        start_colors_rgb[i*3+1]=${end_colors_rgb[i*3+1]}
        start_colors_rgb[i*3+2]=${end_colors_rgb[i*3+2]}
    done

    # Pick new end colors
    for ((i=0; i<num_colors; i++)); do
        local new_hex=$(random_darker_hex)
        read r g b <<< $(hex_to_rgb $new_hex)
        end_colors_rgb[i*3]=$r
        end_colors_rgb[i*3+1]=$g
        end_colors_rgb[i*3+2]=$b
    done
done
