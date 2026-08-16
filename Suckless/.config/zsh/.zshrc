#####---------- EXPORTS ----------###
export BROWSER="Brave"
export EDITOR="nvim -u $HOME/.config/nvim/init.lua"
export VISUAL="nvim -u $HOME/.config/nvim/init.lua"
#export MYVIMRC="$HOME/.config/vim/.vimrc"
#export VIMINIT="source $MYVIMRC"
export LESSHISTFILE=-
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=xcb
export PATH="$PATH:$HOME/.local/scripts/:$HOME/.local/.bin/:$HOME/.local/scripts/dmenu/:$HOME/.bin/:$HOME/.local/fzfm"
export CDPATH=".:$HOME:$HOME/.config/:$HOME/.local/:$HOME/.local/share/:$HOME/.local/programms"
export CSCOPE_EDITOR="nvim"
#export HYPRSHOT_DIR="$HOME/Images/Pictures/Screenshots"
export INPUTRC=/home/georg/.inputrc
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi
#export GIT_CONFIG_GLOBAL=/home/jake/.config/git/gitconfig
precmd() { print "" }
autoload -U compinit
autoload -Uz promptinit
setopt autocd
cdpath=(/ $HOME/.config) 
setopt PROMPT_SUBST
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
HISTFILE=~/.zsh_history
SAVEHIST=1000000000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY


source $HOME/.config/zsh/plugins/zsh-autosuggestions-master/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

count_files() {
  local count=$(ls -A1 2>/dev/null | wc -l)
  echo "%F{004}📁${count}%f"
}

# /Users/georg65/.oh-my-zsh/custom/plugins/zsh-autosuggestions

###------------------- PROMPT -----------------------###

# Git-Zweig anzeigen
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed 's/.*/ &/'
}

# Git-Status (dirty)
parse_git_dirty() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  [[ -n $(git status --porcelain 2>/dev/null) ]] && echo " ✗"
}

# Exit-Status anzeigen
last_status() {
  [[ $? -eq 0 ]] && echo "%F{green}✔%f" || echo "%F{red}❌%f"
}

# Root-Warnung anzeigen
user_icon() {
  [[ $EUID -eq 0 ]] && echo "%F{red} 🔒 root%f" || echo ""
}

# Haupt-Prompt links
PROMPT='%B%F{003} %f%F{015}%~%f $(count_files)$(user_icon) $(last_status) %F{006} %f%b '
# Rechter Prompt (Git & Uhr)
RPROMPT='%F{006}$(parse_git_branch)%f%F{003}$(parse_git_dirty)%f  %F{015} %*%f'


alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

alias ls='eza -bghHliSa'
alias c='clear'
alias dwmc='nvim ~/.config/suckless/dwm/config.def.h'

alias stc='nvim ~/.config/suckless/st/config.def.h'
alias term='nvim ~/.config/alacritty/alacritty.toml'
alias sz='source $HOME/.config/zsh/.zshrc'
# alias merge="xrdb -merge $HOME/.Xresources"

alias upgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias s="subl"
alias ss="sudo subl"
alias update='sudo pacman -Syu --noconfirm'

alias zsh='nvim ~/.config/zsh/.zshrc'
alias pinst='sudo pacman -S'
alias yinst='sudo yay -S'
alias rem='sudo rm -rf'
alias find='find /. -name 2> /dev/null'
alias r='ranger'

##########VOIDLINUX############
alias xi="sudo xbps-install -S"
alias xs="sudo xbps-query -Rs"
alias up="sudo xbps-install -u xbps; sudo xbps-install -Su"
alias xr="sudo xbps-remove -O && sudo xbps-remove -o"
alias make='( \
  curdir=$(pwd); \
  cd /home/georg/.config/suckless/dwm && \
  cp -u config.h config.h.bak && \
  cp -u config.def.h config.def.h.bak && \
  sudo make clean && \
  cp config.def.h config.h && \
  sudo make install && \
  cd "$curdir" \
)'


# eval "$(zoxide init zsh)"
# eval "$(zoxide init --cmd cd zsh)"
#
#
mdwm() {
	local STARTDIR="$PWD"
	cd ~/.config/suckless/dwm || return 1
	cp config.def.h config.h || return 1
	sudo make clean install
	cd "$STARTDIR" || return 1
}	
