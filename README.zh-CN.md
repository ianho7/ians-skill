# Agent Skills Workflow

**语言:** [English](./README.md) | [中文](./README.zh-CN.md)

这个仓库是一套把真实工程工作沉淀为可复用 agent 工作方法的 skill 系统。

它不是 prompt 收藏夹，也不是一些彼此割裂的 skill 清单。

这些 skill 围绕同一条生命周期组织：

* 先定义工作边界
* 再把工作拆成可执行步骤
* 当执行跨 session 时保留连续性
* 从完成的案例里提炼可复用流程
* 把流程正式写成 skill
* 需要时再把案例写成技术文章

## 端到端流程

```text
idea / bug / change request
→ plan or mvp-plan
→ checklist
→ session-handoff (when work spans sessions)
→ completed engineering case
→ extract-skill-from-case
→ write-high-quality-skill
→ optional case-study-writing
```

另外还有一条更聚焦的“知识提炼子流程”：

```text
real engineering case
→ extract-skill-from-case
→ write-high-quality-skill
→ optional case-study-writing
```

## Skill 体系

### Stage 1: 定义工作

当问题还没有被收束成明确执行方案时，先用这一组 skill。

#### `plan`

用于标准的实现规划。

它会把需求、bug、重构或调查目标整理成一个可执行计划，包含：

* scope
* current-state analysis
* proposed solution
* implementation phases
* validation strategy
* risks and open questions

适合在你这样想时使用：

> 我需要一份扎实、可执行的计划。

#### `mvp-plan`

当主要风险是过度设计时使用。

它会生成一个严格的 MVP 优先计划，只保留最小可用路径，并明确推迟所有非必要内容。

适合在你这样想时使用：

> 我只要最小可行版本，范围必须收紧。

它和 `plan` 的区别：

* `plan` = 通用实现规划
* `mvp-plan` = 以范围约束为核心、强制推迟非必要工作的规划

### Stage 2: 把计划变成执行

#### `checklist`

当工作形状已经清楚，但还需要进一步落到执行任务时使用。

它会把计划、需求或技术目标转换成一份有顺序的执行清单，包含：

* 原子化实现任务
* 验证步骤
* 文档步骤
* 清理步骤
* 每个任务完成后的自动 reflection 输出

它不只是 TODO 生成器，而是为了让执行过程更可检查、更可复盘。

适合在你这样想时使用：

> 我已经知道要做什么了，把它拆成能直接执行的任务。

### Stage 3: 保持连续性

#### `session-handoff`

当执行需要暂停，或要跨 session 继续时使用。

它会记录：

* objectives
* completed work
* repository state
* decisions and rationale
* remaining risks
* outstanding work
* recommended next steps

它属于执行卫生的一部分，不是一个事后补充文档。它的作用是让长流程工作在下一个 session 里可以无缝续上。

适合在你这样想时使用：

> 这次先停，但下一个 session 必须能顺着继续做。

### Stage 4: 从完成案例里挖出可复用方法

#### `extract-skill-from-case`

当一个真实案例已经完成后使用。

它会区分：

* 一次性的项目细节
* 可复用流程
* agent failure modes
* 候选 skill
* 更适合进入 docs、snippets 或文章的内容

它的目标不是总结案例，而是判断哪些经验值得被操作化、标准化。

适合在你这样想时使用：

> 这次案例很有价值，哪些部分值得沉淀成可复用方法？

### Stage 5: 把知识变成长期资产

#### `write-high-quality-skill`

当你已经知道哪个 workflow 应该变成 skill 时使用。

它会把这个 workflow 写成正式的 `SKILL.md`，包含：

* 精确触发条件
* workflow phases
* artifacts
* completion criteria
* guardrails
* user checkpoints
* context hygiene

适合在你这样想时使用：

> 这个方法已经足够稳定，应该正式封装成一个 skill。

#### `case-study-writing`

当一个完成案例值得写成对内或对外文章时使用。

它会把案例整理成一篇文章，保留：

* 原始问题
* 调查路径
* 证据与取舍
* skills 或 agents 的作用
* 最终决策
* 可复用经验

适合在你这样想时使用：

> 这个案例值得写成文章，而不只是留个笔记。

## 什么时候走哪条路径

| 场景 | 使用 |
| --- | --- |
| 我有一个新任务，需要先规划 | `plan` |
| 我只要最小可行版本 | `mvp-plan` |
| 我已经有计划了，需要拆成执行步骤 | `checklist` |
| 我现在要停下，但之后还要继续 | `session-handoff` |
| 我们刚做完一件有价值的事，想保留方法 | `extract-skill-from-case` |
| 我已经知道要沉淀哪个 workflow | `write-high-quality-skill` |
| 这个案例值得写成文章 | `case-study-writing` |


## Diagnostic Decision Stack：诊断与决策子体系

下面这组新 skill 更适合作为仓库中的一套独立子体系来理解。

它们的重点不是“规划交付”或“把完成案例沉淀成文档”，而是处理中途真实工程工作里最难的那类不确定性问题。

也就是说，这套体系主要回答的不是：

- 这个需求怎么实现

而是：

- 现在到底哪里有问题
- 多个方向里哪个最值得先做
- 这个收益是否值得它带来的代价
- 剩下的几个候选应该怎么设计实验来比较，而不是全都测一遍
- 实验跑完后，这些结果到底说明了什么

