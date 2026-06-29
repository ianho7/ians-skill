---
name: loop-engineering
description: Design, review, or implement coding-agent closed loops for long-running software tasks. Use when Codex needs to combine scoped planning, iterative code changes, verification, failure recovery, and stop conditions across multiple rounds instead of relying on one-shot prompting. Trigger for requests about Loop Engineering during coding, Codex `/goal` workflows, agentic implementation loops, retry logic, verifiers, pause/resume, task runners, state machines, "how should the next step be chosen", "why is this coding agent still running", "how does this recover from test failures", or "when should this stop". Use especially when the work should coordinate with `$mvp-plan`, `$plan`, `$checklist`, or goal-based execution.
---

# Loop Engineering

## Overview

Treat the task as a closed loop, not a `while true`.

Optimize for one question on every round: why should the system continue, and what evidence changes the next decision.

Read [references/loop-patterns.md](./references/loop-patterns.md) when you need concrete architecture patterns, layer choices, or anti-patterns.

## Default Usage In Coding Work

Use this skill as the loop orchestrator around other planning skills:

1. Use `$mvp-plan` to cut scope to the smallest shippable loop.
2. Use `$plan` to turn that scope into an implementation path grounded in the repo.
3. Use `$checklist` to break the path into atomic execution and validation tasks.
4. Use this skill to decide how those tasks become a multi-round coding loop with state, verifier, retries, and exits.
5. Use Codex `/goal` when the task is long-running enough that the agent should keep pushing toward the same objective across rounds.

Do not let this skill replace the others.

- `$mvp-plan` decides what not to build.
- `$plan` decides the intended implementation path.
- `$checklist` decides the task granularity and execution order.
- `loop-engineering` decides how the system keeps making progress when reality diverges from the first plan.

## Choose The Loop Level

- Use a workflow-level loop for multi-stage pipelines, DAG execution, role handoffs, stage gates, and revision routing.
- Use a runtime-level loop for a single long-running coding task that needs persistence, retries, pause/resume, evidence, and restart semantics.
- Combine both when pipeline stages themselves are long-running tasks.
- Name the layer you are designing before proposing an architecture. Many bad designs mix workflow and runtime concerns into one muddy loop.

For most coding sessions, start with a runtime-level loop. Only introduce workflow-level orchestration when one agent or one goal is no longer a clear fit.

## Start With A Loop Spec

Write a compact loop spec before editing code. Use this shape unless the task already provides an equivalent artifact:

```md
Goal:
- What concrete deliverable must exist?
- What evidence proves progress?

State:
- What is the source of truth?
- What must persist across rounds?
- What can be summarized or discarded?

Planner:
- How is the next step selected from current state and evidence?
- What causes replanning?

Actor:
- What actions can the system take?
- Which actions are risky, costly, or irreversible?

Observer:
- What raw outputs are captured after actions?
- Where are logs, diffs, test results, and tool outputs stored?

Verifier:
- What independent check decides whether things improved?
- What evidence is required for "done"?

Failure Semantics:
- When should the system retry, switch strategy, narrow scope, or hand off?
- What counters or cooldowns cap repetition?

Exit Conditions:
- Success exit
- Blocked exit
- Budget exit
- Risk exit
- Human takeover exit

Policy:
- Permission boundaries
- Cost limits
- Allowed tools
- Approval requirements
```

If any of these sections are missing, call that out explicitly before implementation.

## Map The Loop To Codex Goal

When the task is long enough to justify `/goal`, bind the loop spec to goal semantics explicitly:

- Goal:
  Use a concrete objective that can survive many rounds without being rewritten.
- Continue condition:
  State what evidence would justify one more round of work.
- Completion condition:
  State what verifiable outcome is required before marking the goal complete.
- Blocked condition:
  State what repeated blocker requires human input or external change before more work is useful.
- Budget boundary:
  State what time, token, cost, or attempt cap should stop the loop even if the ideal outcome is unfinished.

Treat `/goal` as the persistence layer for intent, not as the design of the loop itself.

## Build The Minimal Closed Loop

- Start with the smallest loop that can prove convergence. Do not design the maximum future platform first.
- Separate stable goal from transient observations. Stable goals should not be rewritten every round.
- Keep the verifier independent from the actor. The system that makes the change should not be the only system that declares success.
- Record raw evidence paths or IDs, not only summaries.
- Bound retries by reason and count. "Try again" is not a recovery strategy.
- Make handoff possible. A human should be able to inspect state and understand why the loop is still running.
- Default to a coding loop that can finish Phase 1 before inventing extra agents, orchestrators, or memory layers.

## Design The Core Components

### Goal

- Define a deliverable that can be observed externally.
- Replace vague goals like "fix it" or "help with deployment" with target outcomes, evidence, and constraints.
- Prefer goals that can be decomposed and verified incrementally.
- When possible, phrase the goal as "change these files or behaviors until these validations pass."

### State

- Persist attempts, current phase, blocked reasons, prior failures, evidence pointers, and the rationale for the next step.
- Keep a source-of-truth state object or event log. Do not rely on the context window as the only memory.
- Compress history aggressively. Preserve raw evidence separately from reasoning summaries.
- In coding work, the minimum useful state usually includes touched files, failed commands, test status, current hypothesis, and remaining scope.

### Planner

