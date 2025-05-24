# Dotfiles – Personal Linux Configuration

This repository contains my personal dotfiles for a minimal, performant, and cohesive Wayland setup using Hyprland.

## To map the config files use
**stow --target=$HOME --adopt [folder-name]**  

## Apps

### 🖥️ Compositor & Core Utilities
- **Hyprland** – A dynamic tiling Wayland compositor.
- **Hyprpaper** – Lightweight wallpaper daemon for Hyprland.
- **Hyprlock** – Lock screen utility with blur and styling support for Hyprland.
- **Hypridle** – Idle daemon that triggers actions like screen dimming or locking.

### 🧰 System Tools
- **GNU Stow** – Manages symlinks for dotfiles across directories.
- **kitty** – Fast, GPU-accelerated terminal emulator with modern features.
- **flameshot** – Screenshot tool tailored for use with Hyprland.
- **waypaper** – Wallpaper manager with GUI support for Wayland compositors.
- **nwg-displays** – GUI tool for managing display configurations under Wayland.

### 🎨 Theming & Appearance
- **nwg-look** – GTK theme and icon manager for Wayland.
- **kvantummanager** – GUI for managing and applying Kvantum (Qt) themes.
- **eww** – Highly customizable widget system for Linux desktops, used for status panels, system info, etc.

### 📟 Status Bars & Notifications
- **Waybar** – Highly customizable status bar for Wayland compositors.
- **swaync** – Notification daemon for Wayland, compatible with Hyprland and Sway.

### 🚀 Launchers & Docks
- **rofi** – Application launcher, clipboard, and more.
- **nwg-dock-hyprland** – Minimal dock built for Hyprland using nwg-shell components.

### ⌨️ Input
- **wvkbd** – On-screen virtual keyboard for Wayland.


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
