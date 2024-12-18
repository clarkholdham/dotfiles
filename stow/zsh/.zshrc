# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#aliases
alias nv=nvim
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcdv="docker compose down --volumes"
alias dcp="docker compose pull"
alias dl="docker logs"
alias clean_branches="git fetch --all --prune && git branch -D $(git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }')"

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

if ! zgenom saved; then
  # oh-my-zsh plugins
  zgenom load oh-my-zsh plugins/git
  zgenom load oh-my-zsh plugins/gitfast "Faster git command line completion"
  zgenom load oh-my-zsh plugins/wd "Warp directory - easily switch to particular directories"
  zgenom load oh-my-zsh plugins/command-not-found
  zgenom load oh-my-zsh plugins/vi-mode
  zgenom load oh-my-zsh lib/completion "Better tab completion"
  zgenom load oh-my-zsh lib/directories "Provides the directory stack"
  zgenom load oh-my-zsh lib/history "Provides history management"
  zgenom load oh-my-zsh lib/completion "Provides completion of dot directories"
  zgenom load oh-my-zsh lib/theme-and-appearance "Provides auto cd, and some other appearance things"
  zgenom load oh-my-zsh plugins/docker

  # Powerlevel10k theme
  genom load romkatv/powerlevel10k --theme
  # Syntax highlighting bundle.
  zgenom load zsh-users/zsh-syntax-highlighting
  # Autosuggestions bundle.
  zgenom load zsh-users/zsh-autosuggestions "auto completion"
  # fzf
  zgenom load unixorn/fzf-zsh-plugin
  # generate the init script from plugins above
  zgenom save
  # Compile your zsh files
  zgenom compile "$HOME/.zshrc"
fi

# zsh-autosuggestions commands
bindkey '^ ' autosuggest-execute
bindkey '^h' history-beginning-search-backward
bindkey '^j' history-beginning-search-backward

# Setup powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Conan 2.0 script if the file exists
# stored in home workspaces usually
CONAN_RUN="$HOME/workspaces/ouster-perception/build/generators/x86_64/RelWithDebInfo/conanrun.sh"
if [[ "$USER" = "user" ]]; then
  # if the user is user, then it's a container
  CONAN_RUN="/workspaces/ouster-perception/build/generators/x86_64/RelWithDebInfo/conanrun.sh"
fi
if [[ -f "$CONAN_RUN" ]]; then
  source "$CONAN_RUN"
fi