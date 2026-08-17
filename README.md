# Void-Hypr-quickshell

Personal dotfiles and configuration for a **Void Linux** setup running **Hyprland** (Wayland compositor), including terminal, theming, fonts, icons, and installation notes.

## Overview

| Component  | Description                          |
| ---------- | ------------------------------------- |
| OS         | Void Linux (Btrfs, subvolumes)        |
| WM         | [Hyprland](https://hyprland.org/)     |
| Terminal   | [kitty](https://sw.kovidgoyal.net/kitty/) |
| Editor     | Neovim                                |
| WM (alt.)  | Suckless (dwm/st or similar)          |

## Structure
.
├── hyprland/ # Hyprland compositor config
├── kitty/ # Terminal emulator config
├── nvim/ # Neovim configuration
├── fonts/ # Custom/installed fonts
├── icons/ # Icon themes
├── themes/ # GTK/Qt/system themes
├── suckless/ # Suckless tools configs (dwm, st, etc.)
└── docs/
├── void-btrfs-subvol-install-tty1.md # Void Linux install guide (Btrfs subvolumes, via tty1)
└── linux-commands.md # Collection of useful Linux commands
## Installation

> ⚠️ These are personal configs — review before applying to your own system.

1. Clone the repository:
```bash
   git clone https://github.com/gkap28/Void-Hypr-quickshell.git
   cd Void-Hypr-quickshell
```

2. Copy or symlink the desired config folders into your `~/.config/`:
```bash
   ln -s "$(pwd)/hyprland" ~/.config/hypr
   ln -s "$(pwd)/kitty" ~/.config/kitty
   ln -s "$(pwd)/nvim" ~/.config/nvim
```

3. For a fresh Void Linux install with Btrfs subvolumes, see [`docs/void-btrfs-subvol-install-tty1.md`](docs/void-btrfs-subvol-install-tty1.md).

## Notes

See [`docs/linux-commands.md`](docs/linux-commands.md) for a collection of handy Linux commands used throughout this setup.

## License

Personal configuration files — use at your own risk / adapt freely.