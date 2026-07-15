---
name: ship
description: Branch, commit, push, and open a PR. Use when the user says "ship", "open a PR", "push this", "create a pull request", or "commit and push".
---

# Ship

Branch, commit, push changes, and open a PR.

## Steps

1. Run `git status` and `git diff` to understand all staged and unstaged changes, including untracked files.
2. Infer a branch name from the nature of the changes. Follow git-conventions for branch naming. If a branch already exists (not `main`), skip creation and use it.
3. Create the branch with `git switch -c <branch-name>` (skip if already on a feature branch).
4. Group the changes into logical, atomic commits — each commit should represent one coherent unit of work (e.g. a new utility module, a refactored hook, a new component). Avoid bundling unrelated changes into one commit.
5. For each group, stage only the relevant files with `git add <files>` then commit following git-conventions:
  - Emoji prefix matching the type of change
  - Imperative mood subject line under 72 characters
  - Optional body only when extra context genuinely helps
6. After all commits, run `git log --oneline` and show the result so the user can verify the history looks right.
7. Push with `git push -u origin HEAD`.
8. Create a PR using `gh pr create` following git-conventions:
  - Title: derive from the branch name — map the branch prefix to its emoji, convert the description from kebab-case to Sentence case.
  - Body: summarise what changed and why, then provide a "Testing" checklist.
  - Target base branch: `main` unless the user specifies otherwise.

## Rules

- Never `git add .` — always stage files explicitly by name.
- Never amend, force-push, or skip hooks.
- If the user provided a branch name or description as a parameter, use that instead of inferring one.
