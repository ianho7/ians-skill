---
name: plan-build-prove
description: Run a bounded plan → build → prove workflow using optional planning, implementation, independent verification, explicit task state, adaptive verification, and compact session outcomes. Use only when explicitly invoked by the user.
---

# Plan Build Prove

Use this skill only when the user explicitly invokes or references it.

Do not auto-trigger based on task complexity.

The purpose of this skill is to coordinate a high-value plan → build → prove loop without turning the host code agent into a heavyweight workflow engine.

```text
Plan  = Architect when needed
Build = Implementer
Prove = Independent Reviewer / Verifier
```

```text
Architect (when needed)
        ↓
Implementer
        ↓
Independent Reviewer / Verifier
        │
        ├── PASS → Done
        ├── FAIL_NON_BLOCKING → Done + suggestions
        ├── FAIL_BLOCKING → Repair → Review again
        └── PLAN_INVALID → Replan
```

## 1. Preferences

Resolve preferences in this order:

```text
Invocation override
        ↓
Project preferences
        ↓
System preferences
        ↓
Built-in defaults
```

Higher-precedence values override only the fields they specify.

Preferences should remain small and cover only user-controlled execution choices such as:

```yaml
architect:
  model: ...
  reasoning: ...

implementer:
  model: ...
  reasoning: ...

reviewer:
  model: ...
  reasoning: ...

max_repair_rounds: 3
```

If usable preferences already exist, start immediately.

If no saved preferences exist, perform a single-shot first-use setup: present recommended defaults, allow the user to accept or override them, ask whether to save them at System or Project scope, then continue the original task without requiring reinvocation.

For preference paths, merge rules, schema details, and first-use behavior, load:

```text
references/configuration.md
```

only when configuration work is actually needed.

References provide progressive detail, not required control flow. If a referenced file cannot be loaded, continue with the core rules in this file; do not block the task solely because a reference is unavailable or invent replacement policy.

## 2. Task Contract

Before implementation, establish a stable task contract.

At minimum preserve:

```text
Goal
Constraints
Acceptance Criteria
Non-goals
```

Create or reuse an implementation plan as needed. Do not require a new architecture pass when an authoritative and still-valid plan already exists.

If implementation evidence later proves a material plan assumption invalid, replan instead of patching around a broken design.

## 3. Roles

### Architect

Use an Architect when a new plan or replan is materially useful.

The Architect establishes the task contract and a workable implementation direction. Keep the output proportional to the task; do not force a large planning document.

### Implementer

The Implementer performs the code changes.

It may inspect the repository, modify files, and run development-time checks or tests.

The Implementer may self-test, but its own checks are not authoritative acceptance evidence.

```text
self-test ≠ independent acceptance
```

The Implementer must not silently redefine the Goal, Constraints, Acceptance Criteria, or Non-goals.

If the approved plan cannot work because a material assumption is false, return `PLAN_INVALID` with the concrete invalid assumption.

### Independent Reviewer / Verifier

The Reviewer is responsible for independent verification and the final acceptance judgment.

Use an independent subagent or isolated context whenever the host runtime supports it.

Do not simulate independent review merely by switching roles inside the Implementer's context when true isolation is available.

When spawning the Reviewer, the orchestrating agent MUST construct a fresh review context instead of copying or forking the Implementer's full conversation.

Provide only what the Reviewer needs, typically:

```text
Task State
Acceptance Criteria
Current diff or relevant code
Validation context or artifacts
Open blockers, if any
```

Do not provide the Implementer's full reasoning history unless strictly necessary.

The Reviewer must judge whether the current result satisfies the task contract, not whether it matches the Reviewer's preferred implementation.

Never mark a criterion verified solely because another agent claims it passed.

```text
claim ≠ evidence
```

## 4. Verification

Choose verification methods according to the product behavior.

Use one of these profiles when useful:

```text
deterministic
ai_behavioral
hybrid
```

For deterministic behavior, use normal executable or observable verification.

For AI behavior, verify hard invariants strictly but evaluate generative quality with outcome-oriented criteria, representative cases, and inspectable evidence. Do not constrain valid variation unless exact output is part of the product contract.

