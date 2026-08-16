[[ -f ~/.zshrc ]] && source ~/.zshrc



# Automatisch Hyprland starten, wenn wir uns auf TTY1 einloggen
if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    exec Hyprland
fi

export GTK_THEME=Adwaita-dark
export ADW_DISABLE_PORTAL=1

