---
name: ticket-flow
description: Advance an approved Ticket or Ticket DAG through dedicated per-Ticket execution sessions, scoped implementation, independent verification, bounded repair, and dependency-aware orchestration. Reuse Ticket plans instead of replanning. Use only when explicitly invoked by the user.
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
Dedicated Ticket Session
  ↓
Build → Prove
```

For multiple Tickets:

```text
Load DAG
  ↓
derive READY tickets
  ↓
create one dedicated execution Session per dispatched Ticket
  ↓
Ticket Session runs Build + Prove locally
  ↓
compact Ticket Outcome returns to Workflow Session
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

## 3. Session Architecture and Orchestration

Use two orchestration layers.

### Workflow Session

The invoking Session is the thin Workflow Orchestrator.

It owns only workflow-level control:

- load the Ticket or Ticket DAG;
- maintain minimal workflow state;
- derive which Tickets are READY;
- create a dedicated execution Session/context for each dispatched Ticket;
- receive one compact terminal Ticket Outcome from each Ticket Session;
- update Ticket status and unlock dependents;
- enforce graph-level stop conditions;
- continue independent branches when another branch is blocked and safe progress remains.

The Workflow Session must not absorb Ticket implementation history, test logs, repair dialogue, or Reviewer conversations.

```text
Ticket Session → compact Ticket Outcome → Workflow Session
```

### Ticket Session

One Ticket should have one dedicated execution Session when the host supports user-visible or independently traceable Sessions/threads/tasks.

```text
One Ticket → one execution Session
```

Inside that Ticket Session:

- the main agent acts as the Implementer and local Ticket orchestrator;
- Build, self-check, repair, and local `PLAN_INVALID` recovery stay in that Session;
- authoritative Prove runs through a fresh independent Reviewer / Verifier subagent or isolated context;
- Reviewer findings return to the Ticket Session, not directly to the Workflow Session;
- the Ticket Session resolves bounded repair/review cycles before returning a terminal outcome.

Prefer a dedicated traceable Ticket Session over running every Ticket as a child subagent of one large Workflow Session.

If the host cannot create separate traceable Sessions, fall back to a fresh isolated Ticket subagent/context. Preserve the same isolation and compact-handoff rules.

The Workflow Session coordinates Tickets; the Ticket Session coordinates the lifecycle of one Ticket.

## 4. Build

Within the Ticket Session, the main agent acts as the Implementer.

The Ticket's scope, Acceptance Criteria, out-of-scope items, and implementation boundary are the execution boundary.

The Implementer may inspect the repository, modify files, and run development-time checks or tests.

It may self-test, but its own checks are not authoritative acceptance evidence.

```text
self-test ≠ independent acceptance
```

Do not pre-implement downstream Tickets merely because future work is visible or seems convenient.

If useful future work is discovered, record it without implementing it unless the current Ticket requires it.

If a material Ticket assumption is false and the approved Ticket can no longer be executed as written, treat it as `PLAN_INVALID`. Do not silently redesign the Ticket.

Keep Build details inside the Ticket Session.

## 5. Prove

The Ticket Session must obtain independent acceptance before it can report success upstream.

Spawn a fresh Reviewer / Verifier subagent or isolated context inside the Ticket Session whenever the host supports it.

The Ticket Session constructs a fresh verification context rather than forwarding its full implementation conversation.

Provide only what is needed, typically:

```text
Current Ticket
Current Ticket State
Current diff or relevant code
Relevant validation artifacts
Open blockers, if any
```

The Reviewer proves the current Ticket, not the whole project, unless the Ticket's own Acceptance Criteria explicitly require project-level verification.

The Reviewer may independently inspect code, run tests or evals, reproduce failures, and inspect artifacts as needed.

Never mark a criterion verified solely because the Implementer claims it passed.

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

Keep state explicit and small at both layers.

### Workflow State

The Workflow Session retains only what must survive across Ticket Sessions, for example:

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
    session_ref: <optional host reference>
  "03":
    source: issues/03.md
    depends_on: ["02"]
    status: pending
