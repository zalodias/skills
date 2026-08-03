---
name: spec
description: Synthesize the current conversation into a product feature spec and publish it as a GitHub issue.
disable-model-invocation: true
---

# Spec

Turn the current conversation into a complete product feature spec and publish it as a parent GitHub issue. No interview — synthesize what was already discussed (after `/grill`).

## Steps

1. Synthesize the conversation into the template below. Check the codebase when the chat named system areas — verify module/interface names and patterns so implementation is accurate.
2. Show the full draft in chat. Wait for explicit approval before creating anything.
3. On approval, create a GitHub issue with `gh issue create`. Never update an existing issue. No labels, assignees, or milestones unless the user asked for them.
4. Reply with the issue URL/number and a one-line confirmation.

## Template

```markdown
## Problem

The problem the user is facing

## Solution

The solution to the problem

## Stories

Numbered list of user stories that cover the feature

1. As a <role>, I want <capability>, so that <benefit>

## Implementation

Bullet list of technical decisions from the conversation

- <decision>

## Testing

Checkbox list of concrete verification assertion derived from the drafted feature

- [ ] <test>
```

## Title

Imperative, product-facing, no prefix — e.g. `Show account balance on dashboard`. Infer from Problem/Solution. Keep under ~72 characters.

## Rules

- Clear and concise; agent-first actionable instructions, not a conversation memoir.
- Always create a new issue; never overwrite an existing one.
- Always include Problem, Solution, Stories, Implementation, and Testing.
- Avoid including specific file paths or code snippets.
- Don't invent product scope beyond the conversation.
