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

# Update and Install Homebrew apps
if command_exists brew && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo -e "\n${PURPLE}Updating homebrew and packages...${RESET}"
  brew update # Update Brew to latest version
  brew upgrade # Upgrade all installed casks
  brew bundle -v # Install all listed Brew apps
  brew cleanup # Remove stale lock files and outdated downloads
fi

if command_exists mas; then
  echo -e "\n${PURPLE}Installing mac app store applications${RESET}"
  mas install 1423210932 # flow
fi

echo -e "\n${PURPLE}Setup complete, exiting.${RESET}"
exit 0