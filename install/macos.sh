# Key repeat
defaults write -g ApplePressAndHoldEnabled -bool false # disable alternate character menu
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
echo "Key repeat changes require restart"

# Allow quitting Finder
defaults write com.apple.finder QuitMenuItem -bool true
killall Finder
