---
name: release
description: Bump version, tag, and push a release. Use when the user says "release", "publish", "version", or specifies a minor or major release.
---

# Release

Bump version, tag, and push a release.

## Steps

1. Verify `package.json` exists — abort if not.
2. Determine bump level: `patch` (default), or `minor` / `major` if the user specifies.
3. Run `npm version <level> -m "🔖 Publish %s"`. This updates `package.json`, creates a release commit, and tags the release.
4. Push with `git push -u origin HEAD && git push origin --tags`.

## Rules

- Never amend, force-push, or skip hooks.
- When creating a `release/` branch first, follow `/commit` skill guidelines for branch names and commit messages.
