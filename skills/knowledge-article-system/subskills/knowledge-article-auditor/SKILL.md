---
name: knowledge-article-auditor
description: Postdraft audit for knowledge articles. Scores article strength based on misbelief, opening tension, real scenes, recalculation, core judgment, structure, and decision standard.
pattern: reviewer
domain: writing
output-format: scored-markdown
---

# Knowledge Article Auditor

Use after the user has a draft or detailed outline.

## Goal
Judge whether the article is actually strong, not merely "well-formed."

## Score each item 0-2
- 0 = missing
- 1 = present but weak
- 2 = clear and strong

Total: 20

## Criteria

### 1. Misbelief target
Can the article be compressed into:
- Many people think X
- But actually Y

### 2. Opening tension
Does the opening create tension, contradiction, or a strong claim?
If it only introduces the topic, score low.

### 3. Real scene
Is there at least one concrete, recognizable scene?
If removing examples leaves only abstraction, score low.

### 4. Problem recalculation
Does the article reframe the problem at least once?
Look for:
- not X but Y
- surface vs deeper problem
- false diagnosis vs real diagnosis

### 5. Core judgment
Can the full article be compressed into one sentence with stance and boundaries?

### 6. Structural progression
Do sections deepen the argument, or just sit side by side?

### 7. Abstract-to-concrete control
Watch for overuse of:
- cognition
- systems
- structure
- efficiency
- methodology
- value
If abstract words are not anchored in scenes, score low.

### 8. Ending standard
Does the ending leave the reader with a reusable standard, checklist, or rule?
If it ends with mood or attitude only, score low.

### 9. Voice fit
Does it sound like a research-based judgment writer rather than:
- a tool-review account
- a motivational writer
- a trend-summary account

### 10. Order reconstruction
After reading, does the reader gain clearer judgment and less confusion?

## Score meaning
- 16-20: ready to publish
- 12-15: publishable after tightening
- 8-11: good topic, weak article
- 0-7: article-shaped, not strong enough

## Output format

### Audit result

**Total score**: X/20
**Verdict**: Ready / Needs revision / Not ready

**Strongest 2 parts**
1. …
2. …

**Biggest 3 problems**
1. …
2. …
3. …

**Item scores**
1. Misbelief target: X/2
2. Opening tension: X/2
3. Real scene: X/2
4. Problem recalculation: X/2
5. Core judgment: X/2
6. Structural progression: X/2
7. Abstract grounding: X/2
8. Ending standard: X/2
9. Voice fit: X/2
10. Order reconstruction: X/2

**Must-fix**
- …
- …

**Optional tightening**
- …
- …

**Rewrite order**
1. …
2. …
3. …

## Constraints
- No empty praise
- No vague advice like "be more specific"
- Point to the real weak layer: opening, scene, judgment, structure, or ending
- Prioritize judgment over line editing