### 这套子体系的链路

```text
一个模糊的性能问题 / 回归问题 / 复杂系统问题
→ bounded-diagnosis-loop
→ optional benchmark-fixture-replay
→ optimization-prioritization
→ optional quality-cost-tradeoff-review
→ experiment-matrix-design
→ experiment-result-interpretation
```

### 每个 Skill 分别负责什么

#### `bounded-diagnosis-loop`

当问题本身还不清楚时先用它。

它负责：

- 收紧范围
- 识别主证据源
- 建立可重复反馈循环
- 生成可证伪假设
- 只补最小必要 instrumentation
- 一次只验证一个假设

它是这类复杂工程问题的入口 skill。

#### `benchmark-fixture-replay`

当每次都把完整真实流程重跑一遍太痛苦时，用它先保存一次真实案例，后面反复拿这次案例做重放测试。

大白话就是：

- 真实链路太慢
- 真实链路步骤太多
- 真实链路依赖的东西太多
- 但这次真实案例本身很值得保存下来反复测

它负责：

- 决定应该在流程的哪里把这次真实案例保存下来
- 定义到底要保存哪些文件、输入和配置
- 设计后续怎么快速 replay
- 说明这种 replay 还保留了哪些真实含义
- 说明哪些结论仍然必须回到完整真实流程去验证

它是这套体系里的“保存真实案例并重复回放”这一层。

#### `optimization-prioritization`

当诊断已经足够成熟、并且已经出现多个候选方向时，用它来做排序决策。

它负责：

- 按用户可感知价值排序优化方向
- 比较收益、风险、成本和取舍
- 识别看起来很大但其实不值的假收益
- 推荐最值得先做的方向
- 明确哪些方向暂时不值得做

它是这套体系里的“决策层”。

#### `quality-cost-tradeoff-review`

当问题不只是“哪个方向排第一”，而是“这个收益值不值得它带来的画质、体验、正确性或复杂度代价”时，用它来做 tradeoff review。

它负责：

- 评估速度、质量、体验、正确性等维度之间的取舍
- 定义可接受与不可接受的退化边界
- 识别伪 tradeoff 和隐藏成本
- 给出当前是否值得接受的建议

它是这套体系里的“取舍判断层”。

#### `experiment-matrix-design`

当下一个问题不再是“先做哪个方向”，而是“这几个候选怎么高效比较”时，使用它。

它负责：

- 把庞大的配置/选项空间压缩成一个小矩阵
- 控制实验数量
- 保留关键 baseline
- 定义每个场景存在的意义和测量规则
- 给出第一轮最值得跑的实验集

它是这套体系里的“结构化比较层”。

#### `experiment-result-interpretation`

当实验已经跑完，接下来的核心问题变成“这些结果到底说明了什么”时，用它来解释结果。

它负责：

- 先把零散的原始结果整理成可比较的结构化摘要
- 判断比较本身是否有效
- 区分强信号、弱信号和噪声
- 把结果分类为 win / loss / mixed / inconclusive / invalid
- 解释指标冲突
- 给出下一步建议

它是这套体系里的“结果解释层”。

### 为什么把它们单独看成一个体系

这组 skill 处理的问题类型，和 `plan`、`mvp-plan`、`checklist` 不完全一样。

它们适合这样的场景：

- 现在还不应该直接实现
- 当前最重要的是证据质量，而不是编码速度
- 最大风险不是“不会做”，而是“看错问题”或“优先级排错了”
- 候选方向太多，不能靠感觉往前冲
- 结果已经产生，但还不能直接转成可靠决策

换句话说：

- `plan` / `checklist` 适合“路线已经足够清楚，可以开始执行”
- 这套子体系适合“路线还不够可信，必须先把诊断、决策、实验和结果解释做扎实”

### 快速选择指南

| 场景 | 使用 |
| --- | --- |
| 问题是真的，但根因还不清楚 | `bounded-diagnosis-loop` |
| 每次重跑完整流程太痛苦，想把一次真实案例保存下来反复测试 | `benchmark-fixture-replay` |
| 已经有多个可能方向，需要判断先做哪个最值 | `optimization-prioritization` |
| 关键问题是“收益是否值得它带来的损失” | `quality-cost-tradeoff-review` |
| 已经知道哪些候选值得比较，需要设计小规模测试矩阵 | `experiment-matrix-design` |
| 实验已经跑完，但原始结果很零散，需要先整理再正确解释 | `experiment-result-interpretation` |
## 心智模型

```text
plan / mvp-plan = 先把路线定出来
checklist = 把路线拆成步骤
session-handoff = 在中途把地图保存好
extract-skill-from-case = 事后识别可复用方法
write-high-quality-skill = 把方法正式封装
case-study-writing = 把现场经验写成报告
```

## 为什么要这样组织

真实工程流程不是从写文章或写 skill 开始的。

它通常先从一个边界不清的问题开始，进入执行，跨过多个 session，最后才沉淀出值得复用的知识。

这个仓库服务的是完整链路：

```text
delivery work
→ execution discipline
→ continuity
→ workflow extraction
→ reusable artifacts
```

## 原则

先把事情做成。

再把过程结构化。

把关键决策保存下来。

提炼出方法。

让下一次 agent session 直接复用。




