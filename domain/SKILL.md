---
name: domain
description: Build and sharpen a project domain model. Use when discussing codebase terminology, writing or editing a glossary, and creating or updating a decision record.
---

# Domain

Sharpen the project domain model as you build. When a term or decision is crystallized, write it down in the same turn.

## Files

Create files lazily: only when you have something worth to document.

- Terms: use `glossary.md` in `/docs`. The heading is the canonical domain term (`Order`), and the entry defines that term alone.
- Decisions: use `/docs/decisions/kebab-title.md`. The title is a short imperative that states the choice (`record-orders-as-events`).

## Triggers

Write in the same turn the point is settled. A conversation or code change are both sources.

- If a term has a stable meaning, add or update its glossary entry.
- If the user applies a term the glossary defines differently, name the conflict then update once they choose.
- If the user states behavior the code contradicts, name the conflict then update once it is settled.
- If the codebase has no glossary, or the glossary has drifted from the code, record the domain language the code already commits to.
- If a decision is hard to reverse, surprising without context, and the result of a real trade-off, write the record.

## Glossary

- Be opinionated. When multiple words exist for the same concept, follow your judgment to pick the best one.
- Keep definitions tight. 1 or 2 sentences are often enough. Define what it is, not what it does.
- Only include terms specific to this project context. General programming concepts don't belong even if the project is using them extensively.

## Decisions

What is the context, what did we decide, and why.

## Rules

- Don't invent terms, decisions, or rationales that are not in the conversation or the code.
- Update an existing entry when the meaning changed. Don't add a second entry for the same concept.
