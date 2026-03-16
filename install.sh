#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

# ---------- Detect OS & package manager ----------
install_packages() {
    local packages=(zsh zellij git curl neovim fzf ripgrep fd)

    if [[ "$OSTYPE" == darwin* ]]; then
        if command -v brew &>/dev/null; then
            if [ -f "$DOTFILES_DIR/Brewfile" ]; then
                echo "Installing packages from Brewfile..."
                brew bundle --file="$DOTFILES_DIR/Brewfile"
            else
                echo "Installing packages via Homebrew..."
                brew install "${packages[@]}"
            fi
        else
            echo "Homebrew not found. Install it or install these manually: ${packages[*]}"
            exit 1
        fi
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        # fd is packaged as fd-find on Debian/Ubuntu
        local apt_packages=("${packages[@]/fd/fd-find}")
        if command -v apt-get &>/dev/null; then
            echo "Installing packages via apt..."
            sudo apt-get update
            sudo apt-get install -y "${apt_packages[@]}"
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
            echo "  ok: $dst (already linked)"
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

    # Neovim
    link_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

    # Starship
    mkdir -p "$HOME/.config"
    link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

    # Zellij layouts
    mkdir -p "$HOME/.config/zellij/layouts"
    link_file "$DOTFILES_DIR/.config/zellij/layouts/dev.kdl" "$HOME/.config/zellij/layouts/dev.kdl"
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

# ---------- Zsh plugins ----------
setup_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
    fi

    if [ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_custom/plugins/zsh-syntax-highlighting"
    fi
}

# ---------- Set default shell ----------
set_default_shell() {
    if [ "${DOTFILES_NONINTERACTIVE:-}" = "1" ]; then
        return
    fi

    local zsh_path
    if grep -q "^$(which zsh)$" /etc/shells 2>/dev/null; then
        zsh_path="$(which zsh)"
    elif grep -q "^/bin/zsh$" /etc/shells 2>/dev/null; then
        zsh_path="/bin/zsh"
    else
        echo "Warning: No zsh found in /etc/shells. Add it manually and run: chsh -s \$(which zsh)"
        return
    fi

    if [ "$SHELL" != "$zsh_path" ]; then
        echo ""
        echo "Changing default shell to $zsh_path..."
        chsh -s "$zsh_path"
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

    if [ "${DOTFILES_NONINTERACTIVE:-}" = "1" ]; then
        install_packages
    else
        read -p "Install system packages? (y/N) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_packages
        fi
    fi

    setup_symlinks
    setup_omz
    setup_zsh_plugins
    setup_nvm
    set_default_shell

    echo ""
    echo "Done! Restart your shell or run: source ~/.zshrc"
    echo ""
    echo "Tip: Put machine-specific config in ~/.zshrc.local"
}

main "$@"
