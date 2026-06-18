---
name: bounded-diagnosis-loop
description: >
  Diagnose a vague engineering problem by bounding scope, building a repeatable
  feedback loop, separating primary evidence from auxiliary evidence, adding the
  minimum instrumentation needed, and validating one hypothesis at a time before
  implementation. Use when the user reports a slowdown, regression, incorrect
  behavior, or unclear root cause and wants diagnosis before coding.
---

# Bounded Diagnosis Loop

## Purpose

Use this skill to turn a vague engineering problem into a bounded, repeatable,
evidence-driven diagnosis loop.

This skill exists to reduce randomness in agent behavior. It is for cases where
the problem is real, but the cause is unclear and premature coding would likely
make the situation worse.

Typical outcomes include:

- a clear problem boundary
- a primary baseline and auxiliary baselines
- a hypothesis table
- a minimum instrumentation plan
- step-by-step validation records
- a current best conclusion
- a ranked next step

## When To Use

Use when:

- the user reports a slowdown, regression, incorrect behavior, or unclear root cause
- the user says “diagnose first” or “do not code yet”
- the system has multiple possible layers or bottlenecks
- the current logs or measurements are not enough to support a conclusion
- a repeatable baseline, replay loop, trace, or benchmark needs to be established

Also use when the user wants:

- a performance diagnosis
- a root-cause investigation
- a benchmark or replay design
- a falsifiable hypothesis workflow
- a diagnosis handoff artifact

## When Not To Use

Do not use when:

- the root cause is already clear and the user wants implementation
- the task is primarily feature planning or architecture design
- the user wants a direct code change and there is little diagnostic uncertainty
- the problem is too small to justify a structured diagnosis loop
- the work is mainly review, handoff, or article writing rather than diagnosis

## Core Principle

Do not optimize, refactor, or implement before building a bounded diagnosis loop.

A good diagnosis loop answers:

- What exact part of the system is in scope?
- What evidence source has the highest authority?
- What is the shortest repeatable feedback loop?
- What are the current hypotheses?
- What is the minimum instrumentation needed to distinguish them?
- What changed after the latest validation step?

This skill prevents common failure modes:

- starts coding too early
- expands scope without control
- optimizes without a baseline
- treats low-fidelity evidence as final truth
- tests multiple hypotheses at once
- adds too much instrumentation without a purpose
- reports conclusions without preserving the reasoning chain

## Workflow

### Phase 0: Assess Material Sufficiency

Judge whether the available material is enough to proceed.

Classify the material as:

- `Enough`: there is a concrete problem, at least one result, and enough context to begin diagnosis
- `Partial`: the problem is real, but the loop or evidence is incomplete
- `Insufficient`: there is no concrete case, no observable result, or no usable context

Minimum useful material:

- what problem is being observed
- what outcome is undesirable
- what part of the system is suspected or in scope
- what evidence exists now
- what the user wants preserved or avoided

If material is partial or insufficient, ask only for the smallest missing input.

Completion criterion:

- material status is explicitly labeled
- the agent knows whether to proceed, proceed lightly, or stop for missing input

### Phase 1: Bound the Problem

Define what this diagnosis covers and what it does not cover.

Produce:

- a one-paragraph problem statement
- an explicit in-scope list
- an explicit out-of-scope list when useful

The goal is to convert a vague complaint into a bounded diagnostic target.

Completion criterion:

- the diagnosis boundary is clear
- unrelated layers are not mixed into the same investigation
- the user could tell what this skill is and is not trying to explain

### Phase 2: Establish The Feedback Loop

Build the shortest stable loop that can be repeated during the diagnosis.

Identify:

- the primary evidence source
- any auxiliary evidence sources
- the repeatable execution path
- the baseline run or comparison point

Primary evidence should be the highest-fidelity source available for the actual user problem.
Auxiliary evidence can accelerate iteration, but must not silently override the primary source.

Examples of valid loops:

- production-like path plus replay path
- browser baseline plus local replay
- failing test plus reduced fixture
- trace capture plus isolated benchmark

