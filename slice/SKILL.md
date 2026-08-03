---
name: slice
description: Break a parent feature spec issue into vertical tracer-bullet GitHub sub-issues.
disable-model-invocation: true
---

# Slice

Decompose a parent feature spec (from `/spec`) into vertical tracer-bullet sub-issues. Parent issue is the source of truth.

## Rules

Each child is a **tracer bullet**: the smallest useful increment that still delivers one coherent user-visible outcome end-to-end.

- **Shipable** — after the slice, something demonstrable works end-to-end.
- **Thin** — prefer more small slices over one fat slice.
- **Ordered** — dependency order; later slices may assume earlier ones landed.
- **Mapped** — each slice cites which parent Stories it covers.

## Steps

1. Resolve the parent (`#n`, URL, or the issue just created in this chat).
2. Read the parent issue. Optionally do a light codebase check for feasibility and **prefactor** opportunities (“make the change easy, then make the easy change”). If a prefactor clearly unlocks later work, propose it as a **early slice** — never bury it inside a feature slice. If not clearly justified by the parent, omit it or mark it optional for approval.
3. Show one draft package: numbered slices (title + short summary + stories covered + proposed blocked-by graph). Wait for explicit approval.
4. After approval, **preflight** before creating anything: `gh issue view` the parent; confirm `gh` can set `--parent` / `--blocked-by` (needs a recent `gh`, sub-issues enabled). If not, **fail loudly** and stop — do **not** put Parent/Dependencies into issue bodies.
5. Create children in dependency order with `gh issue create --parent <N>`. Wire hard deps with `--blocked-by`. No labels/assignees/milestones unless asked.
6. Reply with the parent URL and each child URL + title. Note that parent/blocked-by links were set.

## Child template

Issue body only — hierarchy and blocking live on the GitHub platform (`--parent`, `--blocked-by`), never duplicated in the description.

```markdown
## Slice

1–2 sentences: the user-visible outcome of this tracer bullet.

## Implementation

The end-to-end behavior this ticket makes work, from the user's perspective — not layer-by-layer implementation.

## Acceptance Criteria

- [ ] Concrete assertion proving this slice works end-to-end
```

Prefactor slices may be thinner on user-visible outcome but still need Acceptance Criteria (e.g. behaviour preserved + seam in place).

## Title

Imperative, product-facing — e.g. `Show primary account balance on home`. No `[Slice 1/4]` or `Parent:` prefix. Keep under ~72 characters.

## Rules

- Never create child issues without explicit approval.
- Never stuff parent or dependency relationships into issue bodies; platform only, or fail loudly.
- No file paths or code snippets.
- Do not auto-invoke from `/spec`; only run when explicitly asked.
