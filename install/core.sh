#! /bin/bash

cd $(dirname "$0")/..

# Change shell to zsh
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
fi

# Install zplug
[ -d ~/.zplug ] || curl -sL --proto-redir -all,https \
  https://raw.githubusercontent.com/zplug/installer/master/installer.zsh \
  | zsh

# Create symlinks
dots=(
  git
  tmux
  zsh
)
for pkg in "${dots[@]}"; do
  stow -t ~ $pkg
done

# Alacritty
mkdir -p ~/.config/alacritty
stow --target ~/.config/alacritty alacritty

# NeoVim
mkdir -p ~/.config/nvim
stow --target ~/.config/nvim nvim

# Tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Fonts
echo "Download the font 'BlexMono Nerd Font Mono' from https://github.com/ryanoasis/nerd-fonts/releases/latest"
echo "Download the font 'IBM Plex Mono' from https://github.com/IBM/plex/releases/latest"
