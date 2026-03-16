# Dotfiles

Symlink-based dotfiles managed by `install.sh`.

## Structure
- Shell: Oh My Zsh (no theme — uses Starship prompt), local overrides in `~/.zshrc.local`
- Editor: Neovim with LazyVim. Extras in `lazyvim.json`, custom plugins in `lua/plugins/*.lua`
- Terminal multiplexer: Zellij with `clear-defaults=true` and tmux compat mode

## Testing changes
- `./install.sh` — verify symlinks
- `nvim --headless "+Lazy! sync" +qa` — verify plugin config
- `source ~/.zshrc` — verify shell loads
- `zellij --layout dev` — verify dev layout
