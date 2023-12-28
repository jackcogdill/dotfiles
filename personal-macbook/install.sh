#!/bin/zsh

cd $(dirname "$0")

packages=(
  lua-language-server
)
brew install $packages

# zsh
pushd zsh >/dev/null
stow --target ~/.zsh .zsh
stow --target ~ local
popd >/dev/null

# neovim
pushd nvim >/dev/null
mkdir -p ~/.config/nvim/lua/local
stow --target ~/.config/nvim/lua/local local
stow --target ~/.config/nvim/lua/plugins plugins
popd >/dev/null
