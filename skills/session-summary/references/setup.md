# 安装后配置

将以下内容合并到 `~/.claude/settings.json`：

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "agent",
            "once": true,
            "prompt": "读取 transcript_path 的对话内容，按照 session-summary skill 的 templates/summary.md.template 格式生成中文总结，保存到 .claude/summaries/session_<session_id前8位>_<YYYYMMDD_HHMMSS>.md。不足3轮对话则跳过。",
            "tools": ["Read", "Write", "Glob"],
            "timeout": 60
          }
        ]
      }
    ]
  }
}
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
