# zplug
# ============
source ~/.zplug/init.zsh

zplug "lib/completion", from:oh-my-zsh # [tab] squares
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# Prompt
# ============
RPROMPT='%F{white}%*'
PROMPT='%F{cyan}%(1j.[%j] .)'$PROMPT
printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs


# Plugin configs
# ============
# Pure theme
PURE_GIT_DOWN_ARROW="v"
PURE_GIT_UP_ARROW="⌃"

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=63'

# Environment vars
# ============
# Path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
export PATH="${PATH}:/usr/local/opt/ruby/bin"
export PATH="${PATH}:/usr/local/opt/mongodb-community@3.4/bin"

# Editor / pager
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export PAGER="$(which less) -Fi" # F: quit if one screen, i: smart case search

# Go
export GOPATH=$(go env GOPATH)
export PATH="${PATH}:$GOPATH/bin"


# Aliases
# ============
alias ip="curl icanhazip.com"
alias gh="cd ~/Git_Repos"
alias zshrc="$EDITOR ~/.zshrc && source ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias mfind="mdfind -onlyin ."
alias bubu="brew upgrade && brew cleanup && brew update && brew outdated" # Update brew

# SSH
alias rl="ssh -t jackcog@rlogin.cs.vt.edu zsh"
alias rlb="ssh jackcog@rlogin.cs.vt.edu" # ssh to rlogin in bash (instead of zsh)
alias portal="ssh jackcog@portal.cs.vt.edu"
alias ourlogin="ssh kiyoshi@ourlogin.space"

# Git
alias gpf="git push -f"
alias gla="git pull --all"
alias gu="gta; gfa; gla"

alias javarepl="java -jar /opt/local/share/java/javarepl*.jar"
alias vs="open -a /Applications/Visual\ Studio\ Code.app"
alias vlc="open -a /Applications/VLC.app"
alias chrome="open -a /Applications/Google\ Chrome.app"


# This speeds up pasting w/ autosuggest
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

# Auto tmux
if [[ -z "$TMUX" ]]; then
  local session
  [[ -n "$SSH_CONNECTION" ]] &&
    session="ssh" ||
    session="default"
  # Not currently attached
  if ! tmux ls | grep -E "^$session" | grep -q attached; then
    tmux new -A -s "$session"
  fi
fi

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Keybindings
# ============
# Auto suggestions
bindkey '^Z' autosuggest-execute # Accept and execute the auto-suggestion with Ctrl-Z