For hybrid products, apply the appropriate method per acceptance criterion.

Each acceptance criterion should make clear:

```text
what must be true
how it can be verified
current status
```

A lightweight form is enough:

```yaml
acceptance:
  - id: AC1
    require: Legacy output remains compatible
    verify: bun test test/compat.test.ts
    status: pending
```

If AI-behavioral or hybrid verification is materially involved, load:

```text
references/verification.md
```

Do not load that reference for ordinary deterministic work unless needed.

Before final `PASS` or `FAIL_NON_BLOCKING`, reconsider the complete acceptance contract against the current implementation. Fixing one blocker is not sufficient if the repair regressed something that previously passed.

This does not require blindly running the entire repository test suite after every edit. Use the smallest evidence set that still provides justified confidence.

## 5. Explicit Task State

Maintain a small canonical Task State for the current task.

Its purpose is to preserve facts across independent agents, repair rounds, long-running sessions, and context compaction.

Task State is a control plane, not a transcript or reasoning log.

Keep only what must survive agent boundaries.

Recommended shape:

```yaml
goal: ...
constraints: [...]
acceptance: [...]
non_goals: [...]
phase: implement
repair_round: 0
replan_count: 0
open_blockers: []
```

Do not store complete conversations, reasoning traces, large test logs, or implementation diaries in Task State.

If a field can be safely derived from current state, do not persist it merely for convenience.

## 6. Loop

The Reviewer returns one primary status:

```text
PASS
FAIL_BLOCKING
FAIL_NON_BLOCKING
PLAN_INVALID
```

### PASS

All required acceptance criteria have sufficient current evidence.

Stop the loop.

### FAIL_BLOCKING

One or more verified issues materially prevent acceptance.

Record only the blocking findings, return them to the Implementer, and repair those blockers without restarting the entire implementation unless replanning occurred.

After repair:

```text
verify repaired blocker
        ↓
re-evaluate full acceptance contract
        ↓
PASS / FAIL
```

### FAIL_NON_BLOCKING

Required outcomes are satisfied but optional improvements remain.

Stop the automatic loop and report the suggestions separately.

Do not automatically repair them.

### PLAN_INVALID

A material assumption in the approved plan is invalid.

Allow one automatic replan. Increment `replan_count`, return to the Architect for targeted replanning, then resume implementation.

If `PLAN_INVALID` occurs again after an automatic replan, stop the automatic loop and escalate instead of continuing architecture churn. The user may explicitly choose to continue.

### Repair limit

Never use an unbounded "repeat until approved" loop.

Stop automatic repair when the configured repair limit is reached.

At that point:

```text
stop modifying
identify the unresolved blocker
identify the assumption most likely to be wrong
recommend one concrete next action
```

After repeated failed repairs, question the assumption rather than increasing activity.

Keep one primary next action at a time and suppress unrelated improvements during the active loop.

Choosing not to continue repairing or optimizing is a valid outcome.

## 7. Session Outcome

Every Architect, Implementer, and Reviewer session MUST end with one compact Session Outcome.

Do not end with a narrative recap or large Summary section.

The user should immediately be able to see:

```text
what completed
what is blocked
why
what happens next
```

Prefer one sentence and omit empty parts.

Example:

```text
Simply: AC1/2 pass; AC3 is blocked by a compatibility regression; next: repair AC3 only.
```

If nothing is blocked:

```text
Simply: implementation is complete and local self-checks pass; next: independent review.
```

For completion:

```text
Simply: all required acceptance criteria are independently verified; the task is complete.
```

Session Outcome is also the compact handoff to the next agent. Once Task State is updated, old outcomes are no longer authoritative.

## 8. Safety and Scope

Do not alter the user's Git workflow unless explicitly requested.

Do not automatically create branches, commits, stashes, resets, or worktrees merely to support this skill.

Keep the workflow thin. Preserve only the coordination rules that independent agents cannot reliably infer across sessions and repair rounds; leave ordinary engineering judgment to the host code agent.
