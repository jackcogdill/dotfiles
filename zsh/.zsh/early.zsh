printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs

function _auto_tmux() {
  local session="tmux"
  [[ -n $SSH_CONNECTION ]] && session="ssh"

  # session does not exist
  if ! 2>/dev/null tmux has -t "$session"; then
    tmux new -t "$session"
    return
  fi

  # session exists and is not attached
  if [[ -n $(tmux ls -f "#{&&:#{==:#{session_name},$session},#{==:#{session_attached},0}}") ]]; then
    tmux attach -t "$session"
    return
  fi

  # find or create an alternate session in the same group
  local i=0
  until [[ -z $(tmux ls -f "#{&&:#{==:#{session_name},$session$i},#{==:#{session_attached},1}}") ]]; do
    (( i++ ))
  done

  tmux new -A -s "$session$i" -t "$session"
}

# Auto tmux
[[ $- == *i* && -z "$TMUX" ]] && _auto_tmux

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
