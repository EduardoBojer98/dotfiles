# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set ZDOTDIR to this config directory
export ZDOTDIR="$HOME/dotfiles/zsh"

# Oh My Zsh setup
export ZSH="$ZDOTDIR/ohmyzsh"

# Point Oh My Zsh to custom theme/plugins (symlink or direct)
ZSH_CUSTOM="$ZDOTDIR/custom"
export ZSH_CUSTOM

# Ensure custom plugins and themes exist
mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

# Symlink plugins if not already
[[ ! -e "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && ln -s "$HOME/.zsh/plugins/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[[ ! -e "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] && ln -s "$HOME/.zsh/plugins/zsh-syntax-highlighting" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[[ ! -e "$ZSH_CUSTOM/themes/powerlevel10k" ]] && ln -s "$HOME/.zsh/plugins/powerlevel10k" "$ZSH_CUSTOM/themes/powerlevel10k"

# Oh My Zsh settings
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# Load Powerlevel10k config if present
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# Path
export PATH="$HOME/.local/bin:$PATH"

# Shell options
setopt CORRECT
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_GLOB

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Local overrides
[[ -f "$ZDOTDIR/.zsh_local" ]] && source "$ZDOTDIR/.zsh_local"

# Lando
eval "$(/home/eduardo/.lando/bin/lando shellenv)"

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
