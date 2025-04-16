#!/bin/bash

hyprctl clients -j | jq -r '.[] | select(.workspace.id == '"$(hyprctl activeworkspace -j | jq '.id')"') | .class' | uniq | paste -sd " · " -
