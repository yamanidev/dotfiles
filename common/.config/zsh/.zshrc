# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  git
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
  nvm
)

source $ZSH/oh-my-zsh.sh

# Terminal tab/window title: just the working directory — no user@host flash.
# Must come AFTER sourcing oh-my-zsh (it sets these unconditionally otherwise).
ZSH_THEME_TERM_TITLE_IDLE="%~"
ZSH_THEME_TERM_TAB_TITLE_IDLE="%~"

# .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Aliases
source $HOME/.aliases

#compdef pnpm
###-begin-pnpm-completion-###
if type compdef &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }
  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi
###-end-pnpm-completion-###

# pyenv (only initialise if it's actually installed)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if [[ -d $PYENV_ROOT/shims ]]; then
  export PATH="$PYENV_ROOT/shims:$PATH"
  pyenv() { unset -f pyenv; eval "$(command pyenv init - zsh)"; pyenv "$@"; }
fi

# User-local bins
export PATH="$HOME/.local/bin:$PATH"

# ---- OS-specific overlay --------------------------------------------------
# install.sh deploys linux/.config/zsh/os.zsh or macos/.config/zsh/os.zsh
# to $ZDOTDIR/os.zsh. Everything OS-specific (extra PATHs, brew, etc.) lives there.
[[ -r "$ZDOTDIR/os.zsh" ]] && source "$ZDOTDIR/os.zsh"
