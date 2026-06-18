---
name: write-high-quality-skill
description: >
  Create high-quality agent skills in the style of Matt Pocock's skills.
  Use when the user wants to turn a repeated workflow, engineering lesson, debugging process,
  planning method, review pattern, or project-specific practice into a reusable skill.
  This skill focuses on determinism, trigger design, workflow phases, completion criteria,
  artifacts, guardrails, and context hygiene.
---

# Write High-Quality Skill

The goal is not to write a longer prompt. The goal is to design a small, sharp, reliable workflow that makes agent behavior more predictable.

---

## Purpose

Use this skill to turn a useful workflow or repeated engineering lesson into a reusable agent skill.

A high-quality skill should answer:

* When should this skill be used?
* What bad agent behavior does it prevent?
* What exact workflow should the agent follow?
* What evidence or artifact proves progress?
* When should the agent stop, ask, continue, or hand off?
* What should the agent explicitly avoid?

---

## Core Principle

A skill exists to reduce randomness in agent behavior.

Before writing the skill, identify the failure mode:

* Does the agent start coding too early?
* Does it over-design?
* Does it skip measurement?
* Does it guess instead of verifying?
* Does it ask too many questions at once?
* Does it lose context across sessions?
* Does it produce vague analysis without decisions?
* Does it create documents that duplicate existing artifacts?
* Does it mark work complete without tests or review?

If you cannot identify the failure mode, do not write the skill yet. First clarify what repeated behavior this skill is meant to stabilize.

---

## Do Not Start By Writing The Skill

First interview the user briefly.

Ask only the minimum questions needed to identify:

1. The repeated workflow
2. The bad behavior to prevent
3. The expected artifact
4. The trigger conditions
5. The completion criteria

Ask one question at a time if the user's context is vague.

If enough context already exists, do not ask unnecessary questions. Proceed with a best-effort draft and mark assumptions clearly.

---

## Phase 1: Extract The Workflow

Summarize the workflow the user wants to preserve.

Output:

* Workflow name
* User scenario
* Typical input
* Expected output
* Why this workflow matters
* What usually goes wrong without a skill

Completion criterion:

* The skill has a clear job.
* The skill is not a vague "help me analyze" prompt.
* The failure mode is explicit.

---

## Phase 2: Define The Trigger

Write a precise `description`.

The description must behave like a trigger, not a marketing sentence.

It should include:

* What the skill does
* When to use it
* User phrases or situations that should activate it
* The type of output it creates
* Optional exclusion cases if misuse is likely

Bad description:

```yaml
description: Helps analyze problems.
```

Better description:

```yaml
description: Diagnose performance problems by building a repeatable baseline, separating likely bottlenecks, ranking falsifiable hypotheses, and measuring before optimizing. Use when the user reports slow exports, latency regressions, unclear benchmark results, or wants help finding the root cause of a performance issue.
```

Completion criterion:

* The description is specific enough that an agent can decide when to use the skill.
* It does not describe a broad personality trait.
* It does not overlap too much with another skill.

---

## Phase 3: Decide The Skill Type

Classify the skill.

Choose one primary type:

| Type                     | Use when                                                                   |
| ------------------------ | -------------------------------------------------------------------------- |
| Router skill             | It decides which skill or workflow to use next                             |
| Interview skill          | It asks questions to clarify a plan, idea, or requirement                  |
| Diagnosis skill          | It finds causes using evidence, measurements, and falsifiable hypotheses   |
| Planning skill           | It converts a goal into a constrained implementation plan                  |
| Implementation skill     | It guides code changes, tests, checks, and review                          |
| Review skill             | It evaluates code, plans, designs, or documents                            |
| Prototype skill          | It creates throwaway experiments to answer a specific question             |
| Handoff skill            | It preserves context for another session or agent                          |
| Writing skill            | It turns raw material into a reusable article, PRD, report, or document    |
| Project governance skill | It enforces scope, MVP boundaries, architecture rules, or team conventions |

Completion criterion:

* The skill has one dominant type.
* It does not try to be router + planner + implementer + reviewer + writer all at once.

---

## Phase 4: Design The Workflow Phases

Write the skill as phases.

Each phase must include:

* What the agent does
* What the agent must not do
* What artifact or evidence is produced
* Completion criterion

Recommended structure:

```markdown
## Phase 1: Bound the problem

...

Completion criterion:

- ...
- ...

## Phase 2: Build the working model

...

Completion criterion:

- ...
- ...

## Phase 3: Produce the artifact

...

Completion criterion:

- ...
- ...

## Phase 4: Review and handoff

...

Completion criterion:

- ...
- ...
```

Avoid vague instructions like:

* Think carefully
* Be comprehensive
* Analyze deeply
* Consider all aspects
* Give the best answer

Replace them with observable actions:

* Build a hypothesis table
* Record baseline metrics
* List rejected alternatives
* Identify the public interface
* Run typecheck and tests
* Write a handoff note
* Ask one blocking question
* Mark assumptions explicitly

Completion criterion:

* Every phase can be checked.
* The agent cannot honestly claim completion without producing the required evidence or artifact.

