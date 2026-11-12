# 学习知识库｜现目标：科软 22408

这是面向未来 Agent 与自己复习的学习资料入口。当前目标是 **2027 年 12 月初试、报考 2028 级中科大软件学院 085405 常规班**，按英语二、数学二、408 与政治备考，具体安排见 [备考计划](STUDY_PLAN.md)。`11408/` 是沿用的仓库目录名，不再代表当前考试组合。目录表达学科与资料类型；**目录存在不代表已经学过**。知识正文是可独立阅读的 Markdown，手写图和原典只用来追溯。

## 从哪里进入

| 任务 | 入口 |
|---|---|
| 查看目标、时间轴与每周复盘 | [科软 22408 备考计划](STUDY_PLAN.md) |
| 读取全局规则 | [CLAUDE.md](CLAUDE.md) |
| 按内容类型整理或审读笔记 | [笔记整理 Schema](99_System/NOTE-SCHEMA.md) |
| 按学科和资产类型路由 | [AGENT_API_GUIDE.md](AGENT_API_GUIDE.md) |
| 摄入新一批手写图 | [INGEST-SOP.md](99_System/INGEST-SOP.md) |
| 复习高数第一章：函数、极限、连续 | [知识主干](03_Math/01_Calculus/MATH-P1-Knowledge.md) ↔ [解题推演](03_Math/01_Calculus/MATH-P1-Exercises.md)；原图见 [高数原图清单](00_Assets/screenshots/math/CCS/manifest.md)，整理口径见 [数学学科规则](03_Math/README.md) |
| 复习高数第二章：导数与微分 | [知识主干](03_Math/01_Calculus/MATH-P2-Knowledge.md) ↔ [解题推演](03_Math/01_Calculus/MATH-P2-Exercises.md)；原图见 [高数原图清单](00_Assets/screenshots/math/CCS/manifest.md) |
| 复习数据结构第 1–4 章（基础） | [知识主干](04_408/01_Data_Structure/DS-P1-Knowledge.md) → [代码与习题](04_408/01_Data_Structure/DS-P1-Code-Exercises.md) |
| 复习数据结构第 5–6 章（树与图） | [知识主干](04_408/01_Data_Structure/DS-P2-Knowledge.md) → [代码与习题](04_408/01_Data_Structure/DS-P2-Code-Exercises.md) |
| 复习英语 | [词汇](02_English/01_Vocabulary/EN-Vocabulary.md) · [长难句与句法](02_English/02_Syntax/EN-Syntax.md) · [发音](02_English/05_Context_Boost/EN-Context-Boost.md) · [后续阅读模板](02_English/03_Reading/EN-Templates-Reading.md) |
| 查原图及处理状态 | [数据结构原图清单](00_Assets/screenshots/408/DS/manifest.md) |

## 目录契约

```text
11408/
├── 00_Assets/                 # 原始资料：ZIP、文本、本地 PDF；不嵌入笔记
│   ├── screenshots/408/DS/    # 两份原图 ZIP + manifest
│   ├── screenshots/math/CCS/ # CCS-partN.zip、CCS-partN-draft.zip 与 manifest
│   ├── texts/politics/        # 政治原典文本
│   └── pdfs/politics/         # 仅本地，不入 Git
├── 01_Politics/               # 00_Readings 与四门考纲分轨
├── 02_English/                # 词汇、句法、阅读、写作、语境复习
├── 03_Math/                   # 数二主线：高数、线代；概率目录保留
├── 04_408/                    # 数据结构、计组、操作系统、计算机网络
├── 99_System/                # 笔记整理 Schema 与摄入 SOP
├── scripts/                   # 本地及 CI 校验
├── STUDY_PLAN.md              # 当前目标、阶段安排与核对事项
├── AGENT_API_GUIDE.md         # 根目录 YAML 路由指南
├── CLAUDE.md                  # 全局规范唯一真源
└── README.md                  # 本入口
```

英语词汇、长难句与发音分支已收录材料；阅读分支仅有待启用模板，写作分支仍为空目录。高数的笔记、手稿 ZIP 已归档并登记：第一章函数、极限、连续在 P1 双文档，第二章导数与微分在 P2 双文档；ZIP 的 `partN` 只表示上传批次，不决定电子笔记分卷。当前课程口径为武忠祥高数基础阶段，具体教材口径以高数学科规则为准。政治目录封存至 2027 年 7 月，考纲分支仍为预留；现有《中国通史》笔记属于 `00_Readings/`，不能当作史纲考点。数据结构按四组规划：P1 第 1–4 章基础、P2 第 5–6 章树与图已有双文档；第 7 章查找和第 8 章排序分别在原图核对后建立 P3、P4。

## 资料和证据

- 原图只在 `00_Assets/` 中保留 ZIP 单一副本；正文提炼抽象信息，不嵌入图片或图片路径。
- **我的错误**只用于原图明确标错、用户明确指出，或有完整题目与过程可核实的错误；涂改和模糊处先在聊天中提问；未澄清的细节不写入新笔记。
- 2027 年 408 考纲与王道《数据结构》用于范围对齐。没有教材具体页时，不声称核对了王道的原题、代码或答案。
- 笔记文件名保留学科前缀，Obsidian 双链以唯一 basename 定位。

## 本地检查

克隆后可安装钩子：`git config core.hooksPath .githooks`。本地运行 `bash scripts/ci-check.sh`，与 CI 的链接、知识库规则、编码、大文件及疑似密钥检查对应。`.obsidian/` 与 `00_Assets/pdfs/politics/` 不入 Git。
