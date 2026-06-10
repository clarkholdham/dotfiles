# Identity

The user is **Clark Holdham** (initials: `ch`).

# Commits

- All commits MUST use [Conventional Commits](https://www.conventionalcommits.org/) format: `type(scope): description`
- Valid types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `ci`, `perf`, `build`, `revert`
- After every commit or push operation, state concisely whether changes are **local only** or have been **pushed to remote** (one line is enough).

# Temporary Files

- ALWAYS use `./.github/tmp/` for temporary files — NEVER use `/tmp/` or the repo root.

# Dot Folders

- Do NOT add files or changes to dotfolders (e.g., `.github/`, `.vscode/`, `.git/`) unless explicitly asked by the user.

# Branch Naming

Format: `ch/<JIRA-ISSUE-TAG>-<kebab-case-issue-title>`

Examples:
- `ch/OD-1234-fix-login-bug`
- `ch/OD-5678-add-user-settings`

# Branch Management & Chained Pull Requests

## Creating Branches

- Before starting a large chunk of work, **ask the user** whether it should be broken into chained PRs.
- If yes, append `-1`, `-2`, etc. to the branch name: `ch/OD-1234-fix-login-bug-1`, `ch/OD-1234-fix-login-bug-2`, etc.

## Rebase Reporting

- After performing any rebase, briefly tell the user: which branch was rebased, onto what, and whether any conflicts were resolved (one line is enough).

## Syncing Before Push

**Always sync before pushing or opening an MR/PR:**

1. `git fetch origin` — get the latest remote state
2. Check if the branch is behind: `git status` or `git log HEAD..origin/<base-branch>`
3. If behind, rebase: `git rebase origin/<base-branch>`
4. Resolve any conflicts, then push

Never push a branch that is behind its upstream — this is the leading cause of MRs based on stale history.

## When Work is Assigned

**Always follow this protocol** (unless the user explicitly tells you which branch or MR to use):

1. **Check for existing chain**: Search for related branches/MRs with the same Jira tag and `-1`/`-2` suffixes.
2. **Identify the target branch**: Determine which branch in the chain (if any) the new work should be added to.
3. **Perform all chain maintenance** on that branch:
   - The first branch is rebased on its parent branch (e.g., `main`, `master`, or a release branch).
   - Each subsequent branch is rebased on the previous branch in the chain.
   - If an upstream branch in the chain changes, propagate the rebase down the chain.
4. **Update MR descriptions** to reflect chain context (links to previous/next MRs if applicable).
5. **Ensure sequential merge order**: PRs must be ordered so they can be merged sequentially without conflicts.

**Exception**: If the user explicitly states which branch or MR to use, follow their direction exactly.

## Branch Context Verification in Chat

When the user provides context about which branch or MR to work on within the same chat session (especially in chain-branch scenarios):
- **Always verify** you are operating on the correct branch before making any changes.
- **Explicitly confirm** the branch name with the user if there's any ambiguity.
- Reference the specific branch/MR in your response so the user can verify your context is correct.

# URL Sharing

- Always share the URL after creating or updating any MR, ticket, or issue — even for minor updates (e.g. adding a comment, changing a description). Format as a markdown link using the ID as the label (e.g. `[OD-1234](https://...)` or `[!2183](https://...)`). No extra explanation needed.

# Replying to Comments

- **Never reply to MR comments** unless specifically asked.
- **Never comment on Jira issues** unless specifically asked.
- If asked to reply or comment, keep the response very concise — a sentence or two at most.

# Creating Merge Requests (MRs)

Every MR must have:
1. A clear, descriptive title following conventional commit style.
2. A description that includes: what changed, why, and references to the relevant Jira issue(s) (e.g., `Closes OD-1234`).
3. Context on whether it is part of a chain (link to previous/next MR if applicable).
4. **Do NOT add tags to MRs** unless specifically asked.

# Jira Issues

**Before starting work:**
- If no Jira item is provided, **ask the user** if there's an existing issue to reference or if one should be created.

**When creating a new Jira ticket:**
- Always include:
  1. A clear, descriptive title
  2. A detailed description explaining the problem, context, or feature
  3. Definition of Done (acceptance criteria)
- Do NOT add labels or fix versions unless specifically asked.

**When working on a Jira ticket:**
- Do NOT comment on the ticket unless specifically asked by the user; if asked, keep it very concise.
- Keep the MR description synchronized with the issue (reference it, don't duplicate it).

# CLI Multi-line Arguments

When passing multi-line text (descriptions, bodies) to any CLI tool (e.g. `jira`, `glab`):
- **Never use `\n` escape sequences** — they are passed literally and appear as `\n` in the output.
- **Always use a heredoc** to produce real newlines:

```bash
jira issue create --no-input -b "$(cat <<'EOF'
First paragraph.

*Heading*
- bullet one
EOF
)"
```

# Integrated Browser

- Only use the integrated browser if explicitly asked, or when testing/validating a specific app UI.
- Do NOT use it for MRs, PRs, Jira tickets, GitLab, Jenkins, or anything requiring authentication — it has no auth context and will fail or show login pages.
- For those tasks, always use CLI tools (glab, jira, jk) or MCPs instead.

# External Tool Integration

**IMPORTANT:** When interacting with Jira, Jenkins, GitLab, or other external services:
- **USE SKILLS and MCPs** available in the environment
- **DO NOT use APIs directly** or construct raw HTTP requests
- Skills provide abstraction, authentication, and best practices built for these tools
- Check available skills before writing any custom integration code

# Argo Workflows CLI

- Static Argo config (`ARGO_SERVER`, `ARGO_HTTP1`, `ARGO_SECURE`, `ARGO_NAMESPACE`) is set in `~/.claude/settings.json` and available automatically.
- `ARGO_TOKEN` is dynamic and must be fetched at runtime via `gcloud auth print-access-token`.
- `argo-auth` is a **zsh shell function**, not a script — calling it as a subprocess does nothing. **Do NOT call `argo-auth` from Bash tool calls.**
- Instead, inline the token for every `argo` command:

```bash
ARGO_TOKEN="Bearer $(gcloud auth print-access-token)" argo <subcommand>
```
