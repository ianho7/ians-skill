# Ticket Flow Orchestration

Load this reference when the input contains multiple approved Tickets or a Ticket dependency graph.

The goal is to advance the graph with minimal state, not to create a workflow platform.

## 1. Load the graph

Read each Ticket's identifier and dependencies from the authoritative Ticket artifacts.

Do not redefine Ticket scope, dependencies, or Acceptance Criteria merely to simplify scheduling.

Validate enough graph structure to proceed safely:

- referenced dependencies exist;
- a Ticket does not depend on itself;
- obvious dependency cycles are surfaced rather than executed;
- Ticket identifiers are unambiguous.

Do not introduce a registry, database, queue service, or event system.

## 2. Minimal workflow state

Persist only the control information that must survive worker boundaries.

Example:

```yaml
tickets:
  "01": { status: pass }
  "02": { status: pending }
  "03": { status: pending }
  "04": { status: running }
```

Keep Ticket metadata in the Ticket artifacts rather than copying it into workflow state unless a small reference is needed.

Recommended workflow statuses:

```text
pending
running
pass
escalated
```

Do not persist derived statuses such as `READY` or `BLOCKED_BY_02` unless the host runtime requires them.

## 3. Derive READY tickets

A pending Ticket is READY when all of its declared dependencies are `pass`.

```text
READY(ticket) =
  ticket.status == pending
  AND every dependency.status == pass
```

Before dispatching a READY Ticket, run the lightweight Ticket validity gate from `SKILL.md`.

Do not run a new planning pass simply because the Ticket is about to execute.

## 4. Dispatch model

Each Ticket should normally be a context island:

```text
Orchestrator
  ↓
fresh Implementer context
  ↓
compact outcome
  ↓
fresh Reviewer / Verifier context
  ↓
compact outcome
  ↓
Orchestrator
```

Do not carry prior Ticket conversations into a new Ticket merely for convenience.

Pass only the current Ticket, necessary repository context, current per-Ticket state, and relevant artifacts.

## 5. Parallelism

If multiple Tickets are READY, the DAG permits them to run independently; it does not require parallel execution.

Run mutation workers in parallel only when the host provides safe isolation or concurrency-safe workspace handling.

If safe isolation is unavailable or uncertain, execute READY Tickets sequentially.

Do not automatically create Git branches, stashes, or worktrees merely to enable parallelism.

Independent read-only verification work may be parallelized when safe and useful.

## 6. Failure propagation

### PASS

Mark the Ticket `pass`. Recompute the READY frontier.

### FAIL_BLOCKING

Keep the Ticket active while its bounded repair loop runs.

Dependents remain not-ready.

Other independent READY branches may continue.

### FAIL_NON_BLOCKING

If required Acceptance Criteria are satisfied, normalize workflow status to `pass`, retain the non-blocking findings compactly, and recompute readiness.

### PLAN_INVALID

Replan only the current Ticket by default.

Do not rewrite the whole project plan or regenerate the entire Ticket set.

After a local replan passes, downstream Tickets are not proactively rewritten. Their own validity gates catch stale assumptions when they become candidates for execution.

If the Ticket exceeds the allowed automatic replan, mark it `escalated`.

Its dependents remain blocked, while unrelated branches may continue.

## 7. Ticket scope boundary

A worker assigned Ticket N may implement only what is necessary to satisfy Ticket N.

Do not pre-build Ticket N+1 or create generalized infrastructure solely for downstream convenience unless Ticket N itself requires it.

If future work is discovered, record it compactly and leave it for the appropriate downstream Ticket.

This boundary preserves attribution, context isolation, and reliable acceptance.

## 8. Verification scope

Each Ticket is proved against its own Acceptance Criteria.

Do not automatically:

- run the full repository test suite;
- execute the complete release loop;
- re-prove all prerequisite Tickets;
- validate downstream features that are outside the current Ticket.

Use minimum sufficient evidence.

A final integration or release Ticket may legitimately require broad project-level verification because its own Acceptance Criteria say so. Do not hard-code special behavior based on Ticket number or graph position.

## 9. No-progress detection

Continue while either:

- at least one worker is making progress; or
- at least one pending Ticket can become READY and be dispatched.

If unfinished Tickets remain, no worker is active, and there is no READY Ticket, stop instead of spinning.

Report the smallest useful blocking explanation, such as:

```text
missing dependency
cycle
escalated prerequisite
invalid Ticket reference
no safe execution path
```

Do not ask the user to manually schedule the next Ticket when the graph itself determines what is ready.

## 10. Completion

The workflow is complete when every required Ticket has normalized to `pass`.

At completion, report a compact workflow outcome rather than replaying every worker's history.

Prefer:

```text
completed tickets
non-blocking findings that remain relevant
any release/integration result required by the Tickets
```

Keep detailed implementation history out of the final orchestration summary unless the user asks for it.
