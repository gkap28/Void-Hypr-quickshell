#!/bin/bash

# Funktion, um die Speicherauslastung abzurufen
get_memory_usage() {
    memory_total=$(free -m | awk '/^Speicher:/ {print $2}')
    memory_used=$(free -m | awk '/^Speicher:/ {print $3}')
    echo "MEM: $memory_used/$memory_total MB"
}

# Funktion, um die Festplattenbelegung abzurufen
get_disk_usage() {
    disk_total=$(df -h /dev/sda3 | awk 'NR==2 {print $2}')
    disk_used=$(df -h /dev/sda3 | awk 'NR==2 {print $3}')
    echo "DISK: $disk_used/$disk_total"
}

# Hauptprogramm
while true; do
    # Ausgabe der verschiedenen Blöcke
    echo "$(get_memory_usage) | $(get_disk_usage)"
    sleep 1  # Aktualisierungsintervall in Sekunden
done
