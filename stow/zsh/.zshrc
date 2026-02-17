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
alias ls="ls -lah"
clean_branches() {
  git fetch --all --prune && git branch -D $(git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }')
}

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

if ! zgenom saved; then
  # Ohmyzsh base library
  zgenom ohmyzsh
  # oh-my-zsh plugins
  # Provides git aliases
  zgenom oh-my-zsh plugins/git
  # Faster git command line completion
  zgenom oh-my-zsh plugins/gitfast
  # Warp directory - easily switch to particular directories
  zgenom oh-my-zsh plugins/wd
  # Suggests packages to install if command not found
  zgenom oh-my-zsh plugins/command-not-found
  # Provides docker aliases
  zgenom oh-my-zsh plugins/docker

  # Powerlevel10k theme
  zgenom load romkatv/powerlevel10k powerlevel10k
  # Syntax highlighting bundle.
  zgenom load zsh-users/zsh-syntax-highlighting
  # Autosuggestions bundle.
  zgenom load zsh-users/zsh-autosuggestions
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

# NVM (Node Version Manager) - optional, only if you do Node.js development
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Google Cloud SDK - optional, only if you use GCP
if [ -f '/Users/clark.holdham/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/clark.holdham/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/clark.holdham/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/clark.holdham/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# run conanrun.sh if it exists, only run in dev containers
if [[ "$USER" = "user" ]]; then
  # if the user is user, then it's a container
  source /workspaces/ouster-perception/build/generators/x86_64/RelWithDebInfo/conanrun.sh
fi

# enable better vscode terminal integration https://code.visualstudio.com/docs/terminal/shell-integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
