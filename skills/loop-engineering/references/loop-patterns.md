# Loop Patterns

## Contents

1. Core Definition
2. Three Nested Loops
3. Cadence By Loop Layer
4. Layer Choice
5. Workflow-Level Pattern
6. Runtime-Level Pattern
7. Skill Composition Pattern
8. Context Advantage
9. Spec/Evals As Interface
10. Failure Semantics
11. Anti-Patterns
12. Review Checklist

## Core Definition

Loop Engineering is not "keep calling the model."

Treat it as the engineering of a closed loop:

- Act toward a goal
- Observe results
- Verify whether the system improved
- Update state
- Decide whether to continue, change strategy, stop, or hand off

The standard to optimize is not duration. It is convergence.

## Three Nested Loops

For product-building with coding agents, treat loop engineering as three nested loops:

- Agentic coding loop: agent and spec/evals iterate on implementation
- Developer feedback loop: developer vision updates spec, scope, and evals
- External feedback loop: user and market signals update developer vision

The loops are nested because each slower loop changes the target or constraints of the faster loop inside it.

## Cadence By Loop Layer

Typical cadence:

- Coding loop: minutes
- Developer feedback loop: hours
- External feedback loop: days or longer

Do not force all problems into the fastest loop.

- Implementation errors belong in the coding loop.
- Product tradeoffs belong in the developer loop.
- Value and adoption questions belong in the external loop.

When a slow-loop problem is handled in a fast loop, the system usually produces local optimization without global progress.

## Layer Choice

Use workflow-level loop design when the main problem is orchestration across stages, agents, or artifacts.

Use runtime-level loop design when the main problem is persistence and control of a single long-running task.

Use both when each workflow node is itself a long-running task.

For coding sessions, runtime-level is the default. A single task usually fails because scope, verification, or recovery are weak, not because it lacks a multi-agent DAG.

## Workflow-Level Pattern

Typical concerns:

- DAG or dependency graph
- Stage state machine
- Artifact dependencies
- Gate checks between stages
- Revision routing back upstream

Representative design moves:

- Make stage transitions explicit: `pending -> running -> completed|failed|retrying`
- Derive the next runnable node from state and dependencies
- Treat agent output as a claim, not as the final truth
- Re-run verification at boundaries before advancing downstream

This pattern fits systems similar to the article's `boss-skill` example.

## Runtime-Level Pattern

Typical concerns:

- Persistent state files or durable state store
- Pause, resume, stop, clone, restart-failed, restart-phase
- Transcript and evidence capture
- Attempt counters and failure history
- Cache reuse and idempotent restart behavior

Representative design moves:

- Store control state separately from task state
- Capture transcripts, tool events, usage, and evidence bundles
- Persist attempt counts and previous errors
- Allow partial restart instead of full replay

In Codex-style coding work, this often maps well onto `/goal`:

- objective = stable desired outcome
- continuation = verifier says more work is justified
- blocked = repeated external blocker or non-actionable ambiguity
- complete = verifiable delivery condition met

`/goal` is not the planner, verifier, or retry policy. It is the lifecycle container around them.

## Skill Composition Pattern

Use this split when composing planning skills for coding tasks:

- `$mvp-plan`: cut scope and remove speculative work
- `$plan`: map scope to repo-specific phases
- `$checklist`: produce atomic executable tasks and validation items
- `loop-engineering`: define the repeated decision cycle that consumes those outputs

The loop should not regenerate all planning artifacts each round. It should consume them, update state, and replan only when evidence invalidates the current path.

This pattern fits systems similar to the article's `orca` example.

## Context Advantage

Humans are not only approval gates or last-resort reviewers.

In outer loops, humans often have a context advantage:

- user knowledge
- product taste
- business constraints
- edge cases from experience
- implicit quality bars

When the agent lacks this context, more coding-loop iteration does not solve the problem. The loop must absorb new context through updated vision, spec, or evals.

## Spec/Evals As Interface

`spec/evals` is the critical interface between the developer loop and the coding loop.

Treat it as a durable artifact, not a disposable prompt:

- Spec compresses intent into actionable requirements
- Evals compress quality expectations into repeatable checks

Repeated mistakes usually mean the interface artifact is weak.

Prefer:

- updating the spec when intent is unclear
- adding or refining evals when quality regressions repeat
- moving human feedback into artifacts the inner loop can reuse

instead of repeatedly telling the agent the same thing in chat.

## Failure Semantics

Every loop should distinguish at least these failure classes:

- Transient: retry may work unchanged
- Strategy: current approach is wrong; change plan or tool
- Environment: external state prevents progress
- Policy: next step requires approval or exceeds constraints
- Unknown: reduce scope and gather evidence before trying again

Good loops cap retries by failure class, not just globally.

## Anti-Patterns

- Infinite retry: the loop keeps acting but never changes strategy
- Self-certification: the same agent both changes the system and declares success
- State leakage: critical memory exists only in context instead of durable state
- Context accretion: every round replays all history, raising cost and drift
- No handoff: a human cannot reconstruct why the loop is still running
- No exit semantics: "stop" means only crash or timeout
- Scope inflation: the loop keeps expanding the objective because no MVP boundary exists
- Planning amnesia: the agent writes a good plan once, then ignores it during execution
- Goal misuse: `/goal` is used for persistence before objective, verifier, and exits are clear
- Product ambiguity inside the coding loop: the agent keeps implementing against a target that should have been revised by the developer loop
- Feedback evaporation: external or human feedback is observed once but never converted into spec, evals, or decision records

## Review Checklist

- Is the goal concrete and externally verifiable?
- Is the active problem in the right loop layer?
- Is there a durable state boundary?
- Is the next step derived from state and evidence?
- Is there an independent verifier?
- Are retries bounded and strategy-aware?
- Are blocked, failed, paused, and completed distinct?
- Can a human inspect the current reason for continuing?
- Can the system stop safely for success, risk, budget, or handoff?
- Does human or external feedback become updated vision, spec, or eval artifacts?
