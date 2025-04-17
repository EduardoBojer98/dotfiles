#!/bin/bash

CACHE="$HOME/.cache/dunst_notifications"

if [[ -s "$CACHE" ]]; then
    COUNT=$(wc -l < "$CACHE")
    echo " $COUNT"
else
    echo ""
fi
