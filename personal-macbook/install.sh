#!/bin/bash

cd $(dirname "$0")

# NeoVim
stow --target ~/.config/nvim/lua/plugins nvim-plugins
