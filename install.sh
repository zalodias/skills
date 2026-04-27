#!/usr/bin/env bash
# Symlinks every skill in this repo into ~/.agents/skills so Cursor and other
# agents (which read from ~/.cursor/skills -> ~/.agents/skills) pick them up.
#
# Idempotent: re-running replaces stale links and skips up-to-date ones.
# Safe: refuses to overwrite a non-symlink.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SKILLS_TARGET_DIR:-$HOME/.agents/skills}"

mkdir -p "$TARGET_DIR"

linked=0
skipped=0
refreshed=0

for skill_dir in "$REPO_DIR"/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue

  name="$(basename "$skill_dir")"
  src="${skill_dir%/}"
  dest="$TARGET_DIR/$name"

  if [ -L "$dest" ]; then
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      printf '  ok       %s\n' "$name"
      skipped=$((skipped + 1))
      continue
    fi
    rm "$dest"
    ln -s "$src" "$dest"
    printf '  refreshed %s (was -> %s)\n' "$name" "$current"
    refreshed=$((refreshed + 1))
  elif [ -e "$dest" ]; then
    printf '  skip      %s (exists and is not a symlink — leaving alone)\n' "$name" >&2
    continue
  else
    ln -s "$src" "$dest"
    printf '  linked    %s\n' "$name"
    linked=$((linked + 1))
  fi
done

printf '\nDone. linked=%d refreshed=%d already-ok=%d  ->  %s\n' \
  "$linked" "$refreshed" "$skipped" "$TARGET_DIR"
