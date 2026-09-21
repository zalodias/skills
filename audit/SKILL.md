---
name: audit
description: Audit selected code for suggestions, fixes, and refactoring opportunities. Use when the user says "audit", "audit this code", or "what would you improve".
---

# Audit

Audit the selected code for suggestions, fixes, and refactoring opportunities.

## Principles

- **Correctness** — logic errors, edge cases, off-by-one errors
- **Clarity** — naming, structure, readability
- **Simplicity** — unnecessary complexity, over-engineering, duplication
- **Consistency** — project conventions and code style
- **Performance** — obvious inefficiencies worth calling out

## Output

Group findings by severity:

- **Must** — bugs, broken logic, security issues
- **Should** — clarity, naming, structure improvements
- **Consider** — optional enhancements, nice-to-haves

Keep each point concise. Reference the specific code. Offer a concrete recommendation to fix/improve.