---

## Phase 5: Add Guardrails

Every high-quality skill should say what not to do.

Add a `Do not` section when the workflow has common failure modes.

Examples:

```markdown
## Do Not

- Do not modify code before establishing a baseline.
- Do not introduce new dependencies without explicit justification.
- Do not turn a feasibility discussion into an implementation plan.
- Do not treat missing errors as proof that the system is healthy.
- Do not create duplicate documents when an existing artifact should be referenced.
- Do not ask the user questions that can be answered by reading the repo.
- Do not expand MVP scope unless the user explicitly approves it.
```

Completion criterion:

* Guardrails target real failure modes.
* They are not generic moral advice.
* They prevent scope drift, premature implementation, false certainty, or context pollution.

---

## Phase 6: Define The Artifact

A skill should usually create or update one clear artifact.

Examples:

| Skill type            | Artifact                                                |
| --------------------- | ------------------------------------------------------- |
| Diagnosis             | Hypothesis table, evidence log, root cause summary      |
| Performance diagnosis | Baseline, stage timing table, bottleneck decision       |
| Planning              | MVP-constrained implementation plan                     |
| Prototype             | Throwaway experiment result and recommendation          |
| Review                | Findings grouped by severity and confidence             |
| Handoff               | Session handoff document                                |
| Writing               | Outline, missing-material list, final draft             |
| Architecture          | Candidate report, tradeoff table, recommended next step |

The artifact must include uncertainty.

Require the agent to distinguish:

* Facts
* Evidence
* Assumptions
* Hypotheses
* Decisions
* Open questions
* Rejected alternatives

Completion criterion:

* The output is reusable by another agent or future session.
* The output is not just a conversational answer.

---

## Phase 7: Add User Checkpoints

The agent should not make high-impact decisions silently.

Add checkpoints before:

* Changing architecture
* Expanding scope
* Introducing dependencies
* Writing many files
* Choosing between major alternatives
* Turning a prototype into production code
* Finalizing a PRD or issue list
* Declaring root cause without strong evidence

Checkpoint format:

```markdown
Before proceeding, present:

- Current understanding
- Options
- Recommendation
- Tradeoffs
- What will happen next

Then wait for user confirmation unless the user explicitly asked for autonomous execution.
```

Completion criterion:

* The skill allows agent autonomy for low-risk work.
* The skill requires user input at high-leverage decision points.

---

## Phase 8: Add Context Hygiene

Decide where information belongs.

The skill should avoid creating context sludge.

Include rules such as:

* Temporary findings go in handoff or scratch notes.
* Stable project language goes in `CONTEXT.md`.
* Architecture decisions go in ADR.
* Product decisions go in PRD or issue tracker.
* Experimental results should say whether the prototype should be deleted, kept, or converted.
* Do not duplicate full content from existing artifacts. Reference paths or links when possible.

Completion criterion:

* The skill says what should be persisted.
* The skill says what should remain temporary.
* The skill avoids scattering the same decision across multiple documents.

---

## Phase 9: Keep The Skill Small

A high-quality skill should be composable.

If the skill tries to do too much, split it.

Split when it contains multiple independent workflows, such as:

* Idea grilling
* Diagnosis
* Implementation
* Review
* Handoff
* Article writing

Prefer a chain of small skills:

```text
grill → diagnose → prototype → implement → review → handoff
```

Instead of one giant skill:

```text
do-everything-perfectly
```

Completion criterion:

* The skill has one main job.
* Other jobs are delegated to other skills.
* The skill can be reused in more than one project.

---

## Phase 10: Final Skill Output Format

When writing the final skill, output it as a complete `SKILL.md` file.

Use this structure:

```markdown
---
name: skill-name
description: Specific trigger-oriented description.
---

# Skill Title

## Purpose

...

## When To Use

...

## When Not To Use

...

## Core Principle

...

## Workflow

### Phase 1: ...

...

Completion criterion:

- ...

### Phase 2: ...

...

Completion criterion:

- ...

## Required Output

...

## Do Not

...

## User Checkpoints

...

## Context Hygiene

...

## Completion Criteria

The skill is complete when:

- ...
- ...
- ...

## Suggested Next Skills

- ...
- ...
```

Only include sections that are useful. Do not add empty ceremony.

---

## Quality Checklist

Before finalizing the skill, check:

* Is the failure mode explicit?
* Is the trigger description specific?
* Is the skill small enough?
* Does it have phases?
* Does each phase have completion criteria?
* Does it produce a reusable artifact?
* Does it require evidence instead of vibes?
* Does it prevent premature action?
* Does it include guardrails?
* Does it define user checkpoints?
* Does it preserve context cleanly?
* Can another agent use it without reading the original conversation?
* Does it avoid project-specific details unless the skill is intentionally project-specific?

If any answer is no, revise the skill.

---

## Final Response To User

When delivering the skill, include:

1. Suggested file path
2. Complete `SKILL.md`
3. Brief explanation of the design choices
4. Optional suggestions for related skills to create next

Do not over-explain if the user asked for the skill directly.