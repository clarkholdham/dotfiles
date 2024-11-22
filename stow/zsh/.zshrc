# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.8

#aliases
alias nv=nvim
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcdv="docker compose down --volumes"
alias dcp="docker compose pull"
alias dl="docker logs"

# zplug stuff
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# Bundles from robbyrussell's oh-my-zsh.
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh # Faster git command line completion
zplug "plugins/wd", from:oh-my-zsh # Warp directory - easily switch to particular directories
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh # Better tab completion
zplug "lib/directories", from:oh-my-zsh # Provides the directory stack
zplug "lib/history", from:oh-my-zsh # Provides history management
zplug "lib/completion", from:oh-my-zsh # Provides completion of dot directories
zplug "zsh-users/zsh-autosuggestions" # auto completion
zplug "lib/theme-and-appearance", from:oh-my-zsh # Provides auto cd, and some other appearance things
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "plugins/docker", from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# zsh-autosuggestions commands
bindkey '^ ' autosuggest-execute
bindkey '^h' history-beginning-search-backward
bindkey '^j' history-beginning-search-backward

# fzf keybindings and auto-completion
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Path for some local binaries
export PATH="$HOME/binaries:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Conan 2.0 script if the file exists
# stored in home workspaces usually
CONAN_RUN="$HOME/workspaces/ouster-perception/build/generators/x86_64/RelWithDebInfo/conanrun.sh"
if [[ "$USER" = "user" ]]; then
  # if the user is user, then it's a container
  CONAN_RUN="/workspaces/ouster-perception/build/generators/x86_64/RelWithDebInfo/conanrun.sh"
fi
[[ -f "$CONAN_RUN" ]] && source "$CONAN_RUN"

# github copilot aliases
# "github copilot suggest = ghcs and github copilot explain = ghce
#eval "$(gh copilot alias -- zsh)"
