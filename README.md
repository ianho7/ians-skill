# Agent Skills Workflow

**Language:** [English](./README.md) | [中文](./README.zh-CN.md)

This repo is a skill system for turning real engineering work into reusable agent operating methods.

It is not a prompt dump and not just a list of isolated skills.

The skills are organized around one lifecycle:

* define the work
* turn the work into executable steps
* preserve continuity when execution spans sessions
* extract reusable workflows from finished cases
* formalize those workflows as skills
* optionally publish the case as a technical article

## End-to-End Workflow

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

There is also a narrower knowledge-extraction sub-flow:

```text
real engineering case
→ extract-skill-from-case
→ write-high-quality-skill
→ optional case-study-writing
```

## Skill System

### Stage 1: Define the work

Use these skills before implementation when the problem still needs structure.

#### `plan`

Use this for a standard implementation plan.

It turns a requirement, bug, refactor, or investigation goal into a concrete execution plan with:

* scope
* current-state analysis
* proposed solution
* implementation phases
* validation strategy
* risks and open questions

Use when you think:

> I need a practical plan for this work.

#### `mvp-plan`

Use this when the main risk is over-engineering.

It creates a strict MVP-first plan that keeps only the smallest useful path and explicitly defers everything else.

Use when you think:

> I only want the minimum viable version. Keep the scope tight.

Difference from `plan`:

* `plan` = general implementation planning
* `mvp-plan` = scope-constrained planning with aggressive deferral of non-essential work

### Stage 2: Turn plan into execution

#### `checklist`

Use this after the shape of the work is already known.

It converts a plan, requirement, or technical goal into an ordered execution checklist with:

* atomic implementation tasks
* validation steps
* documentation steps
* cleanup steps
* automatic per-task reflection output

This is more than a TODO generator. It is meant to make execution reviewable and reflective.

Use when you think:

> I know what needs to happen. Break it into executable tasks.

### Stage 3: Preserve continuity

#### `session-handoff`

Use this when execution needs to pause or move across sessions.

It captures:

* objectives
* completed work
* repository state
* decisions and rationale
* remaining risks
* outstanding work
* recommended next steps

This belongs to execution hygiene. It keeps long-running work resumable without rereading the full conversation.

Use when you think:

> I need to stop now, but the next session should continue cleanly.

### Stage 4: Mine completed work for reusable methods

#### `extract-skill-from-case`

Use this after a real case has been completed.

It separates:

* one-off project details
* reusable workflows
* agent failure modes
* candidate skills
* items that belong in docs, snippets, or articles instead

Its job is not to summarize the case. Its job is to decide what is worth operationalizing.

Use when you think:

> This case was valuable. What part of it should become reusable?

### Stage 5: Convert knowledge into durable artifacts

#### `write-high-quality-skill`

Use this when you already know which workflow should become a skill.

It turns that workflow into a proper `SKILL.md` with:

* precise trigger conditions
* workflow phases
* artifacts
* completion criteria
* guardrails
* user checkpoints
* context hygiene

Use when you think:

> This method is real and repeatable. Package it as a skill.

#### `case-study-writing`

Use this when a finished case deserves a public or internal write-up.

It turns the case into an article that preserves:

* the original problem
* the investigation path
* evidence and tradeoffs
* the role of skills or agents
* the final decision
* reusable lessons

Use when you think:

> This case should become an article, not just a note.

## When To Use Which Path

| Situation | Use |
| --- | --- |
| I have a new task and need a plan | `plan` |
| I need the smallest viable version only | `mvp-plan` |
| I already have a plan and need executable steps | `checklist` |
| I need to stop now and continue later | `session-handoff` |
| We finished something valuable and want to preserve the method | `extract-skill-from-case` |
| We already know the workflow to codify | `write-high-quality-skill` |
| This case deserves a write-up | `case-study-writing` |


## Diagnostic Decision Stack

The newer skills below form a smaller, more tactical sub-system inside the repo.

They are not mainly about planning delivery work or extracting a finished case into documentation.
They are about handling difficult engineering uncertainty in the middle of real work.

This stack is useful when the problem is not “how do we implement this” but rather:

- what is actually going wrong
- which direction is worth pursuing first
- whether the gain is worth the loss
- how should we compare the remaining options without testing everything
- what the finished experiment results actually mean

### The Stack

