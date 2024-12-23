#!/bin/sh

# This script sets up symlinks to all the dotfiles
# in the user's home directory. Set base to be the location of this
# script, and it will set up all the symlinks
base=$(dirname $(readlink -f $0))

# install a few things
sudo apt-get -y install stow zsh tmux keychain

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install zgenom
git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"

# Set up all of the configs:
cd ${base}/stow

# This for loop iterates through all directories
# contained in the stow directory. This makes
# it easy to add configurations for new applications
# without having to modify this script.
for app in */; do
	stow -v -t ${HOME} $app
done
