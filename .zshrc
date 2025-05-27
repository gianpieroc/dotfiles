



# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Python
export PYTHON=$(which python3)

# NVM
source $(brew --prefix nvm)/nvm.sh

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

#TMUX 
XDG_CONFIG_HOME="$HOME/.config/" 

source $ZSH/oh-my-zsh.sh

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/Users/gianpiero/.bun/_bun" ] && source "/Users/gianpiero/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias bunx="bun x"

# Colored commands.
alias ls='ls --color=auto'

# General git aliases.
alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gl='git log'
alias gp='git push'
alias gs='git status'


