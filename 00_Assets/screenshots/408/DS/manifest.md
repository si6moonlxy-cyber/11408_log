# 数据结构原图清单（共 52 张）

本清单仅用于原始资料回查，不属于 Obsidian 正文笔记。原图保留在下列四份 ZIP 中，不在电子笔记展示，也不复制到 `computer/assets/`。ZIP 文件名中的 `partN` 只表示上传批次，不决定 P1/P2/P3 的章节分组。

## 归档与核对

- `DS-part1.zip`：12 张，原文件名序号 1–12；本轮逐张核对，用于知识主干的范围与概念复盘。
- `DS-part1-draft.zip`：20 张，原文件名序号 15–34；本轮逐张核对，用于代码与算法流程的主题总结。
- 两份 ZIP 均通过 ZIP 完整性检查。
- 草稿 ZIP 的 20 张与原 `computer/assets/draft-15.jpg` 至 `draft-34.jpg` 的大小和 CRC32 逐张一致。移除重复副本后，以 ZIP 为原图来源。
- 两份 ZIP 合计就是你上传的 **12 + 20 = 32 张**。`34` 只是第二份 ZIP 最后一张的原文件名序号，不是照片张数；两份 ZIP 的文件名没有使用序号 13、14，这不表示你少上传了两张。
- `DS-part2.zip`：7 张，原文件名序号 62–68；第 6 章拓扑排序、关键路径结尾及第 7 章查找正式笔记。
- `DS-part2-draft.zip`：13 张，原文件名序号 69–81；BST、AVL、B 树、分块查找与散列表等草稿，另含表达式树和查找代价试推。
- 新两份 ZIP 均通过 ZIP 完整性检查；原文件名序号 62–81 连续，共 **7 + 13 = 20 张**。与首批合计 **52 张**。序号 35–61 不在当前四份 ZIP 内，不据此推断缺页内容。

## 条目清单

