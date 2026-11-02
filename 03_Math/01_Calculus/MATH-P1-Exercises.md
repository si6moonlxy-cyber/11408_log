---
type: working-note
subject: 数学（一）
course: 11408
source: 个人函数与极限手稿归纳（待确认处另标）
status: active
part: 1
tags:
  - 数学
  - 高数
  - 学习总结
  - 习题
aliases:
  - 高数 Part1｜函数与极限解题推演
---

# 高数 Part 1｜函数（Functions）与极限（Limits）解题推演

> [!info] 这篇笔记如何读
> 本文按题目与证明重组本批可辨手稿。每题尽量保留足以独立重做的条件和目标；缺少完整题设的地方明确标“待补题设”。定义与稳定结论见 [[MATH-P1-Knowledge]]。下文是可辨手稿的计算链，不把涂改当作已证实错误。

## 1. 从定义出发的证明（Proof from the Definition）

### 1.1 正极限的保号性（Eventual Positivity）

**已知与目标：** 数列（sequence）$a_n\to A>0$；证明从某项以后 $a_n$ 一直为正，并给出一个固定的正下界。

**关键选择：** 先在 $0$ 与 $A$ 之间取 $c$，希望最终得到 $a_n>c$。要从极限定义推出这一点，只需把误差控制到 $A-c$ 以内，因此令 $\varepsilon=A-c>0$。

由数列极限的 $\varepsilon$–$N$ 定义（epsilon–$N$ definition），存在 $N$，使每个 $n>N$ 都满足

$$
|a_n-A|<A-c.
$$

绝对值不等式给出 $a_n>A-(A-c)=c>0$。这里 $A$ 是已知的正极限，$c$ 是选出的正下界；证明的是**足够靠后的所有项**，不要求前面每一项为正。对应结论见 [[MATH-P1-Knowledge]]。

### 1.2 线性函数（Linear Function）的 $\varepsilon$–$\delta$ 证明（Epsilon–Delta Proof）

**题设与目标：** 手稿要证明 $\lim_{x\to2}(3x-1)=5$。需要说明：给定任意输出误差 $\varepsilon>0$，怎样选择输入距离 $\delta>0$。

先把“输出离 $5$ 多远”改写为“输入离 $2$ 多远”：

$$
|(3x-1)-5|=3|x-2|.
$$

式中的系数 $3$ 告诉我们：若要左侧小于 $\varepsilon$，右侧的 $|x-2|$ 就应小于 $\varepsilon/3$。所以取 $\delta=\varepsilon/3$；当 $0<|x-2|<\delta$ 时，便有 $|(3x-1)-5|<\varepsilon$。

**依赖条件：** $\varepsilon$ 可以任意小，$\delta$ 可随它选择；等式对本题的线性函数成立。这里先看目标误差，再决定 $\delta$，而非无依据地猜一个数。

## 2. 振荡（Oscillation）与夹逼（Squeeze Theorem）

**题设与目标：** 手稿一处画出 $\sin(1/x)$ 在 $x\to0$ 附近的振荡（oscillation），另一处要求 $\lim_{x\to0}x\sin(1/x)$。前者自身没有极限，后者仍可能有极限，因为它的振幅还受到 $x$ 的控制。

对每个 $x\ne0$，有 $|\sin(1/x)|\le1$，因此

$$
-|x|\le x\sin\frac1x\le|x|.
$$

左右两界在 $x\to0$ 时都趋于 $0$；夹逼定理（squeeze theorem）于是给出 $\lim_{x\to0}x\sin(1/x)=0$。这里比较的是**整个乘积**，不要求 $\sin(1/x)$ 单独收敛。

手稿中的数列 $(-1)^n/n\to0$ 也说明：符号可以一直变化，只要幅度趋零，整体仍可趋零。它同时反驳“极限为零就最终同号”的想法。

> [!question] 待确认
> 另一组含奇偶项的数列试算有局部涂改，缺少可可靠重建的完整式子。本轮只保留以上可核的振荡结论，不替那道题确定极限。

## 3. 单侧极限（One-Sided Limits）与参数题

**可辨题设，待补原题来源：** 手稿能辨认出下式及左右两侧的计算；若原题要求选择 $a$ 使 $x\to0$ 的双侧极限（two-sided limit）存在，则求 $a$：

$$
F(x)=a\arctan\frac1x+(1+|x|)^{1/x},\qquad x\ne0.
$$

**先分左右：** $x>0$ 时 $|x|=x$；$x<0$ 时 $|x|=-x$。据此，指数项在两侧分别趋于

$$
\lim_{x\to0^+}(1+|x|)^{1/x}=e,
\qquad
\lim_{x\to0^-}(1+|x|)^{1/x}=e^{-1}.
$$

其中 $x\to0^+$ 是右极限（right-hand limit），$x\to0^-$ 是左极限（left-hand limit）。反正切项（arctangent term）$\arctan(1/x)$ 在两侧分别趋于 $\pi/2$ 和 $-\pi/2$。双侧极限存在要求两侧的总结果相等，因此

$$
a\frac\pi2+e=-a\frac\pi2+e^{-1},
\qquad
a=\frac{e^{-1}-e}{\pi}.
$$

这个结果依赖于上面写出的 $F(x)$ 确为原题式。手稿足以支持本轮按该式复核；若后续找到教材原题，应再核对题设与参数位置。

## 4. 渐近等价（Asymptotic Equivalence）的两道试算

