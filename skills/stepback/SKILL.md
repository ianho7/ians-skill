---
name: stepback
description: Interrupt a stuck or over-literal approach, recover the underlying goal, and switch to a verifiably different path. Use when repeated attempts produce no decision-changing evidence, a capability blocks the obvious method, or the literal request appears to underserve the user's actual objective. For long-running or AFK work, checkpoint progress and stop after one failed recovery.
---

# Step Back

A **stepback** holds the goal and releases the current method.

## Trigger

Step back when any of these is true:

- Two consecutive verified attempts leave the success criteria unchanged.
- The same error recurs, or tool calls repeat with materially similar inputs and results.
- A capability blocks the obvious method, but the underlying outcome may be reached through another representation, tool, sequence, or experiment.
- During planning or design, the literal request appears to be a means rather than the user's real objective, and reframing may materially improve the result.

Continue directly while the current path is producing decision-changing evidence. An optional improvement alone is not a trigger.

## Recover the Goal

Before taking another action, write a compact checkpoint:

```text
Goal: the externally observable outcome
Success: the criteria and verifier that establish completion
Tried: the paths attempted and what each established
Stuck: the present blocker or unchanged signal
Assumption: what currently ties the goal to this method
```

Choose one mode:

- **Escape:** Keep the requested outcome and change the representation, tool, sequence, hypothesis, or experiment. Proceed when the change is reversible and stays within scope.
- **Reframe:** Work backward from the underlying objective and propose a better structure, scope, or deliverable. Ask before acting when this changes requested content, requirements, or another meaningful user decision.

Choose the smallest reversible path whose result can be distinguished from the current path.

## Verify Progress

Before acting, record the current baseline, the expected signal, and the check that will observe it. A path produces **decision-changing evidence** only when it changes a verifier result, moves a relevant metric, falsifies a hypothesis, exposes a different failure signal, satisfies part of the success criteria, or demonstrates a working alternative.

New prose, plans, files, or tool calls are not progress by themselves. They count only when the verifier shows that they satisfy a criterion or eliminate a candidate path. Repeating an action with unchanged inputs requires a concrete reason that the outcome may differ.

## Preserve State for Long Work

For automatic continuation, background Goals, AFK agents, context compaction, or handoff, persist the checkpoint outside the conversation. Reuse the host's Goal, task, issue, or existing project state record. If none exists, ask where to persist it before creating a file; keep operational state out of product source by default.

Keep at least:

```yaml
goal: <stable objective>
success_criteria: <observable completion conditions>
acceptance_verifier: <check that covers the requested outcome>
last_verified_progress: <evidence reference or summary>
tried_paths: []
current_path: <active hypothesis or method>
no_progress_streak: 0
stepback_used: false
status: running | blocked | complete
blocked_reason: <missing input, access, evidence, or external change>
```

Update durable state after verification, not after every tool call. Keep raw evidence in its natural location and store a path or identifier in the checkpoint. Treat `stepback_used` as belonging to the current stagnation episode; reset it only after decision-changing evidence appears.

## Continue or Stop

After each verification:

1. If decision-changing evidence appeared, record it, reset `no_progress_streak` to `0`, and continue from the new state.
2. Otherwise increment `no_progress_streak`. At `2`, perform one stepback before another action and set `stepback_used` to `true`.
3. Give the chosen alternative one verifiable attempt. If it produces evidence, return to step 1.
4. If the post-stepback attempt produces none, stop as `blocked`. Report the goal, success criteria, tried paths, strongest evidence, remaining gap, and the exact input or external change needed to resume.

Do not mark work complete from the agent's own summary or a proxy check that does not cover the requested outcome.

## Runtime Boundary

This skill defines the decision protocol. When the host supports hooks, Goals, or continuation guards, enforce the counter, checkpoint update, and stop rule there. Without runtime enforcement, follow the same protocol but describe it as an agent-level safeguard, not a guaranteed interruption.
