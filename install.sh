#! /bin/bash

# Option handling
# ================
OPTIND=1 # Reset in case getopts has been used previously in the shell
force=0

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
    f)  force=1
        ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift


# Create Symlinks
# ================
dotfiles="$HOME/.dotfiles"
ln_params=$( (( $force )) && echo "-sf" || echo "-s" )

for file in $(ls -A "$dotfiles/home"); do
    ln "$ln_params" "$dotfiles/home/$file" "$HOME/$file"
done

if [ -d "$HOME/.config/nvim" ]; then
    ln "$ln_params" "$dotfiles/vim/init.vim" "$HOME/.config/nvim/init.vim" # NeoVim
fi
ln "$ln_params" "$dotfiles/vim/init.vim" "$HOME/.vimrc" # Vim


# macOS config
# ================
# Key repeat
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
