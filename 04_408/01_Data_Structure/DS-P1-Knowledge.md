---
type: note
subject: 数据结构
course: 11408
source: 王道数据结构 + 个人课堂/刷题草稿
status: active
part: 1
tags:
  - 数据结构
  - 王道
  - Obsidian
aliases:
  - 数据结构 Part1
---

# 数据结构（Data Structures）Part 1｜知识主干

> [!info] 使用说明
> 本文档只保留**可复习、可检索、可继续扩展的知识主干**。  
> 从手稿归纳出的推导、代码理解、题型方法与待确认问题整理在：[[DS-P1-Code-Exercises]]。
>
> 后续 Agent 续写时，应优先补充当前章节，而不是重复创建同义笔记。

> [!info] 证据范围
> 本轮已核对两份原图 ZIP 共 32 张：12 张正式笔记与 20 张草稿。原文件名序号分别为 1–12 和 15–34，序号不等于上传张数。这里按主题抽象，不把涂改过的题解、未见到的王道教材代码写成已核对结论。2027 考纲与王道出版社目录用于范围定位，细节口径仍按学科 README 管理。

## 0. 导航

- [[DS-P1-Code-Exercises]]
- 后续待建立：
  - [[DS-C07-Search]]
  - [[DS-C08-Sort]]
  - [[DS-WrongIndex]]
  - [[DS-Templates]]

---

## 1. 数据结构（Data Structure）与算法（Algorithm）基础

### 1.1 数据结构（Data Structure）三要素

**数据结构（data structure）= 逻辑结构（logical structure）+ 存储结构（storage structure）+ 数据的运算（operations on data）**

逻辑结构可概括为：集合结构（set structure）、线性结构（linear structure）、树形结构（tree structure）、图状结构（graph structure）。

存储结构常见为：顺序存储（sequential storage）、链式存储（linked storage）、索引存储（indexed storage）、散列存储（hash storage）。

### 1.2 算法（Algorithm）与复杂度（Complexity）

算法分析（algorithm analysis）主要关注：

- 正确性
- 可读性
- 健壮性
- 时间效率
- 空间效率

常见时间复杂度（time complexity）数量级：

$$
O(1)<O(\log n)<O(n)<O(n\log n)<O(n^2)<O(n^3)<O(2^n)<O(n!)
$$

