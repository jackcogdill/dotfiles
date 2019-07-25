# Dotfiles
My personal config files for (mostly) everything I use.

## Screenshots

![2019-07-04](https://github.com/jackcogdill/dotfiles/blob/master/screenshots/2019-07-24.png)

## Install

```bash
git clone https://github.com/jackcogdill/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

To overwrite files when creating symlinks, use `~/.dotfiles/install.sh -f`.

## Contents
- [bash](bash/.bashrc)
- [iTerm2](iterm2/com.googlecode.iterm2.plist)
- [(Neo)Vim](vim/.vim/vimrc)
- [tmux](tmux/.tmux.conf)
- [zsh](zsh/.zshrc)

## Todo

## Completed

- [x] Create `install.sh` to create symlinks
- [x] Make single vim config with `if has('nvim')` blocks
- [x] Find more suitable light theme
- [x] ssh: auto tmux (`tmux new -A -s ssh`)
- [x] Use stow to create symlinks