```text
a vague slowdown / regression / unclear system problem
→ bounded-diagnosis-loop
→ optional benchmark-fixture-replay
→ optimization-prioritization
→ optional quality-cost-tradeoff-review
→ experiment-matrix-design
→ experiment-result-interpretation
```

### What Each Skill Does

#### `bounded-diagnosis-loop`

Use this when the problem is still unclear.

Its job is to:

- bound the scope
- establish the primary evidence source
- build a repeatable feedback loop
- generate falsifiable hypotheses
- add only the minimum instrumentation needed
- validate one hypothesis at a time

This is the entry point for unclear engineering problems.

#### `benchmark-fixture-replay`

Use this when running the full real workflow every time is too painful, and you want to save one real case so you can replay it again and again.

In plain terms, this means:

- the real path is slow
- the real path has too many steps
- the real path depends on too many moving parts
- but one real case is worth saving for repeat testing

Its job is to:

- choose where to save that real case
- define exactly what files or inputs should be saved
- create a short replay path for future runs
- explain what the replay still represents well
- explain when the full real workflow still needs to be rerun

This is the replay and saved-real-case layer.

#### `optimization-prioritization`

Use this after diagnosis is mature enough that multiple candidate directions exist.

Its job is to:

- rank optimization directions by user-visible value
- compare expected impact, risk, cost, and tradeoffs
- identify false wins
- recommend what is worth doing first
- explicitly defer what is not worth doing yet

This is the decision layer.

#### `quality-cost-tradeoff-review`

Use this when the main question is not just which direction ranks first, but whether a gain is worth its visible or meaningful cost.

Its job is to:

- evaluate speed versus quality, simplicity, correctness, or experience tradeoffs
- define acceptable and unacceptable degradation boundaries
- expose hidden costs and false tradeoffs
- recommend whether the gain is worth shipping now

This is the tradeoff judgment layer.

#### `experiment-matrix-design`

Use this when the next problem is not “which direction matters most” but “how should we compare the remaining options efficiently”.

Its job is to:

- turn a large configuration or option space into a reduced matrix
- keep the number of runs small
- preserve useful baselines
- define scenario purpose and measurement rules
- recommend the first round of experiments

This is the structured comparison layer.

#### `experiment-result-interpretation`

Use this after experiment runs have completed and the main problem is deciding what the results actually mean.

Its job is to:

- first turn messy raw output into a structured comparison summary
- validate whether the comparison was meaningful
- separate strong signal from weak signal or noise
- classify the result as win, loss, mixed, inconclusive, or invalid
- explain metric conflicts
- recommend the next move

This is the results interpretation layer.

### Why This Is A Separate System

These skills solve a different class of problem from `plan`, `mvp-plan`, or `checklist`.

They are for cases where:

- implementation is premature
- evidence quality matters more than coding speed
- the main risk is wrong diagnosis or wrong prioritization
- the problem has too many plausible options
- the result needs interpretation before execution can continue

In other words:

- `plan` and `checklist` help when the route is known enough to execute
- this stack helps when the route is not yet trustworthy enough to execute

### Quick Selection Guide

| Situation | Use |
| --- | --- |
| The issue is real, but the cause is unclear | `bounded-diagnosis-loop` |
| Running the full workflow every time is too painful, and we want to save one real case for repeat testing | `benchmark-fixture-replay` |
| We already have several plausible directions and need to choose what matters most | `optimization-prioritization` |
| The key question is whether a gain is worth the visible or meaningful loss | `quality-cost-tradeoff-review` |
| We already know what options deserve comparison and need a compact test matrix | `experiment-matrix-design` |
| The experiments are done, the raw output is messy, and we need to structure and interpret the results correctly | `experiment-result-interpretation` |
## Mental Model

```text
plan / mvp-plan = define the route
checklist = break the route into steps
session-handoff = preserve the map mid-journey
extract-skill-from-case = identify the reusable method afterward
write-high-quality-skill = package the method
case-study-writing = publish the field report
```

## Why This Structure Exists

A real engineering workflow does not begin at article writing or skill authoring.

It usually starts with an unclear task, moves through execution, spans multiple sessions, and only then produces knowledge worth preserving.

This repo exists to support that full chain:

```text
delivery work
→ execution discipline
→ continuity
→ workflow extraction
→ reusable artifacts
```

## Principle

Do the work.

Structure the work.

Preserve the decisions.

Extract the method.

Reuse the method in the next session.




