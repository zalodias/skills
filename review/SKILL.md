---
name: review
description: Review the diff since a pinned point on two axes — Form and Fit — then fix Must and cheap Should findings. Use after /implement, or when the user says "review" or "verify against the spec".
disable-model-invocation: true
---

# Review

Perform a code review of the agent implementation, on two axes. Keep the axes separate so a clean style pass cannot hide a wrong implementation, or the reverse.

- **Form** — `/code` + any repo-specific code style rules.
- **Fit** — the issue `/implement` just used (parent spec + child slice).

## Steps

1. **Pin** — Use the point from `/implement`. If none, ask. `git rev-parse` it.
2. **Issue** — The issue from this chat, else `#n` in `git log <fixed-point>..HEAD --oneline`, else ask. Fetch with `gh issue view`. No issue → Fit says "no spec" and skips.
3. **Spawn two sub-agents in parallel.** Each gets the three-dot diff command, the commit list, and one brief. ~300 words each. Skip what linters and types already enforce.

**Form:** Violations of `/code` or repo docs — cite the rule. Also judgement-call smells in the diff only: mysterious names, duplication, speculative generality, shotgun edits. Tag Must / Should / Consider.

**Fit:** (a) missing or partial requirements, (b) behavior the spec did not ask for, (c) implemented but wrong. Quote the spec or acceptance line. Tag Must / Should / Consider.

1. **Report** under `## Form` and `## Fit`. Do not merge or rerank across axes. One line: counts and the worst finding on each axis.
2. **Apply** Must findings and cheap Should findings. Leave Consider in the report.
3. **Re-check once** if anything changed. Two rounds max. Remaining Must findings → stop and list them.

## Rules

- No commits, no pull requests.
