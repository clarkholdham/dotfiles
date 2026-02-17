# dotfiles
Dotfiles and setup scripts for macOS and Ubuntu

## Setup

1. Clone the repository
```bash
git clone https://github.com/clarkholdham/dotfiles.git
```

2. Run the setup script
```bash
cd dotfiles
./setup.sh
```

3. Restart your terminal

4. In first tmux session, run `prefix + I` to install plugins. See tmux.conf for prefix key.

## Supported Platforms
- macOS (with Homebrew)
- Ubuntu/Debian (with apt)

The setup script automatically detects your OS and installs dependencies using the appropriate package manager.
