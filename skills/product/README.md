# 产品工作技能：九个业务入口与一个导航入口

不知道先用哪项时，先读取 [ask-product](ask-product/SKILL.md)，描述你已有的材料、当前卡点和想得到的结果。它会读取相关技能后推荐最短路径，并给出可复制的下一步提示词。

从三本书形成的 13 项合并为 9 项，按工作职责组织。每次选择当前缺口对应的入口；已有链路、案例、问题定义与证据直接复用，不要求固定顺序跑完全部技能。

| 当前要解决的问题 | 入口 | 交付 |
|---|---|---|
| 刚接手业务，不知道流程、上下游、各方诉求和规则 | [product-context-interview](product-context-interview/SKILL.md) | 临时业务链与可直接沟通的首轮问题 |
| 同岗位或同一个人在不同情境下选择不同 | [product-user-model](product-user-model/SKILL.md) | 情境差异、行为解释与可推翻的预测 |
| 收到功能请求，需要明确真正值得探索的问题 | [product-opportunity-frame](product-opportunity-frame/SKILL.md) | 问题定义、影响、优先情境与成功结果 |
| 新方案看似更好，却说不清用户为什么愿意换 | [product-switching-value](product-switching-value/SKILL.md) | 新旧做法对照、替换负担与采用条件 |
| 页面难懂、任务难走或中途进入容易迷路 | [product-task-review](product-task-review/SKILL.md) | 可定位的专家判断、最小调整与求证缺口 |
| 问题已明确，需要不同机制而非同方案换皮 | [product-solution-explore](product-solution-explore/SKILL.md) | 不同解法与最小完整体验 |
| 优化项竞争资源、多方利益或目标冲突 | [product-tradeoff](product-tradeoff/SKILL.md) | 含维持现状的条件决策稿 |
| 需要验证方案有用、易用、做得成，或准备主持稿 | [product-discovery-validate](product-discovery-validate/SKILL.md) | 对应风险的验证计划或真实证据结论 |
| 已有试用记录，需要决定先修什么 | [product-usability-triage](product-usability-triage/SKILL.md) | 严重性、最小修复与资源内的顺序 |

## 刚入职拿到 HTML，先这样用

把 `product-context-interview/SKILL.md` 与 HTML 一起提供给 LLM，或给出可读取路径。复制：

```text
请按 product-context-interview/SKILL.md 分析这份 HTML。
我刚接手业务，目前需要准备与 leader、业务人员或用户沟通的问题。
这轮不修改原型。

选一条核心业务，从触发追踪到实际完成及重要的失败补救。
标出原型已见信息、推测和未知，关注交接、各方得失、成本和责任。
首轮合计最多五个问题，优先选择答案会改变后续设计判断的。
每题写原型线索、问谁、可直接说出口的问句、必要追问及答案影响。
使用页面上的具体业务称呼，已有答案直接引用，不先让我填写背景调查表。
```

没有 HTML 或业务资料时，得到的是明确标注的通用起步稿，不能当成公司真实痛点。回答回来后，只更新受影响的部分；按剩余缺口选择下一个入口。

## 合用时的边界

用户模型解释选择，机会定义明确值得探索的问题，换用分析判断相对收益。三个入口引用已有事实，各自交付对应判断，不重新做三遍访谈。

方案探索做足够收敛的比较；多目标、多方利益或跨项目资源竞争才需要正式产品取舍。观察分诊先按真实片段处理可用性严重性，不能把严重性直接等同商业优先级。

体验审查的清晰度与导航是[按需参考](product-task-review/SKILL.md)，结果合入一份报告。准备观察时，由[验证入口](product-discovery-validate/SKILL.md)读取主持方法；只要主持稿就直接走该分支，不强加其他研究。

完整提问格式主要由背景访谈负责。其他入口只对影响本轮结论的关键未知补问，不固定附五道题。原话、行为、解释保持区别；专家推演不是用户观察。

三份原书已各归档一份到 `references/books/`，文件与章节定位见[来源记录](docs/sources.md)。技能默认读短指令；公式、案例或原意需要查证时，才按条件读取方法参考和原书相关位置。所有引用使用包内相对路径。

本目录为可移植文件集合，没有执行全局安装或更改仓库插件配置。用本地文件时读取对应 `SKILL.md`；由支持 skill 的环境加载后，使用同名入口。主入口各自可用，无需先读全部说明与书籍记录。

## 依据与检查

[13→9 对应与职责边界](docs/consolidation.md) · [书籍来源及章节定位](docs/sources.md) · [检查记录](docs/validation.md)

**两分钟内的下一步**：将背景访谈入口与 leader 的 HTML 一起交给 LLM，用上面的提示词先形成第一轮核实问题。
