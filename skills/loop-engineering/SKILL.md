---
name: loop-engineering
description: Design, review, or run evidence-driven closed loops for long-running coding-agent implementation or incident work. Use when a task needs multiple rounds, independent verification, durable state, recovery rules, and explicit complete, mitigated, or blocked exits. Supports Codex `/goal` as an optional adapter.

---

# Loop Engineering

Treat the task as a closed loop, not a `while true`:

```text
act -> observe -> verify -> update durable state -> continue | switch | stop | hand off
```

Optimize for convergence. On every round, be able to answer:

> What new evidence justifies the next action, and what evidence would make us stop?

Read [references/loop-patterns.md](./references/loop-patterns.md) when you need architecture patterns, loop-layer choice, or anti-patterns.

## Scope, Portability, and Optional Adapters

Use this skill as an agent-agnostic loop orchestrator. Do not present it as a root-cause oracle or an incident-diagnosis executor. It works with any coding agent that can inspect, act, observe, and persist a small amount of state.

Other Skills are optional capability adapters, not required dependencies:

| Needed capability                        | Preferred adapter, if available | Fallback when unavailable                                    |
| ---------------------------------------- | ------------------------------- | ------------------------------------------------------------ |
| Cut scope                                | `$mvp-plan`                     | Put an explicit in-scope / out-of-scope boundary in the Loop Spec. |
| Map work to a repository                 | `$plan`                         | Inspect the relevant files and write the smallest executable phase list. |
| Break work into atomic tasks             | `$checklist`                    | Keep a short ordered task list in durable loop state. Do not require auto-generated reflections. |
| Build a red-capable minimal reproduction | `$diagnosing-bugs`              | Do not start speculative fixes. Gather raw evidence, narrow the observation surface, or stop as blocked until a falsifiable probe exists. |

`loop-engineering` consumes whichever artifacts exist and turns them into repeated decisions with state, verification, recovery, and exits. It must work when none of the optional adapters is installed.

For an ambiguous incident, use both diagnostic and loop concerns in this order:

```text
symptom -> minimal reproduction / probe -> evidence boundary
        -> loop state + next-action rule -> mitigation or repair -> independent acceptance
```

`loop-engineering` must not claim that a proxy check proves the user-facing symptom is fixed. If no probe covers that symptom, record the gap and keep the final acceptance gate open.

### Platform Adapters

Use Codex `/goal` as an optional persistence container when it exists and the task spans many rounds. In another agent environment, use the equivalent durable task, issue, state file, or handoff artifact. The platform container does not replace the planner, verifier, retry policy, or exit semantics.

## When Not to Use the Full Loop

Do not create a full Loop Spec, durable state object, or evidence harness for a trivial one-shot task.

Use a normal edit-and-verify pass when all are true:

- one small, reversible change is sufficient;
- a focused verifier already covers the requested behavior;
- no retry, strategy switch, cross-session state, or handoff is expected;
- the task can finish in one short action/verification cycle.

Examples: rename a symbol, correct a known typo, update a well-covered conditional, or answer an explanatory question. Use a lightweight loop only if the task grows: state the goal, run the focused verifier, and stop. Escalate to the full loop when evidence, recovery, or continuation decisions start spanning multiple rounds.

## Choose the Loop Level

Use a runtime-level loop by default for one long-running coding or incident task that needs persistence, retries, and restart semantics.

Use a workflow-level loop for stage dependencies, multi-agent handoffs, pipeline gates, or revision routing. Combine both only when each workflow node is itself a long-running task.

Keep the three nested loops distinct:

1. **Coding / incident loop**: act, observe, verify, and recover in minutes.
2. **Developer feedback loop**: update intent, scope, and evals in hours.
3. **External feedback loop**: update product direction from users, testing, or production over days or longer.

Do not keep iterating in the inner loop when the blocker is missing product intent, external access, policy approval, or an environment change.

## Start With a Loop Spec

Write a compact loop spec before editing code or starting repeated attempts. If the task is an incident, include the Incident Entry Gate below before allowing a success claim.

