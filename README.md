# Dotfiles – Personal Linux Configuration

This repository contains my personal dotfiles for a minimal, performant, and cohesive Wayland setup using Hyprland.

## Apps

- **GNU Stow** – Manages symlinks for dotfiles across directories.
- **wvkbd** – On-screen virtual keyboard for Wayland.
- **Hyprland** – A dynamic tiling Wayland compositor.
- **Hyprpaper** – Lightweight wallpaper daemon for Hyprland.
- **Hyprlock** – Lock screen with blur and styling support.
- **Hypridle** – Idle daemon for triggering actions (e.g., screen dimming, lock).
- **Waybar** – Highly customizable status bar for Wayland.
- **swaync** – Notification daemon compatible with Wayland.
- **Wofi** – Application launcher for Wayland.
- **Kitty** – GPU-accelerated terminal emulator.
- **nwg-look** – Tool to apply GTK themes under Wayland.
- **kvantum-qt5 / kvantum-qt6** – Enables custom theming for Qt5/Qt6 applications.
- **kvantummanager** – GUI for managing Kvantum themes.
- **hyprshot** – Simple screenshot utility for Hyprland.

## Shell

### ⚙️ Zsh

Zsh is used as the default shell, configured with **Oh My Zsh** and **Powerlevel10k** for a fast and visually rich command-line experience.

#### Prompt & Theme

- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)** is used as the shell prompt theme.
- Instant prompt is enabled to improve startup performance.

#### Plugins

The following Oh My Zsh plugins are enabled:

- `git` – Git aliases and functions.
- `z` – Directory jumping based on frecency.
- `zoxide` – Smarter, faster alternative to `cd`.
- `fzf` – Fuzzy search tool.
- `sudo` – Allows pressing `Esc` twice to prefix previous command with `sudo`.
- `zsh-autosuggestions` – Suggests commands based on history and completions.
- `zsh-syntax-highlighting` – Adds syntax highlighting to commands.

#### Configuration Highlights

- **History**: Stores up to 10,000 commands in `~/.zsh_history`.
- **PATH**: Includes `$HOME/bin`, `$HOME/.local/bin`, and `/usr/local/bin`.
- **Manpages**: Enhanced man page display using `bat`.
- **Editor**: `nvim` is set as the default editor.
- **Zoxide**: Initialized via `eval "$(zoxide init zsh)"`.

#### Aliases

```sh
alias ll='exa -al --color=always --group-directories-first'
alias la='exa -a'
alias l='exa'
alias cat='bat'
alias gs='git status'
alias gl='git log --oneline --graph --all --decorate'
alias ..='cd ..'
alias ...='cd ../..'
alias please='sudo'
```
## monitor-switcher
Simple script/apps to toggle external displays between HDMI-1 and HDMI-2.
