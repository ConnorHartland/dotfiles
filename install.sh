#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y neovim tmux

ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Install Neovim plugins

mkdir -p ~/.config/nvim/autload
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install 

nvim +PlugInstall +qall


