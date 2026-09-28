---
name: acceptance-design
description: Design or revise acceptance criteria and verification plans before implementation. Use when deciding what must be proved, which evidence carrier best observes it, and how much verification is sufficient. Do not use to execute checks or review completed implementation.
---

# Acceptance Design

Design the smallest coherent body of evidence that can distinguish the intended behavior from credible failure at the boundary responsible for the change.

Acceptance is a reasoning problem, not a test inventory. Preserve room for judgment; do not turn the result into a ceremonial checklist.

## Anchor the proof

Begin with the claim that must become true and a plausible way the implementation could remain wrong.

For a bug fix, bind acceptance to the diagnosed cause and recurrence mechanism, not only the visible symptom. If the root cause is uncertain, design evidence that separates the live hypotheses instead of compensating with broader generic testing.

Give each distinct changed risk one primary proof at the most direct practical responsibility boundary. One artifact may prove several claims. Add another proof only when it observes a materially different failure mode.

Existing evidence is valid when it still matches the relevant code, input, environment, and claim. Reuse it rather than reproducing it.

## Choose the evidence carrier

When proposed evidence relies on a final or derived artifact, look one boundary upstream for a more direct and authoritative representation.

Prefer the earliest representation that still fully contains the behavior being claimed. It usually introduces fewer unrelated variables, produces clearer failures, and costs less to inspect. Add downstream evidence only when transformation, rendering, integration, or delivery can independently break the outcome.

The final deliverable is not automatically the best primary proof. The earliest or lightest artifact is not automatically sufficient either.

For example, in a `data → JSON → HTML → browser` chain:

- JSON normally owns claims about generated data, state, and meaning.
- HTML or DOM owns claims about binding, escaping, structure, and rendered presence.
- Browser evidence owns claims about layout and interactive behavior.
- Delivery evidence owns claims about writing, opening, or dispatching the result.

Do not repeat the same semantic claim at every layer.

Judge an evidence carrier by its discriminating power, unrelated variables, environment dependencies, diagnostic clarity, reviewability, and execution cost—not merely by file size or proximity to the user.

## Control scope

Local evidence is sufficient when it can observe the changed risk. Expand into other modules, full workflows, or global validation only for a named risk that the local boundary cannot reveal.

Repository requirements remain constraints, but one integration gate should not be multiplied across Acceptance Criteria or Tickets unless each invocation proves a distinct risk.

Time and cost may change how evidence is collected or expose an environment blocker. They must not redefine whether the product behavior passed.

Missing, stale, damaged, or unobservable evidence is not a product failure and is not permission to assume success. Repair the proof, choose a valid substitute, or report the limitation at its actual confidence level.

## Responsibility

This Skill designs acceptance evidence. It does not implement changes, execute verification, review a patch, orchestrate Tickets, or introduce release ceremony.

Use `test-audit` when the question is whether a proposed test is valuable, behavior-focused, and maintainable. Leave execution and independent implementation review to their owning workflows.

There is no required output template. A useful result makes the intended claim, its primary evidence, the credible failure it excludes, and any genuinely distinct secondary proof understandable to the next agent.

If every proposed proof cannot justify the risk it observes, simplify the design. `KEEP_CURRENT` and `STOP` are valid outcomes when existing evidence is sufficient.