#! /bin/bash

# Detect OS
# ============
LINUX=0
MACOS=0
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  LINUX=1
elif [[ "$OSTYPE" == "darwin"* ]]; then
  MACOS=1
fi
# Usage: if (( LINUX ))
# Thank you https://stackoverflow.com/a/8597411/1313757


# Install packages
# ================
packages=(
  neovim
  stow
)
pkg_manager=
if (( MACOS )); then
  pkg_manager="brew install"
fi
for pkg in "${packages[@]}"; do
  $pkg_manager $pkg
done


# Create symlinks
# ================
dots=(
  bash
  brew
  git
  tmux
  vim
  zsh
)
for pkg in "${dots[@]}"; do
  stow -t ~ $pkg
done

# Neovim
ln -s $(pwd)/vim/.vim/vimrc ~/.config/nvim/init.vim


# Antigen setup
# ================
git clone https://github.com/zsh-users/antigen ~/.antigen


# Tmux setup
# ================
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# macOS config
# ================
if (( MACOS )); then
  # Key repeat
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
fi


# Clean up
# ================
unset LINUX
unset MACOS
unset packages
unset pkg_manager
unset dots
