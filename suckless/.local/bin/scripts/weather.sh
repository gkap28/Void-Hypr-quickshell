#!/usr/bin/bash

# Koordinaten für Karditsa, Griechenland
LOC="39.366986,21.923742"

text=$(curl -s "wttr.in/$LOC?format=1")

if [[ $? == 0 ]]; then
	text=$(echo "$text" | sed -E "s/\s+/ /g")
	tooltip=$(curl -s "wttr.in/$LOC?format=%l:+%C+%c+%t+%w+%m")
	if [[ $? == 0 ]]; then
		tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
		echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
		exit
	fi
fi

echo "{\"text\":\"Service Unavailable\", \"tooltip\":\"Service Unavailable\"}"
