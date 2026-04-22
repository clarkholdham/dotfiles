# Mise Configuration

[Mise](https://mise.jdx.dev/) is a polyglot runtime manager that manages tool versions and environment variables.

## Setup

After running `./setup.sh`, you need to configure personal tokens on your machine:

### 1. Set API Tokens

```bash
# Jira API Token (get one at https://id.atlassian.com/manage-profile/security/api-tokens)
mise set --global JIRA_API_TOKEN="your_token_here"

# GitLab Personal Access Token (get one at https://gitlab.com/-/user_settings/personal_access_tokens)
mise set --global GITLAB_TOKEN="your_token_here"
```

These will be stored in `~/.config/mise/config.toml` (machine-local, not committed).

### 2. Verify Setup

```bash
# Check that tokens are set
mise config
```

### 3. Tool Versions

To set tool versions globally:

```bash
mise use python@3.12
mise use node@latest
```

## Project-Level Configuration

For project-specific tool versions, add a `.mise.toml` file to the project root:

```toml
[tools]
python = "3.12"
node = "20"
```

This ensures anyone cloning the project gets consistent tool versions.

## Notes

- Never commit `~/.config/mise/config.toml` (contains secrets)
- `~/.config/mise/config.toml` is gitignored and machine-specific
- Project-level `.mise.toml` files should be committed to repos