```

A `session_ref` may be retained when the host exposes a stable reference and it improves traceability. Do not invent one when the host does not provide it.

Do not persist `READY` or `BLOCKED_BY_*` when they can be derived from Ticket dependencies and current statuses.

### Per-Ticket State

The Ticket Session maintains only its local control state:

```yaml
ticket: issues/02.md
phase: build
repair_round: 0
replan_count: 0
open_blockers: []
```

The Ticket remains the authoritative source for its objective, scope, dependencies, Acceptance Criteria, and boundaries. Do not duplicate the whole Ticket into state.

State is a control plane, not a transcript, reasoning log, test log, or implementation diary.

## 7. Ticket-Local Outcomes and Transitions

The Reviewer returns one primary verdict to the Ticket Session:

```text
PASS
FAIL_BLOCKING
FAIL_NON_BLOCKING
PLAN_INVALID
```

The Ticket Session owns these local transitions.

### PASS

Finish the Ticket Session successfully and return a compact `pass` outcome to the Workflow Session.

### FAIL_BLOCKING

Record only verified blockers, increment `repair_round`, repair inside the same Ticket Session, then spawn a fresh Reviewer / Verifier again.

Stop automatic repair when `max_repair_rounds` is reached. Return an escalated Ticket Outcome instead of continuing blind fixes.

### FAIL_NON_BLOCKING

If required Acceptance Criteria are satisfied, treat the Ticket as successful, retain the non-blocking findings compactly, and return `pass` to the Workflow Session.

Do not enter an optimization loop for optional improvements.

### PLAN_INVALID

Treat this as local recovery for the current Ticket, not permission to rewrite the project plan or re-split the entire DAG.

Allow one automatic targeted replan inside the Ticket Session:

```text
first PLAN_INVALID
→ replan_count = 1
→ Replanner
→ Build
→ Prove
```

If the same Ticket reaches `PLAN_INVALID` again after that automatic replan, stop automatic work on that Ticket and return an escalated outcome to the Workflow Session.

Do not proactively replan downstream Tickets. When they later become candidates for execution, their own validity gate determines whether upstream changes invalidated them.

## 8. Workflow-Level Outcomes and DAG Progress

The Workflow Session should receive only terminal Ticket outcomes such as:

```text
pass
escalated
```

A compact outcome may also include:

```text
non-blocking findings
artifact / commit / host session reference when available
blocking reason when escalated
```

Do not forward the Ticket Session's full repair or verification history upstream.

For multiple Tickets, repeatedly derive the READY frontier from the graph and current terminal statuses.

DAG edges indicate legal concurrency, not mandatory concurrency.

Run READY Ticket Sessions in parallel only when the host runtime provides safe execution isolation or concurrency-safe workspace handling. Otherwise execute them sequentially.

Do not mutate the user's Git workflow merely to create parallelism.

If unfinished Tickets remain but none can run and no Ticket Session is making progress, stop and report the blocking condition instead of spinning.

For detailed DAG loading, readiness, parallelism, failure propagation, and no-progress handling, use `references/orchestration.md`.

## 9. Session Outcome

Every Ticket Session MUST return one compact terminal Session Outcome to the Workflow Session.

Internal Implementer, Reviewer / Verifier, and Replanner steps may also use compact outcomes locally, but the Workflow Session should not receive those intermediate details.

Do not end with a narrative recap or large Summary section.

The user should immediately be able to see:

```text
what completed
what is blocked
why
what happens next
```

Prefer one sentence and omit empty parts.

Successful Ticket example:

```text
Simply: Ticket 03 is independently verified and complete; next: unlock its dependents.
```

Escalated Ticket example:

```text
Simply: Ticket 03 still fails AC3 after bounded repair because the compatibility assumption is invalid; next: keep dependents blocked and surface the escalation.
```

Once Workflow State is updated, old Ticket outcomes are no longer authoritative.

## 10. Safety and Scope

Do not alter the user's Git workflow unless explicitly requested.

Do not automatically create branches, commits, stashes, resets, or worktrees merely to support this skill.

Keep each Ticket context-isolated. A new Ticket should normally receive a dedicated fresh execution Session, and each Prove should use a fresh independent verification context.

Keep the workflow thin. Preserve only the coordination rules that independent agents cannot reliably infer across Tickets, Sessions, repair rounds, and context compaction; leave ordinary engineering judgment to the host code agent.
