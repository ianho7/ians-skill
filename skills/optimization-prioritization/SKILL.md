---
name: optimization-prioritization
description: >
  Rank optimization directions by user-visible impact, evidence strength, risk,
  implementation cost, and quality tradeoffs. Use when multiple possible
  optimizations exist and the user wants to know which one is most worth doing
  first, which ones should wait, and which ones are not worth the tradeoff.
---

# Optimization Prioritization

## Purpose

Use this skill to decide which optimization direction is most worth doing first
when several candidates exist.

This skill is not for discovering root cause from scratch. It is for the stage
where enough evidence already exists to compare options and choose what deserves
engineering effort.

Typical outcomes include:

- a ranked optimization list
- a comparison table with explicit criteria
- a recommended first move
- a list of deferred directions
- a statement of what is not worth doing yet

## When To Use

Use when:

- the user asks which optimization direction is most worth doing first
- several bottlenecks or candidate improvements have already been identified
- the team needs to balance speed, quality, risk, and engineering cost
- there is pressure to avoid low-value optimization work
- the user cares about user-visible impact rather than isolated benchmark wins

Also use when the user asks questions like:

- which direction has the best ROI
- which bottleneck should we tackle first
- which optimization is highest leverage
- which improvements are worth the quality tradeoff
- what should we defer for now

## When Not To Use

Do not use when:

- the problem has not been diagnosed yet
- there is no evidence for the candidate directions
- the user wants root-cause analysis rather than prioritization
- only one realistic option exists`r`n- the task is to directly implement a chosen optimization`r`n- the main question is how to structure comparisons or test combinations rather than how to rank the candidate directions

## Core Principle

Do not rank optimization directions by local technical interest alone.

Rank them by decision criteria that reflect actual value, especially:

- user-visible wall-clock impact
- confidence from evidence
- implementation cost
- regression risk
- quality or product tradeoff
- reversibility

A good prioritization process makes it clear:

- what is known
- what is estimated
- what the likely upside is
- what the likely downside is
- what is explicitly not worth doing yet

This skill is for ranking what deserves attention first.

If the user already has candidate directions but mainly needs help designing the comparison runs, use experiment-matrix-design instead.

This skill prevents common failure modes:

- optimizing the largest-looking number without user context
- chasing benchmark wins that users cannot feel
- ignoring quality tradeoffs
- treating speculation as evidence
- ranking options without explicit criteria
- doing expensive work before testing lower-risk alternatives

## Workflow

### Phase 0: Check Readiness

Confirm that prioritization can begin.

Minimum readiness:

- at least two candidate optimization directions exist
- there is some evidence for each candidate
- the user goal is clear enough to rank tradeoffs

If readiness is missing, say what is missing and stop or route back to diagnosis.

Completion criterion:

- the agent knows this is a prioritization problem, not a diagnosis problem
- missing evidence is explicitly named if prioritization would be premature

### Phase 1: Restate The Goal Function

Translate the user's intent into a decision rule.

Examples:

- maximize user-visible latency reduction without obvious quality loss
- reduce infra cost while preserving throughput
- lower export time without harming final output quality
- improve p95 latency before improving p50

State:

- primary success metric
- important secondary constraints
- unacceptable tradeoffs

Completion criterion:

- the ranking goal is explicit
- success is defined in user or product terms, not just engineering terms

### Phase 2: Normalize Candidate Directions

List the candidate optimization directions in a comparable form.

For each candidate, include:

- name
- what it changes
- expected mechanism of improvement
- affected system area
- expected user-facing effect

Keep candidates at similar granularity. Do not compare a tiny tweak against a multi-quarter rewrite as if they are the same kind of option.

Completion criterion:

- candidates are concrete and comparable
- each candidate describes a direction, not just a symptom

### Phase 3: Score By Decision Criteria

Evaluate each candidate using explicit criteria.

Recommended criteria:

- evidence strength
- expected user-visible impact
- implementation cost
- regression risk
- quality tradeoff
- reversibility
- time to validate

Use simple labels such as:

- High / Medium / Low
- or a short numeric scale if the case benefits from it

For each score, add a one-line reason.

Completion criterion:

- every candidate has explicit scores
- the reasoning is visible rather than implied
- uncertainty is preserved where estimates are weak

### Phase 4: Identify False Wins And Hidden Costs

Challenge the most tempting options.

Specifically look for:

- large local wins with weak user impact
- options that save time only in rare paths
- options that increase quality risk too much
- optimizations that are hard to validate
- complex work that should be deferred until simpler options are exhausted

Completion criterion:

- at least one challenge pass has been performed
- obvious false wins are either downgraded or explicitly defended

### Phase 5: Rank And Recommend

Produce a ranked result.

At minimum include:

- recommended first option
- second-best option if the first fails or is blocked
- deferred options
- options not worth doing now

For the recommended first option, explain:

- why it ranks first
- what it prevents
- what evidence still needs to be validated
- what would cause the ranking to change

Completion criterion:

- there is a real ranking, not just a bag of options
- one best next move is clear
- the recommendation is tied to explicit criteria

### Phase 6: Define The Decision Artifact

Summarize the prioritization in a reusable artifact.

The artifact should separate:

- facts
- evidence
- estimates
- tradeoffs
- recommendation
- deferred work
- open questions

Completion criterion:

- another engineer or agent could continue from the output
- the tradeoffs are visible without rereading the full discussion

## Required Output

Produce a prioritization decision artifact containing at least:

- `Goal function`
- `Candidate list`
- `Comparison criteria`
- `Scored comparison table`
- `False-win or hidden-cost notes`
- `Recommended first option` `r`n- `Second-best fallback` `r`n- `Deferred options`
- `Not worth doing now`
- `Open questions`

The output must distinguish:

- facts
- evidence
- estimates
- assumptions
- tradeoffs
- decisions

## Do Not

- Do not prioritize before diagnosis is mature enough.
- Do not rank options without explicit criteria.
- Do not let the biggest local timing number automatically win.
- Do not ignore user-visible impact.
- Do not hide quality regressions behind performance gains.
- Do not pretend weak estimates are strong evidence.
- Do not recommend broad rewrites before checking smaller high-leverage options.
- Do not confuse “interesting” with “worth doing now.”

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- the ranking depends heavily on unstated product priorities
- the top option carries meaningful quality or regression risk
- a large rewrite is being considered against smaller options
- the agent is about to reject an option the user appears attached to
- the evidence is too weak to rank with confidence

Checkpoint format:

- Current understanding
- Goal function
- Candidate options
- Recommendation
- Key tradeoffs
- What would change the ranking

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put reusable prioritization logic in the skill, not project-specific bottlenecks.
- Put benchmark tables and one-off measurements in reports or handoff notes.
- Put stable project performance principles in project docs or ADRs.
- Put final accepted optimization directions in issue trackers, ADRs, or implementation plans.
- Do not duplicate the full diagnosis log inside the prioritization output; reference it when needed.
- If an option is deferred because of current context, label that clearly instead of making it sound universally bad.

## Completion Criteria

The skill is complete when:

- the optimization goal is explicit
- candidates are concrete and comparable
- ranking criteria are visible
- false wins have been challenged
- one best next option is recommended
- deferred and low-value options are clearly separated
- the output preserves uncertainty and tradeoffs

Typical sequence:

- use ounded-diagnosis-loop to identify and bound the problem
- use this skill to rank the candidate optimization directions
- use experiment-matrix-design if the next step is to compare configurations or variants systematically

## Suggested Next Skills

- `bounded-diagnosis-loop`
- `experiment-matrix-design`
- `session-handoff`

