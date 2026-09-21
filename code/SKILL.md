---
name: code
description: Code production guidance for agents. Use when writing React & TypeScript, building UI, naming files, variables and functions, or making any code styling decisions.
---

# Code

## Engineering

- Choose the simplest implementation that fully meets the current requirements. Avoid speculative abstraction, configuration, and indirection.
- Follow established project conventions. When the project has no local pattern, study how established products solve the problem and adopt a proven approach.
- Prefer self-explanatory code. Avoid using code comments to emit context.
- Extract highly reusable structures, or single-use sections that own meaningful state, interaction, or complex derived data. Keep simple single-use structures inline — avoid premature abstraction.

## Naming & Syntax

- Use lowercase names with dashes for directories and files (`components/auth-wizard`).
- Give variables, functions, types, and components concise but descriptive names.
- Avoid unclear abbreviations. Write `button` instead of `btn` and `error` instead of `err`.
- Favor named exports for components.
- Prefix event handlers with `handle` (`handleClick`, `handleSubmit`).
- Prefix boolean variables with a verb (`isLoading`, `hasError`, `canSubmit`).
- Use absolute imports with the `@` alias (`@/components/button`).

## React & TypeScript

- Use TypeScript for application code.
- Use interfaces for object shapes and component props. Use types for unions, tuples, and smaller compositions.
- Define named components and top-level pure functions with the `function` keyword.
- Use declarative JSX.

## Design

- Use Base UI as default for primitive interface language (`Button`, `Dialog`, `Table`),
- Use shadcn/ui as a styling reference. Prefer existing shadcn/ui composition recipes over custom structures. Study how shadcn/ui solves the surface before inventing one.
- Keep Tailwind utility classes inline. Avoid class extraction into custom variables.
- Build UI from the project design system in `globals.css`, using semantic theme tokens such as `bg-background`, `text-foreground`, `border-border`.
- Prefer reusing existing project tokens. Always ask before introducing a new design token.
- Use a `4` pixel grid. Prefer macro spacing on round pixel steps (`20`, `40`, `80`) for layout & section rhythm. Use micro spacing (`8`, `16`, `24`) for compact & tight UI.
- Prefer `gap` and `padding` for layout. Avoid using `margin`. Keep spacing inside the component to ensure encapsulation, modularity & reusability.