Completion criterion:

- at least one repeatable loop exists
- the primary evidence source is named
- auxiliary evidence is clearly labeled as secondary

### Phase 3: Build The Hypothesis Table

Generate a small set of falsifiable hypotheses.

For each hypothesis include:

- hypothesis
- why it is plausible
- observable signal
- collection method
- condition that would strengthen it
- condition that would weaken or reject it

Keep the list short and prioritizable.

Completion criterion:

- each hypothesis is testable
- each hypothesis has at least one observable signal
- the list is small enough to drive action

### Phase 4: Design Minimum Instrumentation

Add only the instrumentation needed to distinguish the current hypotheses.

Prefer:

- stage timings
- counts
- buffer sizes
- branch usage
- cache hit/miss markers
- simple structured logs

For each new instrumentation point, state:

- which hypothesis it serves
- what signal it will produce
- how it will change the next decision

Completion criterion:

- every added observation point has a clear purpose
- instrumentation is minimal rather than exhaustive
- the next validation step is now possible

### Phase 5: Validate One Hypothesis At A Time

Run one validation step per iteration.

For each step record:

- current hypothesis
- evidence used
- new observation point, if any
- actual result
- conclusion from this step
- next best move

If the result is ambiguous, say so explicitly.
Do not force a root cause from weak evidence.

Completion criterion:

- the current hypothesis is strengthened, weakened, or rejected
- the result of the step is recorded
- the next step is chosen for a reason

### Phase 6: Converge To A Current Best Conclusion

Summarize the current state of the diagnosis.

Separate:

- facts
- evidence
- assumptions
- hypotheses
- decisions
- open questions
- rejected alternatives

Then recommend the next action with a short rationale.

Completion criterion:

- the current best conclusion is explicit
- uncertainty is preserved instead of hidden
- the next action is prioritized, not just listed

## Required Output

Produce a structured diagnosis artifact containing at least:

- `Problem boundary`
- `Material status`
- `Primary evidence source`
- `Auxiliary evidence sources`
- `Feedback loop`
- `Hypothesis table`
- `Instrumentation plan`
- `Validation log`
- `Current best conclusion`
- `Next recommended step`
- `Open questions`

The output must distinguish:

- facts
- evidence
- assumptions
- hypotheses
- decisions
- uncertainty

## Do Not

- Do not modify code before establishing a baseline unless the user explicitly overrides this.
- Do not expand the diagnosis scope without saying so.
- Do not treat auxiliary evidence as stronger than the primary evidence source.
- Do not validate multiple hypotheses in the same step unless the user explicitly wants a fast but lower-certainty pass.
- Do not add broad instrumentation without tying each point to a hypothesis.
- Do not report guesses as conclusions.
- Do not mark the diagnosis complete just because one plausible story exists.
- Do not turn this skill into a general planning or implementation prompt.

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- the diagnosis boundary is changing
- a new feedback loop is being chosen as primary
- substantial instrumentation is about to be added
- the agent is about to recommend a high-impact architectural or optimization direction
- the evidence is weak but a major conclusion is tempting

Checkpoint format:

- Current understanding
- Evidence so far
- Options
- Recommendation
- Tradeoffs
- What happens next

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put reusable method in the skill, not project-specific details.
- Put temporary findings in handoff notes or scratch artifacts.
- Put stable project vocabulary in project docs.
- Put architecture decisions in ADR or equivalent.
- Put benchmark results in reports or handoff, not in the skill.
- Reference existing artifacts instead of duplicating them.
- If a technique is case-specific, label it as an example, not a rule.

## Completion Criteria

The skill is complete when:

- the problem has a clear boundary
- a repeatable feedback loop exists
- primary and auxiliary evidence are distinguished
- hypotheses are explicit and falsifiable
- instrumentation is purpose-driven and minimal
- validation has been recorded step by step
- the current best conclusion is stated with uncertainty
- a prioritized next step is provided

## Suggested Next Skills

- `optimization-prioritization`
- `experiment-matrix-design`
- `session-handoff`
