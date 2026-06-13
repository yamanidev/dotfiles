# macOS-specific zsh config. Deployed to $ZDOTDIR/os.zsh and sourced by .zshrc.

# Homebrew (Apple Silicon prefix; use /usr/local on Intel Macs).
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Spicetify
if [[ -d "$HOME/.spicetify" ]]; then
  export PATH="$PATH:$HOME/.spicetify"
else
  print -u2 "⚠️  ~/.spicetify not found; not added to PATH (macos/os.zsh)"
fi
