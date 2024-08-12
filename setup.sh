#!/bin/sh

# This script sets up symlinks to all the dotfiles
# in the user's home directory. Set base to be the location of this
# script, and it will set up all the symlinks
base=$(dirname $(readlink -f $0))

# install a few things
sudo apt-get install stow zsh tmux fzf

# install oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install fzf

# Set up all of the configs:
cd ${base}/stow

# This for loop iterates through all directories
# contained in the stow directory. This makes
# it easy to add configurations for new applications
# without having to modify this script.
for app in */; do
	stow -v -t ${HOME} $app
done;