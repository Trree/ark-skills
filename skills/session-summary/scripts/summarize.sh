#!/bin/bash
# SessionEnd hook: 生成会话总结
# 绕过 SessionEnd agent hook 静默失败的问题（见 anthropics/claude-code#40010）
# 改为 command hook 调用此脚本，再由脚本内部用 claude -p 执行总结

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('transcript_path',''))" 2>/dev/null)
SESSION_ID=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('session_id',''))" 2>/dev/null)
CWD=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('cwd',''))" 2>/dev/null)

# transcript 不存在则跳过
[ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ] && exit 0

# 对话轮数少于3轮跳过
TURNS=$(grep -c '"type":"user"' "$TRANSCRIPT" 2>/dev/null || echo 0)
[ "$TURNS" -lt 3 ] && exit 0

# 构造输出路径
SESSION_SHORT="${SESSION_ID:0:8}"
DATETIME=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="${CWD}/.claude/summaries"
OUTPUT_FILE="${OUTPUT_DIR}/session_${SESSION_SHORT}_${DATETIME}.md"

mkdir -p "$OUTPUT_DIR"

# 查找模板路径（支持全局和项目级 skill）
TEMPLATE=""
SKILL_DIRS=(
  "$HOME/.claude/skills/session-summary/templates/summary.md.template"
  "${CWD}/.claude/skills/session-summary/templates/summary.md.template"
)
for t in "${SKILL_DIRS[@]}"; do
  [ -f "$t" ] && TEMPLATE="$t" && break
done

TEMPLATE_HINT=""
[ -n "$TEMPLATE" ] && TEMPLATE_HINT="，按照以下模板格式输出：$(cat "$TEMPLATE")"

PROMPT="请读取文件 $TRANSCRIPT 的对话内容，生成中文会话总结${TEMPLATE_HINT}。
将结果保存到文件：$OUTPUT_FILE
Session ID: $SESSION_ID，时间：$(date '+%Y-%m-%d %H:%M:%S')，目录：$CWD"

# 调用 claude -p 执行总结（非交互模式）
claude -p "$PROMPT" --allowedTools "Read,Write" --output-format text > /dev/null 2>&1 &
