#!/bin/bash

# Funktion, um die Speicherauslastung abzurufen
get_memory_usage() {
    memory_total=$(free -m | awk '/^Speicher:/ {print $2}')
    memory_used=$(free -m | awk '/^Speicher:/ {print $3}')
    echo "MEM: $memory_used/$memory_total MB"
}

# Hauptprogramm
while true; do
    # Ausgabe der verschiedenen Blöcke
    echo "$(get_memory_usage)"
    sleep 5  # Aktualisierungsintervall in Sekunden
done