> [!info] 草稿关联
> 复杂度推导、等比数列求和、递归层数等演算见：  
> [[DS-P1-Code-Exercises#复杂度（Complexity）：先分清轮数与每轮代价]]

---

## 2. 线性表（Linear List）

### 2.1 顺序表（Sequential List）与链表（Linked List）

| 维度 | 顺序表（sequential list） | 链表（linked list） |
|---|---|---|
| 存储空间 | 连续 | 可不连续 |
| 随机访问 | 支持 | 不支持 |
| 按位查找 | 快 | 需沿链遍历 |
| 插入/删除 | 常涉及元素移动 | 主要修改指针 |
| 空间分配 | 通常预分配 | 可按需申请 |

### 2.2 单链表（Singly Linked List）

结点（node）结构：

```c
typedef struct LNode {
    ElemType data;
    struct LNode *next;
} LNode, *LinkList;
```

结构示意：

```text
head
 ↓
[data|next] → [data|next] → [data|next] → NULL
```

### 2.3 双链表（Doubly Linked List）

```c
typedef struct DNode {
    ElemType data;
    struct DNode *prior, *next;
} DNode, *DLinkList;
```

结构示意：

```text
NULL ← A ⇄ B ⇄ C → NULL
```

### 2.4 循环链表（Circular Linked List）与静态链表（Static Linked List）

- 循环链表（circular linked list）：尾结点的指针重新指向头结点/头结点附近。
- 静态链表（static linked list）：使用数组下标模拟指针关系。

> [!info] 后续建议
> 链表部分后续可独立拆成：
> - [[DS-C02-SeqList]]
> - [[DS-C02-SinglyLinked]]
> - [[DS-C02-DoublyLinked]]
> - [[DS-C02-CircularStatic]]

---

## 3. 栈（Stack）、队列（Queue）、数组（Array）与串（String）

### 3.1 栈（Stack）

核心特征：

$$
\text{LIFO}
$$

即**后进先出（Last In, First Out, LIFO）**。

典型应用：

- 括号匹配
- 表达式求值
- 递归
- 深度优先类过程

### 3.2 队列（Queue）

核心特征：

$$
\text{FIFO}
$$

即**先进先出（First In, First Out, FIFO）**。

```text
出队 ← front [A][B][C][D] rear ← 入队
```

### 3.3 串（String）与模式匹配（Pattern Matching）

重点：

- 串（string）的基本概念
- 朴素模式匹配（naive string matching）
- KMP 算法（Knuth–Morris–Pratt Algorithm）
- `next` 数组
- `nextval`

> [!warning] 王道口径
> 本库后续关于 KMP 的下标、`next` 初值和推导统一按**王道数据结构**口径整理。  
> 若草稿中使用了不同下标习惯，应在题目旁标明，不直接混写。

---

## 4. 树（Tree）与二叉树（Binary Tree）

### 4.1 树（Tree）的基本概念

常见概念：

- 根结点（root node）
- 父结点（parent node）/ 子结点（child node）
- 兄弟结点（sibling nodes）
- 叶子结点（leaf node）
- 结点的度（node degree）
- 树的度（tree degree）
- 层次（level）
- 高度（height）/ 深度（depth）

树中：

$$
n = e + 1
$$

其中 $n$ 为结点数，$e$ 为边数。

### 4.2 m 叉树（m-ary Tree）的常见结论

第 $i$ 层最多：

$$
m^{i-1}
$$

个结点。

高度为 $h$ 时最多：

$$
1+m+m^2+\cdots+m^{h-1}
=
\frac{m^h-1}{m-1}
$$

个结点。

### 4.3 二叉树（Binary Tree）性质

非空二叉树中：

$$
n_0=n_2+1
$$

其中：

- $n_0$：叶子结点数
- $n_2$：度为 2 的结点数

常见类型：

| 类型 | 记忆重点 |
|---|---|
| 满二叉树（perfect binary tree） | 每层结点数达到最大 |
| 完全二叉树（complete binary tree） | 与满二叉树的编号位置对应 |
| 二叉排序树（binary search tree） | 左子树关键字小于根，右子树关键字大于根 |
| 平衡二叉树（balanced binary tree） | 左右子树高度差受约束 |

> [!info] 草稿关联
> 树高、结点数、层数、递归关系等习题见：  
> [[DS-P1-Code-Exercises#树的遍历（Tree Traversal）：访问顺序由规则和树形共同决定]]

---

## 5. 二叉树遍历（Binary Tree Traversal）、线索二叉树（Threaded Binary Tree）、树（Tree）与森林（Forest）

### 5.1 遍历（Traversal）

| 遍历方式 | 访问顺序 |
|---|---|
| 前序遍历（preorder traversal） | 根 → 左 → 右 |
| 中序遍历（inorder traversal） | 左 → 根 → 右 |
| 后序遍历（postorder traversal） | 左 → 右 → 根 |
| 层序遍历（level-order traversal） | 按层访问 |

记忆法：

> 前、中、后，说的是“根”的访问位置。

### 5.2 线索二叉树（Threaded Binary Tree）

常见结点结构：

```c
typedef struct ThreadNode {
    ElemType data;
    struct ThreadNode *lchild, *rchild;
    int ltag, rtag;
} ThreadNode;
```

标志位：

```text
tag = 0 → 指向孩子
tag = 1 → 指向线索
```

线索用于记录：

- 前驱（predecessor）
- 后继（successor）

### 5.3 树（Tree）与森林（Forest）的表示

- 双亲表示法（parent representation）
- 孩子表示法（child-list representation）
- 孩子兄弟表示法（left-child right-sibling representation）

孩子兄弟表示法核心：

```text
data | firstChild | nextSibling
```

---

## 6. 哈夫曼树（Huffman Tree）

带权路径长度（weighted path length, WPL）：

$$
WPL=\sum_{i=1}^{n}w_i l_i
$$

哈夫曼树的目标：使 WPL 最小。

构造过程：

```text
取权值最小的两个结点
        ↓
合并为新结点
        ↓
新权值 = 两者之和
        ↓
重新加入集合
        ↓
重复
```

---

## 7. 图（Graph）

### 7.1 图（Graph）的基本定义

$$
G=(V,E)
$$

- $V$：顶点（vertex）集合
- $E$：边（edge）集合

常见概念：

- 有向图（directed graph）/ 无向图（undirected graph）
- 简单图（simple graph）/ 多重图（multigraph）
- 完全图（complete graph）
- 子图（subgraph）
- 连通图（connected graph）
- 强连通图（strongly connected graph）
- 连通分量（connected component）
- 强连通分量（strongly connected component）
- 度（degree）/ 入度（in-degree）/ 出度（out-degree）

无向图：

$$
\sum_{v\in V}D(v)=2|E|
$$

有向图：

$$
\sum ID(v)=\sum OD(v)=|E|
$$

### 7.2 图（Graph）的存储

- 邻接矩阵（adjacency matrix）
- 邻接表（adjacency list）
- 十字链表（orthogonal list）
- 邻接多重表（adjacency multilist）

### 7.3 图（Graph）的遍历（Traversal）

**广度优先搜索（Breadth-First Search, BFS）**

- 常借助队列
- 按层扩展

**深度优先搜索（Depth-First Search, DFS）**

- 常借助递归或栈
- 沿一条路径深入后回溯

> [!info] 草稿关联
> 图遍历、访问序列、矩阵/邻接表手推过程见：  
> [[DS-P1-Code-Exercises#图（Graph）的存储与遍历（Traversal）：先弄清结构，再手推访问]]

---

## 8. 最小生成树（Minimum Spanning Tree, MST）

### 8.1 普里姆算法（Prim's Algorithm）

普里姆算法（Prim's algorithm）从一个顶点出发，逐步扩展已选顶点集合。

记忆：

> Prim 更像“扩点”。

基本过程：

```text
从一个顶点开始
      ↓
维护已选顶点集合
      ↓
选择连接集合内外的最小权边
      ↓
加入新顶点
      ↓
直到包含全部顶点
```

### 8.2 克鲁斯卡尔算法（Kruskal's Algorithm）

克鲁斯卡尔算法（Kruskal's algorithm）按边权从小到大选边，同时避免成环。

记忆：

> Kruskal 更像“选边”。

基本过程：

```text
边按权值升序排列
      ↓
从小到大尝试加入
      ↓
若形成环则舍弃
      ↓
直到选出 n-1 条边
```

---

## 9. 最短路径（Shortest Path）

| 算法 | 主要用途 |
|---|---|
| 广度优先搜索（Breadth-First Search, BFS） | 无权图单源最短路 |
| 迪杰斯特拉算法（Dijkstra's Algorithm） | 非负权图单源最短路 |
| 弗洛伊德算法（Floyd–Warshall Algorithm） | 各顶点之间最短路 |

> [!info] 草稿关联
> Dijkstra / Floyd 的表格推演和路径更新过程见：  
> [[DS-P1-Code-Exercises#最短路径（Shortest Path）：距离状态与路径状态要一起维护]]

---

## 10. 有向无环图（Directed Acyclic Graph, DAG）、拓扑排序（Topological Sorting）与关键路径（Critical Path）

### 10.1 有向无环图（Directed Acyclic Graph, DAG）

有向无环图（directed acyclic graph, DAG）：**没有有向环的有向图**。

### 10.2 AOV 网（Activity-on-Vertex Network）

AOV 网（activity-on-vertex network）用顶点表示活动。

- 常用于描述活动之间的先后制约关系
- 与拓扑排序（topological sorting）相关

### 10.3 AOE 网（Activity-on-Edge Network）

AOE 网（activity-on-edge network）用边表示活动。

- 顶点常表示事件
- 与关键路径（critical path）相关

---

## 11. Part 1 当前边界

本 Part 暂时覆盖：

```text
数据结构基础
→ 线性结构
→ 栈/队列/串
→ 树与二叉树
→ 图
→ MST
→ 最短路径
→ DAG / 拓扑 / AOE
```

暂不在本文扩写：

- [[DS-C07-Search]]
- [[DS-C08-Sort]]

这两部分等待后续上传笔记后单独初始化，避免一次性把整本知识体系写成不可维护的大文件。

---

## 12. 后续 Agent 续写约定

> [!info] Agent Rule
> 1. 新内容优先补进已有章节。
> 2. 代码、手推、习题与错题经理解和归纳后进入 [[DS-P1-Code-Exercises]]。
> 3. 已稳定的知识点才进入本文。
> 4. 模糊字迹必须保留 `[?]`，不得自行脑补。
> 5. KMP、树高、下标等定义统一以王道口径为主。
> 6. 查找、排序后续分别创建独立笔记。
> 7. 跨文档引用使用 Obsidian Wikilink，避免 Markdown 相对链接作为主导航。
