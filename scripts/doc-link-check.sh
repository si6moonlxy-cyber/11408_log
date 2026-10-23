#!/usr/bin/env bash
# ================================================================
# doc-link-check.sh — 知识库链接可达性检查
# ================================================================
# 用法:   bash scripts/doc-link-check.sh
# 退出码: 0 通过 / 1 存在死链或歧义链接
#
# 检查三类链接（均先剥离代码块与行内代码，避免把示例当链接）：
#   1. Markdown 相对链接 `](path)`  — 目标必须存在（硬门禁，失败即退出 1）
#   2. Obsidian 双链 `[[目标]]`      — 目标应在库内可解析（仅告警，不阻断）
#      理由：CLAUDE.md《内容升级规则》允许「计划后续建立的页面」作为导航占位。
#   3. 歧义双链                      — 裸文件名双链命中多个同名文件（硬门禁）
#      理由：CLAUDE.md《Obsidian 双链与源文件规范》6.1 —— Wikilink 只写
#      basename，落点不确定等于错链；本库有多个 README.md，必须用相对
#      路径 Markdown 链接指向具体文件。
#
# 跳过: http/https 外链、mailto / tel、纯锚点 `#...`、以 `://` 结尾的外部双链
#
# 被以下入口调用:
#   - .githooks/pre-commit
#   - .github/workflows/ci.yml（docs job）
#   - scripts/ci-check.sh（第 1 步）
# ================================================================

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

WORK="$(mktemp -d 2>/dev/null || mktemp -d -t vaultlink)"
trap 'rm -rf "$WORK"' EXIT

DEAD="$WORK/dead.txt"
WARN="$WORK/warn.txt"
AMB="$WORK/amb.txt"
: > "$DEAD"
: > "$WARN"
: > "$AMB"

echo "🔍 检查知识库链接..."

# ---------- 收集 Markdown 文件 ----------
FILES=()
while IFS= read -r f; do
    FILES+=("$f")
done < <(find . -type f -name '*.md' \
            -not -path './.git/*' \
            -not -path './.obsidian/*' \
            -not -path './node_modules/*' \
            | sed 's|^\./||' | sort)

if [ "${#FILES[@]}" -eq 0 ]; then
    echo "⚠️  未找到 Markdown 文件"
    exit 0
fi

# ---------- 双链索引：完整路径去 .md + 纯文件名去 .md ----------
declare -A INDEX=()
declare -A BASE_COUNT=()
for f in "${FILES[@]}"; do
    p="${f%.md}"
    b="$(basename "$p")"
    INDEX["$p"]=1
    INDEX["$b"]=1
    BASE_COUNT["$b"]=$(( ${BASE_COUNT["$b"]:-0} + 1 ))
done

# ---------- 剥离代码（保留行号：代码行输出为空行而非删除） ----------
strip_code() {
    awk '
        /^[[:space:]]*(```|~~~)/ { inblock = !inblock; print ""; next }
        inblock               { print ""; next }
        { print }
    ' "$1" | sed -E 's/`[^`]*`//g'
}

# ---------- 逐文件检查 ----------
for file in "${FILES[@]}"; do
    [ -f "$file" ] || continue
    clean="$WORK/clean.md"
    strip_code "$file" > "$clean"
    dir="$(dirname "$file")"

    # ---- 1. Markdown 相对链接（硬门禁）----
    while IFS= read -r raw; do
        test -z "$raw" && continue
        # raw 形如 ](target) —— 去掉包裹的方括号与圆括号
        link="$(printf '%s' "$raw" | sed -e 's/^](//' -e 's/)$//')"

        case "$link" in
            http://*|https://*|mailto:*|tel:*|'#'*) continue ;;
        esac

        # 只解码常见的空格编码
        link="${link//%20/ }"
        # 去掉锚点后缀（path#section）
        link="${link%%#*}"
        test -z "$link" && continue

        case "$link" in
            /*) target=".$link" ;;
            *)  target="$dir/$link" ;;
        esac

        if [ ! -e "$target" ]; then
            echo "  DEAD: $file -> $link" >> "$DEAD"
        fi
    done < <(grep -o -E '\]\([^)]*\)' "$clean" 2>/dev/null || true)

    # ---- 2/3. Obsidian 双链（占位告警 / 歧义硬失败）----
    while IFS=$'\t' read -r lno raw; do
        test -z "$raw" && continue
        target="$raw"
        target="$(printf '%s' "$target" | sed -e 's/|.*$//' -e 's/#.*$//' -e 's/\^.*$//')"
        target="$(printf '%s' "$target" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
        test -z "$target" && continue
        case "$target" in *'://'*) continue ;; esac

        if [ -z "${INDEX[$target]:-}" ]; then
            echo "  MISS: $file:$lno -> [[$target]]" >> "$WARN"
        elif [ "${BASE_COUNT[$target]:-0}" -gt 1 ]; then
            echo "  AMB: $file:$lno -> [[$target]]（库内 ${BASE_COUNT[$target]} 个同名文件，落点不确定）" >> "$AMB"
        fi
    done < <(awk '{
        line = $0
        while (match(line, /\[\[[^]]+\]\]/)) {
            s = substr(line, RSTART + 2, RLENGTH - 4)
            print NR "\t" s
            line = substr(line, RSTART + RLENGTH)
        }
    }' "$clean")
done

# ---------- 汇总 ----------
DEAD_N=$(wc -l < "$DEAD" | tr -d ' ')
WARN_N=$(wc -l < "$WARN" | tr -d ' ')
AMB_N=$(wc -l < "$AMB" | tr -d ' ')

if [ "$WARN_N" -gt 0 ]; then
    echo ""
    echo "⚠️  有 ${WARN_N} 个双链目标尚未建立（占位导航，不阻断）："
    sed 's/^/   /' "$WARN" | head -20
    [ "$WARN_N" -gt 20 ] && echo "   ...（其余 $((WARN_N - 20)) 条略）"
fi

if [ "$AMB_N" -gt 0 ]; then
    echo ""
    echo "❌ 发现 ${AMB_N} 个歧义双链（同名文件不止一个，Obsidian 落点不确定）："
    sed 's/^/   /' "$AMB"
    echo ""
    echo "   处理: 改用相对路径 Markdown 链接指向具体文件（如 [数据结构规则](04_408/01_Data_Structure/README.md)）"
    exit 1
fi

if [ "$DEAD_N" -gt 0 ]; then
    echo ""
    echo "❌ 发现 ${DEAD_N} 个死链："
    sed 's/^/   /' "$DEAD"
    echo ""
    echo "   处理: 修正链接路径或补建目标文件后重跑 bash scripts/doc-link-check.sh"
    exit 1
fi

echo ""
echo "✅ 文档链接正常（检查 ${#FILES[@]} 个文件）"
exit 0
