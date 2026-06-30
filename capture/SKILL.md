---
name: capture
description: Distill the current conversation into a compact context file under docs/captures/. Use when the user asks to capture or save conversation context, or wants a handoff document for a fresh agent.
disable-model-invocation: true
---

# Capture

Write a compact handoff document that lets a fresh agent resume with full awareness of what's been decided, assumed, and left open in the current conversation.

Save it as `docs/captures/{slug}-{uuid}.md`, where `slug` is a kebab-case summary of the topic and `uuid` is an 8-character lowercase hex string (e.g. `auth-refactor-f4a8b2c1.md`).

Reply with just the file path and a one-line confirmation — don't echo the document in chat.

## Template

```markdown
# Title

## Summary

[1–3 sentences: what this was about and where it landed]

## Decisions

- [Brief rationale of each decision]

## Constraints & Assumptions

- [Hard limits or context treated as true]

## Questions

- [Unresolved items, not yet agreed]

## Context

- [File paths, issue links, pointers only]
```

## Rules

- Omit any section with nothing worth recording, except Summary, which is always present.
- No YAML frontmatter — the filename carries the slug and id.
- Keep the document under ~80 lines; point to files instead of pasting code blocks.
- Each `/capture` creates a new file; never overwrite an existing one.
- Write the file only — never stage, commit, push, or modify `.gitignore`.
- Don't invent decisions or constraints not present in the conversation.
