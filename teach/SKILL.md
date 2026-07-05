---
name: teach
description: Teach the user about code. Use when the user says "teach me", "explain what you just did", "what did that command do", "help me understand this", "walk me through", or wants to learn from the agent work while still having the agent do the work.
---

# Teach

Explain the agent work so the user learns from it — what happened, how it works, and why it was done this way.

This is a teaching response, not a status update. Assume a competent engineer baseline: skip truly basic concepts, but fully explain domain-specific knowledge.

Reply in chat only. Never write explanations to disk.

## What to teach

Cover any substantive work the agent did in this conversation:

- Code changes (features, fixes, refactors)
- Commands the agent ran (shell, git, package managers, etc.)
- Configuration or tooling changes

## Step 1 — Target

Determine what to explain:

1. **Explicit target** — if the user points at a file, diff, command, or step, teach that.
2. **Single substantive action** — if only one non-trivial change or command happened since the last `/teach` (or since the session started), teach it.
3. **Multiple candidates** — if several distinct substantive changes or commands happened, list them briefly and ask which one(s) to cover. Do not guess.

### Filtering trivial actions

When building the candidate list or choosing the default target, **skip** mechanical actions that carry no learning value:

- Reading files, searching the codebase, listing directories
- Formatting-only or whitespace-only edits
- Routine status checks with no side effects

**Include** anything that changed behavior, fixed a bug, introduced a pattern, ran a command with meaningful flags, or made a non-obvious choice.

## Step 2 — Explain

Use this structure for every target — whether it's a code diff or a command:

### What

What changed or ran, in one or two sentences. Name the files, functions, or command involved.

### How

Walk through the mechanics:

- For **code**: execution flow, key functions/components, how data moves, what the diff actually does line-by-line where it matters.
- For **commands**: what the tool does, what each important flag or argument means, what the command produces.

Reference relevant code with file paths when explaining changes.

### Why

Explain the reasoning:

- What problem this solves
- Why this approach over alternatives
- Trade-offs or constraints that shaped the decision

If the agent chose between options during the work, name them.

### Vocabulary

Call out unfamiliar concepts explicitly — one line each:

- APIs, libraries, or framework features
- Command flags or CLI concepts
- Patterns or idioms (e.g. "dependency injection", "idempotent", "tracer bullet")

If everything in the explanation is already standard for a senior engineer in this stack, this section can be brief or omitted.

## Tone and depth

- Write like a patient senior engineer giving a walkthrough, not a changelog.
- Prefer concrete examples over abstract descriptions.
- Break down complex parts; keep simple parts short.
- Match depth to the complexity of the work — a one-line config tweak needs a paragraph, not an essay.
