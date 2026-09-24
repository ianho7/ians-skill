---
name: ticket-flow
description: Advance an approved Ticket or Ticket DAG through scoped implementation, independent verification, bounded repair, and dependency-aware orchestration. Reuse Ticket plans instead of replanning. Use only when explicitly invoked by the user.
---

# Ticket Flow

Use this skill only when the user explicitly invokes or references it.

Do not auto-trigger based on task complexity.

`ticket-flow` consumes work that has already been defined. A Ticket is the authoritative local execution plan.

```text
upstream planning / to-tickets
            ↓
      approved Ticket DAG
            ↓
         ticket-flow
            ↓
 Build → Prove → advance graph
```

The core rule is:

```text
to-tickets defines the work.
ticket-flow advances the work.
```

Do not re-plan an authoritative Ticket merely because a different implementation might be preferable.

## 1. Inputs

Support two normal inputs:

```text
Single approved Ticket
Ticket set / Ticket DAG
```

For a single Ticket:

```text
Ticket
  ↓
Validity Gate
  ↓
Build
  ↓
Prove
```

For multiple Tickets:

```text
Load DAG
  ↓
derive READY tickets
  ↓
Build + Prove each ready ticket
  ↓
PASS unlocks dependents
  ↓
repeat until complete or no progress is possible
```

If multiple approved Tickets or a Ticket directory are provided, load `references/orchestration.md`.

A Ticket validity check is lightweight. Confirm only that:

- its dependencies are satisfied before execution;
- its assumptions still match the current repository state;
- its Acceptance Criteria are actionable enough to verify;
- no new fact materially invalidates the Ticket.

The validity gate is not a quality review and must not redesign, expand, or optimize the Ticket.

## 2. Preferences

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

Preferences should stay small and cover user-controlled execution choices such as:

```yaml
implementer:
  model: ...
  reasoning: ...

reviewer:
  model: ...
  reasoning: ...

replanner:
  model: ...
  reasoning: ...

max_repair_rounds: 3
```

`replanner` is a recovery role used only after `PLAN_INVALID`; if omitted, it inherits the Reviewer profile.

If usable preferences already exist, start immediately.

If configuration work is needed, load `references/configuration.md`.

References provide progressive detail, not required control flow. If a reference cannot be loaded, continue with the core rules in this file; do not block solely because a reference is unavailable or invent replacement policy.

## 3. Orchestration

The invoking agent acts as the Orchestrator.

Workers do specialist work; the Orchestrator owns workflow transitions.

The Orchestrator MUST:

- load the Ticket or Ticket DAG;
- maintain minimal canonical workflow and per-Ticket state;
- derive which Tickets are READY from dependency status;
- dispatch fresh workers for Build and Prove;
- construct minimal context for each worker instead of forwarding full prior conversations;
- receive Session Outcomes and update state;
- enforce Ticket scope, repair limits, replan limits, and stop conditions;
- continue independent branches when another branch is blocked and safe progress remains.

Prefer hub-and-spoke handoffs:

```text
Worker → Orchestrator → next Worker
```

Workers report outcomes. They do not own the workflow state machine.

The Orchestrator coordinates; it should not duplicate implementation or acceptance work.

## 4. Build

The Implementer executes exactly one current Ticket.

The Ticket's scope, Acceptance Criteria, out-of-scope items, and implementation boundary are the execution boundary.

The Implementer may inspect the repository, modify files, and run development-time checks or tests.

It may self-test, but its own checks are not authoritative acceptance evidence.

```text
self-test ≠ independent acceptance
```

Do not pre-implement downstream Tickets merely because future work is visible or seems convenient.

If useful future work is discovered, record it without implementing it unless the current Ticket requires it.

If a material Ticket assumption is false and the approved Ticket can no longer be executed as written, return `PLAN_INVALID` with the concrete invalid assumption. Do not silently redesign the Ticket.

Return the implementation result and a compact Session Outcome to the Orchestrator.

## 5. Prove

The Independent Reviewer / Verifier proves the current Ticket, not the whole project, unless the Ticket's own Acceptance Criteria explicitly require project-level verification.

Use an independent subagent or isolated context whenever the host runtime supports it.

The Orchestrator MUST construct a fresh verification context rather than copying or forking the Implementer's full conversation.

Provide only what is needed, typically:

```text
Current Ticket
Current Ticket State
Current diff or relevant code
Relevant validation artifacts
Open blockers, if any
```

The Reviewer may independently inspect code, run tests or evals, reproduce failures, and inspect artifacts as needed.

Never mark a criterion verified solely because another agent claims it passed.

```text
claim ≠ evidence
```

