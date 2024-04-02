#!/bin/bash

# Set locale to UTF-8
export LC_ALL=C.UTF-8

# Install dependencies
sudo apt-get update
sudo apt-get install -y neovim tmux

# Create symlinks for dotfiles
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.config/* ~/.config/*

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


