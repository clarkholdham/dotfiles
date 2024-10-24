# This function sets up the SSH agent and adds any common private keys.
# Useful for vscode dev containers.
function _setup_ssh_agent() {
   # Check if the .ssh directory exists
   if [ ! -d "$HOME/.ssh" ]; then
      echo "Error when setting up SSH agent: ~/.ssh/ does not exist."
      return
   fi

   # Check if the ssh-agent file exists
   if [ ! -f "$HOME/.ssh/ssh-agent" ]; then
      # Start a new instance of the SSH agent.
      echo "Starting new SSH agent..."
      ssh-agent -s &>$HOME/.ssh/ssh-agent
   else
      # We need to validate that the ssh-agent is still running

      # Get the PID of the Agent in the ssh-agent file
      local EXPECTED_SSH_AGENT_PID=$(cat $HOME/.ssh/ssh-agent | grep SSH_AGENT_PID | cut -d '=' -f 2 | cut -d ';' -f 1)

      # Determine if the PID of the agent is running
      # Get the PIDs of the running agents. It will be a list of PID numbers.
      local AGENT_PID=($(ps -ax | grep 'ssh-agent -s' | grep -v grep | awk '{print $1}'))

      # Check if the SSH_AGENT_PID is in the list of running agents
      local RUNNING_AGENT="0"
      for pid in $AGENT_PID; do
         if [ "$EXPECTED_SSH_AGENT_PID" = "$pid" ]; then
            RUNNING_AGENT="1"
            break
         fi
      done

      # If the agent is not running, start a new instance of the SSH agent.
      if [ "$RUNNING_AGENT" = "0" ]; then
         # Start a new instance of the SSH agent.
         echo "SSH agent is not running. Starting new SSH agent..."
         ssh-agent -s &>$HOME/.ssh/ssh-agent
      fi
   fi

   # Load the SSH agent environment variables
   eval $(cat $HOME/.ssh/ssh-agent)

   # List of common private key filenames to check
   local common_key_filenames=("id_rsa" "id_dsa" "id_ecdsa" "id_ed25519")
   local key_added=false

   for key_filename in "${common_key_filenames[@]}"; do
      if [ -f "$HOME/.ssh/$key_filename" ]; then
         ssh-add "$HOME/.ssh/$key_filename"
         if [ $? -eq 0 ]; then
            key_added=true
            echo "Added key: $HOME/.ssh/$key_filename"
         else
            echo "Error adding key: $HOME/.ssh/$key_filename"
         fi
      fi
   done

   if [ "$key_added" = false ]; then
      echo "No common private keys were added."
   fi
}

# Setup the ssh agent
_setup_ssh_agent
