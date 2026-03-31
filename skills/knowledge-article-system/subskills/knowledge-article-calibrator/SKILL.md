---
name: knowledge-article-calibrator
description: Prewriting calibration for knowledge articles. Clarifies misbelief, scene, core judgment, recalculation, and decision standard before drafting.
pattern: generator
domain: writing
output-format: structured-markdown
---

# Knowledge Article Calibrator

Use before writing the full article.

## Goal
Help the user answer 5 questions before drafting:
1. What misbelief is this article correcting?
2. What real scene anchors the problem?
3. What is the core judgment?
4. What surface problem must be recalculated?
5. What decision standard should the reader leave with?

## Workflow

### 1. Misbelief
Compress the article into:
- Many people think X
- But the more accurate reality is Y

Requirements:
- specific
- relevant to real work / AI use / content practice
- not a generic hot take

### 2. Real scene
Give 1-3 concrete scenes.
Good scenes are:
- recognizable
- common enough to matter
- tied directly to the article's real problem

### 3. Core judgment
Write one sentence that:
- has a clear stance
- can stand alone
- is not empty like "build systems" or "think deeply"

### 4. Recalculate the problem
Force at least one layer shift:
- You think the problem is A; actually it is B
- The real problem is not X but Y
- On the surface it looks like X; at a deeper level it is Y

### 5. Skeleton
Default structure:
1. Contrarian opening
2. Concrete scene
3. First recalculation
4. Deeper recalculation
5. 2-4 supporting points
6. Decision standard
7. Broader closing frame

### 6. Writing risks
List 3 likely failure modes, such as:
- too abstract
- no real scene
- ends with attitude, not criteria
- sounds like tool advice, not judgment writing

## Output format

### Prewriting calibration

**Misbelief**
…

**Real scenes**
1. …
2. …
3. …

**Core judgment**
…

**Problem recalculation**
- Surface problem: …
- Deeper problem: …
- Root judgment: …

**Suggested structure**
1. …
2. …
3. …
4. …
5. …
6. …
7. …

**Writing risks**
1. …
2. …
3. …

## Constraints
- Do not write the full article unless explicitly asked
- Do not give generic outlines
- Do not allow the article to proceed without a real scene and a core judgment
- If the user has not specified a writing structure, default to the formula in `references/writing-formula.md`: 表面问题 → 常见误判 → 底层机制 → 重新定价 → 可执行动作
- Check the user's topic against the four long-term topic types in `references/writing-formula.md` (被低估的能力 / 被误判的问题 / 被高估的方法 / 被忽视的慢变量) — name which type it belongs to
