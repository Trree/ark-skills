---
name: wechat-pipeline
description: 用已安装的 skill 编排微信公众号内容流水线，按 选题 -> 研究 -> 写作 -> 优化 -> 分发 的固定流程产出内容，并把每一步写入约定文件路径，支持主链路和公众号快写链路切换。
---

# WeChat Pipeline

这个 skill 用来把微信公众号内容生产流程编排成一条固定流水线。

目标是只使用现成 skill，把生产过程稳定为：

`选题 -> 研究 -> 写作 -> 优化 -> 分发`

这是仓库里的公开编排入口。

用户应该把它当成流程入口，而不是把内部 subskill 当成平级选择。

## 何时使用

当用户要在 Codex 里快速搭一套公众号内容流水线，或者明确要做下面这些事情时使用：

- 规划微信公众号内容生产流程
- 用 skill 串起选题、研究、写作、排版、发布
- 批量生产公众号文章
- 为后续扩展到其他渠道保留可替换结构

## 允许使用的 Skill

主链路：

1. `keyword-research`
2. `seo-content-brief`
3. `seo-content-writer`
4. `baoyu-format-markdown`
5. `baoyu-markdown-to-html`
6. `baoyu-post-to-wechat`

公众号快写链路：

1. `wechat-topic-outline-planner`
2. `wechat-article-writer`
3. `baoyu-format-markdown`
4. `baoyu-markdown-to-html`
5. `baoyu-post-to-wechat`

默认优先主链路。只有在下面情况才切到快写链路：

- 用户明确要求“走公众号快写链路”
- 当前主题更强调公众号表达，而不是研究深度
- 主链路中的研究或写作 skill 明显不适配当前目标

## 本仓库内推荐增强 Skill

这条流水线允许接入本仓库的公开 skill 作为增强节点：

1. `ai-workflow-brand`
2. `reader-hook`

使用原则：

- 如果主题方向、定位、栏目归属还不清楚，先用 `ai-workflow-brand`
- 如果文章主线没问题，但标题和开头不够有进入感，用 `reader-hook`
- 如果准备发布前需要检查是否跑偏，也回到 `ai-workflow-brand`

不要要求用户直接记忆 `ai-workflow-brand` 的内部 subskill。对用户来说，公开入口始终是母 skill。

## 工作目录

工作根目录使用 `<workspace_root>`。

默认值：

`/root/workspace/data/wechat-pipeline`

目录约定：

- `<workspace_root>/00_topics/`
- `<workspace_root>/01_research/`
- `<workspace_root>/02_drafts/`
- `<workspace_root>/03_polish/`
- `<workspace_root>/04_publish/`
- `<workspace_root>/_state/`

`slug` 默认不是必填。

如果用户没有提供 `slug`，自动按下面规则生成：

`YYYY-MM-DD-主题`

生成规则：

1. 日期使用当前本地日期
2. 主题使用用户给出的主题文本
3. 把空格替换为 `-`
4. 删除明显不适合文件名的标点
5. 保留中文或 ASCII 字母数字都可以，不需要强制转拼音

示例：

- 主题：`AI 工作流`
- 自动生成：`2026-03-17-AI-工作流`

固定文件契约：

- 选题输出：`<workspace_root>/00_topics/<slug>.md`
- 研究输出：`<workspace_root>/01_research/<slug>.md`
- 初稿输出：`<workspace_root>/02_drafts/<slug>.md`
- 优化输出：`<workspace_root>/03_polish/<slug>.md`
- 发布输出：`<workspace_root>/04_publish/<slug>.html`
- 状态文件：`<workspace_root>/_state/<slug>.json`

## 核心规则

1. 每次只推进一个阶段，不要跳步。
2. 每个阶段都要明确输入文件和输出文件。
3. 如果上一步产物不存在，不要继续下一步。
4. 优先复用已有产物，除非用户明确要求重写。
5. 每完成一步，都简短汇报当前产物路径和下一步。
6. 除非用户明确说“发布”，否则做到 HTML 产物后暂停。
7. 如果某个 skill 不适合当前主题，要先说明原因，再切换到备选链路。
8. 一篇文章对应一个 `slug`，不要把多个主题混进同一条产线。
9. 如果用户没传 `slug`，先生成默认 `slug`，再开始第一阶段。
10. 如果用户没传 `workspace_root`，默认使用 `/root/workspace/data/wechat-pipeline`。

