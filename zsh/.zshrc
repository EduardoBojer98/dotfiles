# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  zoxide
  fzf
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Use bat as man pager if available
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Use zoxide instead of plain `cd`
eval "$(zoxide init zsh)"

# Preferred editor
export EDITOR="nvim"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Enable autosuggestions and syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Aliases
alias ll='exa -al --color=always --group-directories-first'
alias la='exa -a'
alias l='exa'
alias cat='bat'
alias gs='git status'
alias gl='git log --oneline --graph --all --decorate'
alias ..='cd ..'
alias ...='cd ../..'
alias please='sudo'

# Enable Powerlevel10k instant prompt (optional but makes shell faster)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export WLR_RENDERER_ALLOW_SOFTWARE=1
