#!/usr/bin/env bash
# ================================================================
# ci-check.sh — 11408 知识库 push 前本地全量检查
# （与 .github/workflows/ci.yml 的检查口径对应）
# ================================================================
# 用法:   bash scripts/ci-check.sh
# 退出码: 0 全部通过 / 1 存在失败
#
# 设计原则（沿用 InsightGraph 的 CI 约定）:
#   1. 硬门禁 0 容忍：链接 / 铁律 / 编码 / 密钥，出现任何问题即 FAIL
#   2. 用「存在性守卫」让检查随仓库成长自动生效，而不是先造空壳检查
#   3. 结果必须可复现：不跑任何依赖网络或随机性的检查
#   4. 检查范围随项目形态裁剪：本库是 Markdown 知识库，无 ruff / eslint
# ================================================================

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}[PASS]${NC} $*"; }
fail() { echo -e "  ${RED}[FAIL]${NC} $*"; }
warn() { echo -e "  ${YELLOW}[WARN]${NC} $*"; }

echo "================================================================"
echo "  11408 — Pre-Push CI Check"
echo "================================================================"
echo ""

HAS_ERROR=0

# ================================================================
# 1. 链接可达性（Markdown 相对链接 + Obsidian 双链）
# ================================================================
echo -e "${CYAN}[1/6] Docs — 链接检查${NC}"
if bash "$ROOT/scripts/doc-link-check.sh"; then
    pass "链接检查通过"
else
    fail "存在死链，修复后重新运行"
    HAS_ERROR=1
fi

# ================================================================
# 2. 知识库铁律（CLAUDE.md §6.4 / §7.2 / §8 / §19）
# ================================================================
echo ""
echo -e "${CYAN}[2/6] Guard — 知识库铁律${NC}"
if bash "$ROOT/scripts/vault-guard.sh"; then
    pass "知识库铁律通过"
else
    fail "存在铁律违规，修复后重新运行"
    HAS_ERROR=1
fi

# ================================================================
# 3. 编码与换行（.gitattributes 约定：文本统一 LF、UTF-8 无 BOM）
# ================================================================
echo ""
echo -e "${CYAN}[3/6] Hygiene — 编码与换行${NC}"

TEXT_FILES=()
while IFS= read -r f; do
    TEXT_FILES+=("$f")
done < <(find . -type f \( -name '*.md' -o -name '*.sh' -o -name '*.yml' -o -name '*.yaml' -o -name '*.json' \) \
            -not -path './.git/*' -not -path './node_modules/*' \
            | sed 's|^\./||' | sort)

CRLF_HITS=""
for f in "${TEXT_FILES[@]}"; do
    if grep -qU $'\r' "$f" 2>/dev/null; then
        CRLF_HITS="${CRLF_HITS}${f}
"
    fi
done

if [ -z "$CRLF_HITS" ]; then
    pass "换行符：文本文件全部 LF"
else
    fail "换行符：以下文件含 CRLF（.gitattributes 约定 LF）"
    printf '%s' "$CRLF_HITS" | head -10 | sed 's/^/       /'
    echo "       → 处理: git add --renormalize .  或编辑器改为 LF"
    HAS_ERROR=1
fi

BOM_HITS=""
for f in "${TEXT_FILES[@]}"; do
    if [ "$(head -c 3 "$f" | od -An -tx1 | tr -d ' \n')" = "efbbbf" ]; then
        BOM_HITS="${BOM_HITS}${f}
"
    fi
done

if [ -z "$BOM_HITS" ]; then
    pass "编码：文本文件无 UTF-8 BOM"
else
    fail "编码：以下文件带 UTF-8 BOM"
    printf '%s' "$BOM_HITS" | head -10 | sed 's/^/       /'
    HAS_ERROR=1
fi

# ================================================================
# 4. 大文件与仓库配额（GitHub 单文件硬限 100MB）
# ================================================================
echo ""
echo -e "${CYAN}[4/6] Size — 大文件与配额${NC}"

BIG_95="$(find . -type f -size +95M -not -path './.git/*' 2>/dev/null | sed 's|^\./||')"
BIG_50="$(find . -type f -size +50M -not -path './.git/*' 2>/dev/null | sed 's|^\./||')"

if [ -n "$BIG_95" ]; then
    fail "存在超过 95MB 的文件（GitHub 单文件硬限 100MB，推送会被拒绝）"
    printf '%s\n' "$BIG_95" | sed 's/^/       /'
    echo "       → 处理: 压缩 / 拆分，或改用 Git LFS"
    HAS_ERROR=1
else
    pass "无超过 95MB 的文件"
    if [ -n "$BIG_50" ]; then
        warn "以下文件超过 50MB（可推送，但 GitHub 会提示 large file）"
        printf '%s\n' "$BIG_50" | sed 's/^/       /'
    fi
fi

REPO_MB="$(du -sm --exclude=.git . 2>/dev/null | cut -f1)"
if [ -n "${REPO_MB:-}" ]; then
    if [ "$REPO_MB" -ge 1024 ]; then
        warn "仓库体积 ${REPO_MB}MB（超过 1GB，GitHub 会提示仓库过大）"
    else
        pass "仓库体积 ${REPO_MB}MB"
    fi
fi

# ================================================================
# 5. 安全门禁 — 疑似硬编码密钥扫描
# ================================================================
echo ""
echo -e "${CYAN}[5/6] Security — 疑似硬编码密钥扫描${NC}"

SECRETS="$(grep -rn -E '(sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|gho_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----)' \
    --include='*.md' --include='*.sh' --include='*.yml' --include='*.yaml' --include='*.json' \
    . 2>/dev/null | grep -v -E '^\./\.git/' | grep -v 'vault-guard:ignore' || true)"

if [ -z "$SECRETS" ]; then
    pass "未发现疑似硬编码密钥"
else
    fail "发现疑似硬编码密钥（应改为环境变量或本地配置）："
    printf '%s\n' "$SECRETS" | head -10 | sed 's/^/       /'
    HAS_ERROR=1
fi

# ================================================================
# 6. 钩子安装状态（提示级）
# ================================================================
echo ""
echo -e "${CYAN}[6/6] Hooks — 本地钩子安装状态${NC}"

HOOKS_PATH="$(git config --get core.hooksPath 2>/dev/null || true)"
if [ "$HOOKS_PATH" = ".githooks" ]; then
    pass "core.hooksPath = .githooks（钩子已启用）"
else
    warn "本地钩子未启用（当前: ${HOOKS_PATH:-未设置}）"
    echo "       → 一次性安装: git config core.hooksPath .githooks"
fi

# ================================================================
# Summary
# ================================================================
echo ""
echo "================================================================"
if [ "$HAS_ERROR" -eq 0 ]; then
    echo -e "  ${GREEN}All checks passed!${NC} Safe to push."
    echo "================================================================"
    exit 0
else
    echo -e "  ${RED}Some checks failed.${NC} Fix errors before pushing."
    echo "================================================================"
    exit 1
fi
