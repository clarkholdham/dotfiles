# This function sets up the SSH agent and adds any common private keys.
# Useful for vscode dev containers.
function _setup_ssh_agent() {
   # If keychain exists, use it to manage the ssh agent
  if type keychain > /dev/null; then
    eval $(keychain --eval --agents ssh --quick --quiet)
  fi
}

# Setup the ssh agent
_setup_ssh_agent
