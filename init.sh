#!/bin/bash

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/development/dotfiles}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/pekevski/dotfiles.git}"

command_exists () {
  hash "$1" 2> /dev/null
}

echo -e "\033[1;35m""pekevski installation script 
\033[0;35mThis script will install or update specified dotfiles:
- From \033[4;35m${DOTFILES_REPO}\033[0;35m
- Into \033[4;35m${DOTFILES_DIR}\033[0;35m
Ready!\033[0m\n"

# Install homebrew if it does not exist
if ! command_exists brew; then
  echo -en "🍺 ${PURPLE}Installing Homebrew...${RESET}\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH=/opt/homebrew/bin:$PATH
fi

# Install git if it does not exist
if ! command_exists git; then
    echo "Git is not installed. Installing Git..."
    # Install Git based on the OS category
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install git
    else
        echo "Unsupported OS for Git installation"
    fi
else
    echo "Git is already installed."
fi

# If dotfiles not yet present then clone
if [[ ! -d "$DOTFILES_DIR" ]]; then
  mkdir -p "${DOTFILES_DIR}" && \
  git clone --recursive ${DOTFILES_REPO} ${DOTFILES_DIR}
fi

# Execute setup or update script
cd "${DOTFILES_DIR}" && \
chmod +x ./install.sh && \
./install.sh --no-clear