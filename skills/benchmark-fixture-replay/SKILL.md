---
name: benchmark-fixture-replay
description: >
  Save one real case from a slow, expensive, or inconvenient full workflow, then
  replay that same case repeatedly so future testing is faster and more stable.
  Use when the user does not want to re-run the whole system every time, wants a
  repeatable sample for comparison, or needs a shorter loop for debugging,
  benchmarking, or regression checks.
---

# Benchmark Fixture Replay

## Purpose

Use this skill when running the full real workflow every time is too painful.

In plain terms:

- the real path is slow
- the real path has too many steps
- the real path depends on too many moving parts
- but one real case is worth saving and replaying again and again

This skill helps turn:

- “we have to re-run the whole thing every time”

into:

- “we saved one real case, and now we can replay it quickly whenever we need to test something”

Typical outcomes include:

- a saved real-case fixture bundle
- a replay command or replay path
- a note explaining what the replay still represents well
- a note explaining what the replay no longer covers
- a stable baseline run using that saved case

## When To Use

Use when:

- the user wants to save one real case and reuse it for repeated testing
- the full workflow is too slow, too annoying, too expensive, or too noisy to run every time
- the team wants to compare changes against the same exact sample repeatedly
- debugging or benchmarking keeps getting blocked by UI steps, setup steps, external services, or long preparation time
- the user says things like “can we save this case locally and just replay it”

Also use when the user asks things like:

- can we stop re-running the whole flow every time
- can we save this input and test against it repeatedly
- can we make a local replay from one real example
- can we benchmark using one captured case
- can we turn this real run into a shorter feedback loop

## When Not To Use

Do not use when:

- the main problem is still “we do not even know what to investigate yet”
- replay would remove the very behavior that needs to be tested
- the case is too trivial to justify saving and replaying
- the user needs final truth from the live environment every single time
- there is no useful place in the workflow to capture a representative case

## Core Principle

Do not save a replay case just because it sounds neat.

A saved replay is only useful if it does two things at once:

- keeps enough of the real behavior that future comparisons still mean something
- removes enough of the full workflow that testing becomes much cheaper and faster

In plain language, always ask:

- what real case are we saving
- what parts of the full flow are we skipping next time
- what kind of conclusions can this replay support
- what kind of conclusions still require a full real rerun

This skill prevents common failure modes:

- repeating the whole system manually for every test
- using fake toy input that does not match the real problem
- saving too much and making replay awkward
- saving too little and losing the important behavior
- treating replay results as if they were always equal to live-system truth

## Workflow

### Phase 0: Check Whether Replay Is Worth It

First decide whether saving a replay case is worth the setup.

Replay is usually worth it when:

- one real run already exists
- the current full path is expensive or slow to repeat
- more than one future comparison or debugging step is expected
- there is a stable capture point somewhere in the flow

Completion criterion:

- it is clear that replay will save meaningful future effort

### Phase 1: State What Should Be Preserved

Say clearly what the saved case needs to preserve.

Examples:

- the exact processed input to a rendering core
- one real API request after normalization
- one real failing dataset
- one representative benchmark sample

Also say what does not need to be preserved.

Completion criterion:

- the replay goal is explicit
- everyone knows what part of the real case matters most

### Phase 2: Choose Where To Capture

Pick the point in the workflow where the case should be saved.

A good capture point is:

- close enough to the real problem to stay meaningful
- far enough downstream to skip lots of repeated setup work
- simple enough that replay stays easy

For the chosen point, explain:

- what future work will be skipped
- what core behavior will still be exercised
- what realism will be lost

Completion criterion:

- the capture boundary is explicit and justified

### Phase 3: Define What To Save

List the exact files, payloads, or metadata that must be saved.

Keep the bundle as small as possible while still preserving the useful behavior.

Include:

- required inputs
- required metadata or config
- naming rules if needed
- anything that must stay stable across reruns

Completion criterion:

- the fixture bundle is concrete, minimal, and reusable

### Phase 4: Define How To Replay It

State exactly how future runs should use the saved case.

Include:

- replay command or entry point
- required environment assumptions
- expected output
- how to tell whether replay succeeded
- how future runs will compare against baseline if relevant

Completion criterion:

- someone else could run the replay without rediscovering the process

### Phase 5: Write The Fidelity Note

Document what this replay still represents well and what it no longer covers.

In plain language:

- what is still realistic enough
- what is now simplified
- when replay is good enough
- when the full real workflow still has to be rerun

Completion criterion:

- replay boundaries are explicit
- future users are less likely to over-trust the replay

### Phase 6: Establish The First Baseline

Run or define one baseline using the saved case.

Record:

- which saved case is being used
- how it is replayed
- what the baseline output or metric is
- anything unusual that affects comparison

Completion criterion:

- future reruns have a named starting point for comparison

## Required Output

Produce a replay design artifact containing at least:

- `What real case is being saved`
- `Why full reruns are too expensive or annoying`
- `Capture boundary`
- `What will be saved`
- `How replay will work`
- `What replay still represents well`
- `What replay no longer covers`
- `Baseline run`
- `When full real reruns are still required`
- `Open questions`

The output must distinguish:

- captured facts
- assumptions
- fidelity limits
- excluded behavior
- valid uses
- invalid uses

## Do Not

- Do not save the whole upstream system if a smaller saved case is enough.
- Do not use fake toy input if the point is to preserve a real case.
- Do not make the replay path harder than the original workflow.
- Do not leave replay limits implicit.
- Do not pretend replay is always equivalent to a live rerun.
- Do not save so little that the important behavior disappears.

## User Checkpoints

Before proceeding, present a checkpoint when any of the following is true:

- the best capture point is still unclear
- saving less would be faster but may drop important realism
- saving more would preserve realism but make replay awkward
- replay might be mistaken for live-system truth later
- the user needs to choose between convenience and fidelity

Checkpoint format:

- What case we want to save
- Where we plan to capture it
- What future work this will skip
- What behavior will still be tested
- Recommendation
- Fidelity tradeoff

Then wait for user confirmation unless the user explicitly asked for autonomous continuation.

## Context Hygiene

- Put the reusable method in the skill, not project-specific filenames.
- Put actual saved fixtures and captured data in the repository or benchmark area, not inside the skill text.
- Put stable fixture-format conventions in project docs if they become long-lived.
- Put temporary saved cases in scratch or benchmark directories unless they become canonical.
- If a replay boundary is only valid for one case, label it as case-specific.

## Completion Criteria

The skill is complete when:

- it is clear why replay is worth building
- the replay goal is explicit
- the capture boundary is justified
- the saved bundle is minimal and concrete
- the replay path is easy to use
- replay limits are clearly documented
- a baseline run exists or is clearly defined
- future users know when replay is enough and when full reruns are still needed

## Suggested Next Skills

- `bounded-diagnosis-loop`
- `experiment-result-interpretation`
- `session-handoff`
