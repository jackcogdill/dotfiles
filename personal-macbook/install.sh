#!/bin/bash

cd $(dirname "$0")

# NeoVim
mkdir -p ~/.config/nvim/lua/local
stow --target ~/.config/nvim/lua/local nvim-local
stow --target ~/.config/nvim/lua/plugins nvim-plugins