```md
Goal:
- What externally observable deliverable or recovery state is required?
- What evidence proves complete, mitigated, or blocked?

Symptom and Acceptance Surface:
- What did the user actually observe?
- Which executable path, event, API, UI, or environment must pass to close it?

State:
- What persists across rounds?
- Where are raw evidence, attempt history, current hypothesis, and blocked reason stored?

Planner:
- What is the next-action rule?
- What evidence triggers replanning or loop-layer escalation?

Actor:
- Which actions are allowed, risky, costly, or irreversible?

Observer:
- Which raw outputs, logs, diffs, exit codes, and timestamps are captured?

Verifier:
- Which independent check covers the acceptance surface?
- Which checks are probes only, rather than final acceptance?

Failure Semantics:
- How are transient, strategy, environment, policy, and unknown failures classified?
- What are the retry and strategy-switch budgets?

Exit Conditions:
- Complete
- Mitigated but not root-resolved
- Blocked / handoff
- Budget or risk exit

Policy:
- Permission, approval, tool, cost, and mutation boundaries
```

Call out missing fields explicitly. Do not silently infer an end-to-end verifier from a unit test, a successful command, or an agent's own summary.

## Incident Entry Gate

Use this gate whenever a failure is ambiguous, integration-dependent, environment-sensitive, or reported only as a generic error such as `code 1`, timeout, or permission denied.

Before treating a verifier as acceptance evidence, create an evidence-surface map:

| Item               | Required record                                              |
| ------------------ | ------------------------------------------------------------ |
| User symptom       | Exact visible failure, affected path, and time/context       |
| Acceptance surface | The real lifecycle, API, UI, or command path that must work  |
| Candidate verifier | Command, test, probe, or observation being proposed          |
| Coverage           | Does it execute the acceptance surface? `yes`, `partial`, or `no` |
| Evidence role      | `acceptance`, `supporting`, or `diagnostic-only`             |
| Gap                | What the result still cannot prove                           |

Apply these rules:

1. A verifier with `coverage = no` cannot close the incident.
2. A verifier with `coverage = partial` can narrow hypotheses, but must retain the untested acceptance gate.
3. A successful direct component replay proves the component boundary only; it does not prove its real runner, permissions, environment inheritance, or lifecycle integration.
4. If no verifier covers the acceptance surface, use `$diagnosing-bugs` when available to design the smallest falsifiable probe. Without it, do not hypothesize or fix by guesswork: collect raw evidence, narrow the observation surface, and record the remaining gap as a blocker.

This gate prevents the classic failure mode: a CLI or unit-test green result is mistakenly used to declare a lifecycle, UI, or integration bug fixed.

## Build an Evidence Harness for Repeated or High-Impact Work

When the loop needs more than one probe, make the evidence executable rather than leaving it in chat prose.

Define an evidence harness with:

```md
Probe ID:
Hypothesis:
Acceptance-surface coverage: yes | partial | no
Baseline:
Variable changed:
Command or action:
Expected raw signal:
Observed raw signal path or ID:
Exit code / assertion:
Interpretation boundary:
```

Prefer a script when the same comparison will be repeated or handed off. It should:

- run the baseline and changed condition with all other meaningful variables held constant;
- capture raw stdout, stderr, exit code, timestamps, and relevant log/state paths;
- assert the expected signal instead of relying on manual recollection;
- label whether the result is diagnostic, supporting, mitigation, or final acceptance evidence;
- avoid modifying production or user configuration unless that mutation is explicitly authorized.

For configuration-sensitive incidents, use an A/B pattern:

```text
baseline configuration -> same probe -> raw result
one scoped variable change -> same probe -> raw result
```

Do not call a workaround a root repair merely because the changed condition is green. Preserve the failing baseline and the unexecuted acceptance gate.

## State Model

Persist state outside the context window. Keep raw evidence separate from summaries.

The minimum useful state for a long-running implementation or incident loop is:

```yaml
goal: <stable objective>
acceptance_surface: <real path to close>
phase: inspect | reproduce | isolate | mitigate | repair | accept | handoff
status: running | waiting | blocked | mitigated | complete | budget_exhausted
current_hypothesis: <testable statement>
attempts:
  - id: <stable attempt id>
    probe_id: <optional id>
    action: <what changed or ran>
    failure_class: transient | strategy | environment | policy | unknown | none
    raw_evidence: <paths, IDs, exit codes>
    conclusion: <what this does and does not prove>
    next_action_rule: <why this next step>
evidence_gaps:
  - <unobserved but required fact>
retry_budget:
  transient: 1
  strategy_per_hypothesis: 1
  unknown_before_narrowing: 1
blocked_reason: <if any>
handoff_requirements:
  - <what outside actor must provide>
```

