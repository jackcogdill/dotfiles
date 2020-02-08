# Dotfiles

Tailored to me. Use at your own risk :)

## Screenshots

![2020-02-07](https://github.com/jackcogdill/dotfiles/blob/master/screenshots/2020-02-07.png)

Font: [Input](https://input.fontbureau.com/info/)

## Install

```bash
git clone https://github.com/jackcogdill/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

## Todo

- [ ] Make install process not rely on git (perhaps use curl)

## Completed

- [x] Create `install.sh` to create symlinks
- [x] Make single vim config with `if has('nvim')` blocks
- [x] Find more suitable light theme
- [x] ssh: auto tmux (`tmux new -A -s ssh`)
- [x] Use stow to create symlinks
