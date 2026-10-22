# 11408 备考知识库

本仓库是 11408（数据结构 / 计算机组成原理 / 操作系统 / 计算机网络）备考过程的知识库与原始资料归档。

- **知识库正文**：`computer/` 下的 Obsidian Markdown 笔记，按知识主题组织，通过 Wikilink 双链互相跳转。
- **原始资料**：`docs/` 下按学科归档，仅用于回查字迹、题目与公式，不作为电子笔记的一部分展示。
- **写作与整理规范**：见 [`CLAUDE.md`](CLAUDE.md)，任何 Agent 或人工续写都以它为准。

## 目录结构

```text
11408/
├── CLAUDE.md                 # 知识库维护 SOP（唯一规范真源）
├── computer/                 # 电子笔记（Obsidian 正文）
│   ├── README.md
│   ├── 数据结构 Part 1｜知识主干.md
│   └── 数据结构 Part1｜代码与习题总结.md
├── docs/                     # 原始资料（不嵌入正文）
│   ├── computer_notes_shot/  # 手写笔记原图归档
│   │   └── 数据结构/
│   │       ├── 原图清单.md
│   │       └── *.zip         # 原始扫描图
│   └── politics_notes_shot/  # 政治资料纯文本（PDF 只留本地，不入库）
├── scripts/                  # 本地与 CI 共用的检查脚本
├── .githooks/                # Git 钩子（commit-msg / pre-commit / pre-push）
└── .github/workflows/ci.yml  # 持续集成
```

## 本地基础设施（克隆后一次性安装）

```bash
git config core.hooksPath .githooks
```

未执行这一步时钩子不会触发，CI 仍会拦截，但本地提交会失去最早一道保护。

## Git 钩子

| 钩子 | 时机 | 内容 |
|---|---|---|
| `commit-msg` | 提交信息写入前 | 校验「类型: 中文描述」格式 |
| `pre-commit` | 提交前 | 文档链接检查 + 知识库铁律检查（秒级） |
| `pre-push` | 推送到 `main` / `dev` 前 | 运行 `scripts/ci-check.sh` 全量检查 |

跳过方式：`git commit --no-verify`、`SKIP_TESTS=1 git push`。跳过只应作为应急手段，CI 侧不可绕过。

提交信息格式：

```text
类型: 中文描述

- 文件/模块: 要点
```

类型白名单：`feat` / `fix` / `refactor` / `chore` / `docs` / `test` / `style` / `perf` / `ci` / `revert` / `merge`。描述必须用中文，类型后不加括弧说明。

## 持续集成

`main` / `dev` 的 push 与 PR 触发 `.github/workflows/ci.yml`，三个 job：

| Job | 检查内容 | 失败含义 |
|---|---|---|
| `docs` | Markdown 相对链接全部可达；双链目标可解析 | 存在死链 |
| `guard` | 知识库铁律：禁嵌入手写图、禁绝对本地路径、`tags` 不含 `11408`、命名与 frontmatter | 违反 `CLAUDE.md` 约定 |
| `hygiene` | 编码 UTF-8 无 BOM、文本统一 LF、大文件限额、疑似密钥 | 仓库卫生不达标 |

本地等价执行：

```bash
bash scripts/ci-check.sh
```

三个检查脚本可单独运行：

```bash
bash scripts/doc-link-check.sh   # 链接
bash scripts/vault-guard.sh      # 知识库铁律
```

约定说明：相对链接失效是**硬失败**；Obsidian 双链指向尚未建立的页面属于 `CLAUDE.md` §16 允许的导航占位，只输出告警不阻断。

## 仓库体积

入库的原始资料只有两类：手写图 ZIP（约 66MB）与政治资料纯文本（约 6.5MB），仓库合计约 73MB，单文件最大约 38MB。

政治资料的 PDF 只保留在本地，供人工阅读；`docs/politics_notes_shot/PDF/` 已列入 `.gitignore`，不进入版本库。

`scripts/ci-check.sh` 对大文件设有阈值：超过 50MB 告警，超过 95MB 直接判失败（GitHub 单文件硬限 100MB）。后续若继续追加大量扫描件，建议改用 Git LFS 或按批次拆分仓库。

## 知识边界

- 手写原图只保存在 `docs/computer_notes_shot/<学科>/`，不进入电子笔记展示，也不复制到 `computer/assets/`。
- `[?]` 表示原图无法可靠辨认，不得自动消除。
- 未验证的代码与未确认的答案不得标记为正确。
- 未学习章节（查找 / 排序等）不提前补完，双链占位保留即可。
