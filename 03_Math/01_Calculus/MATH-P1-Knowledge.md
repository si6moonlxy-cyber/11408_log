---
type: note
subject: 数学（一）
course: 11408
source: 武忠祥高数基础阶段 + 个人函数与极限笔记
status: active
part: 1
tags:
  - 数学
  - 高数
  - 函数与极限
aliases:
  - 高数 Part1｜函数与极限知识主干
---

# 高数 Part 1｜函数（Functions）与极限（Limits）知识主干

> [!info] 使用说明
> 本文整理本批笔记中可直接复习的定义、条件和结论。证明、试算、反例与未完成题目见 [[MATH-P1-Exercises]]。当前课程为武忠祥《高等数学·基础篇》的基础阶段；“Part 1”是本仓库的主题名，并非教材讲次。

> [!info] 证据范围
> 已检查本批笔记与手稿共 12 张。正文以可辨手稿和可核推导为依据；没有逐页核对《基础篇》。标为“补充”的最小示例由 Agent 自拟，只用来解释概念，不代表原题或教材原例。

## 1. 函数（Function）：先问哪些输入有意义

### 1.1 定义域（Domain）与复合函数（Composite Function）

写出 $y=x^2$ 还没有完整指定一个函数：还要知道允许哪些 $x$。函数（function）由**定义域（domain）**和“每个允许的输入对应唯一输出”的规则确定。因此，同一个解析式若规定了不同的定义域，就不能直接当作同一个函数。

复合函数（composite function）是先算内层 $g(x)$，再把结果交给外层 $f$。它的定义域须同时满足两道门槛：

$$
D_{f\circ g}=\{x\in D_g\mid g(x)\in D_f\}.
$$

这里 $D_g$ 是 $g$ 的定义域，$D_f$ 是 $f$ 的定义域。式子说明：先保证 $g(x)$ 能算，再保证算出的值能作为 $f$ 的输入。只知道内层值域与外层定义域有交集，还不能直接写出所有可取的 $x$。

> [!info] 补充
> 说明性示例（Agent 自拟）：若 $g(x)=x-2$，$f(u)=\sqrt u$，则要让内层输出进入外层定义域，必须有 $x-2\ge0$；所以 $f(g(x))=\sqrt{x-2}$ 的定义域是 $x\ge2$。

### 1.2 反函数（Inverse Function）与值域（Range）

反函数（inverse function）要把“由 $x$ 算 $y$”反过来，要求在**指定定义域**内每个输出只对应一个输入。若两个不同输入给出同一个输出，就无法从这个输出唯一找回原输入。

因此，原函数的值域（range）是反函数的定义域；原函数的定义域是反函数的值域。两幅图像关于 $y=x$ 对称。这个结论建立在原函数在所选定义域上一一对应的前提下。

> [!info] 补充
> 说明性示例（Agent 自拟）：$f(x)=x^2$ 若以全体实数为定义域，$2$ 与 $-2$ 都对应 $4$，没有全局反函数；若限制为 $x\ge0$，就能由输出 $y\ge0$ 唯一找回 $x=\sqrt y$。

笔记列出幂函数（power function）、指数函数（exponential function）、对数函数（logarithmic function）、三角函数（trigonometric function）与反三角函数（inverse trigonometric function）。遇到反三角函数，要核对选取的单调区间与取值范围。

### 1.3 四类常见函数性质（Properties of Functions）

这些性质都是针对**指定定义域或区间**说的。换了讨论范围，判断可能改变。

| 性质 | 通俗检查 | 严谨条件或边界 |
|---|---|---|
| 单调性（monotonicity） | 输入变大时，输出朝哪个方向变 | 在指定区间比较 $x$ 与函数值的先后关系 |
| 奇偶性（parity） | 图像能否呈现相应对称性 | 定义域先关于原点对称，再检验 $f(-x)=f(x)$ 或 $f(-x)=-f(x)$ |
| 周期性（periodicity） | 平移一段后数值是否重复 | 存在 $T>0$，平移后函数仍有定义且 $f(x+T)=f(x)$ |
| 有界性（boundedness） | 输出能否被固定的上下界罩住 | 在指定集合上存在统一的上界与下界 |

## 2. 极限（Limit）：看靠近时的行为

极限（limit）问的是：输入越靠近指定位置，输出能否稳定靠近某个数。先认清研究对象是数列还是函数，再认清从哪个方向趋近。

### 2.1 数列极限（Limit of a Sequence）

数列极限（limit of a sequence）只要求**足够靠后的所有项**靠近 $A$；前面有限项怎样变化，不影响极限。写作 $a_n\to A$ 时，$a_n$ 是第 $n$ 项，$A$ 是候选极限。

严谨地说：对任意允许的误差 $\varepsilon>0$，总能找到序号 $N$，使每个 $n>N$ 都满足

$$
|a_n-A|<\varepsilon.
$$

这个 $\varepsilon$–$N$ 定义（epsilon–$N$ definition）强调“**所有**后续项”，不是只找到某一项碰巧接近 $A$。

### 2.2 函数极限（Limit of a Function）与去心邻域（Punctured Neighborhood）

函数极限（limit of a function）看的是**靠近 $x_0$ 时**的函数值，不直接看 $x_0$ 那一点。这里默认 $x_0$ 是定义域的聚点（accumulation point），即定义域内总能找到不同于 $x_0$、又任意靠近它的点。

若 $\lim_{x\to x_0}f(x)=A$，对任意 $\varepsilon>0$，可找到 $\delta>0$：只要 $x$ 在定义域内，且 $0<|x-x_0|<\delta$，就有

$$
|f(x)-A|<\varepsilon.
$$

