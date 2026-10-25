#!/usr/bin/env bash
# ================================================================
# vault-guard.sh — 11408 知识库铁律 · 强制层（唯一真源）
# ================================================================
# 铁律来源：CLAUDE.md。引用一律用「节标题 + R 编号」，不用 § 序号
# （序号会随 CLAUDE.md 重排变化，节标题才是稳定锚点）。
#
#   R1  《Obsidian 双链与源文件规范》6.4  手写笔记图片不得嵌入电子笔记
#   R2  《禁止事项》                      不得使用不可移植的绝对本地路径
#   R3  《YAML Frontmatter》8.1           Obsidian tags 中不得出现 11408
#   R4  《文件命名规范》7.2               禁止「新建文档1.md」「最终版.md」这类文件名
#   R5  《YAML Frontmatter》              正式笔记必须有 type / subject / course
#   R6  《Agent 续写规则》                不得重复创建同义笔记（basename 唯一）
#   R7  《Obsidian 双链与源文件规范》6.4  原图不得落入任何学科正文目录
#   R8  《学科路由与规则真源》2.1         学科 README 只写状态，不得复制流程规则
#
# 执行点（三处，本脚本是唯一真源）：
#   - .githooks/pre-commit        （本地最早拦截）
#   - scripts/ci-check.sh         （push 前全量检查，含 pre-push 钩子调用）
#   - .github/workflows/ci.yml    （服务端 guard job，不可绕过）
#
# 检查前会剥离代码块与行内代码，避免把规范里的示例当成违规。
# 单行豁免：该行包含 `vault-guard:ignore`。
#
# 用法:   bash scripts/vault-guard.sh
# 退出码: 0 通过 / 1 违规
# ================================================================

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

WORK="$(mktemp -d 2>/dev/null || mktemp -d -t vaultguard)"
trap 'rm -rf "$WORK"' EXIT

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}[PASS]${NC} $*"; }
fail() { echo -e "  ${RED}[FAIL]${NC} $*"; }
skip() { echo -e "  ${YELLOW}[SKIP]${NC} $*"; }

HAS_ERROR=0

echo "▶ [vault-guard] 11408 知识库铁律检查"

# ---------- 收集 Markdown 文件 ----------
FILES=()
while IFS= read -r f; do
    FILES+=("$f")
done < <(find . -type f -name '*.md' \
            -not -path './.git/*' \
            -not -path './.obsidian/*' \
            -not -path './node_modules/*' \
            | sed 's|^\./||' | sort)

