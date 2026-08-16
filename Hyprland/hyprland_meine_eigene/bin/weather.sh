#!/usr/bin/bash

LOCATION="39.366993,21.923761"

TEMP=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=39.366993&longitude=21.923761&current=temperature_2m" \
| grep -o '"temperature_2m":[0-9.]*' \
| cut -d: -f2 \
| tail -n1 \
| tr -d '[:space:]')

if [ -n "$TEMP" ]; then
    echo "<span foreground='#88c0d0'>${TEMP}°C</span>"
else
    echo "<span foreground='#bf616a'>N/A</span>"
fi