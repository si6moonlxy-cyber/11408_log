---
type: working-note
subject: 数据结构
course: 22408
source: 个人手稿（原图 69–81）与正式笔记（原图 62–68）
status: active
part: 3
tags: [数据结构, 基础阶段, 代码, 习题]
aliases: [数据结构查找代码习题]
---

# 数据结构 P3｜第 7 章：查找｜代码与习题

> [!info] 使用说明
> 本篇按原图中的草稿、红笔修正和手推重建可复核的算法片段。代码是便于检查边界的参考实现，不是对涂改页的逐字誊写。知识主干见 [[DS-P3-Knowledge]]。

## 1. 折半查找：闭区间直到 `low > high`

草稿 74 的红笔把循环条件从 `low < high` 改为 `low <= high`，并把失败返回值从 `NULL` 改为整数 `-1`。理由是最后只剩一个位置时仍要比较，且返回类型是 `int`。`mid` 在循环内求出，目标与 `a[mid]` 的**元素值**比较，而非与下标 `mid` 比较。

```c
// a[0..n-1] 已按关键字非降序排列；返回一个匹配下标，失败返回 -1。
int binary_search(const int a[], int n, int key) {
    int low = 0, high = n - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (key == a[mid]) return mid;
        if (key < a[mid]) high = mid - 1;
        else low = mid + 1;
    }
    return -1;
}
```

草稿中的有序表 `7, 10, 13, 18, 19, 28, 32, 33, 37, 41, 43` 查找 `32`：闭区间 `[0,10]` 的中点为 `5`，元素 `28`；改查 `[6,10]`，中点 `8` 为 `37`；改查 `[6,7]`，中点 `6` 为 `32`，返回下标 `6`。三次比较即可找到目标。

## 2. BST 查找：迭代与递归的返回路径

草稿 69 红笔修正了迭代循环：只有「当前结点非空且关键字不相等」才继续向下。循环外统一返回结点指针，命中时不会再错误下探；走到空指针时返回 `NULL`。递归版本必须把递归调用的结果 `return` 给上一层，并按 `key < root->key` 走左、`key > root->key` 走右。

```c
typedef struct BSTNode {
    int key;
    struct BSTNode *lchild, *rchild;
} BSTNode;

BSTNode *bst_search(BSTNode *root, int key) {
    while (root != NULL && root->key != key) {
        root = key < root->key ? root->lchild : root->rchild;
    }
    return root;
}

BSTNode *bst_search_recursive(BSTNode *root, int key) {
    if (root == NULL || root->key == key) return root;
    if (key < root->key) return bst_search_recursive(root->lchild, key);
    return bst_search_recursive(root->rchild, key);
}
```

图中从 `50` 查找 `56` 的路径为 `50 → 60 → 56`。每一步比较的是**目标关键字与当前结点关键字**，不要把函数实参中的 `key` 与结点地址混用。迭代版辅助空间 $O(1)$，递归版调用栈 $O(h)$。

## 3. BST 插入：保留父结点并回接新结点

草稿 70 中，非递归写法沿路径下探时需要同时记住父结点；直接反复改动局部指针 `root`，不会自动修改父结点的孩子指针。空树、新结点分配失败和重复关键字也要分别处理。下列版本用指向孩子指针的 `link` 直接定位接入位置，与草稿红笔「让父结点连接新结点」的修正等价。

```c
#include <stdbool.h>
#include <stdlib.h>

bool bst_insert(BSTNode **root, int key) {
    BSTNode **link = root;
    while (*link != NULL) {
        if (key == (*link)->key) return false;
        link = key < (*link)->key
             ? &(*link)->lchild : &(*link)->rchild;
    }
    BSTNode *p = malloc(sizeof *p);
    if (p == NULL) return false;
    p->key = key;
    p->lchild = p->rchild = NULL;
    *link = p;
    return true;
}
```

递归插入也要通过返回新子树根或传入孩子指针的地址完成回接；如果只给局部形参 `root` 赋值，上层树不会得到新结点。草稿中的 `int` 返回类型与「返回结点指针」混写，参考实现据实际返回值重新统一了类型。

## 4. AVL 旋转：保持中序顺序

草稿 75–76 逐步画出四类失衡：LL、RR 用一次旋转，LR、RL 用两次旋转。以 LL 为例，设失衡结点为 `A`，其左孩子为 `B`，`B` 的右子树为 `BR`：右旋后 `B` 成为局部根，`A` 成为其右孩子，`BR` 接到 `A` 的左侧。RR 是镜像操作。

