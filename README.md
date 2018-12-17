# Dotfiles
My personal config files for (mostly) everything I use.

## Install

```bash
git clone https://github.com/jackcogdill/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

To overwrite files when creating symlinks, use `~/.dotfiles/install.sh -f`.

## Contents
- [bash](home/.bashrc)
- [iTerm2](iterm2/com.googlecode.iterm2.plist)
- [(Neo)Vim](vim/init.vim)
- [tmux](home/.tmux.conf)
- [zsh](home/.zshrc)

## Todo

- [x] Create `install.sh` to create symlinks
- [x] Make single vim config with `if has('nvim')` blocks
- [x] Install [One Half](https://github.com/sonph/onehalf) theme
- [ ] Find more suitable light theme
