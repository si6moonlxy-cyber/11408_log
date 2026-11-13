---
type: note
subject: 数据结构
course: 22408
source: 2027 王道数据结构课程笔记 + 个人手稿
status: active
part: 1
tags: [数据结构, 基础阶段]
aliases: [数据结构基础知识主干]
---

# 数据结构 P1｜第 1–4 章：基础｜知识主干

**推导与代码：** [[DS-P1-Code-Exercises]]；**后续章节：** [[DS-P2-Knowledge]]。

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

复杂度推演见 [[DS-P1-Code-Exercises#1. 算法复杂度：轮数与每轮工作分开算]]。

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

这一区别会直接影响 [[DS-P3-Knowledge#2. 线性结构上的查找|查找算法]] 的选择：顺序查找可逐个访问；折半查找还需要整体有序和高效的按下标访问；分块查找则先定位有序的块范围，再在块内查找。链表即使按关键字有序，也不能像顺序表一样直接取到中间结点。

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

- 循环链表（circular linked list）：尾结点的 `next` 指向头结点（有头结点时）或首元结点（无头结点时）。
- 静态链表（static linked list）：使用数组下标模拟指针关系。

## 3. 栈（Stack）与队列（Queue）

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

队列的先入先出次序用于 [[DS-P2-Knowledge#2.1 遍历（Traversal）|树的层序遍历]] 和 [[DS-P2-Knowledge#4.3 图（Graph）的遍历（Traversal）|图的广度优先遍历]]；栈或递归调用栈则对应沿一条路径深入的过程。这里复用的是 P1 的存取规则，具体访问次序还取决于树或图的算法。

```text
出队 ← front [A][B][C][D] rear ← 入队
```

## 4. 串（String）与模式匹配（Pattern Matching）

重点：

- 串（string）的基本概念
- 朴素模式匹配（naive string matching）
- KMP 算法（Knuth–Morris–Pratt Algorithm）
- `next` 数组
- `nextval`

> [!warning] 王道口径
> 本库后续关于 KMP 的下标、`next` 初值和推导统一按**王道数据结构**口径整理。  
> 具体下标约定须跟随题目或教材，不能把不同约定的 `next` 数组直接混用。
