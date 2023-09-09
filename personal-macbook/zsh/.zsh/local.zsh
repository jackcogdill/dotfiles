PATH=$PATH:/opt/homebrew/opt/coreutils/libexec/gnubin
PATH=$PATH:~/.cargo/bin
PATH=$PATH:/usr/local/sbin

fpath+=${ZDOTDIR:-~}/.zsh_functions

setup-lscolors # redo after updating path

# Homebrew
alias bubu="brew upgrade && brew cleanup && brew update && brew outdated"

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[[ -s "/usr/local/opt/nvm/nvm.sh" ]] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[[ -s "/usr/local/opt/nvm/etc/bash_completion" ]] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Tmux
TMUX_LAYOUTS="$HOME/.tmux/layouts.json"

function savel() {
  [[ -f "$TMUX_LAYOUTS" ]] || echo "{}" > "$TMUX_LAYOUTS"
  local name="$1"
  local layout=$(tmux list-windows -F '#{?window_active,#{window_layout},}' | grep .)
  jq --arg name "$name" --arg layout "$layout" '.[$name] = $layout' "$TMUX_LAYOUTS" | sponge "$TMUX_LAYOUTS"
}

function loadl() {
  local layouts=(${(@f)$(jq --raw-output 'keys[]' $TMUX_LAYOUTS)})
  (COLUMNS=1
  PS3="Select a saved tmux layout: "
  select layout in $layouts; do
    tmux select-layout $(jq --raw-output --arg layout "$layout" '.[$layout]' "$TMUX_LAYOUTS")
    break
  done)
}
