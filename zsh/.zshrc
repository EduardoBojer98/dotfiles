# Zsh config directory
export ZDOTDIR="$HOME/dotfiles/zsh"

# Oh My Zsh setup
export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# Path
export PATH="$HOME/.local/bin:$PATH"

# Plugin directory
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR"

# Plugin sources
declare -A custom_plugins=(
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  [pure]="https://github.com/sindresorhus/pure.git"
)

# Clone plugins if missing
for plugin in "${(@k)custom_plugins}"; do
  plugin_dir="$ZSH_PLUGIN_DIR/$plugin"
  if [[ ! -d "$plugin_dir" ]]; then
    echo "Installing $plugin..."
    git clone --depth=1 "${custom_plugins[$plugin]}" "$plugin_dir"
  fi
done

# Load Pure prompt
fpath+="$ZSH_PLUGIN_DIR/pure"
autoload -U promptinit; promptinit
prompt pure

# Load other plugins
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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