$\delta$ 管输入离 $x_0$ 多近，$\varepsilon$ 管输出离 $A$ 多近。$0<|x-x_0|<\delta$ 描述去心邻域（punctured neighborhood）：它包含附近的点，却排除了中心 $x_0$。因此 $f(x_0)$ 是否有定义、取什么值，都不直接决定这个极限。

> [!info] 补充
> 说明性示例（Agent 自拟）：$f(x)=(x^2-1)/(x-1)$ 在 $x=1$ 无定义；但当 $x\ne1$ 时，$f(x)=x+1$，所以 $\lim_{x\to1}f(x)=2$。中心点没有函数值，仍可讨论邻近点的极限。

在定义域内可从左右两侧任意靠近 $x_0$ 时，双侧极限（two-sided limit）存在且等于 $A$，当且仅当左极限与右极限（one-sided limits）都存在且都等于 $A$。分段、绝对值或含 $1/x$ 的式子，须分别检查两侧；例题见 [[MATH-P1-Exercises]]。

### 2.3 自变量趋于无穷（Limit at Infinity）

$x\to+\infty$ 看输入向右越走越远，$x\to-\infty$ 看向左越走越远。若题目说 $|x|\to\infty$，则两端都要检查；只算出其中一端，不能直接宣称双向结论。

## 3. 收敛（Convergence）会带来哪些限制

### 3.1 有界性（Boundedness）

收敛数列（convergent sequence）不可能在后面一直跑向任意远处；再把前面有限项也算进去，整个数列必有界。函数在有限点有有限极限时，只能推出它在该点附近的**去心邻域内局部有界（locally bounded）**；并不要求 $f(x_0)$ 有定义。

反过来，有界不保证极限存在。例如 $\sin(1/x)$ 在 $x\to0$ 时始终介于 $-1$ 和 $1$ 之间，却不断振荡（oscillation）；相关推演见 [[MATH-P1-Exercises]]。

### 3.2 正极限的保号性（Eventual Positivity）

若数列趋向一个**严格大于零**的数，走到足够后面，它就会一直为正。这是保号性（eventual positivity）：不是说每一项都为正，而是说从某项以后不再变号。

若 $a_n\to A>0$，可选 $0<c<A$，使足够大的 $n$ 满足 $a_n>c>0$。这里 $A$ 是正极限，$c$ 是预先选定的正下界；函数有有限正极限时，也有相应的局部结论。证明见 [[MATH-P1-Exercises]]。

逆向只可推出较弱结论：若 $a_n\ge0$ 从某项起恒成立且 $a_n\to A$，只能得 $A\ge0$，不能得 $A>0$。**非负**与**正**不能交换；反例见 [[MATH-P1-Exercises]]。

## 4. 夹逼定理（Squeeze Theorem）与单调有界定理（Monotone Convergence Theorem）

夹逼定理（squeeze theorem）用在“中间对象难算、两侧对象好算”时。若从某项起 $b_n\le a_n\le c_n$，且 $b_n,c_n\to A$，则 $a_n\to A$：中间的 $a_n$ 无法逃出同趋于 $A$ 的上下界。函数极限同样可在相应去心邻域内使用；关键是**两条不等式确实成立，且两侧趋向同一个数**。本批求和与取整例题见 [[MATH-P1-Exercises]]。

单调有界定理（monotone convergence theorem）用于数列：始终朝一个方向变化，又有边界挡住，就会收敛。使用时分别说明数列是单调递增且有上界，还是单调递减且有下界；只证明单调或只证明有界都不够。

## 5. 无穷小量（Infinitesimal Quantity）与无穷大量（Infinitely Large Quantity）

### 5.1 无穷小量（Infinitesimal Quantity）与渐近等价（Asymptotic Equivalence）

无穷小量（infinitesimal quantity）说的是**在某个趋近过程中极限为零**，并非每个取值都等于零。比较两个无穷小量前，要保证它们讨论的是同一趋近过程，并且分母在相关邻域内非零。

设 $\alpha,\beta$ 都趋于 $0$，比值 $\alpha/\beta$ 告诉我们它们接近零的相对速度：

| 比值极限 | 可下的结论 |
|---|---|
| $\alpha/\beta\to0$ | $\alpha$ 比 $\beta$ 趋零更快，是高阶无穷小（higher-order infinitesimal） |
| $\alpha/\beta\to c\ne0$ | 两者是同阶无穷小（same-order infinitesimals） |
| $\alpha/\beta\to1$ | $\alpha\sim\beta$，两者渐近等价（asymptotically equivalent） |

本批手稿使用的等价式均以 $x\to0$ 为前提，三角函数的自变量按弧度计：

$$
\sin x\sim x,\quad \tan x\sim x,\quad
\arcsin x\sim x,\quad \arctan x\sim x,
$$

$$
e^x-1\sim x,\quad \ln(1+x)\sim x,\quad
1-\cos x\sim\frac{x^2}{2}.
$$

这里的 $\sim$ 表示两边比值趋于 $1$。如果题中换成 $\sin(3x)$，须先确认括号里的 $3x\to0$；不能看到一个熟悉的函数名就略过趋近条件。具体试算见 [[MATH-P1-Exercises]]。

### 5.2 无穷大量（Infinitely Large Quantity）与无界（Unboundedness）

“曾经取得很大值”与“走到后面一直大”不同。无穷大量要求在指定趋近过程中：对任意 $M>0$，最终都有 $|f(x)|>M$，即 $|f(x)|\to\infty$（数列同理）。$f\to+\infty$ 和 $f\to-\infty$ 还区分正负方向。

所以无穷大量（infinitely large quantity）必无界，但无界（unboundedness）量未必是无穷大量：它可能反复回到 $0$。取倒数（reciprocal）讨论无穷大与无穷小时，要保证原量在所讨论位置有定义且非零；相应反例见 [[MATH-P1-Exercises]]。