| ZIP | 原文件名序号 | ZIP 内文件名 | 本轮归类 |
|---|---:|---|---|
| DS-part1.zip | 1 | Weixin Image_20261021172240_1_1.jpg | 数据结构基本概念、逻辑与存储结构 |
| DS-part1.zip | 2 | Weixin Image_20261021172240_2_1.jpg | 算法性质、时空复杂度 |
| DS-part1.zip | 3 | Weixin Image_20261021172240_3_1.jpg | 顺序表与线性结构入口 |
| DS-part1.zip | 4 | Weixin Image_20261021172240_4_1.jpg | 栈、队列、串与 KMP |
| DS-part1.zip | 5 | Weixin Image_20261021172240_5_1.jpg | 树的性质、二叉排序树与平衡树 |
| DS-part1.zip | 6 | Weixin Image_20261021172240_6_1.jpg | 二叉树性质、遍历、线索化 |
| DS-part1.zip | 7 | Weixin Image_20261021172240_7_1.jpg | 线索二叉树与树的表示 |
| DS-part1.zip | 8 | Weixin Image_20261021172240_8_1.jpg | 图基本概念、哈夫曼树、并查集 |
| DS-part1.zip | 9 | Weixin Image_20261021172240_9_1.jpg | 图的连通性、生成树与存储 |
| DS-part1.zip | 10 | Weixin Image_20261021172240_10_1.jpg | 图存储、BFS/DFS 与复杂度 |
| DS-part1.zip | 11 | Weixin Image_20261021172240_11_1.jpg | MST 与最短路径 |
| DS-part1.zip | 12 | Weixin Image_20261021172240_12_1.jpg | DAG、拓扑排序、关键路径 |
| DS-part1-draft.zip | 15 | Weixin Image_20261021173809_15_1.jpg | 复杂度、对数层数、求和草稿 |
| DS-part1-draft.zip | 16 | Weixin Image_20261021173809_16_1.jpg | 复杂度、倍增与折半过程 |
| DS-part1-draft.zip | 17 | Weixin Image_20261021173809_17_1.jpg | 复杂度；双链表插入 |
| DS-part1-draft.zip | 18 | Weixin Image_20261021173809_18_1.jpg | 复杂度；中缀/后缀表达式草稿 |
| DS-part1-draft.zip | 19 | Weixin Image_20261021173809_19_1.jpg | 二叉树层序遍历与队列片段 |
| DS-part1-draft.zip | 20 | Weixin Image_20261021173809_20_1.jpg | 线索二叉树建立草稿 |
| DS-part1-draft.zip | 21 | Weixin Image_20261021173809_21_1.jpg | 线索二叉树递归与前驱/后继 |
| DS-part1-draft.zip | 22 | Weixin Image_20261021173809_22_1.jpg | 线索二叉树中序遍历与结点函数 |
| DS-part1-draft.zip | 23 | Weixin Image_20261021173809_23_1.jpg | 线索二叉树首/末结点函数 |
| DS-part1-draft.zip | 24 | Weixin Image_20261021173809_24_1.jpg | 树与森林遍历、孩子兄弟表示 |
| DS-part1-draft.zip | 25 | Weixin Image_20261021173809_25_1.jpg | 并查集；图的度与存储 |
| DS-part1-draft.zip | 26 | Weixin Image_20261021173809_26_1.jpg | 图的存储方式、邻接判断 |
| DS-part1-draft.zip | 27 | Weixin Image_20261021173809_27_1.jpg | 图的 BFS 与访问序列 |
| DS-part1-draft.zip | 28 | Weixin Image_20261021173809_28_1.jpg | 带权图最短路径手推 |
| DS-part1-draft.zip | 29 | Weixin Image_20261021173809_29_1.jpg | Floyd 路径拆分与递归复原 |
| DS-part1-draft.zip | 30 | Weixin Image_20261021173809_30_1.jpg | 无权图 BFS 最短路径 |
| DS-part1-draft.zip | 31 | Weixin Image_20261021173809_31_1.jpg | Dijkstra 算法代码草稿（原图横置） |
| DS-part1-draft.zip | 32 | Weixin Image_20261021173809_32_1.jpg | Floyd 算法代码草稿（原图横置） |
| DS-part1-draft.zip | 33 | Weixin Image_20261021173809_33_1.jpg | Floyd 路径递归；表达式树 |
| DS-part1-draft.zip | 34 | Weixin Image_20261021173809_34_1.jpg | 表达式树草图 |
| DS-part2.zip | 62 | Weixin Image_20261112164354_62_1.jpg | 拓扑排序、关键路径结尾；查找总论、顺序与折半查找 |
| DS-part2.zip | 63 | Weixin Image_20261112164354_63_1.jpg | BST 查找、插入、删除；AVL 插入旋转 |
| DS-part2.zip | 64 | Weixin Image_20261112164354_64_1.jpg | AVL 删除、红黑树与 B 树性质 |
| DS-part2.zip | 65 | Weixin Image_20261112164354_65_1.jpg | B 树高度、插入分裂与删除借位/合并 |
| DS-part2.zip | 66 | Weixin Image_20261112164354_66_1.jpg | 分块查找；B+ 树与 B 树比较 |
| DS-part2.zip | 67 | Weixin Image_20261112164354_67_1.jpg | 散列表、冲突与散列函数构造 |
| DS-part2.zip | 68 | Weixin Image_20261112164354_68_1.jpg | 拉链法、开放定址法、ASL 与装填因子 |
| DS-part2-draft.zip | 69 | Weixin Image_20261112164416_69_1.jpg | BST 迭代与递归查找及红笔修正 |
| DS-part2-draft.zip | 70 | Weixin Image_20261112164416_70_1.jpg | BST 迭代与递归插入及红笔修正 |
| DS-part2-draft.zip | 71 | Weixin Image_20261112164416_71_1.jpg | 分块查找索引代码；拉链法散列草稿 |
| DS-part2-draft.zip | 72 | Weixin Image_20261112164416_72_1.jpg | 拉链法散列删除与指针修正（原图横置） |
| DS-part2-draft.zip | 73 | Weixin Image_20261112164416_73_1.jpg | 表达式树草图；查找失败 ASL 试推 |
| DS-part2-draft.zip | 74 | Weixin Image_20261112164416_74_1.jpg | 折半查找代码、边界修正与有序表示例 |
| DS-part2-draft.zip | 75 | Weixin Image_20261112164416_75_1.jpg | AVL 的 LL、RR 旋转及指针重连 |
| DS-part2-draft.zip | 76 | Weixin Image_20261112164416_76_1.jpg | AVL 的 LR、RL 双旋转草图（原图横置） |
| DS-part2-draft.zip | 77 | Weixin Image_20261112164416_77_1.jpg | AVL 删除后向上调整的多版手推（原图横置） |
| DS-part2-draft.zip | 78 | Weixin Image_20261112164416_78_1.jpg | B 树阶数、关键字数和高度界（原图横置） |
| DS-part2-draft.zip | 79 | Weixin Image_20261112164416_79_1.jpg | 5 阶 B 树插入、分裂与删除手推（原图横置） |
| DS-part2-draft.zip | 80 | Weixin Image_20261112164416_80_1.jpg | B 树删除合并；B+ 树分支与叶层（原图横置） |
| DS-part2-draft.zip | 81 | Weixin Image_20261112164416_81_1.jpg | 分块查找索引结构和比较次数草稿（原图横置） |

## 使用规则

- 新会话先核对 ZIP 完整性与对应条目，再读取原图。
- 先按页码和知识上下文排序；同一张图出现多个知识点时，分别归入对应章节。
- 看不清的字、数字、图结点或代码先在聊天中向用户提问；未澄清的细节不写入新笔记，不以教材或模型常识替代原笔记。
- 已划掉的废稿和装饰线不转入电子笔记；疑似错误先核对完整原图和用户澄清；能证明时直接纠正并说明依据，证据不足时先提问。
- 已逐张核对当前四份 ZIP 的全部 52 张。图中涂改、划去和看不清的结论没有升格为个人错误或标准答案。第 6 章尾页归 P2；第 7 章查找归 P3；第 73 张的表达式树属于基础章节，不因 ZIP 批次归入 P3。
