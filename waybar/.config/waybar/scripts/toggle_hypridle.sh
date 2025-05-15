#!/bin/bash

# Function to output JSON with icon and state
output_state() {
    local running=$1
    if [[ $running -eq 1 ]]; then
        # hypridle running: icon "on" (e.g. red circle), state 1
        echo "{\"icon\":\"\", \"state\":\"1\"}"
    else
        # hypridle not running: icon "off" (e.g. empty circle), state 0
        echo "{\"icon\":\"\", \"state\":\"0\"}"
    fi
}

# Check if hypridle is currently running (before toggling)
if pgrep -x hypridle > /dev/null; then
    # Output current state: running
    output_state 1
    # Now toggle: kill hypridle gracefully
    pkill hypridle
    sleep 0.5
    if pgrep -x hypridle > /dev/null; then
        pkill -9 hypridle
    fi
else
    # Output current state: not running
    output_state 0
    # Now toggle: start hypridle silently
    hypridle >/dev/null 2>&1 &
    sleep 1
fi
