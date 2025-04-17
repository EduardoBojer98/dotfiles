#!/bin/bash

CACHE="$HOME/.cache/dunst_notifications"
COUNT=$(wc -l < "$CACHE" 2>/dev/null || echo 0)

if [ "$COUNT" -eq 0 ]; then
    echo ""
else
    echo " $COUNT"
fi