```c
// 仅表达指针重连；高度或平衡因子的更新由完整 AVL 实现负责。
BSTNode *rotate_right(BSTNode *a) {
    BSTNode *b = a->lchild;
    a->lchild = b->rchild;
    b->rchild = a;
    return b;
}

BSTNode *rotate_left(BSTNode *a) {
    BSTNode *b = a->rchild;
    a->rchild = b->lchild;
    b->lchild = a;
    return b;
}
```

`LR` 先对 `A->lchild` 左旋，再对 `A` 右旋；`RL` 先对 `A->rchild` 右旋，再对 `A` 左旋。每次都要把**返回的新局部根**接回原父结点。草稿 77 还从被删结点向上检查最小失衡子树；删除后的失衡可能持续向上传播，不能只修复一次便默认整树平衡。

## 5. B 树：用结点容量约束手推分裂和合并

草稿 78–80 用 $m$ 阶 B 树练习结点数、高度以及插入/删除。手推前固定以下计数：一个非叶结点若有 $k$ 个关键字，就有 $k+1$ 棵子树；$m$ 阶结点最多 $m-1$ 个关键字，非根结点至少 $\lceil m/2\rceil-1$ 个关键字。把「阶数」误当成关键字数，后续分裂时会整体错位。

以草稿里的 5 阶插入前缀 `10, 20, 30, 40, 5` 为例：前四个关键字可同处一个根结点；加入 `5` 后暂有五个关键字，超过上限四个，于是中间的 `20` 上提，新根为 `[20]`，左右子结点分别为 `[5,10]` 和 `[30,40]`。这里根结点分裂导致高度从一层变两层。

删除时先定位关键字；若关键字在非叶结点，换成前驱或后继后继续处理相应叶层。叶层结点删除后若低于下限，可向满足容量条件的兄弟借；借不到则与相邻兄弟及父结点的分隔关键字合并。草稿 79–80 有多轮涂改，逐轮结果须在每一步重新检查「关键字有序、孩子数 = 关键字数 + 1、非根容量合法、叶层同深」四个约束。

## 6. 分块查找：索引返回候选块，块内再比较

草稿 71 的 `Index_Search` 先对块索引折半，找到候选块，再查该块内容。若索引按每块最大关键字升序排列，索引阶段要找**第一个最大值不小于目标的块**；目标刚好等于某块最大值时仍属于该块，不能跳到下一块。索引命中仅说明目标可能在该块，不能代替块内查找。

```c
typedef struct {
    int max_key;
    int begin, end;  // 数据表中的闭区间
} BlockIndex;

int block_search(const BlockIndex index[], int blocks,
                 const int data[], int key) {
    int low = 0, high = blocks - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (index[mid].max_key < key) low = mid + 1;
        else high = mid - 1;
    }
    if (low == blocks) return -1;
    for (int i = index[low].begin; i <= index[low].end; ++i) {
        if (data[i] == key) return i;
    }
    return -1;
}
```

这段代码假定每块的关键字范围严格按块递增，块内次序不作要求，索引的 `begin/end` 均为有效数据下标。草稿 81 的分块手推也须分开记录「索引比较」和「块内比较」，总比较次数是两部分之和。

## 7. 拉链法散列：桶地址与链中关键字分开

正式笔记 67–68 与草稿 71–72 使用除留余数法定位桶，再在对应链表中处理元素。草稿中的 `hashTable[key]` 把原始关键字当成数组下标；正确下标须先由 `H(key)` 算出，且同桶结点仍须逐一比较 `node->key`。链表删除要保存前驱；若删的是首结点，更新桶头，否则更新前驱的 `next`。

```c
typedef struct HashNode {
    int key;
    struct HashNode *next;
} HashNode;

// 假定 key 非负、m > 0，p 为题目给定且 p <= m 的质数。
int hash_address(int key, int p) { return key % p; }

HashNode *chain_search(HashNode *table[], int p, int key) {
    for (HashNode *cur = table[hash_address(key, p)];
         cur != NULL; cur = cur->next) {
        if (cur->key == key) return cur;
    }
    return NULL;
}

bool chain_delete(HashNode *table[], int p, int key) {
    int address = hash_address(key, p);
    HashNode *prev = NULL, *cur = table[address];
    while (cur != NULL && cur->key != key) {
        prev = cur;
        cur = cur->next;
    }
    if (cur == NULL) return false;
    if (prev == NULL) table[address] = cur->next;
    else prev->next = cur->next;
    free(cur);
    return true;
}
```

其中 `NULL`、`bool` 和 `free` 需要 `<stddef.h>`、`<stdbool.h>`、`<stdlib.h>`。正式笔记的示意使用 `H(key)=key%7`；题目给定的表长可以大于模数，不能把两者写成同一变量。若使用开放定址法，则删除方式不同，应保留探测路径上的删除标记。
