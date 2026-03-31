---
name: wechat-pipeline
description: 微信公众号内容生产的统一入口。当用户要写公众号文章、内容创作、微信自媒体、公众号选题、写稿、写文章时，必须通过此 skill 启动。核心目标是把一个被误判的问题提炼成可发布的好文章。
---

# WeChat Pipeline

这条 pipeline 只做一件事：

**把"一个被误判的问题"从模糊状态，提炼到可以发布的状态。**

如果进来的主题没有翻案点、没有真实场景、没有核心判断，pipeline 的职责是拒绝推进，而不是帮它把步骤跑完。

## 好内容的判断标准

每篇文章必须满足以下四个条件，缺一不能进入写作：

1. **翻案句**：很多人以为 ___，但实际上 ___（具体，不是泛泛反转）
2. **真实场景**：1 个，读者能认出自己在里面
3. **核心判断句**：1 句，有立场，能独立成句，不是口号
4. **读者带走的标准**：1 个，可操作，不是态度

这四行是内容核心，在阶段 2.5 强制生成，不能为空，不能模糊。

## 允许使用的 Skill

本仓库拥有的 skill：

- `ai-workflow-brand`（含 `topic-architect`、`content-auditor`）
- `reader-hook`（含 `pain-first-opening`、`example-scene-selector`、`anti-preach-rewrite`、`distribution-hooks`）
- `knowledge-article-system`（含 `knowledge-article-calibrator`、`knowledge-article-auditor`）

外部依赖（需安装 baoyu-skills 插件）：

- `keyword-research`
- `seo-content-brief`
- `seo-content-writer`
- `wechat-topic-outline-planner`
- `wechat-article-writer`
- `baoyu-format-markdown`
- `baoyu-markdown-to-html`
- `baoyu-post-to-wechat`

外部 skill 不可用时，对应阶段改为手动完成，不跳过。

## 链路选择

**品牌深度链路**（默认）：

适用于：需要研究深度、品牌积累、长期读者信任的文章。

```
品牌收束 → 选题锁定 → 研究 → 内容核心锁定 → 写作 → 写后审查 → 格式优化 → 入口优化 → 分发准备 → [发布]
```

**公众号快写链路**：

适用于：时效性强、表达驱动、不依赖研究深度的文章。

```
品牌收束 → 选题锁定 → 大纲 → 内容核心锁定 → 写作 → 写后审查 → 格式优化 → 入口优化 → 分发准备 → [发布]
```

切换到快写链路的条件：

- 用户明确要求走快写链路
- 主题是时效事件、反应型内容、个人观察记录
- 主题不依赖外部研究，素材来自作者真实经历

两条链路的品牌约束、内容核心锁定、写后审查要求完全相同。格式优化工具不同。

## 工作目录

工作根目录：`<workspace_root>`

默认值：`/root/workspace/data/wechat-pipeline`

目录约定：

- `<workspace_root>/00_topics/`
- `<workspace_root>/01_research/`
- `<workspace_root>/02_core/`
- `<workspace_root>/03_drafts/`
- `<workspace_root>/04_polish/`
- `<workspace_root>/05_publish/`
- `<workspace_root>/_state/`

`slug` 生成规则（用户未提供时自动生成）：

1. 日期使用当前本地日期
2. 主题使用用户给出的主题文本
3. 空格替换为 `-`
4. 删除不适合文件名的标点
5. 保留中文或 ASCII 字母数字

示例：主题 `AI 工作流` → `2026-03-31-AI-工作流`

固定文件契约：

- 选题输出：`<workspace_root>/00_topics/<slug>.md`
- 研究/大纲输出：`<workspace_root>/01_research/<slug>.md`
- 内容核心输出：`<workspace_root>/02_core/<slug>.md`
- 初稿输出：`<workspace_root>/03_drafts/<slug>.md`
- 优化输出：`<workspace_root>/04_polish/<slug>.md`
- 发布输出：`<workspace_root>/05_publish/<slug>.html`
- 状态文件：`<workspace_root>/_state/<slug>.json`

状态文件 schema：

