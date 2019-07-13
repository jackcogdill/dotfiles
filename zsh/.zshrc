# Detect OS
# ============
LINUX=0
MACOS=0
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  LINUX=1
elif [[ "$OSTYPE" == "darwin"* ]]; then
  MACOS=1
fi
# Usage: if (( LINUX ))
  # Thank you https://stackoverflow.com/a/8597411/1313757

# Load nerd font vars
source ~/.fonts/lib/i_oct.sh


# Antigen
# ============
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh

# Plugins
antigen bundle git
antigen bundle history
antigen bundle python
antigen bundle extract

if (( LINUX )); then
  antigen bundle debian
elif (( MACOS )); then
  antigen bundle brew
fi

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jackcogdill/autoupdate-antigen # Auto updates for antigen

# Theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply


# Prompt
# ============
printf '\e[1 q' # Blinking box cursor


# Misc
# ============
# Line editing
bindkey -v # Vi mode
export KEYTIMEOUT=1 # Reduce default 0.4s delay after hitting <ESC> key
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history
# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
# ctrl-w removed word backwards
bindkey '^w' backward-kill-word
# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward


# Plugin configs
# ============
# Pure theme
PURE_GIT_DOWN_ARROW=$i_oct_chevron_down
PURE_GIT_UP_ARROW=$i_oct_chevron_up

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=63'

# Environment vars
# ============
# Path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@3.4/bin:$PATH"

# Editor
export EDITOR=`which nvim`
export VISUAL="$EDITOR"


# Aliases
# ============
alias lt='ls -halt' # human readable, show hidden, print details, sort by date
alias ip='curl icanhazip.com'
alias gh='cd ~/Git_Repos'
alias zshrc="$EDITOR ~/.zshrc && source ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias mfind="mdfind -onlyin ."
alias bubu="brew upgrade && brew cleanup && brew update && brew outdated" # Update brew

# SSH
alias rl="ssh -t jackcog@rlogin.cs.vt.edu zsh"
alias rlb="ssh jackcog@rlogin.cs.vt.edu" # ssh to rlogin in bash (instead of zsh)
alias portal="ssh jackcog@portal.cs.vt.edu"
alias ourlogin="ssh kiyoshi@ourlogin.space"

# Git
alias gpf="git push -f"
alias gla="git pull --all"
alias gu="gta; gfa; gla"

alias todo="$EDITOR ~/Documents/todo.md"
alias hw="todo"
alias javarepl="java -jar /opt/local/share/java/javarepl*.jar"
alias tapastic="python2 ~/Programming/Python/tapastic\ dl"
alias vs="open -a /Applications/Visual\ Studio\ Code.app"
alias vlc="open -a /Applications/VLC.app"
alias chrome="open -a /Applications/Google\ Chrome.app"
alias jn="jupyter notebook"


# Functions
# ============
# Random 4-byte number
function rand() {
  od -An -D -N 4 /dev/urandom | tr -d ' '
}

