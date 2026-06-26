---

## name: capture
description: Distill the current conversation into a compact context file under docs/captures/. Use when the user runs /capture, asks to capture or save conversation context, or wants a handoff document for a fresh agent.
disable-model-invocation: true

# Capture

Distill the current conversation into a compact context file so a fresh agent can continue with agreed decisions and background, without re-reading the previous chat.

## Workflow

1. **Review the entire conversation** — full snapshot, not just the latest messages.
2. **Derive a slug** from the primary topic:
  - Lowercase kebab-case (`[a-z0-9-]` only)
  - 3–6 words, max 40 characters
  - Drop filler words: `a`, `an`, `the`, `for`, `about`, `our`, `my`
3. **Generate an 8-character lowercase hex UUID** and build the filename:
  `{slug}-{uuid}.md` → e.g. `auth-refactor-f4a8b2c1.md`
4. **Create `docs/captures/`** if it does not exist.
5. **Write the capture file**. Omit any section with nothing worth recording, except **Summary**, which is always present.
6. **Reply with the file path only** and a one-line confirmation. Do not echo the full document in chat.

## Template

```markdown
# [Human-readable topic title]

## Summary

[1–3 sentences: what this conversation was about and where things landed.]

## Decisions

- **[Decision]** - [Brief rationale]

## Constraints & Assumptions

- [Hard limit or thing treated as true]

## Questions

- [Unresolved item — not yet agreed]

## Context

- [File paths, issue links, pointers only]
```

Keep the whole document under ~80 lines. No code blocks — point to files instead.

## Sections


| Section                       | Include when                                                      |
| ----------------------------- | ----------------------------------------------------------------- |
| **Summary**                   | Always                                                            |
| **Decisions**                 | Explicit agreements only — not proposals still under discussion   |
| **Constraints & Assumptions** | Hard limits or unverified assumptions the next agent must respect |
| **Questions**                 | Unresolved items only — not rhetorical questions from the chat    |
| **Context**                   | Pointers to relevant files, prior captures, PRs, or issues        |


No YAML frontmatter — the filename carries slug and id; the `#` title orients the reader.

## Rules

- Write the file only — never stage, commit, push, or modify `.gitignore`.
- Each `/capture` creates a **new** file; never overwrite an existing capture.
- Each file is a **full snapshot** of the conversation so far — self-contained for manual handoff via `@`-mention in the next chat.
- Do not invent decisions or constraints not present in the conversation.

