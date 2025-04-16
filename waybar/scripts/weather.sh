#!/bin/bash

weather=$(curl -s 'wttr.in?format=%C+%t')
condition=$(echo "$weather" | cut -d' ' -f1)
temp=$(echo "$weather" | grep -oE '[+-]?[0-9]+°C')

# Mapping conditions to MDI icons
case "$condition" in
  Sunny) icon="󰖨" ;;            # mdi-weather-sunny
  Clear) icon="󰖨" ;;
  Cloudy) icon="󰖐" ;;          # mdi-weather-cloudy
  Overcast) icon="󰖐" ;;
  Partly*) icon="󰖕" ;;         # mdi-weather-partly-cloudy
  Mist|Fog) icon="󰖑" ;;         # mdi-weather-fog
  Rain*) icon="󰖖" ;;           # mdi-weather-rainy
  Snow*) icon="󰖘" ;;           # mdi-weather-snowy
  Thunderstorm*) icon="󰖓" ;;   # mdi-weather-lightning
  *) icon="󰖩" ;;               # mdi-weather-cloudy-alert
esac

echo "$icon $weather"
