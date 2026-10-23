# 11408 学习知识库

这是面向未来 Agent 与自己复习的学习资料入口。目录表达学科与资料类型；**目录存在不代表已经学过**。知识正文是可独立阅读的 Markdown，手写图和原典只用来追溯。

## 从哪里进入

| 任务 | 入口 |
|---|---|
| 读取全局规则 | [CLAUDE.md](CLAUDE.md) |
| 按学科和资产类型路由 | [AGENT_API_GUIDE.md](AGENT_API_GUIDE.md) |
| 摄入新一批手写图 | [INGEST-SOP.md](99_System/INGEST-SOP.md) |
| 复习数据结构 Part 1 | [知识主干](04_408/01_Data_Structure/DS-P1-Knowledge.md) → [代码与习题过程](04_408/01_Data_Structure/DS-P1-Code-Exercises.md) |
| 查原图及处理状态 | [数据结构原图清单](00_Assets/screenshots/408/DS/manifest.md) |

## 目录契约

```text
11408/
├── 00_Assets/                 # 原始资料：ZIP、文本、本地 PDF；不嵌入笔记
│   ├── screenshots/408/DS/    # 两份原图 ZIP + manifest
│   ├── texts/politics/        # 政治原典文本
│   └── pdfs/politics/         # 仅本地，不入 Git
├── 01_Politics/               # 00_Readings 与四门考纲分轨
├── 02_English/                # 词汇、句法、阅读、写作、语境复习
├── 03_Math/                   # 高数、线代、概率论
├── 04_408/                    # 数据结构、计组、操作系统、计算机网络
├── 99_System/                # 摄入 SOP
├── scripts/                   # 本地及 CI 校验
├── AGENT_API_GUIDE.md         # 根目录 YAML 路由指南
├── CLAUDE.md                  # 全局规范唯一真源
└── README.md                  # 本入口
```

英语、数学和政治考纲分支目前为空目录，仅为未来学习预留。数据结构现阶段仍保留两篇 Part 1 文档，按主题导航，章节稳定后再拆分。政治现有《中国通史》笔记属于 `00_Readings/`，不能当作史纲考点。

## 资料和证据

- 原图只在 `00_Assets/` 中保留 ZIP 单一副本；正文提炼抽象信息，不嵌入图片或图片路径。
- **我的错误**只用于原图明确标错、用户明确指出，或有完整题目与过程可核实的错误；涂改和模糊处标待核对。
- 2027 年 408 考纲与王道《数据结构》用于范围对齐。没有教材具体页时，不声称核对了王道的原题、代码或答案。
- 笔记文件名保留学科前缀，Obsidian 双链以唯一 basename 定位。

## 本地检查

克隆后可安装钩子：`git config core.hooksPath .githooks`。本地运行 `bash scripts/ci-check.sh`，与 CI 的链接、知识库规则、编码、大文件及疑似密钥检查对应。`.obsidian/` 与 `00_Assets/pdfs/politics/` 不入 Git。
