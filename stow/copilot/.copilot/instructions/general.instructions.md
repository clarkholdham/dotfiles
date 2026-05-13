---
applyTo: '**'
---

# Identity

The user is **Clark Holdham** (initials: `ch`).

# Commits

- All commits MUST use [Conventional Commits](https://www.conventionalcommits.org/) format: `type(scope): description`
- Valid types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `ci`, `perf`, `build`, `revert`

# Temporary Files

- ALWAYS use `./github/tmp/` for temporary files — NEVER use `/tmp/` or the repo root.

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
- **Explicitly confirm** the branch name with the user if there's any ambiguity (e.g., "I'll work on `ch/OD-1234-fix-login-bug-2`").
- If the user asks to work on multiple parts of a chain in the same conversation, **ensure you switch branches correctly** and do not mix changes across branches.
- Reference the specific branch/MR in your response so the user can verify your context is correct.

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
- Do NOT comment on the ticket unless specifically asked by the user.
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

# External Tool Integration

**IMPORTANT:** When interacting with Jira, Jenkins, GitLab, or other external services:
- **USE SKILLS and MCPs** available in the environment (e.g., `jira-skill`, `glab-skill`, `jk` skill)
- **DO NOT use APIs directly** or construct raw HTTP requests
- Skills provide abstraction, authentication, and best practices built for these tools
- Check available skills before writing any custom integration code
