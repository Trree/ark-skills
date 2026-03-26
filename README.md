# ark-skills

`ark-skills` is a GitHub-hosted skill repository designed for `npx skills add`.

It currently includes one writing skill:

- `reader-hook`: rewrites an abstract author angle into a concrete, reader-centered entry point

## Install

Use the GitHub repository directly:

```bash
npx skills add <your-github-username>/ark-skills
```

If your environment supports Claude Code plugin marketplaces, you can also add the repository there:

```text
/plugin marketplace add <your-github-username>/ark-skills
```

## Included Skills

### `reader-hook`

Use `reader-hook` when a draft feels correct but too abstract to pull readers in.

It is designed for cases like:

- the title sounds like the author's conclusion, not the reader's problem
- the opening starts with essence, trend, or judgment before concrete tension
- the article is about AI, platforms, cognition, work, or creators, but the reader still lacks an entry point

## Repository Layout

```text
.
├── .claude-plugin/
│   └── marketplace.json
└── skills/
    └── reader-hook/
        ├── SKILL.md
        └── agents/
            └── openai.yaml
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

If the target environment supports skill UI metadata, add:

```text
skills/
  your-skill/
    agents/
      openai.yaml
```

## Principles

- Prefer `npx skills add` as the primary install path
- Keep each skill self-contained after installation
- Treat `skills/` as the single source of truth
- Avoid shared runtime dependencies between skills unless you later add a publish-time sync step
