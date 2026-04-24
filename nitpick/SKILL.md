---
name: nitpick
description: >-
  Compare a live web implementation against its Figma design and produce a
  Jira-ready defect report. Use when the user asks to "nitpick", "QA against
  Figma", "compare to the design", or provides both a Figma frame URL and a
  live/staging/production URL and asks for a visual review.
---

# Nitpick: Figma vs Live Implementation QA

Produce a Markdown defect report comparing a live implementation to its Figma design across the user's requested viewports. The report is pasted into a single Jira ticket, so all findings for one run go in one document.

This is vision-based visual QA: compare rendered images, don't inspect the source.

## Required inputs

- One live URL (staging, branch preview, or production).
- One or more Figma frame URLs (the user may provide 1, 2, or 3 — typically mobile / tablet / laptop variants). If only one is provided, use it as the baseline for every viewport and note the reduced coverage in the report.

If either input is missing, stop and ask the user for it.

## Dependencies

This skill uses `@playwright/cli` (the official Playwright CLI).
Verify it is available before starting:

```bash
playwright-cli --version
```

If the command fails, install it first:

```bash
npm install -g @playwright/cli@latest
```

The Figma renders are fetched via the `plugin-figma-figma` MCP — no separate setup needed.

## Viewports

Default viewport set when not otherwise specified by the user or by Figma frame widths:

| Name   | Width | Height (initial) |
| ------ | ----- | ---------------- |
| Mobile | 375   | 800              |
| Tablet | 768   | 1024             |
| Laptop | 1280  | 840              |

If the user supplies Figma frames at different canvas widths, match the live viewport width to each frame's canvas width so the comparison is like-for-like. Record the actual widths used in the report.

## Workflow

Track progress with this checklist:

```
- [ ] 1. Gather Figma renders and context
- [ ] 2. Capture live screenshots per viewport
- [ ] 3. Compare and identify findings
- [ ] 4. Crop per-finding evidence
- [ ] 5. Emit the report
```

### 1. Gather Figma renders and context

For each Figma URL, call the `plugin-figma-figma` MCP:

- `get_metadata` — parse the canvas width from the top-level frame. Adjust the live viewport width to match if it differs from the defaults above.
- `get_screenshot` — fetch the design render. This is the visual baseline for comparison.

Save each render and note its canvas width. Treat the Figma output as **reference of designer intent**, not literal truth — Figma ignores browser-side rendering artifacts (antialiasing, font smoothing, sub-pixel layout).

**Extract more from the metadata layer tree.** `get_metadata` returns a full XML tree of every layer with names, types, positions, sizes, and `hidden` states. Use it for three things beyond canvas width:

1. **Section Y boundaries** — note each top-level section's `y` and `height` so you can compute accurate crop coordinates in step 4. The live page will likely be a slightly different total height than Figma; derive a vertical scale factor after step 2d: `scale = live_page_height / figma_body_height`. Multiply all Figma Y positions by this factor when cropping the live screenshot.

2. **Element cross-referencing** — scan for component/layer names that should appear on the live page (e.g. `LP-language-selector`, `Disclaimer`, `ic_circle_empty_small`). Elements that are present in the tree but absent in the live screenshot are direct candidates for findings.

3. **Finding vocabulary** — use the Figma layer names verbatim when writing finding titles and "Expected" descriptions. This makes tickets immediately actionable for developers without them having to re-open Figma.

**Node-ID format.** Figma URLs encode the node ID with hyphens (`node-id=5079-23681`). The `plugin-figma-figma` MCP requires a colon separator (`5079:23681`). Always convert before calling `get_metadata` or `get_screenshot`.

### 2. Capture live screenshots per viewport

`playwright-cli` runs a headless Chromium browser process.

**Critical: always run `playwright-cli` from the workspace root.** The CLI pins allowed file-write roots to the current working directory when the session opens. If you `cd` into a subdirectory first, screenshot and snapshot writes outside that directory will be denied. Confirm with `pwd` before running any `playwright-cli` commands.

For each viewport, run this sequence as Shell commands:

**a. Open the page at the correct viewport**

```bash
# Run from workspace root — e.g. /path/to/project
playwright-cli open <live-url>
playwright-cli resize <width> <height>
```

**b. Verify the actual viewport — HARD STOP if wrong**

```bash
playwright-cli eval "window.innerWidth"
```

If the returned value differs from the requested width by more than 10%, **stop the run immediately**. Do not produce a report. Tell the user:

> "Browser returned `innerWidth = Xpx` after requesting `Ypx`. Cannot produce a like-for-like comparison. Check that `@playwright/cli` is installed correctly and re-run."

**c. Wait for the page to settle**

```bash
playwright-cli eval "document.readyState"
```

If it does not return `"complete"`, wait 2 s and retry once. Also trigger lazy-loading:

```bash
playwright-cli press End
playwright-cli eval "new Promise(r => setTimeout(r, 1500))"
playwright-cli press Home
playwright-cli eval "new Promise(r => setTimeout(r, 800))"
```

**c′. Dismiss cookie/consent banners**

Cookie banners and GDPR overlays might appear in screenshots and obscure content they sit on top of. Before capturing, try to dismiss them:

```bash
# Click a visible "Accept", "Allow All", or "Decline" button if one exists
playwright-cli eval "document.querySelector('button')?.textContent"   # inspect first
```

If a dismiss button is identifiable, click it and wait 800 ms for the overlay to animate away. If no button is found or the banner persists, note it in the report as dynamic/expected and proceed — do not block on it.

**d. Capture full-page screenshot**

```bash
playwright-cli screenshot --full-page --filename=.nitpick/runs/<ISO-timestamp>/<viewport>-fullpage.png
```

**e. Read the screenshot for vision comparison**

