#!/bin/bash

# Farben
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Optionen mit Emojis und Leerzeilen für Abstand
options=(
  "🔁  Reboot"
  ""
  "⏻  Poweroff"
  ""
  "🔒  Lock"
  ""
  "🚪  Logout"
  ""
  "❌  Exit"
)

# Auswahl anzeigen mit fzf
selected_option=$(printf '%s\n' "${options[@]}" | fzf --prompt="System-Menü: " --height=40% --reverse --border)

# Auswahl auswerten
case "$selected_option" in
  "🔁  Reboot")
    echo -e "${YELLOW}→ Starte neu...${RESET}"
    sudo /usr/bin/reboot
    ;;

  "⏻  Poweroff")
    echo -e "${YELLOW}→ Fahre herunter...${RESET}"
    sudo /usr/bin/poweroff
    ;;

  "🔒  Lock")
    echo -e "${BLUE}→ Sperre Bildschirm...${RESET}"
    slock &
    ;;

  "🚪  Logout")
    echo -e "${RED}→ Abmelden...${RESET}"
    pkill -KILL -u "$USER"
    ;;

  "❌  Exit")
    echo -e "${GREEN}→ Tschüss!${RESET}"
    exit 0
    ;;

  *)
    echo -e "${RED}Ungültige Auswahl.${RESET}"
    ;;
esac
