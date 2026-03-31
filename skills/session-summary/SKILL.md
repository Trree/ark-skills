---
name: session-summary
description: 在 Claude Code session 结束时自动生成中文会话总结，保存到 .claude/summaries/。当用户需要记录对话历史、生成工作日志、或回顾上下文时使用。
tools: Read, Write, Glob
---

# Session Summary

每次 session 结束时自动生成结构化中文总结，持久化保存到项目目录。

## 触发方式

通过 `SessionEnd` hook 自动触发，无需手动调用。

安装后需要将 hooks 配置合并到 `~/.claude/settings.json`，详见 `references/setup.md`。

## 去重机制

- 同一 session 只生成一次（`once: true`）
- 文件名包含 session_id 前 8 位，重复触发时覆写而非新建
- 对话轮数少于 3 轮自动跳过

## 总结格式

参考 `templates/summary.md.template`，输出 5 个字段：

1. **核心目标** — 本次 session 想解决什么
2. **完成内容** — 实际做了什么，产物在哪里
3. **关键决策** — 做了哪些值得记录的判断
4. **待续事项** — 下次需要接着做的事
5. **使用的 skill** — 调用了哪些 skill

## 手动触发

在对话中说"生成本次会话总结"即可手动触发，输出路径同自动触发。

## Position in ark-skills

- 公开角色：会话记录与上下文持久化
- 工作目录：`<project_root>/.claude/summaries/`
- 推荐搭配：
  - 配合 `wechat-pipeline` 使用，记录每条产线的执行状态
  - 配合 `ai-workflow-brand` 使用，记录每次定位决策
