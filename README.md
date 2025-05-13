# Dotfiles – Personal Linux Configuration

This repo contains my personal configuration files for a minimal and cohesive Wayland setup using Hyprland.

## Apps

- **GNU stow** – To manage the dot files.
- **Hyprland** – Wayland window manager with tiling support.
- **Hyprpaper** – Lightweight wallpaper daemon for Hyprland.
- **Hyprlock** – Lock screen utility with blur and customization.
- **Hypridle** – Idle daemon for triggering actions after inactivity (e.g., screen dim, lock).
- **Waybar** – Customizable status bar for Wayland.
- **swaync** – notification daimon.
- **Wofi** – Application launcher for Wayland.
- **Kitty** – Fast, GPU-accelerated terminal emulator.
- **nwg-look** – Tool for applying GTK themes under Wayland.
- **kvantum-qt5 / kvantum-qt6** – Enables theming for Qt5/Qt6 applications.
- **kvantummanager** – GUI for managing Kvantum Qt themes.

## Theming

### 🎨 Theme – Catppuccin

- 🌈 Multiple flavors: Latte, Frappe, Macchiato, Mocha  
- 🔗 [https://github.com/catppuccin](https://github.com/catppuccin)  
- Supports GTK, Kvantum, and terminal themes (Kitty, Alacritty, etc.)

### 🧊 Icon Pack – Papirus

- 🔗 [https://github.com/PapirusDevelopmentTeam/papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)  
- Clean, modern, and frequently updated icon set.

### 🔤 Font – Nerd Font (Recommended: JetBrainsMono Nerd Font)

- Includes patched icons for terminal and status bar usage.  
- 🔗 [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)

## Shell

### ⚙️ Zsh

Zsh is used as the default shell with the following plugins:

- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) – Suggests commands as you type.
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) – Highlights command syntax.
- [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting) – Alternative fast highlighter.
- [`zsh-completions`](https://github.com/zsh-users/zsh-completions) – Additional completion definitions.

## Custom Scripts

### `monitor-switcher`
Switches display output between HDMI-1 and HDMI-2.