strip_code() {
    awk '
        /^[[:space:]]*(```|~~~)/ { inblock = !inblock; print ""; next }
        inblock               { print ""; next }
        { print }
    ' "$1" | sed -E 's/`[^`]*`//g'
}

# 去掉带 vault-guard:ignore 的行后检索
scan_rule() {
    local pattern="$1"
    local label="$2"
    local hint="$3"
    local hits=""
    local f clean
    for f in "${FILES[@]}"; do
        [ -f "$f" ] || continue
        clean="$WORK/scan.md"
        strip_code "$f" > "$clean"
        grep -n -E "$pattern" "$clean" 2>/dev/null \
            | grep -v 'vault-guard:ignore' \
            | sed "s|^|${f}:|" \
            >> "$WORK/hits.tmp" || true
    done
    hits="$(cat "$WORK/hits.tmp" 2>/dev/null || true)"
    : > "$WORK/hits.tmp"
    if [ -z "$hits" ]; then
        pass "$label"
    else
        fail "$label"
        echo "$hits" | head -8 | sed 's/^/       /'
        [ "$(printf '%s\n' "$hits" | wc -l)" -gt 8 ] && echo "       ...（最多显示 8 条）"
        echo "       → $hint"
        HAS_ERROR=1
    fi
}

: > "$WORK/hits.tmp"

# ================================================================
# R1 禁嵌入手写图（CLAUDE.md《Obsidian 双链与源文件规范》6.4）
# ================================================================
scan_rule '(!\[\[)|(!\[[^]]*\]\()' \
    "R1 禁嵌入图片：电子笔记中不得出现 ![[...]] 或 ![...](...)" \
    "电子笔记保持纯 Markdown；原图只放 00_Assets/screenshots/，不要在正文嵌入"

# ================================================================
# R2 禁绝对本地路径（CLAUDE.md《禁止事项》）
# 盘符前须是非字母或行首，避免把 https:// 的 s:/ 误认成 S 盘。
# ================================================================
scan_rule '(^|[^A-Za-z])([A-Za-z]:[\\/])|(file://)|(/Users/[A-Za-z0-9._-]+/)|(/home/[A-Za-z0-9._-]+/)' \
    "R2 可移植性：文档中不得出现绝对本地路径" \
    "改用相对路径（如 00_Assets/screenshots/408/DS/）"

# ================================================================
# R3 tags 不含 11408（CLAUDE.md《YAML Frontmatter》8.1）
# ================================================================
scan_rule '^[[:space:]]*-[[:space:]]*11408[[:space:]]*$' \
    "R3 Tag 约束：Obsidian tags 中不得出现 11408" \
    "11408 用 frontmatter 的 course: 11408 表达，不要放进 tags"

# ================================================================
# R4 文件名黑名单（CLAUDE.md《文件命名规范》7.2）
# ================================================================
BAD_NAMES=""
for f in "${FILES[@]}"; do
    base="$(basename "$f" .md)"
    case "$base" in
        新建文档*|未命名*|Untitled*|untitled*|"最终版"*|"最终版"[0-9]*|"新版"*|"笔记"[0-9]*|*" - 副本"|*"副本"|*"(1)"*|*"(2)"*) 
            BAD_NAMES="${BAD_NAMES}${f}
" ;;
    esac
done

if [ -z "$BAD_NAMES" ]; then
    pass "R4 文件命名：未发现禁止的文件名"
else
    fail "R4 文件命名：存在禁止的文件名"
    printf '%s' "$BAD_NAMES" | sed 's/^/       /'
    echo "       → 改用「主题｜子主题.md」或「<学科> Part N｜知识主干.md」"
    HAS_ERROR=1
fi

# ================================================================
# R5 正式笔记 frontmatter（CLAUDE.md《YAML Frontmatter》）
# 说明：bash 的 case 模式中 * 匹配 /，覆盖四个学科域下的正式笔记。
# ================================================================
FM_BAD=""
for f in "${FILES[@]}"; do
    case "$f" in
        01_Politics/*.md|02_English/*.md|03_Math/*.md|04_408/*.md) ;;
        *) continue ;;
    esac
    case "$(basename "$f")" in
        README.md|index.md|*MOC*.md) continue ;;
    esac
    first="$(head -n 1 "$f" | sed 's/[[:space:]]*$//')"
    if [ "$first" != "---" ]; then
        FM_BAD="${FM_BAD}${f}: 缺少 YAML frontmatter
"
        continue
    fi
    for key in type subject course; do
        if ! sed -n '1,30p' "$f" | grep -Eq "^${key}:"; then
            FM_BAD="${FM_BAD}${f}: 缺少 ${key}:
"
        fi
    done
done

if [ -z "$FM_BAD" ]; then
    pass "R5 Frontmatter：正式笔记字段完整（type / subject / course）"
else
    fail "R5 Frontmatter：正式笔记字段缺失"
    printf '%s' "$FM_BAD" | sed 's/^/       /'
    echo "       → 参照 CLAUDE.md《YAML Frontmatter》补齐 type / subject / course / status / tags"
    HAS_ERROR=1
fi

# ================================================================
# R6 不得重复创建同义笔记（CLAUDE.md《Agent 续写规则》）
# 说明：README.md / index.md 是目录说明；原图目录的 manifest.md 是资料清单，
# 均不是笔记双链目标，不参与重名判定。
# ================================================================
DUP="$(for f in "${FILES[@]}"; do
    base="$(basename "$f")"
    case "$f" in
        00_Assets/screenshots/*/manifest.md) continue ;;
    esac
    case "$base" in
        README.md|index.md) continue ;;
    esac
    printf '%s\n' "$base"
done | sort | uniq -d)"
if [ -z "$DUP" ]; then
    pass "R6 唯一性：Markdown 文件名无重名（Obsidian 双链可唯一定位）"
else
    fail "R6 唯一性：存在同名 Markdown 文件（双链会指向不明）"
    printf '%s\n' "$DUP" | sed 's/^/       /'
    HAS_ERROR=1
fi

# ================================================================
# R7 原图不得落入电子笔记目录（CLAUDE.md《Obsidian 双链与源文件规范》6.4）
# ================================================================
IMG_HITS="$(find 01_Politics 02_English 03_Math 04_408 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' \) 2>/dev/null)"
if [ -n "$IMG_HITS" ]; then
    fail "R7 学科正文目录中存在图片（应只放 00_Assets/screenshots/）"
    printf '%s\n' "$IMG_HITS" | head -5 | sed 's/^/       /'
    HAS_ERROR=1
else
    pass "R7 学科正文目录中无图片"
fi

# ================================================================
# R8 学科 README 体量上限（CLAUDE.md《学科路由与规则真源》2.1）
# 学科 README 只写状态与事实。超过上限即意味着流程规则被复制进来了，
# 于是 CLAUDE.md 与学科 README 各有一份，改一处就会漂移。
# ================================================================
README_LIMIT=120
OVER=""
for f in 01_Politics/README.md 02_English/README.md 03_Math/README.md 04_408/*/README.md; do
    [ -f "$f" ] || continue
    n="$(wc -l < "$f" | tr -d ' ')"
    if [ "$n" -gt "$README_LIMIT" ]; then
        OVER="${OVER}${f}: ${n} 行（上限 ${README_LIMIT}）
"
    fi
done

if [ -z "$OVER" ]; then
    pass "R8 学科规则体量：每科 README 均在 ${README_LIMIT} 行以内"
else
    fail "R8 学科规则体量：学科 README 超过 ${README_LIMIT} 行"
    printf '%s' "$OVER" | sed 's/^/       /'
    echo "       → 学科 README 只写「教材口径 + 禁止提前扩写」；流程规范指回 CLAUDE.md"
    HAS_ERROR=1
fi

echo ""
if [ "$HAS_ERROR" -eq 0 ]; then
    echo -e "  ${GREEN}知识库铁律全部通过${NC}"
else
    echo -e "  ${RED}存在铁律违规，修复后重新运行${NC}"
fi

exit "$HAS_ERROR"
