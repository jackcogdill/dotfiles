#!/bin/bash

cd $(dirname "$0")

# NeoVim
pushd nvim >/dev/null
mkdir -p ~/.config/nvim/lua/local
stow --target ~/.config/nvim/lua/local local
stow --target ~/.config/nvim/lua/plugins plugins
popd >/dev/null
