
Locale.conf
LANG=de_DE.UTF-8
LANGUAGE=de_DE
#LC_COLLATE=C
LC_TIME=de_DE.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_CTYPE=de_DE.UTF-8
LC_MESSAGES=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_ALL=


XDG_DESKTOP_DIR="$HOME/Schreibtisch"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Vorlagen"
XDG_PUBLICSHARE_DIR="$HOME/Öffentlich"
XDG_DOCUMENTS_DIR="$HOME/Dokumente"
XDG_MUSIC_DIR="$HOME/Musik"
XDG_PICTURES_DIR="$HOME/Bilder"
XDG_VIDEOS_DIR="$HOME/Videos"


## INSTALL DEVOUR

 git clone https://github.com/salman-abedin/devour.git && cd devour && sudo make install && cd "$HOME"/.local


./flexipatch-finalizer.sh -r -d ~/Downloads/dwm-flexipatch-master/ -o ~/Downloads/dwm

THUNAR CUSTOM AKTION
Open terminal here

    Name: Open terminal here
    Command 1: for f in %F; do exo-open --working-directory "$f" --launch TerminalEmulator; done
    Command 2: for f in %F; do if [ -d "$f" ]; then exo-open --working-directory "$f" --launch TerminalEmulator; elif [ -z "$default" ]; then default=1; exo-open --launch TerminalEmulator; fi done
    File pattern: *

    Open root terminal here

    Name: Open root terminal here
    Command(1): pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-launch xfce4-terminal --default-working-directory=%f
    Command(2): gksu xfce4-terminal --default-working-directory=%f
    File pattern: *

Open thunar as root here

    Name: Open thunar as root here
    Command(1): pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-launch thunar %f
    Command(2): thunar admin:///%f
    Command(3): gksu thunar %f
    File pattern: *


Edit file as root

    Name: Edit as root
    Command(1): pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-launch put-your-favourite-text-editor-here %f
    Command(2): gksu put-your-favourite-text-editor-here %f
    File pattern: *


    Hyprland repo auf Voidlinux
    echo "repository=https://downloads.sourceforge.net/project/d77void/hypr-d77" | sudo tee /etc/xbps.d/d77-hyprland.conf

    Brave-browser install auf VOIDLINUX OHNE TEMPLATE
    sudo xbps-install -R https://github.com/VUP-Linux/vup/releases/download/browsers-x86_64-current -S brave

