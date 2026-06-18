---
name: experiment-result-interpretation
description: >
  Interpret experiment outcomes by separating clear wins, ambiguous results,
  conflicting metrics, and invalid comparisons. Use when an experiment, A/B run,
  benchmark matrix, or configuration comparison has already been executed and
  the next problem is deciding what the results actually mean.
---

# Experiment Result Interpretation

## Purpose

Use this skill to turn raw experiment output into a defensible conclusion.

This skill is for the stage after experiments, benchmarks, comparisons, or A/B
runs have already been executed and the main challenge is interpretation rather
than design.

Typical outcomes include:

- a structured result summary
- a result summary
- classification of clear win / clear loss / inconclusive / invalid comparison
- an explanation of metric conflicts
- a recommendation for next action
- a list of additional evidence needed if the result is not decision-grade

## When To Use

Use when:

- experiment runs have completed and the user wants help interpreting them
- benchmark results show mixed or conflicting signals
- a matrix comparison produced too much raw data to turn into a decision directly
- the user wants to know whether a result is strong enough to act on
- the main challenge is not how to run tests, but how to read them correctly

Also use when the user asks things like:

- what do these results actually mean
- is this a real win or just noise
- can we conclude anything yet
- which result matters more when metrics conflict
- do we need another round of testing

## When Not To Use

Do not use when:

- no experiment has been run yet
- the main question is how to design the experiment matrix
- the main question is how to prioritize candidate directions before testing
- there is no usable result data at all
- the user wants direct implementation rather than interpretation

## Core Principle

Do not confuse output with conclusion.

A result is only actionable if:

- the comparison is valid
- the signal is relevant to the decision
- the uncertainty is understood
- metric conflicts are surfaced rather than ignored

Good interpretation answers:

- did this experiment answer the intended question
- is the underlying result set structured enough to compare fairly
- is the result strong enough to act on
- what result is real versus noisy
- what conflicts remain
- what should happen next

This skill prevents common failure modes:

- declaring victory from weak or noisy deltas
- treating conflicting metrics as if only one mattered
- comparing invalid or non-equivalent scenarios
- collecting data without making a decision
- over-reading inconclusive experiments

## Workflow

### Phase 0: Check Result Readiness

Confirm that there is enough output to interpret.

Minimum readiness:

- a defined comparison exists
- at least some result data exists
- the underlying decision question is known

If readiness is missing, say whether the missing piece is:

- experiment design
- missing measurements
- missing baseline
- missing comparison validity

Completion criterion:

- the task is confirmed as interpretation, not design or diagnosis

### Phase 1: Restate The Intended Question

State what the experiment was supposed to answer.

Examples:

- which variant is faster at equal quality
- whether the mixed mode preserves enough quality to justify the speed gain
- whether parameter X matters enough to keep testing

This anchors the interpretation to the real decision rather than to whatever numbers happen to be available.

Completion criterion:

- the interpretation target is explicit

### Phase 2: Structure The Raw Results

Before interpreting meaning, organize the raw output into a comparable result set.

Build a compact structured summary containing:

- baseline runs
- variants or scenarios being compared
- key metrics for each scenario
- any missing metrics
- any obviously non-comparable entries
- any anomalies that need to be flagged before interpretation

The goal is not to produce a beautiful report. The goal is to make later interpretation reliable.

If raw output is spread across multiple logs, reports, screenshots, or benchmark dumps, reduce it into a small comparison summary first.

Completion criterion:

- the raw output has been reduced to a structured comparison summary
- baseline and variants are explicit
- obviously unusable or missing data has been flagged

### Phase 3: Validate The Comparison
Check whether the comparison itself is valid.

Look for:

- missing baseline
- mismatched environments
- too many changing variables
- incomparable samples
- missing quality checks
- missing sample size or run stability where relevant

If the comparison is invalid, say so before interpreting the metrics.

Completion criterion:

- the comparison is labeled valid, weak, or invalid

### Phase 4: Summarize The Signal

Extract the key results.

Summarize:

- strongest positive signals
- strongest negative signals
- flat or negligible changes
- uncertainty or noise indicators
- metric conflicts

Do not repeat every raw number unless necessary.

Completion criterion:

- the important signal has been separated from the raw output

### Phase 5: Classify The Outcome

Classify the result as one of:

- clear win
- clear loss
- mixed result
- inconclusive
- invalid comparison

Add a short rationale tied to evidence.

Completion criterion:

- the result has a usable category
- the rationale is explicit

### Phase 6: Resolve Metric Conflicts

If metrics disagree, explain how to interpret the conflict.

Examples:

- faster but visibly worse
- lower mean time but worse p95
- lower runtime but higher memory cost
- better quality but too expensive

State which metric should dominate and why, based on the decision question.

Completion criterion:

- conflicts are surfaced and resolved or explicitly left unresolved

### Phase 7: Recommend The Next Move

Recommend one of:

- accept the result and proceed
- reject the option
- run a narrower follow-up experiment
- gather missing evidence
- revisit the original decision question

Completion criterion:

- the next action is clear
- the recommendation matches the strength of the evidence

## Required Output

Produce an interpretation artifact containing at least:

- `Decision question`
- `Structured result summary`
- `Comparison validity`
- `Key signals`
- `Metric conflicts`
- `Outcome classification`
- `What the result supports`
- `What the result does not support`
- `Recommended next move`
- `Open questions`

The output must distinguish:

- facts
- measurements
- interpretation
- uncertainty
- invalid assumptions
- next decision

## Do Not

- Do not treat raw output as a conclusion.`r`n- Do not skip the step of structuring the raw result set when the source data is messy or fragmented.
- Do not interpret an invalid comparison as a meaningful result.
- Do not hide metric conflicts.
- Do not declare a win when the result is mostly noise or ambiguity.
- Do not recommend further experiments without saying what uncertainty they would resolve.
- Do not collapse multiple decision questions into one interpretation.

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- the comparison validity is questionable
- the result is mixed and the dominant metric depends on product priorities
- the result appears strong but conflicts with visible quality or correctness
- the next move would require another expensive round of testing
- the evidence is not strong enough for the decision the user wants to make

Checkpoint format:

- Intended question
- Comparison validity
- Key signals
- Current interpretation
- Recommendation
- Remaining uncertainty

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put reusable interpretation logic in the skill, not project-specific metrics.
- Put raw result tables and charts in reports, logs, or experiment artifacts.
- Put stable evaluation policy in project docs or ADRs.
- Put final chosen defaults or rollout decisions in implementation plans or issue trackers.
- If a conclusion depends on case-specific priorities, label that clearly.

## Completion Criteria

The skill is complete when:

- the intended question is restated
- the raw results have been structured into a usable comparison summary
- the comparison validity is checked
- the key signal is separated from noise
- the outcome is classified
- metric conflicts are handled explicitly
- the next move matches the strength of the evidence
- unsupported conclusions are clearly excluded

## Suggested Next Skills

- `experiment-matrix-design`
- `optimization-prioritization`
- `session-handoff`

