#!/bin/bash
# 从 stdin 读取 hook 输入，判断是否需要总结
INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('transcript_path',''))" 2>/dev/null)

# transcript 不存在则跳过
[ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ] && exit 0

# 对话轮数少于3轮跳过
TURNS=$(grep -c '"type":"user"' "$TRANSCRIPT" 2>/dev/null || echo 0)
[ "$TURNS" -lt 3 ] && exit 0

exit 0  # 通过检查，交给 agent 处理
