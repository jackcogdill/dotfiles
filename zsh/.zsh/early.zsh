printf '\e[1 q' # Blinking block cursor
bindkey -e # Emacs

# Auto tmux
if [[ $- == *i* && -z "$TMUX" ]]; then
  [[ -n "$SSH_CONNECTION" ]] && local session="ssh" || local session="tmux"
  if tmux ls | grep -q "(attached)"; then
    # create new session in the same group
    tmux new -A -s "${session}-alt" -t "${session}"
  else
    tmux new -A -s "${session}"
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
