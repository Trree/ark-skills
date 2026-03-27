---
name: ai-workflow-brand
description: 母 skill。用工程视角解释 AI 如何进入真实工作流，并改变协作、判断与个人价值。负责定位总控与任务分流。
---

# AI Workflow Brand

这是对外公开入口 skill。

用户应该直接使用这个入口来处理定位、选题方向和品牌主线检查，不需要单独记忆内部 subskill。

先读取：

- `references/brand.md`
- `references/audience.md`
- `references/rules.md`

## 任务分流

### 1. 定位 / 简介 / 品牌表述
直接回答，但严格基于 references。

### 2. 选题 / 标题 / 栏目 / 系列规划
调用：
- `subskills/topic-architect/SKILL.md`

### 3. 审稿 / 跑偏检查 / 重写建议
调用：
- `subskills/content-auditor/SKILL.md`

## 在仓库中的位置

- 公开角色：策略与品牌入口
- 内部能力：通过 subskill 完成更细的选题和审稿动作
- 典型搭配：
  - 写完后用 `reader-hook` 优化标题和开头
  - 做公众号流程时可作为 `wechat-pipeline` 的前置定位或发布前审查节点

## 总原则
输出必须满足：

- 结论先行
- 不写泛 AI 热点
- 不写工具清单
- 不写空泛趋势文
- 必须落到工作流、协作、判断节点、责任边界、价值迁移

## 目标位置
成为这样的人：

**一个用工程视角，持续解释 AI 如何进入真实工作流，并重塑工作、协作与个人价值的人。**
