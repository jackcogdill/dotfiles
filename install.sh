#! /bin/bash

dotfiles="$HOME/.dotfiles"

for file in $(ls -A "$dotfiles/home"); do
    ln -s "$dotfiles/home/$file" "$HOME/$file"
done

ln -s "$dotfiles/vim/init.vim" "$HOME/.config/nvim/init.vim" # NeoVim
ln -s "$dotfiles/vim/init.vim" "$HOME/.vimrc" # Vim
