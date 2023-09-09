printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs

# Auto tmux
if [[ $- == *i* && -z "$TMUX" ]]; then
  [[ -n "$SSH_CONNECTION" ]] && local session="ssh" || local session="tmux"
  tmux new -A -s "$session"
fi
