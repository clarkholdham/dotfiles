# Update the dotfiles repo to make sure we have all changes:
~/dotfiles/doupdate.sh

source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Plugin to check if a 256 colour terminal
# is available, and enable all colours if
# it is
antigen bundle chrissicool/zsh-256color

# z - awesome directory switching plugin
antigen bundle rupa/z

# fzf-marks - a plugin to allow bookmarking
# directories, and then fuzzy searching through
# the bookmarks using fzf
antigen bundle uvaes/fzf-marks

# Load the theme.
antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Tell antigen that you're done.
antigen apply

export EDITOR=vim

# Set the terminal to urxvt, for i3wm:
export TERMINAL=urxvt

# Set ccache to use distcc:
export CCACHE_PREFIX="distcc"

# Set ccache directory
export CCACHE_DIR=/home/choldham/workspace/opal2/ccache
#export CCACHE_UMASK=002
#export CCACHE_BASEDIR=~/workspace/opal2/build-release-clang

# Ensure Google Test tests always show colour output:
export GTEST_COLOR=yes

# Set some preferences for the bullet train theme:
export BULLETTRAIN_CONTEXT_SHOW=true
export BULLETTRAIN_TIME_SHOW=false
export BULLETTRAIN_GIT_COLORIZE_DIRTY=true
export BULLETTRAIN_RUBY_SHOW=false
export BULLETTRAIN_GIT_BG="green"
export BULLETTRAIN_DIR_FG="black"

# Set up ninja tab completion:
source ~/dotfiles/ninja/_ninja

# Adjust the path
source ~/.pathrc

# Aliases
alias nv='nvim'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-flat.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Alias ninja build command for distcc
alias n="ninja -j30 -l10"

# Alias ls -ltr to ltr
alias ltr="ls -ltr"
