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
zplug "zsh-users/zsh-history-substring-search"
zplug "trapd00r/LS_COLORS", \
  hook-build:"dircolors -b LS_COLORS > c.zsh", \
  use:c.zsh

# Theme
zplug "jackcogdill/spaceship-prompt", \
  use:spaceship.zsh, \
  as:theme

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
# Spaceship
# ---------
printf '\e[1 q' # Blinking block cursor

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  package       # Package version
  node          # Node.js section
  golang        # Go section
  venv          # virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  time          # Time stamps section
)

SPACESHIP_DIR_COLOR=32 # blue
SPACESHIP_GIT_BRANCH_COLOR=72 # aqua
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=
SPACESHIP_GIT_STATUS_COLOR=245 # gray
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_CHAR_SYMBOL_SECONDARY="❯ "
SPACESHIP_CHAR_VI_MODE=true
SPACESHIP_CHAR_VI_MODE_SYMBOL="❮ "
SPACESHIP_CHAR_COLOR_SUCCESS= # fg
SPACESHIP_CHAR_COLOR_SECONDARY=245 # gray

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_COLOR=239 # bg2

# Autosuggestions
# ---------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=63'
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

# History Substring Search
# ------------------------
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# Aliases
# =======
alias ls="ls --color=auto"
alias la="ls --color=auto -a"
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
bindkey -e # Emacs

# Set the terminal title
function set_title() {
  # Set title atomically in one print statement so that it works when XTRACE is enabled.
  # $2 is the current command
  print -n $opts $'\e]0;'${2}$'\a'
}
add-zsh-hook precmd set_title
add-zsh-hook preexec set_title

# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Auto start tmux
if [[ -z "$TMUX" ]]; then
  local session
  [[ -n "$SSH_CONNECTION" ]] \
    && session="ssh" \
    || session="default"

  # Only attach once
  if ! tmux ls | grep -E "^$session" | grep -q attached; then # Not currently attached
    tmux new -A -s "$session"
  fi
fi
