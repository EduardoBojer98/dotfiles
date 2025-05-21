#!/bin/bash

# Combined status check and toggle script for hypridle

# Function to get current status (0 = running, 1 = not running)
get_status() {
    if pgrep -x hypridle >/dev/null; then
        echo 0
    else
        echo 1
    fi
}

# Function to output JSON for Waybar
output_json() {
    local status=$1
    if [[ $status -eq 0 ]]; then
        # hypridle is running (inhibitor NOT active)
        echo '{"text":"󱫗 not active","tooltip":"Idle inhibitor NOT ACTIVE\nClick to activate","class":"active"}'
    else
        # hypridle is not running (inhibitor ACTIVE)
        echo '{"text":"󰾪 active","tooltip":"Idle inhibitor ACTIVE\nClick to deactivate","class":"inactive"}'
    fi
}

# If no arguments, just show status
if [[ $# -eq 0 ]]; then
    output_json $(get_status)
    exit 0
fi

# If toggle argument, change state
if [[ "$1" == "toggle" ]]; then
    if [[ $(get_status) -eq 0 ]]; then
        # hypridle is running - kill it
        pkill hypridle
        sleep 0.5
        # Force kill if needed
        if pgrep -x hypridle >/dev/null; then
            pkill -9 hypridle
        fi
    else
        # hypridle is not running - start it
        hypridle >/dev/null 2>&1 &
    fi
    # Return new status
    output_json $(get_status)
fi