```json
{
  "slug": "",
  "stage": "topic|research|core|draft|polish|publish",
  "pillar": "Judgment|Method|System|Brand Asset",
  "mission": "Define|Distinguish|Diagnose|Build|Sharpen",
  "core": {
    "inversion": "",
    "scene": "",
    "judgment": "",
    "standard": ""
  },
  "audit_score": null,
  "created_at": "",
  "updated_at": ""
}
```

## 强制规则

1. **品牌收束不可跳过**。每篇文章必须在开始前确认落在四大支柱之一，并选定文章使命类型（Define / Distinguish / Diagnose / Build / Sharpen）。
2. **内容核心锁定不可跳过**。四行内容核心（翻案句、真实场景、核心判断句、读者标准）必须明确写出，存入 `02_core/<slug>.md`，进入写作前不能为空。
3. **写后审查门槛为 16 分**。低于 16 分不进入格式优化，退回修稿。12-15 分可在标注修复项后继续，0-11 分必须退回写作阶段。
4. **入口优化默认执行**。品牌定位决定了抽象写法是高风险，每篇文章在格式优化后默认过一遍 `reader-hook`。
5. **每次只推进一个阶段**。产物文件不存在，不允许进入下一阶段。
6. **优先复用已有产物**。除非用户明确要求重写。
7. **发布需要用户明确确认**。做到 HTML 产物后暂停，不自动发布。

## 执行流程

### 阶段 0：品牌收束（强制）

使用 `ai-workflow-brand`。

目标：

1. 确认主题落在四大支柱之一（Judgment / Method / System / Brand Asset）
2. 选定文章使命类型（Define / Distinguish / Diagnose / Build / Sharpen）
3. 确认主题有"被误判"或"被低估"的张力，不是工具盘点、资讯搬运或空泛感悟

如果无法完成以上三项，停止推进，重新讨论主题方向。

如果用户未提供 `slug`，在此阶段自动生成。

输出：确认的主题方向、支柱归属、使命类型，写入状态文件。

---

### 阶段 1：选题锁定

品牌深度链路使用 `keyword-research`（不可用则手动完成）。
公众号快写链路跳过关键词研究，直接进入阶段 2。

输入：阶段 0 确认的主题方向

输出：`<workspace_root>/00_topics/<slug>.md`

最低要求：

1. 给出 5-10 个候选选题，每个注明与品牌支柱的对应关系
2. 每个选题包含：潜在翻案角度、目标读者困惑、预期核心判断方向
3. 收敛为 1 个最终选题，说明选择理由

---

### 阶段 2：研究 / 大纲

品牌深度链路使用 `seo-content-brief`（不可用则手动完成）。
公众号快写链路使用 `wechat-topic-outline-planner`（不可用则手动完成）。

输入：`<workspace_root>/00_topics/<slug>.md`

输出：`<workspace_root>/01_research/<slug>.md`

最低要求：

1. 核心问题是什么（读者真实困惑，不是泛泛话题）
2. 大家通常把它理解错在哪里（误判方向）
3. 真实场景候选（至少 2 个，择优进入下一阶段）
4. 机制层解释（为什么会误判，平台/工具/认知哪个层面）
5. 结构提纲

---

### 阶段 2.5：内容核心锁定（强制）

使用 `knowledge-article-calibrator`。

输入：`<workspace_root>/01_research/<slug>.md`

输出：`<workspace_root>/02_core/<slug>.md`

必须明确写出以下四行，不能为空，不能模糊：

```
翻案句：很多人以为 ___，但实际上 ___
真实场景：___（1 个，具体，读者能认出自己）
核心判断句：___（1 句，有立场，能独立成句）
读者带走的标准：___（1 个，可操作）
```

同时输出：

- 写作风险（3 条，指出这篇最容易犯的具体错误）
- 文章骨架（按：表面问题 → 常见误判 → 底层机制 → 重新定价 → 可执行动作）

**如果四行内容无法写出，说明研究不够，退回阶段 2。**

将确认的四行写入状态文件 `core` 字段。

---

### 阶段 3：写作

品牌深度链路使用 `seo-content-writer`（不可用则手动完成）。
公众号快写链路使用 `wechat-article-writer`（不可用则手动完成）。

输入：

- `<workspace_root>/01_research/<slug>.md`
- `<workspace_root>/02_core/<slug>.md`（必须提供，缺一不可）

