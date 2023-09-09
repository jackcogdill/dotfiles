# Courtesy of https://github.com/mattmc3/zsh_unplugged

function plugin-clone {
  local repo plugdir initfile initfiles=()
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) && ln -sf $initfiles[1] $initfile
    fi
  done
}

function plugin-source {
  local plugdir
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for plugdir in $@; do
    [[ $plugdir = /* ]] || plugdir=$ZPLUGINDIR/$plugdir
    fpath+=$plugdir
    local initfile=$plugdir/${plugdir:t}.plugin.zsh
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

repos=(
  romkatv/powerlevel10k
  ohmyzsh/ohmyzsh
  zsh-users/zsh-autosuggestions
  zdharma-continuum/fast-syntax-highlighting
)
plugin-clone $repos

source $ZPLUGINDIR/ohmyzsh/lib/completion.zsh # [tab] squares
source $ZPLUGINDIR/ohmyzsh/lib/directories.zsh
source $ZPLUGINDIR/ohmyzsh/lib/history.zsh

plugins=(
  powerlevel10k
  zsh-autosuggestions
  fast-syntax-highlighting
  ohmyzsh/plugins/git
  ohmyzsh/plugins/python
  ohmyzsh/plugins/extract
)
[[ -f /etc/debian_version ]] && plugins+=ohmyzsh/plugins/debian
plugin-source $plugins

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

# p10k
# ----
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
