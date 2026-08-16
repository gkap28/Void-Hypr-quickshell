# ~/.bashrc

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash prompt
# PS1="\n\[\e[1;32m\]  \[\e[1;37m\]\w\[\e[0m\]\n\[\e[1;35m\]❯ \[\e[0m\]"


# Define aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi


shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

if [ -d /etc/bash/bashrc.d/ ]; then
    for f in /etc/bash/bashrc.d/*.sh; do
        [ -r "$f" ] && . "$f"
    done
    unset f
fi

# Ganz unten in der ~/.bashrc einfügen:
# export PS1="\n\[\e[1;32m\]  \[\e[1;37m\]\w\[\e[0m\]\n\[\e[1;35m\]❯ \[\e[0m\]"
# source ~/.fancy-bash-promt.sh
# source ~/.fancy-bash-promt.sh
# source ~/.fancy-bash-promt.sh
# 


# Prompt Settings
_generate_greek_prompt() {
    # Wichtig: Den Exit-Code des letzten Befehls zuerst sichern, falls Sie ihn später brauchen
    local exit_code=$?

    local -a PROMPTS=(
        "Σ" "ς" "Ε" "ε" "Ρ" "ρ" "Τ" "τ" "Υ" "υ" "Θ" "θ" "Ι" "ι" "Ο" "ο" "Π" "π"
        "Α" "α" "Σ" "σ" "Δ" "δ" "Φ" "φ" "Γ" "γ" "Η" "η" "Ξ" "ξ" "Κ" "κ" "Λ" "λ"
        "Ζ" "ζ" "Χ" "χ" "Ψ" "ψ" "Ω" "ω" "Β" "β" "Ν" "ν" "Μ" "μ" 
    )

    # Zufälligen Index für das Array berechnen (Bash-Arrays starten bei 0)
    local random_index=$(( RANDOM % ${#PROMPTS[@]} ))
    local ignition="${PROMPTS[$random_index]}"

    # Aktuelles Verzeichnis ermitteln (wie das %1~ in Zsh, nur der letzte Ordnername)
    # Wenn Sie den vollen Pfad (mit ~) wollen, ändern Sie "\W" zu "\w"
    local current_dir="\W"

    # PS1 zusammenbauen: Gelber Ordner, Leerzeichen, Grüner griechischer Buchstabe, Pfeil
    PS1="\[\033[1;33m\]${current_dir}\[\033[0m\] \[\033[1;32m\]${ignition}\[\033[0m\] \[\033[1;34m\]>>\[\033[0m\] "
}

# Aktiviert die dynamische Aktualisierung bei jedem Befehl
PROMPT_COMMAND=_generate_greek_prompt



local_fortune() {
    local quote_file="$HOME/.local/bin/quotes/quotes"
    
    if [[ -f "$quote_file" ]]; then
        # Nutzt awk, um die Datei anhand von % in Blöcke zu teilen und einen zufälligen Block zu drucken
        awk -v RS='(^|\n)%\n' 'BEGIN{srand()} {a[NR]=$0} END{if(NR>0) print a[int(rand()*NR)+1]}' "$quote_file"
    else
        echo "Hinweis: Zitatdatei unter $quote_file nicht gefunden."
    fi
}

# Zitat beim Start des Terminals ausgeben
local_fortune

