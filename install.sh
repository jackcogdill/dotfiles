#! /bin/bash

cd $(dirname "$0")

# TODO: consider changing this to platform-specific install files.
# (e.g. macos.sh -> install packages -> run main install.sh)
# Detect OS
# Usage: if (( LINUX ))
# Thank you https://stackoverflow.com/a/8597411/1313757
LINUX=0
DEBIAN=0
MACOS=0
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  LINUX=1
  if cat /etc/issue | grep -i debian; then
    DEBIAN=1
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  MACOS=1
fi

# Change shell to zsh
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
fi

# Install zplug
[ -d ~/.zplug ] || curl -sL --proto-redir -all,https \
  https://raw.githubusercontent.com/zplug/installer/master/installer.zsh \
  | zsh

# Create symlinks
dots=(
  alacritty
  bash
  git
  tmux
  zsh
)
for pkg in "${dots[@]}"; do
  stow -t ~ $pkg
done

# NeoVim
mkdir -p ~/.config/nvim
stow --target ~/.config/nvim nvim

# Tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# macOS config
if (( MACOS )); then
  # Key repeat
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
  echo "Key repeat changes require restart"

  # Allow quitting Finder
  defaults write com.apple.finder QuitMenuItem -bool true
  killall Finder
fi

echo "Download the Blex Mono nerd font from https://github.com/ryanoasis/nerd-fonts/releases/latest"
echo "Download the IBM Plex Mono font from https://github.com/IBM/plex/releases/latest"
