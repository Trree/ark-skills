# 安装后配置

> **注意：** `SessionEnd` 的 `agent` 类型 hook 存在静默失败的已知 bug（[anthropics/claude-code#40010](https://github.com/anthropics/claude-code/issues/40010)）。
> 本 skill 改用 `command` hook 调用 `summarize.sh`，脚本内部再通过 `claude -p` 完成总结，以绕过该问题。

将以下内容合并到 `~/.claude/settings.json`：

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/session-summary/scripts/summarize.sh"
          }
        ]
      }
    ]
  }
}
```

首次使用前需确保脚本有执行权限：

```bash
chmod +x ~/.claude/skills/session-summary/scripts/summarize.sh
```

## 总结存储位置

总结文件保存在每个项目的 `.claude/summaries/` 目录下：

```
<project_root>/
└── .claude/
    └── summaries/
        ├── session_a1b2c3d4_20260331_143022.md
        └── session_e5f6g7h8_20260401_091500.md
```

## 文件命名规则

`session_<session_id前8位>_<YYYYMMDD_HHMMSS>.md`

- `session_id` 取自 hook 输入的 `session_id` 字段
- 日期时间使用 session 结束时的本地时间
- 同一 session 重复触发时覆写已有文件
