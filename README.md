# ark-skills

`ark-skills` is a GitHub-hosted content workflow skill repository designed for `npx skills add`.

It is organized as a small system with three public entry skills:

- `ai-workflow-brand`: strategy and brand entry point
- `reader-hook`: title and opening refinement
- `wechat-pipeline`: publishing workflow orchestration

Internal subskills stay nested under their parent skill and are not the main entry points users need to remember.

## Install

Use the GitHub repository directly:

```bash
npx skills add <your-github-username>/ark-skills
```

If your environment supports Claude Code plugin marketplaces, you can also add the repository there:

```text
/plugin marketplace add <your-github-username>/ark-skills
```

## Public Skills

### `ai-workflow-brand`

Use `ai-workflow-brand` when you need positioning, topic direction, or a brand-line audit.

This is the strategy entry point. It routes internally to its own subskills when needed.

### `reader-hook`

Use `reader-hook` when a draft feels correct but too abstract to pull readers in.

It is designed for cases like:

- the title sounds like the author's conclusion, not the reader's problem
- the opening starts with essence, trend, or judgment before concrete tension
- the article is about AI, platforms, cognition, work, or creators, but the reader still lacks an entry point

### `wechat-pipeline`

Use `wechat-pipeline` when you want to run a repeatable WeChat content workflow from topic selection through publishing preparation.

It can use local `ark-skills` capabilities as optional enhancement steps while keeping the main pipeline stable.

## Recommended Entry Paths

- Need positioning, topic direction, or brand guardrails: start with `ai-workflow-brand`
- Need a stronger title or opening: use `reader-hook`
- Need an end-to-end production flow: use `wechat-pipeline`

See `skills/CATALOG.md` for the full relationship map.

## Repository Layout

```text
.
├── .claude-plugin/
│   └── marketplace.json
├── docs/
│   └── superpowers/
│       └── specs/
└── skills/
    ├── CATALOG.md
    ├── ai-workflow-brand/
    │   ├── SKILL.md
    │   ├── agents/
    │   │   └── openai.yaml
    │   ├── references/
    │   └── subskills/
    ├── reader-hook/
    │   ├── SKILL.md
    │   └── agents/
    │       └── openai.yaml
    └── wechat-pipeline/
        ├── SKILL.md
        └── agents/
            └── openai.yaml
```

Each skill lives in its own folder under `skills/<skill-name>/`.

## Architecture

The repository uses three layers:

- Public entry skills: the main skills users should invoke directly
- Internal subskills: focused helpers used by a parent skill
- Orchestration skills: workflow skills that connect multiple capabilities into a repeatable process

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
- Keep public entry points few and obvious
- Treat `skills/` as the single source of truth
- Keep subskills nested under the parent skill that owns them
- Avoid shared runtime dependencies between skills unless you later add a publish-time sync step