function verse() {
  local verses
  verses=(
    "There is neither Jew nor Greek, there is neither slave nor free, there is no male and female, for you are all one in Christ Jesus.\n\nGalatians 3:28"
    "Be not a terror to me; you are my refuge in the day of disaster.\n\nJeremiah 17:7"
    "If we confess our sins, he is faithful and just to forgive us our sins and to cleanse us from all unrighteousness.\n\nI John 1:9"
    "And we know that for those who love God all things work together for good, for those who are called according to his purpose.\n\nRomans 8:28"
    "There is therefore now no condemnation for those who are in Christ Jesus.\n\nRomans 8:1"
    "For 'everyone who calls on the name of the Lord will be saved.'\n\nRomans 10:13"
    "In the beginning was the Word, and the Word was with God, and the Word was God.\n\nJohn 1:1"
    "For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.\n\nJohn 3:16"
    "Rejoice in the Lord always; again I will say, rejoice. Let your reasonableness be known to everyone. The Lord is at hand; do not be anxious about anything, but in everything by prayer and supplication with thanksgiving let your requests be made known to God. And the peace of God, which surpasses all understanding, will guard your hearts and your minds in Christ Jesus.\n\nPhilippians 4:4-7"
    "do not be anxious about anything, but in everything by prayer and supplication with thanksgiving let your requests be made known to God. And the peace of God, which surpasses all understanding, will guard your hearts and your minds in Christ Jesus. Finally, brothers, whatever is true, whatever is honorable, whatever is just, whatever is pure, whatever is lovely, whatever is commendable, if there is any excellence, if there is anything worthy of praise, think about these things. What you have learned and received and heard and seen in me--practice these things, and the God of peace will be with you.\n\nPhilippians 4:6-9"
    "Finally, be strong in the Lord and in the strength of his might. Put on the whole armor of God, that you may be able to stand against the schemes of the devil. For we do not wrestle against flesh and blood, but against the rulers, against the authorities, against the cosmic powers over this present darkness, against the spiritual forces of evil in the heavenly places. Therefore take up the whole armor of God, that you may be able to withstand in the evil day, and having done all, to stand firm. Stand therefore, having fastened on the belt of truth, and having put on the breastplate of righteousness, and, as shoes for your feet, having put on the readiness given by the gospel of peace. In all circumstances take up the shield of faith, with which you can extinguish all the flaming darts of the evil one; and take the helmet of salvation, and the sword of the Spirit, which is the word of God, praying at all times in the Spirit, with all prayer and supplication. To that end, keep alert with all perseverance, making supplication for all the saints,\n\nEphesians 6:10-18"
    "Then my enemy will see, and shame will cover her who said to me, 'Where is the Lord your God?' My eyes will look upon her; now she will be trampled down like the mire of the streets.\n\nMicah 7:10"
    "All Scripture is breathed out by God and profitable for teaching, for reproof, for correction, and for training in righteousness, that the man of God may be complete, equipped for every good work.\n\nII Timothy 3:16-17"
    "Do not be unequally yoked with unbelievers. For what partnership has righteousness with lawlessness? Or what fellowship has light with darkness? What accord has Christ with Belial? Or what portion does a believer share with an unbeliever? What agreement has the temple of God with idols? For we are the temple of the living God; as God said, 'I will make my dwelling among them and walk among them, and I will be their God, and they shall be my people.\n\nII Corinthians 6:14-16"
    "The Lord is my shepherd; I shall not want. He makes me lie down in green pastures. He leads me beside still waters. He restores my soul. He leads me in paths of righteousness for his name's sake. Even though I walk through the valley of the shadow of death, I will fear no evil, for you are with me; your rod and your staff, they comfort me. You prepare a table before me in the presence of my enemies; you anoint my head with oil; my cup overflows. Surely goodness and mercy shall follow me all the days of my life, and I shall dwell in the house of the Lord forever.\n\nPsalm 23"
    "He who dwells in the shelter of the Most High will abide in the shadow of the Almighty. I will say to the Lord, 'My refuge and my fortress, my God, in whom I trust.'\n\nPsalm 91:1-2"
    "And without faith it is impossible to please him, for whoever would draw near to God must believe that he exists and that he rewards those who seek him.\n\nHebrews 11:6"
    "But someone will say, 'You have faith and I have works.' Show me your faith apart from your works, and I will show you my faith by my works.\n\nJames 2:18"
    "Enter by the narrow gate. For the gate is wide and the way is easy that leads to destruction, and those who enter by it are many. For the gate is narrow and the way is hard that leads to life, and those who find it are few.\n\nMatthew 7:13-14"
    "And everyone who hears these words of mine and does not do them will be like a foolish man who built his house on the sand. And the rain fell, and the floods came, and the winds blew and beat against that house, and it fell, and great was the fall of it.\n\nMatthew 7:26-27"
    "Now faith is the assurance of things hoped for, the conviction of things not seen. For by it the people of old received their commendation.\n\nHebrews 11:1-2"
    "So God created man in his own image, in the image of God he created him; male and female he created them. And God blessed them. And God said to them, 'Be fruitful and multiply and fill the earth and subdue it, and have dominion over the fish of the sea and over the birds of the heavens and over every living thing that moves on the earth.'\n\nGenesis 1:27-28"
    "Vanity of vanities, says the Preacher, vanity of vanities! All is vanity. What does man gain by all the toil at which he toils under the sun? A generation goes, and a generation comes, but the earth remains forever.\n\nEcclesiastes 1:2-4"
    "And so, from the day we heard, we have not ceased to pray for you, asking that you may be filled with the knowledge of his will in all spiritual wisdom and understanding, so as to walk in a manner worthy of the Lord, fully pleasing to him: bearing fruit in every good work and increasing in the knowledge of God; being strengthened with all power, according to his glorious might, for all endurance and patience with joy; giving thanks to the Father, who has qualified you to share in the inheritance of the saints in light. He has delivered us from the domain of darkness and transferred us to the kingdom of his beloved Son, in whom we have redemption, the forgiveness of sins.\n\nColossians 1:9-14"
    "Has the Lord as much delight in burnt offerings and sacrifices as in obeying the voice of the Lord? Behold to obey is better than sacrifice, and to heed than the fat of rams.\n\n1 Samuel 15:22"
  )
  local index=$(( `rand` % ${#verses[@]} ))
  (( index++ )) # zsh arrays are 1-indexed
  echo ${verses[ index ]}
}

# List files changed between a commit range
function glc() {
  local commit_range="$1"
  git log --name-only --pretty=oneline --full-index "$commit_range" | grep -vE '^[0-9a-f]{40} ' | sort | uniq
}

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Auto tmux
if [[ -z "$TMUX" ]]; then
  local session="default"
  [[ -n "$SSH_CONNECTION" ]] && session="ssh"
  tmux new -A -s "$session"
fi

# NVM (Node Version Management)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Keybindings
# ============
# Auto suggestions
bindkey '^Z' autosuggest-execute # Accept and execute the auto-suggestion with Ctrl-Z

# Clean up
# ============
unset LINUX
unset MACOS
