#!/bin/bash

# Detect the operating system
OS=$(uname)

# Function to display a message and exit if a command fails
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Symlink .bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
check_command "Symlinking .bashrc"

# Backup and symlink .vimrc
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
#!/bin/bash

# Detect the operating system
OS=$(uname)

# Function to display a message and exit if a command fails
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Symlink .bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
check_command "Symlinking .bashrc"

# Backup and symlink .vimrc
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
    echo "Backed up .vimrc to .vimrc.bak"
fi
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
check_command "Symlinking .vimrc"

# Backup and symlink .tmux.conf
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
    echo "Backed up .tmux.conf to .tmux.conf.bak"
fi
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
check_command "Symlinking .tmux.conf"

# Symlink config files
for file in ~/.dotfiles/.config/*; do
    if [ -e "$HOME/.config/$(basename "$file")" ]; then
        if [ -d "$HOME/.config/$(basename "$file")" ]; then
            rm -rf "$HOME/.config/$(basename "$file")"
        else
            mv "$HOME/.config/$(basename "$file")" "$HOME/.config/$(basename "$file").bak"
            echo "Backed up $(basename "$file") to $(basename "$file").bak"
        fi
    fi
    ln -sf "$file" "$HOME/.config/$(basename "$file")"
    check_command "Symlinking $(basename "$file")"
done

# Symlink tmux files
for file in ~/.dotfiles/.tmux/*; do
    if [ -e "$HOME/.tmux/$(basename "$file")" ]; then
        mv "$HOME/.tmux/$(basename "$file")" "$HOME/.tmux/$(basename "$file").bak"
        echo "Backed up $(basename "$file") to $(basename "$file").bak"
    fi
    ln -sf "$file" "$HOME/.tmux/$(basename "$file")"
    check_command "Symlinking $(basename "$file")"
done

# Install package manager and dependencies based on the operating system
if [ "$OS" == "Linux" ]; then
    echo "Installing dependencies for Linux..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y neovim tmux
        check_command "Installing neovim and tmux via apt-get"
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y neovim tmux
        check_command "Installing neovim and tmux via dnf"
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm neovim tmux
        check_command "Installing neovim and tmux via pacman"
    else
        echo "Unsupported Linux distribution. Please install neovim and tmux manually."
    fi
elif [ "$OS" == "Darwin" ]; then
    # Install Homebrew if not already installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        check_command "Installing Homebrew"
    else
        echo "Homebrew is already installed."
    fi

    # Install dependencies for macOS using Homebrew
    brew install neovim tmux
    check_command "Installing neovim and tmux via Homebrew"
else
    echo "Unsupported operating system. Please install neovim and tmux manually."
fi

echo "Setup completed successfully."

    echo "Backed up .vimrc to .vimrc.bak"
fi
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
check_command "Symlinking .vimrc"

# Backup and symlink .tmux.conf
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
    echo "Backed up .tmux.conf to .tmux.conf.bak"
fi
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
check_command "Symlinking .tmux.conf"

# Symlink config files
for file in ~/.dotfiles/.config/*; do
    if [ -e "$HOME/.config/$(basename "$file")" ]; then
        if [ -d "$HOME/.config/$(basename "$file")" ]; then
            rm -rf "$HOME/.config/$(basename "$file")"
        else
            mv "$HOME/.config/$(basename "$file")" "$HOME/.config/$(basename "$file").bak"
            echo "Backed up $(basename "$file") to $(basename "$file").bak"
        fi
    fi
    ln -sf "$file" "$HOME/.config/$(basename "$file")"
    check_command "Symlinking $(basename "$file")"
done

# Symlink tmux files
for file in ~/.dotfiles/.tmux/*; do
    if [ -e "$HOME/.tmux/$(basename "$file")" ]; then
        mv "$HOME/.tmux/$(basename "$file")" "$HOME/.tmux/$(basename "$file").bak"
        echo "Backed up $(basename "$file") to $(basename "$file").bak"
    fi
    ln -sf "$file" "$HOME/.tmux/$(basename "$file")"
    check_command "Symlinking $(basename "$file")"
done

# Install package manager and dependencies based on the operating system
if [ "$OS" == "Linux" ]; then
    echo "Installing dependencies for Linux..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y neovim tmux
        check_command "Installing neovim and tmux via apt-get"
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y neovim tmux
        check_command "Installing neovim and tmux via dnf"
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm neovim tmux
        check_command "Installing neovim and tmux via pacman"
    else
        echo "Unsupported Linux distribution. Please install neovim and tmux manually."
    fi
    if ! command -v brew &> /dev/null; then
      # Install Homebrew if not already installed
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      check_command "Installing Homebrew"
    else
      echo "Homebrew is already installed."
      fi
      
      # Install dependencies for macOS using Homebrew
      brew install neovim tmux
      check_command "Installing neovim and tmux via Homebrew"
    else
      echo "Unsupported operating system. Please install neovim and tmux manually."
      fi
      
elif [ "$OS" == "Darwin" ]; then
echo "Setup completed successfully."