Use the `Read` tool on the `.png` file. The Read tool renders PNG images inline — this is how you see the live page.

**f. Batch all viewports in one session**

After capturing the first viewport's screenshot, resize and capture the remaining viewports before closing the browser. There is no need to `open` a fresh browser per viewport — a single session handles all resizes:

```bash
playwright-cli open <url>          # once only
# ... resize, settle, screenshot for viewport 1 ...
playwright-cli resize <w2> <h2>    # switch to viewport 2
# ... settle, screenshot ...
playwright-cli resize <w3> <h3>    # switch to viewport 3
# ... settle, screenshot ...
playwright-cli close               # once only
```

**g. Compute the vertical scale factor after all screenshots are captured**

```bash
magick identify .nitpick/runs/<ts>/laptop-fullpage.png   # note actual height
```

`scale = actual_live_height / figma_body_height`

Apply this factor to all Figma section Y positions when computing crop coordinates in step 4. This prevents systematic ~100–200 px crop misalignment on pages where the live render is taller than the Figma frame.

**h. Close the browser when all viewports are done**

```bash
playwright-cli close
```

### 3. Compare and identify findings

For each `(viewport, Figma render, live screenshot)` triple:

Walk the page top-to-bottom in bands (hero, then each major section) rather than holding the entire full-page image in one comparison — this keeps reasoning precise on tall pages.

**Standard of correctness: loose tolerance.** Flag only differences a user would plausibly notice at a glance. Ignore:

- Sub-pixel antialiasing / font smoothing.
- Minor color shifts within a few percent that do not change perceived hue.
- Scrollbar presence/absence.
- Visually obvious **dynamic content** (timestamps, avatars, usernames, randomized product images, personalized greetings, A/B variant banners). List these in the "Not flagged (dynamic content detected)" section instead of as bugs.

**Flag** anything in these categories:

- Layout, alignment, positioning.
- Typography (size, weight, line-height, letter-spacing, font family).
- Spacing, padding, margins.
- Copy differences visible at a glance.
- Responsive behavior (element that wraps, overflows, or disappears at a given breakpoint).
- Icons, images, illustrations wrong or missing.
- Motion/animation issues that are statically observable (e.g., a transform that left content offset).

**Severity rubric:**

- **Critical** — broken layout, unreadable text, missing primary content, CTA unusable or missing, content clipped/overflowing.
- **Major** — clearly wrong typography scale, clearly wrong spacing on a major element (hero, CTA, primary heading), wrong icon/image in a prominent spot.
- **Minor** — small spacing nudges, secondary-copy differences, subtle color variations, non-primary icon swaps.

If a single viewport yields more than ~15 findings, stop listing new items and instead hypothesize a systemic issue (wrong CSS bundle, wrong branch, theme mismatch). Ask the user before filing noise.

### 4. Crop per-finding evidence

For each finding, crop a zoomed-in snippet of the **live** screenshot around the issue using ImageMagick (`magick`). Use pixel coordinates estimated from the section's position in the full-page image.

```bash
magick <viewport>-fullpage.png -crop <W>x<H>+<X>+<Y> +repage .nitpick/runs/<ISO-timestamp>/<viewport>-<finding-id>.png
```

**Crop precision guidance:**

- If the section containing the issue is ≤ ~600 px tall in the full-page image, attach the entire section rather than a tighter crop — the context helps more than the zoom.
- If coordinate estimation is uncertain, attach the **full viewport screenshot band** for that section and note "full band attached" in the finding.

Save crops to `./.nitpick/runs/<ISO-timestamp>/<viewport>-<finding-id>.png` relative to the workspace root. Reference them in the report with relative Markdown image links.

### 5. Emit the report

Output a single Markdown document in the chat, using the template below. The user will copy-paste it into one Jira ticket.

## Report template

```markdown
# Nitpick — <page name or live URL path>

**Figma:** <figma-url(s)>
**Live:** <live-url>
**Viewports compared:** <list viewports with actual widths used>
**Requested vs. actual viewport (innerWidth check):** <e.g., "requested 1280 → got 1280 ✓">
**Run:** <ISO timestamp>

## Summary

- <N> critical, <N> major, <N> minor
- Notable theme across findings: <one line>

## Critical

### C1. <Short title>

- **Viewport:** <viewport>
- **Location:** <element description>
- **Expected (Figma):** <what the design shows>
- **Actual (live):** <what the implementation shows>
- **Evidence:** ![](./.nitpick/runs/<ts>/<viewport>-c1.png)

## Major

### M1. ...

## Minor

### m1. ...

## Not flagged (dynamic content detected)

- <element>: <why ignored>

## Coverage notes

- <viewport skipped, missing Figma frame, auth requirement, etc.>
```

## When to stop and ask the user

- Missing Figma URL or missing live URL.
- `playwright-cli --version` fails (not installed).
- `window.innerWidth` after resize differs from requested width by >10%.
- Live URL returns an auth wall / error page / 404 / 5xx.
- Figma node cannot be fetched (wrong permissions, invalid URL).
- Page has significant client-side errors — run `playwright-cli console error` and surface the output instead of producing a comparison.
- More than ~15 findings in a single viewport — likely systemic; surface hypothesis and ask before continuing.

## Auth-gated pages

`playwright-cli` starts a fresh isolated profile per session. For pages behind SSO or login:

1. Run `playwright-cli open <login-url> --headed --persistent` to open a visible browser with a persistent profile.
2. Ask the user to log in manually.
3. Once logged in, close the headed browser — the session is saved.
4. Subsequent `playwright-cli open <url>` calls in the same workspace (with `--persistent`) will reuse the saved cookies.

For fully public pages (the common case), skip this section entirely.

## After the run

When the report is delivered, invoke the `retro` skill to capture process improvements from this run.
