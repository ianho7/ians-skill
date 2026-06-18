---
name: experiment-matrix-design
description: >
  Design a small, high-information experiment matrix for comparing multiple
  configurations, strategies, thresholds, or implementation variants without
  falling into combinatorial explosion. Use when the user wants to test several
  options, establish baselines, compare tradeoffs, or decide which combinations
  are worth validating next.
---

# Experiment Matrix Design

## Purpose

Use this skill to turn a messy multi-option comparison problem into a controlled
experiment matrix.

This skill is for cases where there are multiple possible configurations,
strategies, thresholds, toggles, or variants, and the user needs a disciplined
way to compare them without testing everything.

Typical outcomes include:

- a clear experiment goal
- a list of variables worth testing
- a reduced set of scenarios
- explicit baseline and comparison groups
- a measurement plan
- a recommendation for which combinations to test first

## When To Use

Use when:

- the user wants to compare multiple configurations or variants
- there are too many possible combinations to test blindly
- the team needs an experiment plan before implementation or benchmarking
- the user asks for an A/B comparison framework, benchmark matrix, or test grid
- the task involves balancing several dimensions such as quality, speed, cost, or risk

Also use when the user asks things like:

- how should we test these combinations
- which configs should we compare first
- how do we avoid testing every permutation
- what experiment matrix should we use
- which scenarios give the most information

## When Not To Use

Do not use when:

- there is only one realistic option
- the problem is root-cause diagnosis rather than option comparison
- the user wants direct implementation of a chosen path
- the comparison criteria are still unknown`r`n- there is no practical way to measure outcomes yet`r`n- the main question is which direction deserves priority before any experiment matrix is designed

## Core Principle

Do not test every possible combination.

A good experiment matrix maximizes decision value per run.

Prefer experiments that:

- establish strong baselines first
- isolate the most important variables
- compare a small number of high-information scenarios
- reduce ambiguity for the next decision

This skill is for designing informative comparisons, not for deciding overall business or engineering priority from scratch.

If the user mainly needs to choose which direction is worth doing first, use optimization-prioritization instead.

This skill prevents common failure modes:

- combinatorial explosion
- blind parameter sweeping
- comparing options without a baseline
- changing too many variables at once
- measuring lots of runs without learning anything useful
- collecting results that do not answer a decision question

## Workflow

### Phase 0: Check Readiness

Confirm that experiment design is the right problem.

Minimum readiness:

- there are at least two realistic options or variables
- there is a measurable outcome or proxy metric
- the user wants to compare options rather than diagnose an unknown cause

If readiness is missing, say what is missing and stop or route to diagnosis or prioritization.

Completion criterion:

- the task is clearly an experiment design problem
- missing prerequisites are explicitly named if needed

### Phase 1: Define The Decision Question

Turn the user's broad request into a specific question the experiment should answer.

Examples:

- Which configuration gives the best speed-quality tradeoff?
- Which variant is worth shipping as the new default?
- Which parameter has the strongest effect on the target metric?
- Which subset of features actually needs the expensive mode?

State:

- the main decision to support
- the primary metric
- important secondary constraints
- what would count as a useful outcome

Completion criterion:

- the experiment has a decision target, not just a vague desire to collect data

### Phase 2: Normalize Variables And Constraints

List the variables that could change and the constraints that matter.

For each variable, state:

- name
- possible values
- expected effect
- why it is worth testing

Also state:

- fixed conditions that should stay constant
- environmental constraints
- known cost limits
- any variables that should not be changed yet

Completion criterion:

- the experiment space is explicit
- fixed and variable dimensions are clearly separated

### Phase 3: Reduce The Search Space

Shrink the possible combinations before designing runs.

Prefer these moves:

- remove clearly low-value variables
- merge equivalent options
- freeze low-priority dimensions
- separate exploratory variables from production-critical ones
- identify the smallest set of variables that could change the decision

If the space is still too large, say so and reduce further.

Completion criterion:

- the candidate space is intentionally reduced
- the remaining variables are high-value enough to justify testing

### Phase 4: Build The Matrix

Design the actual experiment scenarios.

Always include:

- a baseline
- at least one high-end or extreme comparison
- at least one practical candidate close to the likely recommendation

Prefer a matrix that supports:

- baseline vs extreme comparison first
- then a small number of promising mixed combinations
- one decision per matrix when possible

For each scenario, include:

- scenario name
- values for each active variable
- why this scenario exists
- what signal it should produce

Completion criterion:

- each scenario has a reason to exist
- the matrix is small enough to run
- the matrix can answer the decision question

### Phase 5: Define Measurement And Interpretation Rules

State how results will be collected and interpreted.

Include:

- primary metric
- secondary metrics
- quality or regression checks
- how many runs or samples are needed if relevant
- what outcome would count as clearly better
- what outcome would count as inconclusive

Also define how to compare:

- absolute results
- delta from baseline
- tradeoff against cost or quality

Completion criterion:

- the experiment can be judged consistently
- success, failure, and inconclusive outcomes are defined ahead of time

### Phase 6: Recommend The First Round

Choose what to run first.

Typically recommend:

- the minimum set of runs that establishes the boundaries
- the next most informative comparison if the first round is inconclusive
- which combinations should wait until later

Completion criterion:

- the user knows what to test first
- the first round is small but informative
- unnecessary runs are explicitly deferred

## Required Output

Produce an experiment execution design artifact containing at least:

- `Decision question`
- `Primary metric`
- `Secondary constraints`
- `Variables`
- `Fixed conditions`
- `Reduced search space`
- `Experiment matrix` `r`n- `Scenario definitions` `r`n- `Measurement rules`
- `Interpretation rules`
- `Recommended first round`
- `Deferred scenarios`

The output must distinguish:

- facts
- assumptions
- variables
- constraints
- measurement rules
- decisions still pending

## Do Not

- Do not test every possible combination by default.
- Do not design experiments without a decision question.
- Do not compare scenarios if too many variables change at once without a reason.
- Do not treat a large matrix as better than a small informative one.
- Do not ignore cost, runtime, or quality constraints.
- Do not recommend mixed scenarios before establishing useful baselines.
- Do not collect measurements that cannot affect a decision.
- Do not present an experiment grid without saying what each scenario is supposed to teach.

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- the decision question is still ambiguous
- the variable space is too large and needs aggressive reduction
- the recommended matrix drops options the user may care about
- the experiment cost is high enough to matter
- interpretation depends heavily on unstated product priorities

Checkpoint format:

- Current decision question
- Variables under consideration
- Proposed reduced matrix
- Recommendation
- Tradeoffs
- What will be learned first

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put the reusable experiment design method in the skill, not the project-specific knobs.
- Put concrete run results in reports, logs, or handoff notes.
- Put stable project tuning policy in project docs or ADRs.
- Put final chosen defaults into implementation plans or issue trackers.
- Do not duplicate the full diagnosis or prioritization context inside the matrix output; reference it when needed.
- If a variable is excluded only because of current cost or scope, label it as deferred rather than universally unimportant.

## Completion Criteria

The skill is complete when:

- the decision question is explicit
- the variable space is normalized
- the search space is intentionally reduced
- the matrix includes meaningful baselines
- each scenario has a purpose
- measurement and interpretation rules are defined
- the first round of runs is clearly recommended
- deferred scenarios are named explicitly

Typical sequence:

- use ounded-diagnosis-loop to understand the problem and evidence
- use optimization-prioritization if the main question is which direction matters most
- use this skill when the next step is to compare a reduced set of configurations, variants, or combinations

## Suggested Next Skills

- `bounded-diagnosis-loop`
- `optimization-prioritization`
- `session-handoff`

