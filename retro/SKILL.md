---
name: retro
description: >-
  Reflect on a completed skill run and improve the relevant SKILL.md.
  Use when the user asks "what did you learn?", "run a retro", "improve the skill",
  or similar after completing a skill-driven workflow.
---

# Retro: Skill Improvement Cycle

After a skill run, capture what worked, what caused friction, and what was missing — then bake the highest-value lessons directly into the relevant skill.

This is not a discussion. It ends with an edit to a SKILL.md.

## Workflow

**1. Identify the skill that was just run**

If it isn't obvious from context, ask the user which skill to retro. Read that skill's SKILL.md before proceeding.

**2. Produce a short retrospective**

Cover exactly three headings — no more:

- **What worked well** — steps or techniques that saved time or caught the right things cleanly.
- **What caused friction** — steps that added latency, required re-work, produced noisy output, or needed workarounds.
- **What was missing** — situations the skill didn't anticipate at all.

Be specific and concrete. Reference actual steps by name or letter. Vague observations ("the workflow felt slow") are not actionable and should be discarded.

**3. Derive the highest-value changes**

From the retrospective, identify the 1–3 changes that would most improve the next run. Prioritise:

- Removing steps that added cost with little benefit (e.g. an always-skipped optional step).
- Adding guardrails for a class of failure that was encountered.
- Sharpening ambiguous instructions that required interpretation mid-run.

Discard lessons that are too narrow to recur (one-off site quirks, etc.).

**4. Edit the SKILL.md**

Apply the changes directly. Rules:

- Prefer editing existing sections over adding new ones — keep skills concise.
- Only add a new section if the lesson genuinely doesn't fit anywhere existing.
- Do not add a "Changelog" or "History" section — the skill should read as always-current, not as a versioned document.

**5. Confirm to the user**

Summarise what changed and why in 2–4 sentences. No need to reproduce the full diff.

## Guiding principle

The skill should get measurably faster and more accurate with each run. A retro that produces no edit to a SKILL.md is a missed opportunity.