Use a state file, issue record, checklist, or other durable artifact appropriate to the repository. A free-form handoff is useful, but it must include the current hypothesis, failed attempts, raw evidence pointers, acceptance gap, and exact next gate.

## Planner and Next-Action Rules

Derive the next action from state and evidence; do not repeatedly regenerate a plan from scratch.

Use these default decision rules:

1. If the acceptance surface is not mapped, map it before optimizing a proxy verifier.
2. If the current hypothesis is not falsifiable, narrow it with the cheapest probe that can change the decision.
3. If a probe is green but does not cover acceptance, classify it as supporting evidence and keep the acceptance gate pending.
4. If a new observation contradicts the current hypothesis, switch layer or hypothesis; do not repeat the same action.
5. If the failure is environmental or policy-bound, stop modifying unrelated application code and prepare handoff evidence.
6. If all low-cost probes agree and the remaining gate requires outside control, mark `blocked` or `mitigated`, not `complete`.

Choose the smallest reversible action that can falsify the current hypothesis. Prefer focused checks before broad suites, and direct observation before speculative edits.

## Verifier Integrity

Keep the actor and verifier independent where practical. An agent saying “done” is never sufficient evidence.

Classify every check:

| Class               | Meaning                                                      | Can close the goal?           |
| ------------------- | ------------------------------------------------------------ | ----------------------------- |
| Acceptance verifier | Executes the defined acceptance surface and checks its required outcome | Yes                           |
| Supporting verifier | Confirms an important component or adjacent path             | No, by itself                 |
| Diagnostic probe    | Narrows hypotheses or exposes raw failure semantics          | No                            |
| Regression verifier | Checks that a change did not damage other required behavior  | Only with acceptance evidence |

Record the exact command, input conditions, output, exit code, and evidence path for an acceptance claim. If the true lifecycle cannot be triggered automatically, state the manual or external gate explicitly and leave the task in `mitigated` or `blocked` until it runs.

## Failure Semantics and Retry Policy

Classify failures before retrying:

- **Transient**: same action may reasonably succeed unchanged; retry once with evidence capture.
- **Strategy**: the hypothesis, tool, or implementation path is wrong; switch strategy before another attempt.
- **Environment**: an external runtime, dependency, permission, or machine state prevents progress; collect a minimal reproducer and hand off or repair the environment.
- **Policy**: the next action requires user approval or exceeds permissions; stop and request authority.
- **Unknown**: evidence is insufficient; reduce scope and improve observation. Use `$diagnosing-bugs` when available; otherwise stop before speculative edits and record the missing red-capable probe.

Never retry without a reason. Enforce these minimum limits unless the task specifies stricter ones:

- retry a transient failure once;
- do not retry the same strategy after the same evidence disproves it;
- after one unknown failure, narrow the observation surface before attempting a fix;
- treat repeated environment failures as a handoff trigger, not a code-edit invitation.

## Exit Conditions and Honest Status

Maintain distinct outcomes:

| Status             | Meaning                                                      | Required evidence                                            |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `complete`         | The requested outcome is achieved                            | Acceptance verifier passes; required regressions pass        |
| `mitigated`        | A safe workaround restores limited usefulness                | Workaround probe passes; original acceptance or root cause remains explicitly open |
| `blocked`          | Further progress needs outside input, access, or environment change | Minimal reproducer, raw evidence, and precise handoff request exist |
| `budget_exhausted` | Further attempts are low-yield within agreed limits          | Attempt history and next best action are recorded            |
| `risk_stop`        | Next action would exceed policy or safety limits             | Risk and required approval are recorded                      |

Do not use “fixed” when only a proxy path works. Do not use “blocked” as a vague failure label: identify the owner, missing condition, evidence bundle, and next acceptance action.

## Handoff Contract

When exiting without completion, provide a handoff that another engineer can execute without reconstructing the whole chat:

```md
Current status: mitigated | blocked | budget_exhausted | risk_stop
User-visible symptom:
Acceptance surface still pending:
What was ruled out:
Strongest remaining hypothesis:
Minimal reproduction / evidence harness command:
Raw evidence paths or IDs:
Configuration and environment facts:
Attempts and failure classes:
What the workaround proves and does not prove:
Exact next action, owner, and acceptance condition:
```

The handoff is part of the loop, not an afterthought.

## Worked Example: Hook Says `code 1`, but the Direct Replay Is Green

