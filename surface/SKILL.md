---
name: surface
description: >-
  Stop and surface a blocker when the next step is a workaround the active
  skill or the user did not authorize. Use during any skill or implementation
  when a tool or preflight fails, a requirement cannot be met as written, or
  more than one reasonable path exists and none was specified.
---

# Surface

Put the user in the loop before taking a path they did not authorize.

## When to stop

Stop this turn when the next action is a workaround, fallback, or substitute that the active skill and the user's direction did not name.

- A missing tool, permission, or preflight the skill depends on
- A requirement you cannot meet as written
- Two reasonable implementations, and the skill does not choose one

Finding a way through is the blocker. Confidence that the workaround will succeed is not permission to take it.

## What to send

Wait after this message. Do not apply the workaround in this turn.

- **Blocker** — what failed or what is missing
- **Expected path** — the step or outcome the skill or direction required
- **Workaround** — the substitute you would take, and why it sits outside that direction

## What to continue

Proceed when the active skill already names the path, including a named fallback. An instruction to run a later step without asking covers only that step.
