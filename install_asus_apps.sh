#!/bin/bash

rog=(
  power-profiles-daemon
  asusctl
  supergfxctl
  rog-control-center
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "Failed to change directory to $PARENT_DIR"; exit 1; }

GLOBAL_FUNCTIONS="$(dirname "$(readlink -f "$0")")/Global_functions.sh"
if [[ ! -f $GLOBAL_FUNCTIONS ]]; then
  echo "Missing required file: Global_functions.sh"
  exit 1
fi

source "$GLOBAL_FUNCTIONS"

SKY_BLUE="\e[36m"
GREEN="\e[32m"
RESET="\e[0m"

mkdir -p Install-Logs
LOG="Install-Logs/install-$(date +%d-%H%M%S)_rog.log"

{
  echo "====== ASUS ROG Setup Log ======"
  echo "Date: $(date)"
  echo "User: $(whoami)"
  echo "================================"
} >> "$LOG"

printf " Installing ${SKY_BLUE}ASUS ROG packages${RESET}...\n"
for ASUS in "${rog[@]}"; do
  if ! is_package_installed "$ASUS"; then
    install_package "$ASUS" "$LOG"
  else
    echo "$ASUS is already installed" | tee -a "$LOG"
  fi
done

SERVICES=(supergfxd power-profiles-daemon)
for SERVICE in "${SERVICES[@]}"; do
  echo "Enabling and starting $SERVICE..." | tee -a "$LOG"
  sudo systemctl enable --now "$SERVICE" 2>&1 | tee -a "$LOG"
done

echo -e "\n${GREEN}ASUS ROG setup complete. Log saved to $LOG${RESET}"
