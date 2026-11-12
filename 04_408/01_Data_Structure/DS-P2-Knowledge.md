---
type: note
subject: 数据结构
course: 22408
source: 2027 王道数据结构课程笔记 + 个人手稿
status: active
part: 2
tags: [数据结构, 基础阶段]
aliases: [数据结构树与图知识主干]
---

# 数据结构 P2｜第 5–6 章：树与图｜知识主干

> [!info] 范围与来源
> 第 5–6 章：树与二叉树、图。依据 32 张已核对的原图中相关页面整理；具体推导与代码见 [[DS-P2-Code-Exercises]]。第 1–4 章见 [[DS-P1-Knowledge]]。

## 1. 树（Tree）与二叉树（Binary Tree）

### 1.1 树（Tree）的基本概念

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

### 1.2 m 叉树（m-ary Tree）的常见结论

第 $i$ 层最多：

$$
m^{i-1}
$$

个结点。

当 $m\ge2$，高度为 $h$ 时最多：

$$
1+m+m^2+\cdots+m^{h-1}
=
\frac{m^h-1}{m-1}
$$

个结点。

### 1.3 二叉树（Binary Tree）性质

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
> [[DS-P2-Code-Exercises#1. 层序遍历：队列保持待访问顺序]]

---

## 2. 二叉树遍历（Binary Tree Traversal）、线索二叉树（Threaded Binary Tree）、树（Tree）与森林（Forest）

### 2.1 遍历（Traversal）

| 遍历方式 | 访问顺序 |
|---|---|
| 前序遍历（preorder traversal） | 根 → 左 → 右 |
| 中序遍历（inorder traversal） | 左 → 根 → 右 |
| 后序遍历（postorder traversal） | 左 → 右 → 根 |
| 层序遍历（level-order traversal） | 按层访问 |

记忆法：

> 前、中、后，说的是“根”的访问位置。

### 2.2 线索二叉树（Threaded Binary Tree）

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

### 2.3 树（Tree）与森林（Forest）的表示

- 双亲表示法（parent representation）
- 孩子表示法（child-list representation）
- 孩子兄弟表示法（left-child right-sibling representation）

孩子兄弟表示法核心：

```text
data | firstChild | nextSibling
```

---

## 3. 哈夫曼树（Huffman Tree）

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

## 4. 图（Graph）

### 4.1 图（Graph）的基本定义

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

### 4.2 图（Graph）的存储

- 邻接矩阵（adjacency matrix）
- 邻接表（adjacency list）
- 十字链表（orthogonal list）
- 邻接多重表（adjacency multilist）

### 4.3 图（Graph）的遍历（Traversal）

**广度优先搜索（Breadth-First Search, BFS）**

- 常借助队列
- 按层扩展

**深度优先搜索（Depth-First Search, DFS）**

- 常借助递归或栈
- 沿一条路径深入后回溯

> [!info] 草稿关联
> 图遍历、访问序列、矩阵/邻接表手推过程见：
> [[DS-P2-Code-Exercises#5. 图的存储与邻接操作]]

---

## 5. 最小生成树（Minimum Spanning Tree, MST）

### 5.1 普里姆算法（Prim's Algorithm）

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

### 5.2 克鲁斯卡尔算法（Kruskal's Algorithm）

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

## 6. 最短路径（Shortest Path）

| 算法 | 主要用途 |
|---|---|
| 广度优先搜索（Breadth-First Search, BFS） | 无权图单源最短路 |
| 迪杰斯特拉算法（Dijkstra's Algorithm） | 非负权图单源最短路 |
| 弗洛伊德算法（Floyd–Warshall Algorithm） | 各顶点之间最短路 |

> [!info] 草稿关联
> Dijkstra / Floyd 的表格推演和路径更新过程见：
> [[DS-P2-Code-Exercises#8. Dijkstra：先选点，再确定，再松弛]]

---

## 7. 有向无环图（Directed Acyclic Graph, DAG）、拓扑排序（Topological Sorting）与关键路径（Critical Path）

### 7.1 有向无环图（Directed Acyclic Graph, DAG）

有向无环图（directed acyclic graph, DAG）：**没有有向环的有向图**。

### 7.2 AOV 网（Activity-on-Vertex Network）

AOV 网（activity-on-vertex network）用顶点表示活动。

- 常用于描述活动之间的先后制约关系
- 与拓扑排序（topological sorting）相关

### 7.3 AOE 网（Activity-on-Edge Network）

AOE 网（activity-on-edge network）用边表示活动。

- 顶点常表示事件
- 与关键路径（critical path）相关

---