Use minimum sufficient evidence for the current Ticket. Do not automatically run whole-project or release verification unless the Ticket requires it.

Choose verification methods according to the product behavior:

```text
deterministic
ai_behavioral
hybrid
```

For deterministic behavior, use normal executable or observable verification.

For AI behavior, verify hard invariants strictly while evaluating generative quality with outcome-oriented criteria and representative evidence. Do not constrain valid variation unless exact output is part of the product contract.

For hybrid products, apply the appropriate method per criterion.

If AI-behavioral or hybrid verification is materially involved, load `references/verification.md`.

After a repair, verify the repaired blocker and then reconsider the complete Acceptance Criteria of the current Ticket. Do not automatically re-prove already completed prerequisite Tickets.

## 6. State

Keep workflow state explicit and small.

### Workflow State

For a Ticket DAG, retain only what must survive orchestration boundaries, for example:

```yaml
tickets:
  "01":
    source: issues/01.md
    depends_on: []
    status: pass
  "02":
    source: issues/02.md
    depends_on: ["01"]
    status: running
  "03":
    source: issues/03.md
    depends_on: ["02"]
    status: pending
```

Do not persist `READY` or `BLOCKED_BY_*` when they can be derived from Ticket dependencies and current statuses.

### Per-Ticket State

Keep transient control state separate from the Ticket artifact:

```yaml
ticket: issues/02.md
phase: build
repair_round: 0
replan_count: 0
open_blockers: []
```

The Ticket remains the authoritative source for its objective, scope, dependencies, Acceptance Criteria, and boundaries. Do not duplicate the whole Ticket into state.

State is a control plane, not a transcript, reasoning log, test log, or implementation diary.

## 7. Outcomes and Transitions

The Reviewer returns one primary result:

```text
PASS
FAIL_BLOCKING
FAIL_NON_BLOCKING
PLAN_INVALID
```

The Orchestrator owns the transition.

### PASS

Mark the Ticket `pass`. Its dependents may become READY.

### FAIL_BLOCKING

Keep the Ticket active, record only verified blockers, increment `repair_round`, and dispatch a focused repair.

Downstream Tickets that depend on it remain blocked, but unrelated READY branches may continue.

Stop automatic repair when `max_repair_rounds` is reached. Escalate that Ticket instead of continuing blind fixes.

### FAIL_NON_BLOCKING

If required Acceptance Criteria are satisfied, normalize the workflow status to `pass`, record the non-blocking findings, and continue the DAG.

Do not enter an optimization loop for optional improvements.

### PLAN_INVALID

Treat this as local recovery for the current Ticket, not permission to rewrite the project plan or re-split the entire DAG.

Allow one automatic targeted replan of the current Ticket:

```text
first PLAN_INVALID
→ replan_count = 1
→ Replanner
→ Build
→ Prove
```

If the same Ticket reaches `PLAN_INVALID` again after that automatic replan, escalate it and stop automatic work on that Ticket.

Do not proactively replan downstream Tickets. When they later become candidates for execution, their own validity gate determines whether upstream changes invalidated them.

## 8. DAG Progress

For multiple Tickets, repeatedly derive the READY frontier from the graph and current statuses.

DAG edges indicate legal concurrency, not mandatory concurrency.

Run READY Tickets in parallel only when the host runtime provides safe execution isolation or concurrency-safe workspace handling. Otherwise execute them sequentially.

Do not mutate the user's Git workflow merely to create parallelism.

If unfinished Tickets remain but none can run and no worker is making progress, stop and report the blocking condition instead of spinning.

For detailed DAG loading, readiness, parallelism, failure propagation, and no-progress handling, use `references/orchestration.md`.

## 9. Session Outcome

Every Implementer, Reviewer / Verifier, and Replanner session MUST end with one compact Session Outcome returned to the Orchestrator.

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
Simply: Ticket 03 meets AC1/2, but AC3 is blocked by a compatibility regression; next: repair AC3 only.
```

Completion example:

```text
Simply: Ticket 03 is independently verified; its dependents may now advance.
```

Session Outcome is the Worker → Orchestrator handoff. Once state is updated, old outcomes are no longer authoritative.

## 10. Safety and Scope

Do not alter the user's Git workflow unless explicitly requested.

Do not automatically create branches, commits, stashes, resets, or worktrees merely to support this skill.

Keep each Ticket context-isolated where practical. A new Ticket should normally receive a fresh Build context and a fresh Prove context rather than inheriting previous Ticket conversations.

Keep the workflow thin. Preserve only the coordination rules that independent agents cannot reliably infer across Tickets, sessions, repair rounds, and context compaction; leave ordinary engineering judgment to the host code agent.
