#!/bin/bash

# Color variables
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/development/dotfiles}"

command_exists () {
  hash "$1" 2> /dev/null
}

arch=$(uname -m)
if [ "$arch" = "arm64" ]; then
  echo "Running on Apple Silicon (M-series)"

  # Check if rosetta is installed for m1
  if /usr/bin/pgrep oahd >/dev/null 2>&1; then
    echo "Rosetta 2 is installed!"
  else
    echo "Rosetta 2 is not installed. Installing now..."
    softwareupdate --install-rosetta --agree-to-license
  fi
else
  echo "Not running on Apple Silicon"
fi

# Update and Install Homebrew apps
if command_exists brew && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo -e "\n${PURPLE}Updating homebrew and packages...${RESET}"
  brew update # Update Brew to latest version
  brew upgrade # Upgrade all installed casks
  brew bundle -v # Install all listed Brew apps
  brew cleanup # Remove stale lock files and outdated downloads
fi

echo -e "\n${PURPLE}Setup complete, exiting.${RESET}"
exit 0