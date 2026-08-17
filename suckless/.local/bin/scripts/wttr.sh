#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NONE='\033[0m'

# Wetter für Karditsa abrufen (Fahrenheit deaktiviert durch Weglassen von ?F)
curl "wttr.in/39.366986,21.923742"

echo -e "$GREEN"
read -rp "Press Enter to continue" </dev/tty
echo -e "$NONE"
