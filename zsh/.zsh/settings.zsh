# Nerd-fonts
source ~/.local/share/fonts/i_all.sh

# Options
setopt extendedglob

# Set the terminal title
# $1 is options
# $2 is the message
function set_title() {
  setopt localoptions noshwordsplit

  case $TTY in
    /dev/ttyS[0-9]*) return;; # Don't set title over serial console.
  esac

  local -a opts
  case $1 in
    expand-prompt) opts=(-P);;
    ignore-escape) opts=(-r);;
  esac

  # Set title atomically in one print statement so that it works when XTRACE is enabled.
  print -n $opts $'\e]0;'${2}$'\a'
}

function precmd() {
  set_title 'ignore-escape' "$SHELL:t"
}

# $1 the string that the user typed
# $2 a single-line, size-limited version of the command
# $3 the full text that is being executed
function preexec() {
  set_title 'ignore-escape' "$2"
}

autoload -U add-zsh-hook
add-zsh-hook precmd precmd
add-zsh-hook preexec preexec

function setup-lscolors() {
  (( $+commands[dircolors] )) || return
  eval $(dircolors)
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
}
setup-lscolors

# Edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Load completion engine
autoload -U compinit
compinit
