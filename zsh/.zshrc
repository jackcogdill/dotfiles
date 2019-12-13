# Vars
# ====
export GOPATH=$(go env GOPATH)
# !! Keep this order. Use GNU ls for LS_COLORS to work
export PATH="/usr/local/opt/coreutils/libexec/gnubin:\
${PATH}:\
$GOPATH/bin:\
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
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export PAGER="$(which less) -Fi" # F: quit if one screen, i: smart case search


# zplug
# =====
source ~/.zplug/init.zsh

zplug "lib/completion", from:oh-my-zsh # [tab] squares
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh

# !! Keep order
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

zplug "trapd00r/LS_COLORS", \
  hook-build:"dircolors -b LS_COLORS > c.zsh", \
  use:"c.zsh"

# Theme
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


# Shell
# =====
# Prompt
#        [    time   ]
RPROMPT='%F{white}%*%f'
#       [        jobs        ]
PROMPT='%F{cyan}%(1j.[%j] .)%f'$PROMPT
printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs

# Pure
PURE_GIT_DOWN_ARROW="v"
PURE_GIT_UP_ARROW="⌃"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=63'
bindkey '^Z' autosuggest-execute # Accept and execute
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

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# Aliases
# =======
alias ls="ls --color=auto -F"
alias ll="ls --color=auto -Flh"
alias la="ls --color=auto -Fa"
alias  l="ls --color=auto -Falh"
alias h="history"
alias ip="curl icanhazip.com"
alias bubu="brew upgrade && brew cleanup && brew update && brew outdated" # Update brew
# ssh
alias rl="ssh -t jackcog@rlogin.cs.vt.edu zsh"
alias rlb="ssh jackcog@rlogin.cs.vt.edu" # ssh to rlogin in bash (instead of zsh)
alias portal="ssh jackcog@portal.cs.vt.edu"
alias ourlogin="ssh kiyoshi@ourlogin.space"
# macOS
alias vs="open -a /Applications/Visual\ Studio\ Code.app"
alias vlc="open -a /Applications/VLC.app"
alias chrome="open -a /Applications/Google\ Chrome.app"


# Misc
# ====
# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Auto tmux
if [[ -z "$TMUX" ]]; then
  local session
  [[ -n "$SSH_CONNECTION" ]] &&
    session="ssh" ||
    session="default"
  # Only attach once
  if ! tmux ls | grep -E "^$session" | grep -q attached; then # Not currently attached
    tmux new -A -s "$session"
  fi
fi
