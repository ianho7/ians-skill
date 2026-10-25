# 13 项到 9 项：迁移与职责

2026-10-25，根据已确认的合并建议实施。本文件说明九个业务入口的去向，不作为每次调用必读内容。后续按用户要求新增 [ask-product 导航](../ask-product/SKILL.md)，帮助选择这些入口，不增加新的业务分析职责。

## 对应关系

| 原入口 | 新位置 | 处理 |
|---|---|---|
| product-context-interview | [product-context-interview](../product-context-interview/SKILL.md) | 合并业务背景、交换与责任的同一轮访谈 |
| yujun-exchange-map | [product-context-interview](../product-context-interview/SKILL.md) | 得失、成本转移、激励与异常闭环融入业务链 |
| product-task-review | [product-task-review](../product-task-review/SKILL.md) | 保留完整任务、状态、占位识别与统一交付 |
| krug-page-clarity | [页面清晰度参考](../product-task-review/references/page-clarity.md) | 由任务审查按条件读取，不再独立生成报告 |
| krug-wayfinding | [导航定位参考](../product-task-review/references/wayfinding.md) | 保留深层直达、trunk test 和入口承诺 |
| product-discovery-validate | [product-discovery-validate](../product-discovery-validate/SKILL.md) | 统一按风险选证据、计划与结果判断 |
| krug-usability-session | [可用性主持参考](../product-discovery-validate/references/usability-session.md) | 仅观察分支读取；主持请求可直接进入此分支 |
| product-opportunity-frame | [product-opportunity-frame](../product-opportunity-frame/SKILL.md) | 收紧到问题、影响、成功结果与探索价值 |
| yujun-user-model | [product-user-model](../product-user-model/SKILL.md) | 保留行为解释与预测，复用链路与案例 |
| yujun-switching-value | [product-switching-value](../product-switching-value/SKILL.md) | 保留新旧体验、替换负担和采用门槛 |
| product-solution-explore | [product-solution-explore](../product-solution-explore/SKILL.md) | 保留机制发散与完整体验，缩小决策展开 |
| yujun-product-tradeoff | [product-tradeoff](../product-tradeoff/SKILL.md) | 聚焦目标冲突、多方利益及机会成本 |
| krug-usability-triage | [product-usability-triage](../product-usability-triage/SKILL.md) | 保留真实观察分诊，复杂冲突交给取舍 |

九个名称统一为职责命名的 `product-*`。旧名称仅在迁移、来源和历史阅读记录中出现；没有另建旧名技能或副本，因此仍为九个业务入口；新增导航另计。

## 重复如何消除

背景访谈只生成一次业务链及首轮问题，把各方交换与责任纳入同一分析。界面审查只生成一份任务报告，清晰度、导航为有条件的检查视角。验证只维护一套证据判断，主持方法拆到专用参考，首次接触顺序只在主持参考完整定义。

事实与解释的区别等独立调用必需约束各入口保留短句；完整提问格式放在背景访谈。其余入口仅对关键缺口附追问或求证动作，不固定生成完整提纲。没有建立额外的“公共规则 skill”或强制共享前置文件。

## 六个保留职责的收口

| 职责 | 主要回答 | 引用已有内容后停止在哪 |
|---|---|---|
| 用户模型 | 什么情境改变了选择，解释能否被反例推翻 | 行为模型与预测，不决定开发顺序 |
| 机会定义 | 什么问题值得继续探索，怎样才算有改善 | 问题与成功结果，不重新建模或比较整个方案组合 |
| 换用价值 | 相对真实旧做法是否值得承担替换负担 | 条件比较，不做跨项目资源分配 |
| 方案探索 | 是否有不同机制满足同一目标 | 可走通体验及必要收敛，复杂冲突不重复做整套权衡 |
| 产品取舍 | 在目标和资源约束下选择哪种行动 | 条件建议，复用上游分析，不重新访谈或主持观察 |
| 观察分诊 | 实际阻碍有多严重，怎样最小修复 | 资源内的修复顺序，严重性不直接代替商业优先级 |

原三套文件在本次聊天输出目录中仍保持原样。本目录保存的是整合版、按需参考及来源记录，不再同时装入三套旧入口。未修改仓库其他 skill、README、marketplace 或同步脚本。
