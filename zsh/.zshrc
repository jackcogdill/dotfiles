printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs
# Auto tmux
if [[ $- == *i* && -z "$TMUX" ]]; then
  [[ -n "$SSH_CONNECTION" ]] && local session="ssh" || local session="tmux"
  # Only attach once
  if ! tmux ls | grep -E "^$session" | grep -q attached; then
    tmux new -A -s "$session"
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Vars
# ====
export GOPATH=$(go env GOPATH)
# !! Keep this order. Use GNU ls for LS_COLORS to work
export PATH="/usr/local/opt/coreutils/libexec/gnubin:\
${PATH}:\
$GOPATH/bin:\
$HOME/.cargo/bin:\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/local/opt/mongodb-community@3.4/bin:\
/usr/local/opt/ruby/bin:\
/opt/X11/bin:\
/Library/TeX/texbin"
fpath+=${ZDOTDIR:-~}/.zsh_functions
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export PAGER="$(which less) -i" # i: smart case search
export LANG="en_US.UTF-8"


# zplug
# =====
source ~/.zplug/init.zsh

# Omz libs
zplug "lib/completion", from:oh-my-zsh # [tab] squares
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

# Omz plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh

# Other
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


# Plugins
# =======
# Autosuggestions
# ---------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239' # gruvbox bg2
bindkey -M emacs '^Z' autosuggest-execute
bindkey -M vicmd '^Z' autosuggest-execute
# This speeds up pasting
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


# Aliases
# =======
alias ls="ls --color=auto"
alias lx="ls -lAhX"
alias h="history"
alias ip="curl icanhazip.com"
alias bubu="brew upgrade && brew cleanup && brew update && brew outdated"

# ssh
# ---
alias rl="ssh -t jackcog@rlogin.cs.vt.edu zsh"
alias rlb="ssh jackcog@rlogin.cs.vt.edu" # ssh to rlogin in bash (instead of zsh)
alias portal="ssh jackcog@portal.cs.vt.edu"

# macOS
# -----
alias vs="open -a /Applications/Visual\ Studio\ Code.app"
alias vlc="open -a /Applications/VLC.app"
alias chrome="open -a /Applications/Google\ Chrome.app"


# Everything Else
# ===============
# Set the terminal title
function set_title() {
  # $1 is the raw user string
  # $2 is a single-line, size-limited version
  local cmd
  [[ -z "$2" ]] && cmd="${0#-}" || cmd="$2"
  # Set title atomically in one print statement so that it works when XTRACE is enabled.
  print -n $opts $'\e]0;'${cmd}$'\a'
}
add-zsh-hook precmd set_title
add-zsh-hook preexec set_title

# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# fzf
# ---
# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
# Color scheme
export FZF_DEFAULT_OPTS="
  --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
  --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
" # Nord

# Nerd fonts
source ~/.local/share/fonts/i_all.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
