# This function sets up the SSH agent and adds any common private keys.
# Useful for vscode dev containers.
function _setup_ssh_agent() {
  # Get all the identities in the ~/.ssh directory
  keys=($(find ~/.ssh -type f -name 'id_*' -not -name '*.pub'))
  
  # If there are no keys, return
  if [ ${#keys[@]} -eq 0 ]; then
    return
  fi

  if type keychain > /dev/null; then
    eval $(keychain --eval --agents ssh --quick --quiet "${keys[@]}")
  fi
}

# Setup the ssh agent
_setup_ssh_agent