## 执行流程

### 阶段 0：可选定位收束

如果用户给的是宽泛主题，或本次内容更依赖品牌判断而不是关键词研究，先使用 `ai-workflow-brand` 收束定位、主线和选题方向。

这个阶段是可选增强，不替代后续正式阶段。

### 阶段 1：选题

使用 `keyword-research`。

输入：

- 用户给出的主题方向

如果用户没给 `slug`，先根据主题自动生成。

输出：

- `<workspace_root>/00_topics/<slug>.md`

最低要求：

1. 给出 10 个可写选题
2. 每个选题包含关键词、搜索意图、目标读者
3. 给出优先级
4. 最终收敛成 1 个最值得写的题目

### 阶段 2：研究

默认使用 `seo-content-brief`。

输入：

- `<workspace_root>/00_topics/<slug>.md`

输出：

- `<workspace_root>/01_research/<slug>.md`

最低要求：

1. 文章目标
2. 读者画像
3. 核心论点
4. 结构提纲
5. 证据点或案例建议
6. 标题方向

如果使用公众号快写链路，则在这个阶段改用 `wechat-topic-outline-planner` 直接生成公众号大纲。

### 阶段 3：写作

默认使用 `seo-content-writer`。

输入：

- `<workspace_root>/01_research/<slug>.md`

输出：

- `<workspace_root>/02_drafts/<slug>.md`

最低要求：

1. 标题有点击动机但不过度夸张
2. 结构清晰
3. 有案例或场景
4. 结尾有行动建议

如果使用公众号快写链路，则在这个阶段改用 `wechat-article-writer`。

### 阶段 4：优化

使用 `baoyu-format-markdown`。

输入：

- `<workspace_root>/02_drafts/<slug>.md`

输出：

- `<workspace_root>/03_polish/<slug>.md`

最低要求：

1. 补齐标题
2. 补齐摘要
3. 调整小标题层级
4. 整理列表和重点强调
5. 补齐 CTA

### 阶段 4.5：可选入口优化

如果草稿或优化稿已经成立，但标题和开头仍然偏抽象、偏结论、缺少点击动机，则使用 `reader-hook` 做入口优化。

输入：

- `<workspace_root>/02_drafts/<slug>.md` 或 `<workspace_root>/03_polish/<slug>.md`

输出：

- 更新后的标题和开头方案，写回当前稿件或作为单独优化建议记录

这个阶段不改变文章主线，只改善读者进入感。

### 阶段 5：分发准备

使用 `baoyu-markdown-to-html`。

输入：

- `<workspace_root>/03_polish/<slug>.md`

如果用户希望在转 HTML 前做一次品牌主线检查，先使用 `ai-workflow-brand` 对当前稿件进行审查，再继续分发准备。

输出：

- `<workspace_root>/04_publish/<slug>.html`

### 阶段 6：发布

只有用户明确说“发布”时，才使用 `baoyu-post-to-wechat`。

输入：

- `<workspace_root>/04_publish/<slug>.html`

输出：

- 已发布到微信公众号，或给出发布过程中的登录/API 选择

## 阶段切换条件

只有满足下面条件，才能进入下一阶段：

1. `00_topics/<slug>.md` 存在，才能进入研究
2. `01_research/<slug>.md` 存在，才能进入写作
3. `02_drafts/<slug>.md` 存在，才能进入优化
4. `03_polish/<slug>.md` 存在，才能转 HTML
5. `04_publish/<slug>.html` 存在，且用户明确要求发布，才能进入公众号发布

可选增强阶段不会改变主阶段的必需产物要求。

## 批量执行建议

如果用户要做周更或批量生产，按这个节奏分批执行：

1. 周一统一跑选题
2. 周二统一跑研究
3. 周三统一跑写作
4. 周四统一跑优化
5. 周五统一跑 HTML 和发布
