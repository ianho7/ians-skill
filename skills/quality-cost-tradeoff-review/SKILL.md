---
name: quality-cost-tradeoff-review
description: >
  Evaluate whether a proposed optimization, simplification, or efficiency gain is
  worth its quality, user-experience, correctness, or product tradeoff. Use when
  the user asks whether a performance gain is worth the degradation risk, wants
  to compare speed versus quality, or needs a clear recommendation on what loss
  is acceptable and what is not.
---

# Quality Cost Tradeoff Review

## Purpose

Use this skill to evaluate whether a gain is worth its cost when the cost is not
just engineering time, but quality degradation, user experience regression,
correctness risk, product compromise, or reduced clarity.

This skill is for decisions like:

- faster but uglier
- cheaper but less reliable
- simpler but less flexible
- lighter but lower quality
- faster benchmark but weaker user outcome

Typical outcomes include:

- a tradeoff table
- an explicit recommendation
- a statement of acceptable and unacceptable degradation
- a list of assumptions and missing evidence
- a decision on whether the gain is worth shipping now

## When To Use

Use when:

- the user asks whether a performance or efficiency gain is worth a visible or meaningful cost
- multiple options differ mainly by speed-versus-quality tradeoff
- the team risks optimizing for internal metrics at the expense of user experience
- the user explicitly wants a value judgment, not just raw measurements
- the main question is what degradation is acceptable

Also use when the user asks things like:

- is this worth it
- does the speed gain justify the quality loss
- how much degradation can we tolerate
- is this tradeoff acceptable for users
- should we keep the better-looking version or the faster version

## When Not To Use

Do not use when:

- the main question is root-cause diagnosis
- there is only one realistic option and no meaningful tradeoff
- the user wants a direct implementation plan
- the problem is primarily about ranking many engineering directions by cost and risk rather than judging one tradeoff boundary
- there is no evidence at all for either the gain or the cost

## Core Principle

Do not evaluate an optimization by upside alone.

A tradeoff is only good if the gain matters enough to justify the loss.

Always evaluate both sides:

- what is gained
- what is lost
- who feels the loss
- how visible the loss is
- whether the loss is reversible
- whether the gain is user-visible or mostly internal

This skill prevents common failure modes:

- shipping a faster system that feels worse to users
- accepting visible degradation for low-value benchmark gains
- arguing from personal preference without explicit criteria
- hiding correctness or quality regressions behind performance wins
- treating all losses as equal even when some are unacceptable

## Workflow

### Phase 0: Check Readiness

Confirm that a real tradeoff exists.

Minimum readiness:

- at least two options or modes exist
- there is some evidence for the gain side
- there is some evidence or plausible concern for the loss side
- the decision depends on value judgment, not just measurement collection

If readiness is missing, say what evidence is still needed.

Completion criterion:

- the problem is confirmed to be a tradeoff review, not a diagnosis or implementation task

### Phase 1: State The Decision Frame

Restate the decision in plain language.

Include:

- what is being gained
- what is being given up
- who is affected
- what decision must be made

Examples:

- reduce export time at the cost of slightly lower visual quality
- reduce infra cost at the cost of slower tail latency
- simplify implementation at the cost of less flexibility for rare cases

Completion criterion:

- the tradeoff is stated as gain-versus-loss, not as a vague preference question

### Phase 2: Define The Evaluation Criteria

List the criteria that matter for this decision.

Common criteria:

- user-visible benefit
- user-visible degradation
- correctness risk
- product quality risk
- implementation complexity
- rollback cost
- reversibility
- strategic importance

Separate:

- must-not-break constraints
- soft preferences
- unknowns that still need evidence

Completion criterion:

- the decision criteria are explicit
- unacceptable loss conditions are named

### Phase 3: Compare Gain And Cost

For each option, evaluate:

- expected gain
- expected cost
- visibility of gain
- visibility of loss
- confidence level
- reversibility
- who bears the downside

Use a compact table where possible.

Completion criterion:

- each option is evaluated on both upside and downside
- uncertainty is preserved rather than flattened

### Phase 4: Identify False Tradeoffs And Hidden Costs

Challenge the tempting story.

Look for:

- gains that are technically real but not user-visible
- losses that are technically small but highly noticeable
- options that are easy to ship but hard to reverse
- hidden maintenance or support costs
- options that look neutral until scaled to common user behavior

Completion criterion:

- at least one challenge pass has been applied
- false wins and hidden losses are made explicit

### Phase 5: Draw The Boundary

State clearly:

- what tradeoff is acceptable
- what tradeoff is unacceptable
- what would change the decision
- whether more evidence is required before deciding

This phase should make the threshold explicit, not just the current recommendation.

Completion criterion:

- there is a clear accept / reject / wait boundary
- the user can see where the line is being drawn

### Phase 6: Recommend The Decision

Provide:

- recommended option
- why it wins
- why the rejected option loses
- what evidence would overturn the recommendation
- whether the decision should be revisited later

Completion criterion:

- one recommendation is clear
- the recommendation is tied to criteria and evidence

## Required Output

Produce a tradeoff review artifact containing at least:

- `Decision frame`
- `Options under review`
- `Evaluation criteria`
- `Must-not-break constraints`
- `Tradeoff comparison table`
- `False tradeoff or hidden cost notes`
- `Acceptable boundary`
- `Unacceptable boundary`
- `Recommendation`
- `Open questions`

The output must distinguish:

- facts
- evidence
- assumptions
- subjective preferences
- constraints
- recommendation

## Do Not

- Do not evaluate performance gains without evaluating visible loss.
- Do not collapse product quality and engineering convenience into the same thing.
- Do not assume a measurable gain is automatically meaningful.
- Do not treat all degradation as acceptable if it is reversible only in theory.
- Do not hide uncertainty behind a confident recommendation.
- Do not substitute personal taste for explicit criteria.

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- acceptable degradation is not yet defined
- the gain is measurable but the user impact is unclear
- the top option risks a visible regression
- the tradeoff depends heavily on product or brand standards
- the recommendation requires choosing between speed and perceived quality

Checkpoint format:

- Current decision frame
- Gains under consideration
- Costs under consideration
- Recommendation
- Boundary being drawn
- What would change the recommendation

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put reusable tradeoff logic in the skill, not project-specific thresholds.
- Put benchmark numbers, screenshots, and raw comparisons in reports or handoff notes.
- Put stable product quality policy in project docs or ADRs.
- Put final adopted defaults or limits into implementation plans, issues, or product docs.
- If a boundary is case-specific, label it as case-specific rather than universal.

## Completion Criteria

The skill is complete when:

- the gain and loss are both explicit
- evaluation criteria are visible
- unacceptable regressions are named
- hidden costs have been challenged
- an accept / reject / wait boundary exists
- one recommendation is clearly stated
- the output preserves uncertainty and value judgment

## Suggested Next Skills

- `optimization-prioritization`
- `experiment-result-interpretation`
- `session-handoff`
