# Antigen
# ============
if [ ! -d "$HOME/.antigen" ]; then
    git clone https://github.com/zsh-users/antigen ~/.antigen
fi
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh

# Plugins
antigen bundle git
antigen bundle sudo
antigen bundle brew
antigen bundle history
antigen bundle python
antigen bundle extract
antigen bundle sublime

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle b4b4r07/enhancd
antigen bundle unixorn/autoupdate-antigen.zshplugin # Auto updates for antigen

# Theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply


# Plugin configs
# ============
bindkey '^Z' autosuggest-execute # Accept and execute the auto-suggestion with Ctrl-Z
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=63'
export ENHANCD_FILTER=fzy
export ENHANCD_DOT_SHOW_FULLPATH=1
export ENHANCD_HOOK_AFTER_CD='l' # ls after each cd

# Environment vars
# ============
# Path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"

# Editor
export EDITOR=`which nvim`
export VISUAL="$EDITOR"

# Set theme if unset
if ! [ -n "$THEME" ]; then
    export THEME="dark"
fi


# Aliases
# ============
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

alias todo="$EDITOR ~/Documents/todo.md"
alias hw="todo"
alias javarepl="java -jar /opt/local/share/java/javarepl*.jar"
alias tapastic="python2 ~/Programming/Python/tapastic\ dl"
alias vs="open -a /Applications/Visual\ Studio\ Code.app"
alias vlc="open -a /Applications/VLC.app"
alias chrome="open -a /Applications/Google\ Chrome.app"
alias jn="jupyter notebook"


# Functions
# ============
weather() {
    if [[ $# -eq 0 ]]; then
        curl "wttr.in/~Blacksburg"
    else
        curl "wttr.in/\~$1"
    fi
}

search() {
    s="$1"
    find . | while IFS= read -r f; do
        cat "$f" | grep -E "$s" && (
            print -P "%F{cyan}"
            echo "${f#`pwd`}"
            print -P "%f"
        )
    done
}

# List files changed between a commit range
glc() {
    commit_range="$1"
    git log --name-only --pretty=oneline --full-index "$commit_range" | grep -vE '^[0-9a-f]{40} ' | sort | uniq
}

squash() {
    # Thank you https://stackoverflow.com/a/5201642/1313757
    git reset --soft HEAD~$1 && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
}

gta() {
    # Thank you https://stackoverflow.com/a/10312587/1313757
    git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
}

swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE $2
}

# Restart wifi until connection detected
rw() {
    while true; do
        sudo ifconfig en0 down >/dev/null
        sudo ifconfig en0 up >/dev/null
        sleep 5 && curl icanhazip.com && break
    done
    echo "$fg[green]Success!"
}

# Switch to dark theme(s)
D() {
    DARK_THEME="Matrix"
    echo -e "\033]50;SetProfile=$DARK_THEME\a"
    export THEME="dark"
}

# Switch to light theme(s)
L() {
    LIGHT_THEME="MatrixLight"
    echo -e "\033]50;SetProfile=$LIGHT_THEME\a"
    export THEME="light"
}

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