输出：`<workspace_root>/03_drafts/<slug>.md`

写作约束（来自品牌规则）：

- 结论先行，不用空概念开头
- 先写读者已感受到的症状，再解释本质
- 最强金句放在文章 60%-80% 位置，不顶在开头
- 结尾给裁决型标准，不用态度收尾
- 全文只讲一个核心判断

禁止词：赋能、闭环、未来已来、颠覆一切、行业洗牌、AI 时代来临

---

### 阶段 3.5：写后审查（强制）

使用 `knowledge-article-auditor`。

输入：`<workspace_root>/03_drafts/<slug>.md`

输出：审查报告（总分、最强部分、最大问题、各项评分、必须修复、重写顺序）

评分门槛：

- **16-20 分**：进入格式优化
- **12-15 分**：可进入格式优化，但必须标注待修复项，优化后重新审查
- **0-11 分**：退回写作阶段重写，不进入格式优化

将审查分数写入状态文件 `audit_score` 字段。

---

### 阶段 4：格式优化

品牌深度链路和公众号快写链路均使用 `baoyu-format-markdown`（不可用则手动完成）。

输入：`<workspace_root>/03_drafts/<slug>.md`

输出：`<workspace_root>/04_polish/<slug>.md`

最低要求：

1. 补齐标题（必须是读者困惑型，不是作者总结型）
2. 补齐摘要
3. 调整小标题层级，每个小标题描述一个具体论点
4. 整理列表和重点强调
5. 补齐 CTA

---

### 阶段 4.5：入口优化（默认执行）

使用 `reader-hook`。

输入：`<workspace_root>/04_polish/<slug>.md`

输出：更新后的标题和开头，写回 `04_polish/<slug>.md`

检查标准：

- 标题是读者困惑，不是作者总结
- 开头先写症状，不先写本质
- 3 秒内能看懂这篇在说读者什么问题

如果当前标题和开头已满足以上三项，可跳过，说明原因。

---

### 阶段 5：分发准备

使用 `baoyu-markdown-to-html`（不可用则手动完成）。

输入：`<workspace_root>/04_polish/<slug>.md`

输出：`<workspace_root>/05_publish/<slug>.html`

完成后暂停，汇报产物路径，等待用户确认是否发布。

---

### 阶段 6：发布（需用户明确确认）

只有用户明确说"发布"，才使用 `baoyu-post-to-wechat`。

输入：`<workspace_root>/05_publish/<slug>.html`

输出：已发布到微信公众号

---

## 阶段切换条件

| 进入阶段 | 前置条件 |
|---|---|
| 阶段 1（选题） | 阶段 0 完成，支柱和使命类型已确认 |
| 阶段 2（研究） | `00_topics/<slug>.md` 存在 |
| 阶段 2.5（内容核心锁定） | `01_research/<slug>.md` 存在 |
| 阶段 3（写作） | `02_core/<slug>.md` 存在，四行内容核心完整 |
| 阶段 3.5（写后审查） | `03_drafts/<slug>.md` 存在 |
| 阶段 4（格式优化） | 审查分数 ≥ 12 |
| 阶段 5（分发准备） | `04_polish/<slug>.md` 存在 |
| 阶段 6（发布） | `05_publish/<slug>.html` 存在，且用户明确确认 |

---

## 选题池管理

`<workspace_root>/00_topics/` 下维护一个 `_backlog.md` 文件，记录：

- 所有生成过但未选用的候选选题
- 每个选题的支柱归属和预期翻案角度
- 已写过的选题角度（避免重复覆盖）

每次运行阶段 1 后，将未选用的候选选题追加到 `_backlog.md`，不丢弃。

---

## 批量执行建议

如果要做周更或批量生产，按这个节奏分批执行：

1. 周一：统一跑阶段 0-1（品牌收束 + 选题锁定），产出多个选题，填充 backlog
2. 周二：统一跑阶段 2-2.5（研究 + 内容核心锁定），确保每篇四行内容核心清晰
3. 周三：统一跑阶段 3-3.5（写作 + 写后审查），不通过的退回修稿
4. 周四：统一跑阶段 4-4.5（格式优化 + 入口优化）
5. 周五：统一跑阶段 5-6（分发准备 + 发布）
