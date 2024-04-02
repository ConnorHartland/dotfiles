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

# Install Neovim plugins
mkdir -p ~/.config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim +PlugInstall +qall
