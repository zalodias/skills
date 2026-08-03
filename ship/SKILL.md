---
name: ship
description: Branch, commit, push, and open a PR. Use when the user says "ship", "open a PR", "push this", "create a pull request", or "commit and push".
---

# Ship

Branch, commit, push changes, and open a PR.

## Steps

1. Run `git status` and `git diff` to understand all staged and unstaged changes, including untracked files.
2. Infer a branch name from the nature of the changes, or use a name provided by the user. Follow the `/commit` skill for branch naming.
3. Create the branch with `git switch -c <branch-name>`. If a branch already exists (not `main`), skip creation and use it.
4. Group the changes into logical, atomic commits — each commit should represent one coherent unit of work. Avoid bundling unrelated changes into one commit.
5. For each group, stage only the relevant files with `git add <files>` then commit following `/commit`.
6. Run `git log --oneline` and show the result so the user can verify the history looks right.
7. After explicit user approval, push with `git push -u origin HEAD`.
8. Create a PR using `gh pr create`, providing a "Summary" of what changed and a "Testing" checklist.