- Replan from current state instead of trusting an initial perfect plan.
- Select the next step from dependencies, evidence, and failure history.
- When multiple next actions are possible, state the decision rule. Examples: cheapest verifier first, unblock highest-dependency node first, or rerun only the failed phase.
- Reuse `$mvp-plan`, `$plan`, and `$checklist` outputs as planner inputs instead of regenerating strategy from scratch on every round.

### Actor

- Keep actions small and reversible where possible.
- Label risky operations before running them.
- Prefer idempotent actions for restartability.
- In coding tasks, prefer the smallest edit that can falsify the current hypothesis.

### Observer

- Capture raw outputs from tools, tests, logs, diffs, and API responses.
- Distinguish observations from interpretations. First record what happened, then infer what it means.
- Record whether failures came from code, environment, permissions, flaky tests, or incorrect assumptions.

### Verifier

- Use independent checks such as tests, lint, typecheck, static analysis, diff review, schema validation, or policy checks.
- Refuse self-certification. "The agent said DONE" is not evidence.
- Define what constitutes progress, not just completion.
- Prefer cheap verifiers before expensive ones: focused test, then broader suite, then manual review if needed.

### Failure Recovery

- Classify failures: transient, strategy, environment, policy, or unknown.
- Retry only when the failure class justifies retry.
- Change strategy after repeated failures. Narrow scope, use a different tool, ask for approval, or hand off.
- Keep retry budgets explicit per phase or per error type.
- Do not treat repeated test failure as a reason to keep editing blindly. Update the hypothesis or stop.

### Exit Conditions

- Stop on success when evidence meets the goal.
- Stop as blocked when the system cannot make meaningful progress without outside input or an environment change.
- Stop on budget when cost, time, or attempt caps are exhausted.
- Stop on risk when the next action exceeds policy.
- Stop on handoff when a human decision is now the fastest path.
- Keep "complete" and "blocked" honest. A messy partial implementation with failing checks is not complete just because the agent ran for a long time.

### Policy

- Encode permission boundaries, allowed mutations, approval requirements, model/tool routing, and spend limits.
- Treat policy as part of the loop, not a separate afterthought.
- In coding sessions, explicitly separate read-only inspection, safe local edits, expensive validation, and privileged operations.

## Recommended Sequence

For software delivery work, prefer this sequence:

1. Clarify the requested outcome and validation signal.
2. Use `$mvp-plan` if scope is ambiguous or at risk of over-engineering.
3. Use `$plan` to map the change onto actual files, modules, and commands.
4. Use `$checklist` if the implementation has enough moving parts that task ordering and reflection matter.
5. Decide whether a normal coding session is enough or whether `/goal` is justified.
6. Run the loop:
   inspect -> choose next task -> edit -> verify -> update state -> continue, replan, block, or stop

If the work is small and can be finished in one short edit/verify pass, do not force `/goal`.

## Decide When To Use Goal

Use `/goal` when most of these are true:

- The task will require many rounds
- Validation is not immediate
- State will matter across interruptions
- The agent may need to revisit earlier failures
- You want explicit complete vs blocked lifecycle

Do not use `/goal` just because the task sounds important. Use it when persistence and repeated decision-making actually matter.

## Coding Loop Template

Use this compact template for implementation-heavy tasks:

```md
Objective:
- Deliver <specific code or behavior change>

Phase Source:
- MVP scope from `$mvp-plan` or scope assumption
- Execution phases from `$plan`
- Atomic tasks from `$checklist`

Current State:
- Relevant files:
- Current phase/task:
- Last verification result:
- Current hypothesis:
- Remaining scope:

Next Action Rule:
- Pick the smallest task that can change verification state.

Verifier Order:
1. Focused local check
2. Relevant tests/lint/typecheck
3. Broader regression check if needed

Failure Policy:
- Retry once for transient issues
- Replan after repeated logic failure
- Block on missing permissions, missing environment, or unclear product choice

Stop Rule:
- Stop complete when required evidence exists
- Stop blocked when new progress requires outside input
- Stop budgeted when further rounds are low-yield
```

## Review Existing Loops

When reviewing an existing agent loop, inspect it in this order:

1. Find the source of truth for state.
2. Find the independent verifier.
3. Find the retry and strategy-switch logic.
4. Find the stop conditions.
5. Find the human takeover path.
6. Find whether planning outputs from `$mvp-plan`, `$plan`, or `$checklist` are being preserved or silently discarded.

If any item is missing, explain how the loop can drift, stall, or become a token sink.

## Output Expectations

When using this skill, produce artifacts that another engineer can execute against:

- A loop spec or architecture note
- A state model or event/state transition table
- A verifier plan
- Failure semantics and retry limits
- Exit conditions
- A short risk register
- A recommendation for whether to use `/goal`
- A mapping to `$mvp-plan`, `$plan`, and `$checklist` outputs when those skills are in play

If implementing code, map the design to concrete files, state containers, and verification entry points.

## Common Smells

- Infinite retry with no strategy change
- Actor and verifier collapsed into one component
- No persisted state outside the prompt/context window
- Full history replayed every round with no compression boundary
- "Completed" declared without raw evidence
- No distinction between blocked, failed, and waiting
- No explicit stop path
- The loop regenerates plans each round but never commits to one executable next task
- `/goal` is created before scope is cut down, so the agent persists a bloated objective
- Planning skills are used as one-shot documents and never feed the next-round decision logic
