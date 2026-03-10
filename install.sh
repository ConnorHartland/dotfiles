#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

# ---------- Detect OS & package manager ----------
install_packages() {
    local packages=(zsh zellij git curl)

    if [[ "$OSTYPE" == darwin* ]]; then
        if command -v brew &>/dev/null; then
            echo "Installing packages via Homebrew..."
            brew install "${packages[@]}"
        else
            echo "Homebrew not found. Install it or install these manually: ${packages[*]}"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if command -v apt-get &>/dev/null; then
            echo "Installing packages via apt..."
            sudo apt-get update
            sudo apt-get install -y "${packages[@]}"
        elif command -v dnf &>/dev/null; then
            echo "Installing packages via dnf..."
            sudo dnf install -y "${packages[@]}"
        elif command -v pacman &>/dev/null; then
            echo "Installing packages via pacman..."
            sudo pacman -Syu --noconfirm "${packages[@]}"
        else
            echo "No supported package manager found. Install these manually: ${packages[*]}"
            exit 1
        fi
    else
        echo "Unsupported OS. Install these manually: ${packages[*]}"
        exit 1
    fi
}

# ---------- Symlink helper ----------
link_file() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            echo "  ok: $dst -> $src (already linked)"
            return
        fi
        echo "  backup: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -sf "$src" "$dst"
    echo "  link: $dst -> $src"
}

# ---------- Symlink dotfiles ----------
setup_symlinks() {
    echo ""
    echo "Setting up symlinks..."

    link_file "$DOTFILES_DIR/.zshrc"              "$HOME/.zshrc"
    link_file "$DOTFILES_DIR/.gitconfig"           "$HOME/.gitconfig"
    link_file "$DOTFILES_DIR/.gitignore_global"    "$HOME/.gitignore_global"

    # Zellij
    mkdir -p "$HOME/.config/zellij"
    link_file "$DOTFILES_DIR/.config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
}

# ---------- Oh My Zsh ----------
setup_omz() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo ""
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo ""
        echo "Oh My Zsh already installed."
    fi
}

# ---------- Set default shell ----------
set_default_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo ""
        echo "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
    fi
}

# ---------- NVM ----------
setup_nvm() {
    if [ ! -d "$HOME/.nvm" ]; then
        echo ""
        echo "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    else
        echo ""
        echo "NVM already installed."
    fi
}

# ---------- Main ----------
main() {
    echo "=== Dotfiles Setup ==="
    echo ""

    read -p "Install system packages? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_packages
    fi

    setup_symlinks
    setup_omz
    setup_nvm
    set_default_shell

    echo ""
    echo "Done! Restart your shell or run: source ~/.zshrc"
    echo ""
    echo "Tip: Put machine-specific config (AWS creds, API keys, etc.) in ~/.zshrc.local"
}

main "$@"
