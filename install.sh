#! /bin/bash

# Option handling
# ================
OPTIND=1 # Reset in case getopts has been used previously in the shell
overwrite=false

# Use : to require argument, $OPTARG to access value
while getopts "hf" opt; do
    case "$opt" in
    h)
        printf "Usage:\n\
$0 -h           Show this help\n\
$0 -f           Overwrite files when creating symlinks\n\
"
        exit 0
        ;;
    f)  overwrite=true
        ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift


# Create Symlinks
# ================
dotfiles="$HOME/.dotfiles"
if [ "$overwrite" = true ]; then
    alias ln="ln -sf"
else
    alias ln="ln -s"
fi

for file in $(ls -A "$dotfiles/home"); do
    ln "$dotfiles/home/$file" "$HOME/$file"
done

# NeoVim
if hash nvim 2>/dev/null; then
    mkdir -p "$HOME/.config/nvim"
    ln "$dotfiles/vim/init.vim" "$HOME/.config/nvim/init.vim"
    # vim-plug
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Vim
ln "$dotfiles/vim/init.vim" "$HOME/.vimrc"
# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# macOS config
# ================
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Key repeat
    defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
fi