Use this compact example as a pattern for an integration incident. It demonstrates evidence roles, not a claim that one probe proves the whole system.

```md
Goal:
- Restore the taskbar state update from a real Hook lifecycle event.

User symptom:
- The real Codex session shows `hook exited with code 1`.

Acceptance surface:
- A real lifecycle event completes without `code 1` and writes the expected state.
```

| Attempt                                       | Raw observation                                              | Coverage / role                                              | State update                                                 |
| --------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Directly replay Hook JSON                     | Exit `0`; isolated state file written                        | `partial` / supporting: proves the Hook boundary, not the runner or sandbox | Rule out a deterministic parser/state-write failure in direct execution |
| Run `codex exec` and inspect Hook diagnostics | Command succeeds; no Hook event or state update              | `no` / diagnostic-only for lifecycle acceptance              | Do not use `codex exec` to close the Hook issue              |
| Run a read-only shell probe                   | Sandbox helper reports `Access denied`                       | `partial` / diagnostic-only for Hook, strong environment evidence | Switch from Hook code edits to environment isolation         |
| Compare sandbox modes                         | `unelevated` shell probe passes repeatedly; scoped `elevated` probe fails | `partial` / mitigation evidence                              | Mark `mitigated`; retain real lifecycle acceptance gate      |

The correct status is `mitigated`, not `complete`: the shell workaround restores a useful path, but the actual lifecycle Hook has not yet passed. A correct handoff asks for the missing runner stderr or a real lifecycle acceptance run, and includes the direct replay, mode-comparison commands, raw outputs, and the unclosed gate.

## Recommended Sequence

For normal software delivery:

1. Clarify outcome and validation signal.
2. Use any available scope, planning, and task-breakdown adapters when scope and ordering warrant them; otherwise write the equivalent minimal artifacts in the Loop Spec and durable state.
3. Write the loop spec.
4. Run: inspect -> choose -> act -> verify -> update state -> continue, replan, block, or stop.

For ambiguous incidents:

1. Record the user-visible symptom and acceptance surface.
2. Use `$diagnosing-bugs`, when available, to reproduce or minimize the failure. Without a red-capable probe, gather evidence or hand off; do not enter speculative fix iterations.
3. Apply the Incident Entry Gate to every proposed verifier.
4. Build a minimal evidence harness for the important comparison.
5. Use the loop to select the next falsifiable action, not to repeat edits.
6. Separate mitigation from root repair.
7. Run the true acceptance verifier, or hand off with the missing gate explicit.

Use Codex `/goal`, when available, when work spans many rounds and needs persistence. Treat it as one possible container for a stable objective and lifecycle, not as the planner, verifier, or retry policy.

## Review Existing Loops

Review in this order:

1. Find the durable source of truth.
2. Find the stated acceptance surface.
3. Find the independent verifier and check its coverage.
4. Find raw evidence capture and the evidence harness.
5. Find failure classes, retry limits, and strategy-switch rules.
6. Find the distinction between complete, mitigated, and blocked.
7. Find the human takeover path and the exact remaining gate.
8. Check whether repeated feedback became durable spec or eval artifacts.

If any item is missing, explain how the loop can drift, self-certify, confuse a workaround with a repair, or become a token sink.

## Common Smells

- A green unit, CLI, or shell probe is used to close a different lifecycle or UI failure.
- The actor and verifier are the same assertion with no independent evidence.
- Generic errors are treated as root causes rather than starting points for observation.
- “Retry” repeats the same action without a changed hypothesis or failure class.
- Environment failure triggers unrelated application code edits.
- A workaround is reported as a root fix.
- State exists only in the chat context or a prose handoff without attempt IDs and evidence pointers.
- A goal remains `running` even though the next progress requires an external actor.
- Human or external feedback never becomes a specification, eval, or decision record.
- A full Loop Spec, persistent state store, or harness is created for a one-shot, well-covered change that needs one edit and one focused check.

## Output Expectations

When using this skill, produce the artifacts needed for another engineer to continue safely:

- loop spec with acceptance surface;
- state model or state-transition table;
- evidence-surface map and verifier plan;
- evidence harness when a critical probe or comparison repeats;
- failure classes and retry limits;
- exit condition and risk register;
- honest status: complete, mitigated, blocked, budget exhausted, or risk stop;
- recommendation for a durable task container such as `/goal`, when one is needed;
- mapping to optional planning or diagnosis adapters when they are available, plus the fallback artifacts used when they are not.