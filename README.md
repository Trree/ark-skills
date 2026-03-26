# ark-skills

`ark-skills` is a GitHub-hosted skill repository designed to install cleanly via `npx skills add`.

## Install

Use the GitHub repository directly:

```bash
npx skills add <your-github-username>/ark-skills
```

If your environment supports Claude Code plugin marketplaces, you can also add the repository there:

```text
/plugin marketplace add <your-github-username>/ark-skills
```

## Repository Layout

```text
.
├── .claude-plugin/
│   └── marketplace.json
└── skills/
    └── ark-hello/
        └── SKILL.md
```

Each skill lives in its own folder under `skills/<skill-name>/`.

## Add a New Skill

1. Create a new folder under `skills/`
2. Add a `SKILL.md`
3. Keep the skill self-contained

Minimal example:

```text
skills/
  your-skill/
    SKILL.md
```

`SKILL.md` must include YAML frontmatter with at least:

```yaml
---
name: your-skill
description: Brief description of what the skill does and when it should be used.
---
```

## Principles

- Prefer `npx skills add` as the primary install path
- Keep each skill self-contained after installation
- Treat `skills/` as the single source of truth
- Avoid shared runtime dependencies between skills unless you later add a publish-time sync step
