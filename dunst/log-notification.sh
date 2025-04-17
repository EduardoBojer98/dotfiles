#!/bin/bash

CACHE="$HOME/.cache/dunst_notifications"
mkdir -p "$(dirname "$CACHE")"

read -r
echo "$REPLY" >> "$CACHE"

# Optional: Limit to last 50
tail -n 50 "$CACHE" > "$CACHE.tmp" && mv "$CACHE.tmp" "$CACHE"
