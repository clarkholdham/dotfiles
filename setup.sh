#!/bin/bash

# This script sets up symlinks to all the dotfiles
# in the user's home directory. Set base to be the location of this
# script, and it will set up all the symlinks

# Get the absolute path of this script (works on both macOS and Linux)
base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    OS="macos"
    echo "Detected macOS"
else
    OS="linux"
    echo "Detected Linux"
fi

# Install dependencies based on OS
if [ "$OS" = "macos" ]; then
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install stow zsh tmux npm
else
    # Linux (Ubuntu/Debian)
    sudo apt-get update
    sudo apt-get -y install stow zsh tmux keychain npm
fi

# Set zsh as default shell
ZSH_PATH=$(command -v zsh)
if [ "$OS" = "macos" ]; then
    # On macOS, ensure zsh is in /etc/shells
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
    fi
fi
if [ "$SHELL" != "$ZSH_PATH" ]; then
    echo "Setting zsh as default shell..."
    if [ "$OS" = "macos" ]; then
        chsh -s "$ZSH_PATH"
    else
        sudo usermod -s "$ZSH_PATH" "$(whoami)"
    fi
fi

# install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install zgenom
if [ ! -d ~/.zgenom ]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Install mise (polyglot runtime manager)
# https://mise.jdx.dev
if ! command -v mise &> /dev/null && [ ! -f ~/.local/bin/mise ]; then
    echo "Installing mise..."
    curl -fsSL https://mise.run | bash 2>/dev/null
    # Add to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"
    echo "mise installed at ~/.local/bin/mise"
else
    echo "mise already installed"
fi

# Install Dev Container CLI
# https://github.com/devcontainers/cli
if ! command -v devcontainer &> /dev/null; then
    echo "Installing Dev Container CLI..."
    npm install -g @devcontainers/cli
    echo "Dev Container CLI installed"
else
    echo "Dev Container CLI already installed"
fi

# Set up all of the configs:
cd "${base}/stow"

# This for loop iterates through all directories
# contained in the stow directory. This makes
# it easy to add configurations for new applications
# without having to modify this script.
for app in */; do
	stow -v -t ${HOME} "$app"
done

echo "Setup complete!"
