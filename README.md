# Dotfiles

Personal dotfiles managed with symlinks.

## What's managed
- `.zshrc` — zsh config with oh-my-zsh, nvm, aliases
- `.gitconfig` / `.gitignore_global` — git defaults
- `.config/zellij/config.kdl` — zellij terminal multiplexer

## Install
```bash
git clone git@github.com:ConnorHartland/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

## Local overrides
Put machine-specific config in `~/.zshrc.local` (not tracked by git).
