#!/usr/bin/env bash

# Optionen definieren (Nerd Font Icons)
op_shutdown="⏻  Herunterfahren"
op_reboot="⟳  Neustarten"
op_logout="    Abmelden"
op_suspend="    Bereitschaft"
op_hibernate="    Ruhezustand"

# Alle Optionen an Rofi übergeben
options="$op_shutdown\n$op_reboot\n$op_logout\n$op_suspend\n$op_hibernate"

choice=$(echo -e "$options" | rofi -dmenu -i -theme /home/georg/.config/rofi/styles/powermenu.rasi -p "System:")

case "$choice" in
    "$op_shutdown")
        loginctl poweroff
        ;;

    "$op_reboot")
        loginctl reboot
        ;;

    "$op_logout")
        hyprctl dispatch exit
        ;;

    "$op_suspend")
        loginctl suspend
        ;;

    "$op_hibernate")
        loginctl hibernate
        ;;

    *)
        exit 0
        ;;
esac