**共同题设：** 均令 $x\to0$。等价无穷小（asymptotically equivalent infinitesimals）只在相应趋近过程中成立；替换前先看函数括号里的量是否也趋于 $0$。基本等价式见 [[MATH-P1-Knowledge]]。

### 4.1 对数式（Logarithmic Expression）

**求：** $\lim_{x\to0}\ln(1+3x)/(2x)$。由于 $3x\to0$，有 $\ln(1+3x)\sim3x$，所以

$$
\lim_{x\to0}\frac{\ln(1+3x)}{2x}
=\lim_{x\to0}\frac{3x}{2x}=\frac32.
$$

这里的 $\sim$ 表示比值趋于 $1$；分子换成 $3x$ 后，才约去公共的 $x$。原对数在 $x$ 足够接近 $0$ 时满足 $1+3x>0$。

### 4.2 指数式（Exponential Expression）

**求：** $\lim_{x\to0}(e^{2x}-1)/\sin x$。$2x\to0$，于是 $e^{2x}-1\sim2x$；同时 $\sin x\sim x$，从而

$$
\lim_{x\to0}\frac{e^{2x}-1}{\sin x}
=\lim_{x\to0}\frac{2x}{x}=2.
$$

这两题都只是在已知趋近前提下做等价替换；目前不把单题操作升格为一套通用“方法 / 策略”。

## 5. 局部极大值（Local Maximum）与差商（Difference Quotient）

**题设与目标：** $f(a)$ 有定义，且在 $a$ 附近的去心邻域（punctured neighborhood）内可取函数值。已知

$$
\lim_{x\to a}\frac{f(x)-f(a)}{(x-a)^2}=-1.
$$

判断 $a$ 是否为局部极值（local extremum）点；若求导数，再判断 $f'(a)$。式中的分子 $f(x)-f(a)$ 是附近函数值与中心值的差，分母 $(x-a)^2$ 在 $x\ne a$ 时恒正。

**先看极值：** 比值趋于 $-1$，因此在足够靠近 $a$ 且 $x\ne a$ 时它为负；分母为正，故 $f(x)-f(a)<0$。附近的函数值都比 $f(a)$ 小，所以 $a$ 是局部严格极大值点。

**再看导数：** 一阶差商可写成

$$
\frac{f(x)-f(a)}{x-a}
=\frac{f(x)-f(a)}{(x-a)^2}(x-a)\longrightarrow(-1)\cdot0=0.
$$

因此 $f'(a)=0$。极值判断用差的**符号**，导数（derivative）判断用一阶差商的**极限**；两个结论依赖同一题设，检查对象不同。

## 6. 用夹逼求极限（Squeeze Theorem）

### 6.1 求和（Summation）：先界住每一项

**题设与目标：** 对正整数 $n$，求

$$
\lim_{n\to\infty}S_n,\qquad
S_n=\sum_{k=1}^{n}\frac{n}{n^2+k}.
$$

这里 $k$ 从 $1$ 走到 $n$，共有 $n$ 项。对每一项，分母在 $n^2+1$ 与 $n^2+n$ 之间，且分子为正，因此

$$
\frac{n}{n^2+n}\le\frac{n}{n^2+k}\le\frac{n}{n^2+1}.
$$

把这两条对**每一项都成立**的界各加 $n$ 次，得到

$$
\frac{n^2}{n^2+n}\le S_n\le\frac{n^2}{n^2+1}.
$$

上下界都趋于 $1$，所以 $S_n\to1$。检查时要把“单项大小”和“项数”一起算，不能只看分母含 $n^2$ 就跳到总和的结论。

### 6.2 取整函数（Floor Function）：分正负两侧

**题设与目标：** 求 $\lim_{x\to0}x\lfloor1/x\rfloor$，其中 $x\ne0$，取整函数（floor function）的 $\lfloor t\rfloor$ 表示不超过 $t$ 的最大整数。

手稿尝试用夹逼，但乘不等式时的方向有涂改；仅凭涂改不能记为“我的错误”。从取整定义重新推得

$$
\frac1x-1<\left\lfloor\frac1x\right\rfloor\le\frac1x.
$$

当 $x>0$，同向乘以 $x$，有

$$
1-x<x\left\lfloor\frac1x\right\rfloor\le1.
$$

当 $x<0$，乘以 $x$ 要反转不等号，有

$$
1\le x\left\lfloor\frac1x\right\rfloor<1-x.
$$

两侧都被趋于 $1$ 的界夹住，所以双侧极限为 $1$。关键检查点是：**乘不等式前先看 $x$ 的符号**。

## 7. 反例（Counterexamples）与待补题设

- “最终非负 $\Rightarrow$ 极限严格大于 $0$”不成立：$a_n=1/n\ge0$，但 $a_n\to0$。题设只给非负，结论最多为非负。
- “无界 $\Rightarrow$ 无穷大量”不成立：对 $m\ge1$，令 $a_{2m}=2m$、$a_{2m-1}=0$。数列无界，却反复回到 $0$，因此 $|a_n|$ 不会最终超过任意给定的正数。
- 笔记里的增长速度排列缺完整比较条件；手稿中另一段绝对值极限证明、奇偶项数列与末尾涂改式也缺可复核的完整题设。它们暂时只作为“待补题设”，不写唯一答案。

> [!info] 下一次续写
> 找到《基础篇》对应原题或更清晰手稿后，优先核对参数题原式、增长比较链与本节缺失的题设。本批仍属于基础阶段，不提前合并强化阶段题型。
