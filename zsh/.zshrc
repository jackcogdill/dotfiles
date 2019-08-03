# Antibody
# ================
# Tell Oh-My-Zsh where it lives
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
source ~/.zsh_plugins.sh


# Vi mode cursor
# ================
# The `add-zle-hook-widget` function is not guaranteed to be available.
# It was added in Zsh 5.3.
autoload -Uz +X add-zle-hook-widget 2>/dev/null

function reset_vi_mode_cursor {
  printf '\e[1 q' # Blinking box cursor
}

function update_vi_mode_cursor {
  # Change the cursor style depending on keymap mode.
  case $KEYMAP {
    vicmd)
      reset_vi_mode_cursor
      ;;
    viins|main)
      printf '\e[5 q' # Blinking bar cursor
      ;;
    }
}

zle -N update_vi_mode_cursor
zle -N reset_vi_mode_cursor
if (( $+functions[add-zle-hook-widget] )); then
  add-zle-hook-widget zle-line-init update_vi_mode_cursor
  add-zle-hook-widget zle-keymap-select update_vi_mode_cursor
  # Reset cursor to same style as vi command mode after entering a command
  # This is to prevent persisting the vi insert mode style into other programs
  add-zle-hook-widget zle-line-finish reset_vi_mode_cursor
fi


# Misc
# ============
# Line editing
bindkey -v # Vi mode
export KEYTIMEOUT=1 # Reduce default 0.4s delay after hitting <ESC> key
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history
# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
# ctrl-w removed word backwards
bindkey '^w' backward-kill-word
# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward


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
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@3.4/bin:$PATH"

# Editor
export EDITOR=`which nvim`
export VISUAL="$EDITOR"


# Aliases
# ============
alias lt='ls -halt' # human readable, show hidden, print details, sort by date
alias ip='curl icanhazip.com'
alias gh='cd ~/Git_Repos'
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
  tmux new -A -s "$session"
fi

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Keybindings
# ============
# Auto suggestions
bindkey '^Z' autosuggest-execute # Accept and execute the auto-suggestion with Ctrl-Z
