#!/bin/bash

# Show the error and quits
function exit_with_error() {
    echo "Error : $1"
    exit 1
}

# ====== MacOs Install Procedure =======
function install_mac_os() {
    source "$HOME/.zshrc"

    # Oh my zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || exit_with_error "Failed to install Oh My Zsh"
    else
        echo "Oh My Zsh already installed. Skipping."
    fi

    # Starship
    if ! command -v starship >/dev/null 2>&1; then
        echo "Starship not found. Installing..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes || exit_with_error "Failed to install Starship"
    else
        echo "Starship already installed. Skipping."
    fi

    # NVM
    if ! command -v nvm >/dev/null 2>&1; then
        echo "NVM not found. Installing..."
        sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)" || exit_with_error "Failed to install NVM"
        sh -c $(nvm install --lts --default) || exit_with_error "Couldn't install node lts"
    else
        echo "NVM already installed. Skipping."
    fi

    # Homebrew
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit_with_error "Failed to install Homebrew"
    fi

    # Checking brewfile
    if [ -f "$HOME/Brewfile" ]; then
        echo "Installing Brew bundle from Brewfile..."
        brew bundle install --file="$HOME/Brewfile" || exit_with_error "Failed to install from Brewfile"
    else
        echo "No Brewfile found at $HOME/Brewfile. Skipping."
    fi

    # Jetbrains Mono Nerd Font
    if ! find ~/Library/Fonts -iname "*JetBrains*Nerd*" -print -quit | grep -q "."; then
        echo "JetBrains Mono Nerd Font not found. Installing..."
        curl -LOJ "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/JetBrainsMono.zip" || exit_with_error "Failed to download JetBrains Mono Nerd Font"
        unzip -o JetBrainsMono.zip -d "$HOME/Library/Fonts" || exit_with_error "Failed to unzip JetBrains Mono Nerd Font"
        rm JetBrainsMono.zip
    else
        echo "JetBrains Mono Nerd Font already installed."
    fi

    # Checking brewfile
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "Installing tpm"
        git clone git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    else
        echo "tmp exists. Skipping."
    fi
}

# ====== Debian Install Procedure =======
function install_debian() {
    echo "Not supported at the moment"
}

# ========== OS Checking ===============
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_mac_os
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_debian
else
    exit_with_error "OS not supported"
fi




echo "Done."

