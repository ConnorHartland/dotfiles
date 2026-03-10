# dotfiles

Personal dotfiles managed with symlinks.

## What's included

- **zsh** config with Oh My Zsh
- **git** config and global gitignore
- **zellij** terminal multiplexer config
- **nvm** for Node.js version management

## Install

```bash
git clone https://github.com/ConnorHartland/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

Machine-specific config (API keys, work email, etc.) goes in `~/.zshrc.local` which is sourced automatically and not tracked by git.
