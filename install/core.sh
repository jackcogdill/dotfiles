#! /bin/bash

cd $(dirname "$0")/..

# Change shell to zsh
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
fi

# Create symlinks
packages=(
  git
  tmux
  zsh
)
for pkg in "${packages[@]}"; do
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
( # Install nerd font scripts
  cd /tmp
  git clone https://github.com/ryanoasis/nerd-fonts \
    --depth 1 \
    --filter=blob:none \
    --sparse
  cd nerd-fonts
  git sparse-checkout set bin
  mkdir -p ~/.local/share/fonts
  mv bin/scripts/lib/*.sh ~/.local/share/fonts
  rm -rf /tmp/nerd-fonts
)
echo "Download the font 'BlexMono Nerd Font Mono' from https://github.com/ryanoasis/nerd-fonts/releases/latest"
echo "Download the font 'IBM Plex Mono' from https://github.com/IBM/plex/releases/latest"
