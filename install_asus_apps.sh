#!/bin/bash

# Function to check if a package is installed
is_installed() {
    pacman -Qs "$1" > /dev/null 2>&1
}

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install essential dependencies
echo "Installing necessary dependencies..."
sudo pacman -S --noconfirm base-devel git

# Install ROG Control Center (assuming AUR)
if ! is_installed "rog-control-center"; then
    echo "Installing rog-control-center..."
    yay -S --noconfirm rog-control-center
else
    echo "rog-control-center is already installed."
fi

# Install asusctltray (assuming AUR)
if ! is_installed "asusctltray"; then
    echo "Installing asusctltray..."
    yay -S --noconfirm asusctltray
else
    echo "asusctltray is already installed."
fi

# Install supergfxctl (assuming AUR)
if ! is_installed "supergfxctl"; then
    echo "Installing supergfxctl..."
    yay -S --noconfirm supergfxctl
else
    echo "supergfxctl is already installed."
fi

# Install asusctl (assuming AUR)
if ! is_installed "asusctl"; then
    echo "Installing asusctl..."
    yay -S --noconfirm asusctl
else
    echo "asusctl is already installed."
fi

# Enable necessary services (if applicable)
echo "Enabling asusctl services..."
sudo systemctl enable --now asusctl

# Final message
echo "Installation complete!"
