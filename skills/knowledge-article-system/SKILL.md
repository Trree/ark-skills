---
name: knowledge-article-system
description: Route between prewriting calibration and postdraft audit for knowledge articles on AI, workflows, cognition, content systems, and judgment.
pattern: orchestrator
domain: writing
output-format: structured-markdown
---

# Knowledge Article System

Use this skill for knowledge articles, especially:
- AI
- workflows
- cognition
- content production
- judgment
- WeChat longform essays

## Route
- If user has only a topic, angle, notes, or rough outline → use `knowledge-article-calibrator`
- If user has a full draft or detailed outline → use `knowledge-article-auditor`
- If user has both topic and draft → do a light calibration first, then audit

## Global standard
Every strong article should contain:
- 1 real scene
- 1 problem recalculation
- 1 core judgment sentence
- 1 reusable decision standard

## Hard rules
- Do not reward empty abstraction
- Do not confuse information density with article strength
- Do not end with attitude only; end with judgment criteria
- Prefer clear judgment over neutral summarization
- Prefer scene + mechanism over slogans

## Good output
For calibration:
1. Misbelief
2. Real scenes
3. Core judgment
4. Recalculation
5. Article skeleton
6. Writing risks

For audit:
1. Total score
2. Strongest parts
3. Biggest weaknesses
4. Item scores
5. Must-fix issues
6. Rewrite order
