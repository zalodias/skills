---
name: rework
description: Rework branch history or an existing PR, using fixup + autosquash. Use when a commit is wrong, history looks messy, PR review feedback needs folding in, the user is unhappy with a PR structure, or says "rework", "fix the commit", or "clean up history".
---

# Rework

Fix mistakes and reshape history on the **same branch and same PR**. The branch should read as if the mistake never happened.

## Principles

- **Same PR** — never open a follow-up PR to fix this one. Don't compensate with more layers.
- **Fold, don't stack** — corrections belong inside the commit they fix, not as new commits on top.
- **Subtract** — remove or split commits to simplify.

## Examples

| Situation                   | Action                                 |
| --------------------------- | -------------------------------------- |
| Wrong code in a commit      | Fixup into that commit                 |
| Wrong message               | Reword during rebase                   |
| Wrong grouping / order      | Rebase to squash, split, or reorder    |
| Review feedback on open PR  | Fixup into the logical commit; same PR |
| User unhappy with PR shape  | Reshape on this branch; same PR        |
| Pre-push review looks wrong | Rework before pushing                  |

## Workflow

1. `git log --oneline` — identify target commit(s) and base (`origin/main` or user-specified).
2. Make the code change.
3. `git add <files>` — stage only what belongs in the fix.
4. `git commit --fixup=<hash>` — fold correction into the target commit.
5. `GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash <base>` — squash fixups in.
6. If a message is wrong, reword in the same rebase (`GIT_SEQUENCE_EDITOR` to mark `reword`, or `git commit --amend` on detached HEAD during rebase).
7. `git log --oneline` — verify history is clean.
8. `git push --force-with-lease` — update the open PR.

For a full reshape (wrong commit boundaries), `git reset --soft <base>` then recommit in logical chunks — often simpler than a complex rebase.

## Rules

- Follow `/commit` for message format when writing or rewording.
- Use `--force-with-lease`, never bare `--force`.
- Force-push only on the feature branch backing the PR — never on `main`, `master`, or shared branches.
- Never skip hooks (`--no-verify`).
- Never `git add .` — stage files explicitly.
- Show `git log --oneline` before and after so the user can verify.

## Avoid

- Opening a second PR to fix the first
- Renaming the feature branch backing the PR. GitHub closes it, and it cannot be reopened onto the new name.
- Adding `fix review feedback` or `address PR comments` commits on top
- Pushing messy history and "clean up later"
- Cherry-picking fixes onto a new branch when this branch can be reworked
