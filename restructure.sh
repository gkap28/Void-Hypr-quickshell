#!/usr/bin/env bash
set -e

# Ordner umbenennen (klein, ohne unnötige Verschachtelung)
git mv Hyprland hyprland
git mv ICONS icons
git mv Themes themes
git mv Suckless suckless

# FONTS/fonts -> fonts (Verschachtelung entfernen)
git mv FONTS/fonts fonts
rmdir FONTS 2>/dev/null || true

# chatgpt-nvim/nvim -> nvim (Verschachtelung entfernen)
git mv chatgpt-nvim/nvim nvim
rmdir chatgpt-nvim 2>/dev/null || true

# Dateien in docs/ mit sinnvollen Namen und .md-Endung
mkdir -p docs
git mv "Postinstall VoidBtrfs" docs/void-btrfs-subvol-install-tty1.md
git mv "Diverse_Linux_commands" docs/linux-commands.md

# Commit
git add -A
git commit -m "Restructure: konsistente Kleinschreibung, docs/-Ordner, Verschachtelung entfernt"
git push
