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
zplug "sindresorhus/pure", as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


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
