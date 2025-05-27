#!/bin/bash

# Install homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install Git if not installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed, installing..."
    brew install git
else
    echo "Git is already installed."
fi

# Install Ansible through Homebrew
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed, installing..."
    brew install ansible
else
    echo "Ansible is already installed."
fi

# verify if dotfiles exists
#if [ ! -d "$HOME/.dotfiles.git" ]; then
    # Récupérer le repo git bare avec vos dotfiles
#     git clone --bare <URL_DU_REPO_GIT> $HOME/.dotfiles.git
#
#     # Définir un alias pour gérer les dotfiles
#     alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
#
#     # Configurer les dotfiles
#     dotfiles checkout
#
#     # Ignorer les fichiers non nécessaires
#     dotfiles config --local status.showUntrackedFiles no
# else
#     echo "dotfiles repo already exists."
# fi

# Lancer le playbook Ansible
ansible-playbook macos_playbook.yml

