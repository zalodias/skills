# skills

Canonical source of truth for my personal Cursor agent skills. Authored skills live here; this repo is for version history and publishing only.

## How it works

- Lives at `~/skills/` on my machine.
- **Authored source:** each skill is a folder here with `SKILL.md`.
- **Cursor discovery:** Cursor reads `~/.cursor/skills` → `~/.agents/skills/`. That folder is the Raycast skill-installer target and also holds **symlinks** into `~/skills/<skill-name>/` for each authored skill. Community skills installed by Raycast appear as real directories next to those symlinks.
- Because the Cursor symlink is global, every Cursor project on this machine sees these skills automatically. No per-project copies, no sync step.

## Layout

```
~/skills/
├── .gitignore
├── README.md
└── <skill-name>/
    └── SKILL.md        # frontmatter (name, description) + instructions

~/.agents/              # Raycast-managed; not part of this repo
├── .skill-lock.json    # tracks skills imported from external repos
└── skills/
    ├── <community-skill>/   # real folders from Raycast
    └── <your-skill> -> ~/skills/<your-skill>   # symlinks
```

## Adding a skill

1. `mkdir -p ~/skills/<skill-name>`
2. Create `SKILL.md` with YAML frontmatter:

   ```yaml
   ---
   name: <skill-name>
   description: What the skill does + when to trigger it. Include strong trigger terms.
   ---
   ```

3. Write the instructions below the frontmatter.
4. Link it so Cursor sees it (ensure `~/.agents/skills/` exists):

   ```bash
   ln -s ~/skills/<skill-name> ~/.agents/skills/<skill-name>
   ```

5. Commit and push:

   ```bash
   cd ~/skills
   git add <skill-name>
   git commit -m "Add <skill-name> skill"
   git push
   ```

## Bootstrapping a new machine

```bash
git clone https://github.com/zalodias/skills.git ~/skills
# After Raycast has created ~/.agents/skills/ (or mkdir -p ~/.agents/skills):
for d in ~/skills/*/; do
  name=$(basename "$d")
  ln -s "$d" ~/.agents/skills/"$name"
done
# Ensure Cursor points at the aggregator (if not already):
# ln -sf ~/.agents/skills ~/.cursor/skills
```

## Conventions

- **Skills over rules/commands.** Anything that can be a skill should be a skill. Skills trigger via description-match, load on demand, and work uniformly across any agent tool that understands the `SKILL.md` convention.
- **Descriptions earn their place.** Third person, specific, and packed with trigger terms. The description is the only thing the agent uses to decide whether to load the skill.
- **Project-specific stays in the project.** This repo is for cross-project skills. Anything tied to a single project's domain, stack, or team belongs in that project's `.cursor/` folder.
