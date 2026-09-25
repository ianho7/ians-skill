# Ticket Flow Orchestration

Load this reference when the input contains multiple approved Tickets or a Ticket dependency graph.

The goal is to advance the graph with minimal workflow state while keeping each Ticket independently traceable.

## 1. Two-layer orchestration

Use two layers:

```text
Workflow Session
  ↓ creates
Ticket Session
  ↓ spawns
Reviewer / Verifier context
```

### Workflow Session

Owns the DAG only:

```text
load graph
derive READY frontier
start Ticket Sessions
receive terminal Ticket Outcomes
update statuses
unlock dependents
stop on completion or no-progress
```

It should not contain Ticket implementation history, local repair dialogue, or Reviewer transcripts.

### Ticket Session

Owns one Ticket from dispatch to terminal outcome:

```text
validity gate
↓
Build
↓
self-check
↓
fresh independent Prove
↓
repair / local replan when needed
↓
terminal Ticket Outcome
```

Prefer one dedicated, independently traceable Session/thread/task per Ticket when the host supports it.

If the host cannot create such Sessions, use a fresh isolated Ticket subagent/context as the fallback.

## 2. Load the graph

Read each Ticket's identifier and dependencies from the authoritative Ticket artifacts.

Do not redefine Ticket scope, dependencies, or Acceptance Criteria merely to simplify scheduling.

Validate enough graph structure to proceed safely:

- referenced dependencies exist;
- a Ticket does not depend on itself;
- obvious dependency cycles are surfaced rather than executed;
- Ticket identifiers are unambiguous.

Do not introduce a registry, database, queue service, or event system.

## 3. Minimal workflow state

Persist only the control information that must survive Ticket Session boundaries.

Example:

```yaml
tickets:
  "01": { status: pass }
  "02": { status: pending }
  "03": { status: pending }
  "04": { status: running, session_ref: <optional> }
```

Recommended workflow statuses:

```text
pending
running
pass
escalated
```

Keep Ticket metadata in the Ticket artifacts rather than copying it into workflow state unless a small reference is needed.

A host-provided `session_ref` may be retained for traceability. Do not manufacture identifiers.

Do not persist derived statuses such as `READY` or `BLOCKED_BY_02` unless the host requires them.

## 4. Derive READY tickets

A pending Ticket is READY when all of its declared dependencies are `pass`.

```text
READY(ticket) =
  ticket.status == pending
  AND every dependency.status == pass
```

Before starting a READY Ticket Session, run the lightweight Ticket validity gate from `SKILL.md`.

Do not run a new planning pass simply because the Ticket is about to execute.

## 5. Dispatch model

The preferred model is:

```text
Workflow Session
  ↓
Dedicated Ticket Session
  ├─ Build in the Ticket Session main agent
  ├─ self-check
  ├─ fresh Reviewer / Verifier subagent/context
  ├─ local repair and re-prove as needed
  └─ compact terminal Ticket Outcome
  ↓
Workflow Session
```

Do not dispatch both Build and Prove directly from one large Workflow Session when the host can create a dedicated Ticket Session.

Do not carry previous Ticket conversations into a new Ticket Session merely for convenience.

Pass only the current Ticket, necessary repository context, and relevant upstream artifacts.

## 6. Handoff boundary

The formal cross-Ticket handoff is:

```text
Ticket Session → terminal Ticket Outcome → Workflow Session
```

Keep intermediate Reviewer verdicts, repair attempts, and local replan details inside the Ticket Session.

The Workflow Session should normally receive only:

```text
ticket id
terminal status
compact acceptance result
relevant artifact / commit / session reference when available
non-blocking findings when useful
blocking reason when escalated
```

This boundary keeps the Workflow Session small and makes each Ticket independently inspectable.

## 7. Parallelism

If multiple Tickets are READY, the DAG permits them to run independently; it does not require parallel execution.

Run mutation Ticket Sessions in parallel only when the host provides safe isolation or concurrency-safe workspace handling.

If safe isolation is unavailable or uncertain, execute READY Tickets sequentially.

Do not automatically create Git branches, stashes, or worktrees merely to enable parallelism.

Independent read-only verification work may be parallelized when safe and useful.

## 8. Failure propagation

### Ticket passes

Mark the Ticket `pass`. Recompute the READY frontier.

### Ticket escalates

Mark the Ticket `escalated`.

Its dependents remain not-ready.

Other independent READY branches may continue.

### Reviewer returns FAIL_BLOCKING

Handle bounded repair inside the Ticket Session. Do not bounce every repair attempt through the Workflow Session.

### Reviewer returns FAIL_NON_BLOCKING

If required Acceptance Criteria are satisfied, the Ticket Session returns terminal `pass` plus compact non-blocking findings.

### PLAN_INVALID

Handle one targeted local replan inside the Ticket Session by default.

Do not rewrite the whole project plan or regenerate the entire Ticket set.

If local replan cannot recover the Ticket within the allowed bound, return `escalated` upstream.

After a local replan passes, downstream Tickets are not proactively rewritten. Their own validity gates catch stale assumptions when they become candidates for execution.

## 9. Ticket scope boundary

A Ticket Session assigned Ticket N may implement only what is necessary to satisfy Ticket N.

Do not pre-build Ticket N+1 or create generalized infrastructure solely for downstream convenience unless Ticket N itself requires it.

If future work is discovered, record it compactly and leave it for the appropriate downstream Ticket.

This boundary preserves attribution, context isolation, and reliable acceptance.

## 10. Verification scope

Each Ticket is proved against its own Acceptance Criteria.

Do not automatically:

- run the full repository test suite;
- execute the complete release loop;
- re-prove all prerequisite Tickets;
- validate downstream features outside the current Ticket.

Use minimum sufficient evidence.

A final integration or release Ticket may legitimately require broad project-level verification because its own Acceptance Criteria say so. Do not hard-code special behavior based on Ticket number or graph position.

## 11. No-progress detection

Continue while either:

- at least one Ticket Session is making progress; or
- at least one pending Ticket is READY and can be dispatched.

If unfinished Tickets remain, no Ticket Session is active, and there is no READY Ticket, stop instead of spinning.

Report the smallest useful blocking explanation, such as:

```text
missing dependency
cycle
escalated prerequisite
invalid Ticket reference
no safe execution path
```

Do not ask the user to manually schedule the next Ticket when the graph itself determines what is ready.

## 12. Completion

The workflow is complete when every required Ticket has normalized to `pass`.

At completion, report a compact workflow outcome rather than replaying every Ticket Session's history.

Prefer:

```text
completed tickets
non-blocking findings that remain relevant
any release/integration result required by the Tickets
```

Detailed implementation history stays in the dedicated Ticket Sessions and should only be surfaced when the user asks for it.
