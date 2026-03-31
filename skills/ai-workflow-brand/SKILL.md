---
name: ai-workflow-brand
description: 母 skill。研究 AI 时代个人判断力、方法论、系统能力与品牌资产建设。负责定位总控与任务分流。
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
- 不写纯工具盘点
- 不写空泛趋势文
- 不写没有方法论沉淀的内容
- 必须落到判断力、方法论、系统、或品牌资产四大支柱之一

## 目标位置
成为这样的人：

**一个持续研究 AI 时代个人判断力与系统能力建设的人——帮助读者不只是把事情做完，而是把自己整理成一个系统。**
