# Linux-specific zsh config. Deployed to $ZDOTDIR/os.zsh and sourced by .zshrc.

# Neovim
# Skip if already resolvable (symlink/apt/brew); otherwise try the known prebuilt-tarball directories
if ! command -v nvim >/dev/null 2>&1; then
  for d in /opt/nvim-linux64/bin /opt/nvim-linux-x86_64/bin; do
    [[ -x "$d/nvim" ]] && { export PATH="$PATH:$d"; break; }
  done
  command -v nvim >/dev/null 2>&1 || \
    print -u2 "⚠️  nvim not found — install it / add it to PATH (linux/os.zsh)"
fi

# Spicetify
if [[ -d "$HOME/.spicetify" ]]; then
  export PATH="$PATH:$HOME/.spicetify"
else
  print -u2 "⚠️  ~/.spicetify not found; not added to PATH (linux/os.zsh)"
fi
