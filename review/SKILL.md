---
name: review
description: Review selected code and identify suggestions, fixes, and refactoring opportunities to produce cleaner, more scalable and concise code. Use when the user says "review this", "code review", "what would you improve", "refactor suggestions", or "review this PR".
---

# Review

Review the selected code and identify suggestions, fixes, and refactoring opportunities to produce cleaner, scalable, and concise code.

## What to look for

- **Correctness** — logic errors, edge cases, off-by-one errors
- **Clarity** — naming, structure, readability
- **Simplicity** — unnecessary complexity, over-engineering, duplication
- **Consistency** — follows project conventions and code style
- **Performance** — obvious inefficiencies worth calling out

## Output format

Group findings by severity:

- 🔴 **Must** — bugs, broken logic, security issues
- 🟡 **Should** — clarity, naming, structure improvements
- 🟢 **Consider** — optional enhancements, nice-to-haves

Keep each point concise. Reference the specific code being discussed. Offer a concrete suggestion, not just a complaint.
