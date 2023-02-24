printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs
# Auto tmux
if [[ $- == *i* && -z "$TMUX" ]]; then
  # Machine-specific config
  [[ -f ~/.zshrc_pretmux ]] && source ~/.zshrc_pretmux
  [[ -n "$SSH_CONNECTION" ]] && local session="ssh" || local session="tmux"
  tmux new -A -s "$session"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment vars
# ================================
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export PAGER="$(which less) -i" # i: smart case search


# Aliases
# ================================
alias grep="grep --color=auto"
alias ls="ls --color=auto"


# zplug
# ================================
source ~/.zplug/init.zsh

# omz libs
zplug "lib/completion", from:oh-my-zsh # [tab] squares
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

# omz plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
[[ -f /etc/debian_version ]] && zplug "plugins/debian", from:oh-my-zsh

# Other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "trapd00r/LS_COLORS", \
  hook-build:"dircolors -b LS_COLORS > c.zsh", \
  use:c.zsh

# Theme
zplug "romkatv/powerlevel10k", \
  as:theme, \
  depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# Libraries
# ================================
# Nerd-fonts
source ~/.local/share/fonts/i_all.sh


# Plugins
# ================================
# Autosuggestions
# ---------------
bindkey -M emacs '^[^M' autosuggest-execute # Alt + Enter
bindkey -M vicmd '^[^M' autosuggest-execute # Alt + Enter
# This speeds up pasting
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
function pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
function pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


# Everything Else
# ================================
# Options
setopt EXTENDED_GLOB

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

add-zsh-hook precmd precmd
add-zsh-hook preexec preexec

# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# fzf
export FZF_DEFAULT_OPTS="--color=16" # Match terminal color scheme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Machine-specific config
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
