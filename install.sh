#! /bin/bash

cd $(dirname "$0")

# Detect OS
# ============
LINUX=0
DEBIAN=0
MACOS=0
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  LINUX=1
  if $(cat /etc/issue | grep -i debian); then
    DEBIAN=1
  fi
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
  zsh
)
pkg_manager=
if (( MACOS )); then
  pkg_manager="brew install"
elif (( DEBIAN )); then
  pkg_manager="apt install"
fi
if [[ -n "$pkg_manager" ]]; then
  for pkg in "${packages[@]}"; do
    $pkg_manager $pkg
  done
fi


# Change shell to zsh
# ============
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
fi


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
mkdir -p ~/.config/nvim/
ln -s "$(pwd)/vim/.vim/vimrc" ~/.config/nvim/init.vim

# Antibody setup
# ================
(( MACOS )) &&
  brew install getantibody/tap/antibody ||
  curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh


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
unset dots
unset packages
unset pkg_manager
unset extra_plugins
