# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Aliases
source $HOME/.aliases
