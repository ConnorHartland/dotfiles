#!/bin/bash

# Set locale to UTF-8
export LC_ALL=C.UTF-8

# Install dependencies
if ! command -v nvim &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y neovim
fi

if ! command -v tmux &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y tmux
fi

# Create directories if they don't exist
mkdir -p ~/.config
mkdir -p ~/.tmux

# Create symlinks for dotfiles
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
ln -sf ~/.dotfiles/.bashrc ~/.bashrc

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
ln -sf ~/.dotfiles/.vimrc ~/.vimrc

if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Symlink config files
for file in ~/.dotfiles/.config/*; do
    if [ -e "$HOME/.config/$(basename "$file")" ]; then
        if [ -d "$HOME/.config/$(basename "$file")" ]; then
            rm -rf "$HOME/.config/$(basename "$file")"
        else
            mv "$HOME/.config/$(basename "$file")" "$HOME/.config/$(basename "$file").bak"
        fi
    fi
    ln -sf "$file" "$HOME/.config/$(basename "$file")"
done

# Symlink tmux files
for file in ~/.dotfiles/.tmux/*; do
    if [ -e "$HOME/.tmux/$(basename "$file")" ]; then
        mv "$HOME/.tmux/$(basename "$file")" "$HOME/.tmux/$(basename "$file").bak"
    fi
    ln -sf "$file" "$HOME/.tmux/$(basename "$file")"
done

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi