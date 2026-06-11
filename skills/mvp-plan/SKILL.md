---

name: mvp-plan
description: Create a strict MVP-first implementation plan that minimizes scope, prevents over-engineering, and forces every decision to be justified against the MVP goal.

---

# MVP Plan

## Purpose

Use this skill when the user wants to turn an idea, requirement, bug, refactor, architecture change, feature request, investigation goal, or product concept into a **minimal viable implementation plan**.

The goal is not to design the best possible system.

The goal is to design the **smallest useful version** that solves the user's immediate problem, can be implemented safely, and can be validated quickly.

This skill is especially useful when:

* The project is early-stage
* The user explicitly asks for an MVP
* The implementation should avoid over-engineering
* The user wants fast validation before expanding scope
* A coding agent may be tempted to add extra abstractions, features, frameworks, workflows, dashboards, agents, or speculative architecture

The plan must aggressively limit unnecessary work.

---

# Core Principle

Every part of the plan must answer this question:

> Does this directly help deliver and validate the MVP outcome requested by the user?

If the answer is not clearly yes, the item should be:

* Removed
* Deferred
* Marked as out of scope
* Or listed as a future enhancement, not part of the MVP

Do not include work because it is:

* Nice to have
* More scalable
* Cleaner long-term
* Probably useful later
* Easy while we are here
* More elegant
* More generic
* Something the coding agent can do anyway

Those are common ways MVPs become accidental platforms.

---

# Universal MVP Thinking Model

A good MVP plan should focus on the smallest complete loop:

1. Accept the minimum required input
2. Perform only the necessary processing
3. Produce the smallest useful output
4. Validate that the output solves the user's immediate problem
5. Stop before adding generalized systems

Do not confuse a useful MVP with a miniature version of the final platform.

An MVP is not:

* A full product foundation
* A generic framework
* A scalable platform
* A plugin ecosystem
* A complete automation suite
* A dashboard-first product
* A speculative architecture playground

An MVP is a focused proof that the core loop works.

---

# Universal MVP Discipline Rules

These rules apply to all projects.

## 1. Default to Less

Prefer the smallest implementation that can satisfy the user-visible requirement.

Avoid:

* New frameworks unless already used
* New infrastructure unless required
* New abstractions unless they directly reduce current implementation risk
* New configuration systems unless needed immediately
* New generic utilities unless they simplify the current task
* New background jobs unless required for the MVP behavior
* New admin panels, dashboards, analytics, permissions, or settings unless explicitly requested
* Premature support for multiple tenants, providers, environments, modes, or platforms

## 2. No Speculative Additions

Do not add work based on imagined future needs.

Avoid reasoning like:

* This will make it easier later
* For scalability
* For extensibility
* For future use
* We might need it
* It would be better to also add
* While we are here
* This is a good foundation

If it is not needed to validate the MVP, defer it.

## 3. Every Decision Needs an MVP Justification

For each meaningful design or implementation decision, explain why it is necessary for the MVP.

A valid MVP justification should connect directly to:

* User-visible behavior
* A blocking technical requirement
* A safety or correctness requirement
* A validation requirement
* A constraint already present in the project

If a decision cannot be justified this way, defer it.

## 4. Prefer Existing Project Patterns

Use what the project already has.

Prefer:

* Existing libraries
* Existing architecture
* Existing API patterns
* Existing test patterns
* Existing file structure
* Existing deployment approach
* Existing configuration approach
* Existing error-handling style

Do not introduce a new pattern just because it is cleaner in isolation.

## 5. Build for Validation, Not Perfection

The MVP should make it possible to learn whether the idea works.

Prefer:

* Manual validation over automation when acceptable
* Simple logs over full observability
* A single happy path before broad edge-case coverage
* Hardcoded constraints when safe and clearly temporary
* Simple configuration over dynamic customization
* One supported flow over multiple optional flows
* A small number of realistic test cases over exhaustive scenario modeling

## 6. Make Deferrals Explicit

Anything useful but not necessary must be placed in a deferred section.

Deferred items must not quietly sneak into the implementation phases.

For each deferred item, briefly explain:

* Why it is not required for MVP
* What signal would justify adding it later

## 7. Ask Only Blocking Questions

Do not create a long list of open questions as a way to avoid planning.

Only include questions that materially affect:

* MVP scope
* Implementation path
* Validation strategy
* Safety
* Technical feasibility

If a detail is not blocking, make the simplest reasonable assumption and clearly label it.

## 8. Protect Against Coding Agent Scope Creep

Before adding any task, phase, file, dependency, abstraction, test, automation, data source, or architectural decision, perform this MVP check:

1. Is this required to deliver the requested MVP behavior?
2. Is there a simpler existing way to do it?
3. Would skipping this prevent MVP validation?
4. Is this solving a real current problem, not an imagined later problem?
5. Can this be deferred safely?
6. Does this increase the amount of state, configuration, or maintenance the project must carry?

If the item fails this check, remove or defer it.

---

# Required Output Structure

## Objective

Summarize the MVP goal.

Include:

* The immediate problem being solved
* The smallest useful outcome expected
* What is in scope for MVP
* What is explicitly out of scope
* The main validation signal for success

Keep this section strict. Do not broaden the goal.

---

## MVP Scope Boundary

Define the boundary of the MVP.

### Must Have

List only what is required for the MVP to work.

For each item, include:

* Requirement:
* MVP Justification:

### Must Not Have

List features, abstractions, workflows, or enhancements that should not be included in the MVP.

For each item, include:

* Excluded Item:
* Reason for Exclusion:

### Deferred Until After MVP

List useful future work that should wait.

For each item, include:

* Deferred Item:
* Why Deferred:
* Signal to Reconsider:

---

## Background and Context

Explain the relevant context needed to understand the plan.

Include:

* Existing behavior
* Current architecture or workflow
* Important files or modules
* Prior decisions or constraints
* Any assumptions being made

Clearly mark assumptions that have not been verified.

Avoid long historical summaries unless they directly affect MVP implementation.

---

## Current State Analysis

Describe the current project state.

Include:

* Relevant files and their roles
* Existing implementation details
* Known limitations that affect the MVP
* Known bugs or risks that affect the MVP
* Dependencies or external systems involved

Do not analyze unrelated parts of the system.

If information is uncertain, state what needs to be checked and whether it blocks the MVP.

---

## MVP Decision Gate

Before proposing the solution, evaluate the intended approach against MVP constraints.

Use this checklist:

* Does this solve the user's immediate problem?
* Can the MVP be validated without this item?
* Is there an existing project pattern that avoids new design?
* Is any part of the plan preparing for a hypothetical future?
* Are any new dependencies, services, abstractions, workflows, or data sources truly necessary?
* What is the simplest acceptable implementation?

Then summarize:

* Keep:
* Remove:
* Defer:
* Simplify:

This section is mandatory.

---

## Proposed MVP Solution

Describe the recommended MVP solution.

Include:

* Smallest viable high-level approach
* Main design decisions
* MVP justification for each decision
* Expected behavior after implementation
* How the solution fits into the existing project
* Why this approach is preferred over a larger design

Use this format for decisions:

### Decision: <Decision Name>

* Choice:
* MVP Justification:
* Simpler Alternative Considered:
* Why Not More Complex:

---

## Alternatives Considered

List only meaningful alternatives that were actually relevant.

For each alternative, include:

* Description:
* Advantages:
* Disadvantages:
* MVP Fit:
* Reason Not Selected:

Do not invent elaborate alternatives just to look thorough.

At minimum, include the obvious simpler and more complex options when the problem involves design tradeoffs.

---

## Implementation Plan

Break the work into the smallest practical phases.

Each phase should produce a useful, reviewable result.

Avoid phases dedicated only to abstraction, cleanup, framework setup, or speculative foundation work unless they are strictly required.

Use this structure:

### Phase 1: <Name>

* Goal:
* Files:
* Tasks:
* Expected Result:
* MVP Check:

  * Why this phase is necessary:
  * What is intentionally not included:

### Phase 2: <Name>

* Goal:
* Files:
* Tasks:
* Expected Result:
* MVP Check:

  * Why this phase is necessary:
  * What is intentionally not included:

Add more phases only if needed.

Prefer fewer phases.

---

## Validation Strategy

Describe how to verify the MVP.

Include:

* The minimum tests needed
* Manual checks
* Commands to run
* Expected outputs
* Failure cases that matter for the MVP
* What does not need to be tested yet

Prefer validation that proves the user-visible MVP behavior works.

Do not require large test suites unless the project already has them or the risk justifies them.

---

## Risks and Mitigations

List only major risks that could affect MVP delivery or validation.

For each risk, include:

* Risk:
* Impact:
* Likelihood if known:
* MVP Mitigation:
* Fallback Plan:

Avoid generic risks that apply to every software project.

---

## Over-Engineering Watchlist

List specific things the coding agent must avoid while executing this plan.

Examples:

* Do not introduce a new framework
* Do not create a generic plugin system
* Do not build a settings UI
* Do not add multi-provider support
* Do not refactor unrelated modules
* Do not add a database migration unless required
* Do not create abstractions before a second real use case exists
* Do not optimize performance without evidence of a bottleneck
* Do not build dashboards before the core loop works
* Do not convert a focused workflow into a platform

Make this section specific to the project and request.

---

## Conditional Add-ons

The following sections are optional.

Only apply a conditional add-on when the user's project clearly matches that category.

Do not apply these constraints to unrelated MVP projects.

If no conditional add-on applies, skip this section entirely in the generated plan.

---

### Add-on: Agent / AI / Automation / Diagnostic / Analysis Projects

Apply this add-on only when the MVP involves one or more of the following:

* AI reasoning
* LLM calls
* Agent workflows
* Automated decision-making
* Diagnostic analysis
* Log analysis
* Monitoring
* Large-context analysis
* Evidence-based recommendations
* Automated actions that may affect system state

Do not apply this add-on to ordinary CRUD features, simple UI pages, small scripts, simple APIs, static content changes, or straightforward refactors.

#### Additional Principle

For these projects, the MVP should be evidence-based, bounded, inspectable, and preferably advisory before it becomes autonomous.

#### Evidence First, Intelligence Second

Do not let the agent guess when evidence can be collected cheaply.

Prefer this order:

1. Collect minimal relevant evidence
2. Normalize or summarize the evidence
3. Remove obvious noise with deterministic logic
4. Apply heuristics or rules where they are enough
5. Use AI or complex reasoning only for the part that truly needs it
6. Produce an output that separates evidence from inference

Do not skip straight from raw inputs to AI judgment.

#### Filter Before Expensive Reasoning

Before using an LLM, complex algorithm, external service, or heavy workflow, reduce the input.

The MVP plan should define:

* What raw input is collected
* What is filtered out
* What is kept
* Why the kept input is enough
* What maximum input size is allowed
* What happens when the input is too large

Avoid feeding full raw logs, full repositories, full datasets, or full histories into a reasoning step unless the MVP explicitly requires it and the input size is bounded.

#### Bound the Context

Every MVP involving analysis should define a context budget.

Include:

* Maximum files, records, logs, events, or messages to inspect
* Time window or scope window if applicable
* Truncation or summarization rules
* Priority order when too much data exists
* Failure behavior when context is insufficient

#### Separate Facts, Rules, and Inference

Outputs should distinguish between:

* Verified facts
* Rule-based findings
* AI-generated interpretations
* Assumptions
* Confidence level
* Recommended next actions

Do not present inferred conclusions as verified truth.

#### Start with Read-Only or Advisory Behavior

For MVPs involving automation or agents, prefer read-only analysis and recommendations before taking actions that mutate state.

Avoid in MVP unless explicitly requested:

* Auto-fixing
* Auto-deleting
* Auto-restarting
* Auto-deploying
* Auto-migrating
* Auto-sending
* Auto-purchasing
* Any irreversible or high-impact operation

First prove the agent can understand the situation. Only then consider letting it act.

#### Use One Narrow Path Before Generalizing

Prefer one concrete supported flow.

Avoid early support for:

* Multiple providers
* Multiple deployment modes
* Multiple user roles
* Multiple storage backends
* Plugin systems
* Rule marketplaces
* Custom workflow builders
* Fully dynamic pipelines

Generalization should be earned by repeated real use cases.

#### Prefer Inspectable Outputs

The MVP output should be easy to inspect, debug, and compare.

Prefer:

* Markdown reports
* JSON output
* Console output
* Simple files
* Clear logs

Avoid building a UI, dashboard, or visualization layer unless it is necessary for MVP validation.

#### Extra Output Fields for This Add-on

When this add-on applies, include these fields inside relevant sections of the plan:

* Evidence Used:
* Filtering Before Reasoning:
* Context Boundary:
* Output Format:
* Human Review Point:
* Read-Only vs Mutating Behavior:

---

### Add-on: Data-Heavy Projects

Apply this add-on only when the MVP depends heavily on data processing, datasets, imports, exports, analytics, reports, or transformations.

Do not apply this add-on to normal features that only read or write small amounts of application data.

#### Additional Rules

* Define the smallest dataset required to validate the MVP
* Avoid building a generic data pipeline unless required
* Prefer one input format before supporting many
* Prefer one output format before supporting many
* Define how bad, missing, or malformed data is handled
* Do not add complex analytics unless the MVP decision depends on them
* Do not add dashboards unless plain output cannot validate the workflow

#### Extra Output Fields for This Add-on

When this add-on applies, include:

* Minimum Dataset:
* Input Format:
* Output Format:
* Data Quality Assumptions:
* Failure Handling:
* What Is Not Processed Yet:

---

### Add-on: Infrastructure / DevOps Projects

Apply this add-on only when the MVP involves deployment, containers, servers, CI/CD, monitoring, runtime environments, networking, or operations workflows.

Do not apply this add-on to ordinary application features unless infrastructure changes are central to the MVP.

#### Additional Rules

* Prefer the existing deployment model
* Avoid introducing new infrastructure unless required
* Prefer local or single-environment validation first
* Avoid multi-cloud, multi-region, or HA design in MVP unless explicitly required
* Avoid complex observability stacks unless required for validation
* Prefer reversible changes
* Define rollback or fallback behavior
* Separate read-only inspection from mutating operations

#### Extra Output Fields for This Add-on

When this add-on applies, include:

* Target Environment:
* Existing Deployment Pattern:
* Operational Risk:
* Rollback Plan:
* Required Permissions:
* What Is Not Automated Yet:

---

### Add-on: UI / Product Feature Projects

Apply this add-on only when the MVP involves user-facing screens, product flows, forms, onboarding, navigation, or interaction design.

Do not apply this add-on to backend-only features unless user-facing behavior is central to validation.

#### Additional Rules

* Prefer one primary user flow
* Avoid settings screens unless required
* Avoid full design systems unless already present
* Avoid advanced empty states, animations, personalization, or preferences unless essential
* Prefer existing components
* Define the minimum acceptable UX
* Validate with the simplest user action that proves the feature works

#### Extra Output Fields for This Add-on

When this add-on applies, include:

* Primary User Flow:
* Minimum Acceptable UX:
* Existing Components to Reuse:
* States Required for MVP:
* States Deferred:
* User Validation Signal:

---

## Open Questions

List unresolved questions that need user input, code inspection, or further investigation.

Only include questions that are genuinely blocking or materially affect MVP scope.

For each question, include:

* Question:
* Why It Matters:
* Default MVP Assumption if Unanswered:

If there are no blocking questions, write:

> No blocking open questions. Proceed with the simplest MVP assumptions listed above.

---

## Recommended Next Step

State the single best next action to begin execution.

This should be concrete, such as:

* Inspect a specific file
* Create a specific minimal module
* Add a specific MVP test
* Implement Phase 1
* Confirm a specific scope boundary

Do not recommend multiple parallel next steps.

---

# Generation Rules

1. Prefer verified facts over assumptions.
2. Inspect code and documentation when available.
3. Treat MVP scope as a hard constraint, not a suggestion.
4. Do not add features, abstractions, dependencies, workflows, agents, or data sources unless directly required for MVP validation.
5. Every included task must have an MVP justification.
6. Separate required work from deferred work.
7. Prefer existing project patterns over new architecture.
8. Prefer manual or simple validation when enough for MVP.
9. Avoid vague tasks such as “improve the code” without concrete scope.
10. Avoid broad refactors unless they directly unblock the MVP.
11. Keep the plan concise but complete.
12. Ask only blocking questions.
13. Do not invent future requirements.
14. Do not optimize for scale before the MVP proves value.
15. Do not create generic systems for single-use needs.
16. The output should be suitable to save as a project planning document.
17. If the proposed solution feels elegant, pause and check whether it is too large.
18. If the plan contains more than one new abstraction, justify each one or remove it.
19. If the plan adds a new dependency, explain why existing dependencies cannot satisfy the MVP.
20. If an item is useful but not essential, defer it.
21. Apply conditional add-ons only when the project clearly matches the add-on category.
22. Do not let optional add-ons dominate ordinary MVP projects.
23. If an add-on does not apply, omit it from the generated plan.
24. If the plan includes mutation or automated action, justify why advisory or read-only behavior is not enough for MVP.
25. If the plan includes a UI, dashboard, or visualization, justify why plain output or existing UI is not enough for MVP.
26. If the plan includes support for multiple providers, platforms, or modes, justify why one narrow path is not enough for MVP.

---

# Final Self-Check Before Output

Before finalizing the plan, silently verify:

* Did I include anything not required for the MVP?
* Did I defer obvious nice-to-have work?
* Did I avoid speculative architecture?
* Did I justify every major decision?
* Did I keep the implementation path small?
* Did I protect the coding agent from scope creep?
* Did I keep the universal MVP rules dominant?
* Did I apply conditional add-ons only when relevant?
* Did I avoid turning the MVP into a platform?

If any answer is unsatisfactory, revise the plan before output.
