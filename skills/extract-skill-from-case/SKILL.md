---
name: extract-skill-from-case
description: >
  Extract reusable agent skill candidates from a completed engineering case, Codex/Claude
  conversation, debugging session, performance optimization, architecture discussion, or
  workflow retrospective. Use when the user has solved a real problem and wants to identify
  which lessons, prompts, decision patterns, guardrails, or workflows are worth turning
  into reusable skills.
---

# Extract Skill From Case

The goal is not to summarize the case. The goal is to identify which parts represent repeatable workflows that can become reusable agent skills.

---

## Purpose

Use this skill to extract reusable skill ideas from a real engineering case.

A good output should help answer:

* What actually happened in the case?
* Which parts were one-off project details?
* Which parts are reusable workflows?
* What agent failure modes appeared or were avoided?
* Which lessons deserve a skill, prompt snippet, project doc, article section, or nothing?
* Which candidate skill should be written first?

---

## Core Principle

Not every lesson should become a skill.

A skill is worth creating only when it stabilizes a repeated workflow or prevents a recurring agent failure mode.

Do not turn every bug, trick, prompt sentence, benchmark, or project-specific decision into a skill.

Extract skills only when the case reveals a reusable process.

---

## When To Use

Use this skill when the user says things like:

* "This conversation has several things worth turning into skills."
* "I just solved a problem. Help me identify what should become a skill."
* "This performance optimization process was valuable. Help me extract reusable skills from it."
* "I finished a Codex/Claude session and want to preserve the workflow."
* "Help me turn this case into reusable agent workflows."
* "Which prompts are worth upgrading into skills?"
* "I want to make this debugging method reusable."

Also use it for:

* debugging retrospectives
* performance optimization cases
* architecture decision discussions
* MVP planning sessions
* code review workflows
* handoff workflows
* repeated Codex / Claude Code collaboration patterns

---

## When Not To Use

Do not use this skill when:

* The user only wants a normal summary
* The case has not happened yet
* The user already knows exactly which skill to write
* The material is too small to reveal a reusable pattern
* The lesson is purely project-specific and unlikely to repeat
* The user wants final article writing rather than skill extraction

If the user wants a final `SKILL.md`, use `write-high-quality-skill` after this skill finishes.

Recommended workflow:

```text
real engineering case
→ extract-skill-from-case
→ write-high-quality-skill
→ optional case-study-writing
```

---

## Phase 0: Material Gate

Before doing the extraction, judge whether the available material is enough.

This phase is mandatory.

Classify the material into one of three levels:

| Level        | Condition                                                           | Action                                                                                  |
| ------------ | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Enough       | There is a clear case, outcome, and at least some process detail    | Proceed with full extraction                                                            |
| Partial      | There is a clear outcome, but the process or evidence is incomplete | Produce a lightweight extraction, mark gaps, and ask 1 to 3 focused follow-up questions |
| Insufficient | There is no concrete case, no outcome, or only a vague topic        | Stop and ask for the minimum missing material                                           |

Minimum useful material:

* What problem was solved
* What the final outcome was
* What agent interaction or workflow helped
* What should be reused in the future
* Any mistakes, detours, or rejected directions

If material is insufficient, do not pretend to complete the full extraction.

Ask for the smallest useful input:

```text
Please provide these 4 items:
1. What specific problem was solved?
2. What was the final outcome?
3. Which prompts, skills, or agent behaviors were most useful?
4. Which parts do you expect to face again in future work?
```

If material is partial, continue with a compact output and clearly label uncertain parts as:

* Known
* Inferred
* Missing
* Needs confirmation

Completion criterion:

* The agent has decided whether to proceed fully, proceed lightly, or stop for missing material.
* The agent does not use weak material to manufacture a full-looking report.

---

## Phase 1: Reconstruct The Case Path

Reconstruct the case in a compact timeline.

Do not over-polish the story. Preserve the real sequence, including uncertainty, reversals, and decisions.

Use this table:

| What happened | Who drove it | Result or turning point |
| ------------- | ------------ | ----------------------- |

Guidance:

* "What happened" should describe the meaningful step, not every chat turn.
* "Who drove it" should distinguish user, agent, data, test result, or external constraint.
* "Result or turning point" should capture what changed because of this step.

Look for moments such as:

* a vague problem becoming bounded
* scope being narrowed
* the agent being stopped from premature action
* a hypothesis being created
* measurement being added
* multiple options being compared
* a direction being rejected
* a final decision being made
* a reusable process becoming visible

Completion criterion:

* The case path shows how the problem evolved.
* The path is short enough to read.
* It identifies major turning points rather than every detail.

---

## Phase 2: Extract Patterns, Failure Modes, And Value

Extract reusable patterns from the case and grade their value.

A pattern is reusable when it can help future cases beyond this exact project.

For each pattern, identify the agent failure mode it prevents or the workflow behavior it stabilizes.

Use this table:

| Pattern or lesson | Evidence from case | Failure mode prevented | Reuse value | Best home | Reason |
| ----------------- | ------------------ | ---------------------- | ----------- | --------- | ------ |

Reuse value:

| Value  | Meaning                                                                            |
| ------ | ---------------------------------------------------------------------------------- |
| High   | Likely to repeat, prevents costly agent failure, deserves a skill or skill section |
| Medium | Useful, but may fit better as a prompt snippet or addition to an existing skill    |
| Low    | Interesting, but too specific or too small to become a skill                       |
| None   | One-off detail, should not be preserved as workflow                                |

Best home options:

| Best home        | Use when                                                                     |
| ---------------- | ---------------------------------------------------------------------------- |
| New skill        | The workflow is repeated, has clear phases, and prevents a real failure mode |
| Existing skill   | The lesson strengthens an existing skill but does not deserve its own file   |
| Prompt snippet   | The wording is useful, but the workflow is too small for a skill             |
| Project doc      | The lesson is project-specific knowledge, vocabulary, or decision history    |
| Article material | The lesson is narratively useful but not a reusable workflow                 |
| Nothing          | The lesson is too specific, obvious, or unlikely to repeat                   |

Common reusable patterns:

* turning a vague problem into a bounded scope
* forcing the agent to avoid premature coding
* building a performance path before optimizing
* separating hypotheses from conclusions
* using multiple reports as experiment groups
* comparing options by criteria instead of preference
* challenging MVP fit before implementation
* preserving long-session context with handoff
* turning a completed case into an article
* extracting reusable prompts from a long conversation

Common failure modes:

* starts coding too early
* optimizes without measurement
* treats guesses as conclusions
* expands scope
* over-designs
* ignores MVP stage
* asks too many questions at once
* compares options without criteria
* summarizes without extracting decisions
* turns a prototype into production code
* creates duplicate docs
* marks work complete without verification

Completion criterion:

* Reusable patterns are separated from one-off details.
* Failure modes are tied to concrete evidence from the case.
* Each pattern has a clear best home.
* The output does not inflate every lesson into a skill.

---

## Phase 3: Generate And Stress-Test Candidate Skills

Generate a small set of candidate skills from the high-value patterns in Phase 2.

Each candidate must have one main job.

Do not create a giant all-purpose skill.

Use this table:

| Candidate skill | Purpose | Trigger | Prevents | Artifact | Priority |
| --------------- | ------- | ------- | -------- | -------- | -------- |

Priority levels:

| Priority      | Meaning                                                             |
| ------------- | ------------------------------------------------------------------- |
| P0            | Should create now because it prevents a recurring high-cost failure |
| P1            | Useful soon, but not blocking                                       |
| P2            | Nice to have                                                        |
| Merge         | Better merged into an existing skill                                |
| Do not create | Better as note, prompt snippet, project doc, or article material    |

For each P0 or P1 candidate, stress-test it using the failure mode already identified in Phase 2.

Do not re-identify failure modes from scratch.

Use this table:

| Candidate | Keep / merge / reject | Linked Phase 2 failure mode | Reason | Better home if rejected |
| --------- | --------------------- | --------------------------- | ------ | ----------------------- |

Stress-test questions:

* Is this workflow likely to repeat?
* Does it clearly address the linked Phase 2 failure mode?
* Can it be triggered clearly?
* Can it produce a reusable artifact?
* Is it better than a normal prompt?
* Is it small enough?
* Does it overlap with an existing skill?
* Would another agent understand it without reading the original case?

Completion criterion:

* Weak candidates are rejected or merged.
* Strong candidates are sharpened.
* Candidate evaluation reuses Phase 2 failure modes instead of repeating the same analysis.
* The final candidate list is small enough to act on.

---

## Phase 4: Recommend The Next Skill To Write

Pick one best next skill.

Do not recommend writing many skills at once unless the user explicitly asks.

Selection criteria:

* highest reuse potential
* highest cost if not standardized
* clearest failure mode
* clearest trigger
* clearest artifact
* least overlap with existing skills
* strongest connection to the user's current workflow

Output:

```text
Recommended next skill:
- Name:
- Why this first:
- What it prevents:
- What it should produce:
- What it should not do:
- Suggested file path:
```

Completion criterion:

* The user knows exactly which skill to create first.
* The recommendation is practical, not maximalist.

---

## Phase 5: Prepare Brief For `write-high-quality-skill`

For the recommended skill, produce a compact brief that can be handed to `write-high-quality-skill`.

Format:

```markdown
# Skill Brief

## Proposed Name

...

## Purpose

...

## Trigger Conditions

Use when:

- ...

Do not use when:

- ...

## Main Failure Mode

...

## Workflow To Preserve

1. ...
2. ...
3. ...

## Required Artifact

...

## Guardrails

- ...
- ...

## User Checkpoints

- ...

## Context Hygiene

- ...

## Related Skills

- ...

## Notes From Case

- ...
```

Completion criterion:

* The brief is self-contained.
* Another agent can use it to write the final `SKILL.md`.
* The brief does not require reading the entire original case.

---

## Required Final Output

When this skill finishes, output only these sections:

1. Material status
2. Case path
3. Pattern, failure mode, and value table
4. Candidate skill table
5. Candidate stress-test table
6. Recommended next skill
7. Skill brief for `write-high-quality-skill`

If the material is partial, keep the output compact and include a short "Missing material" section.

If the material is insufficient, do not output all sections. Ask for the minimum missing material instead.

---

## Optional Article-Worthy Insights

Only output this section if the user explicitly says they want to write an article, case study, blog post, retrospective, or public write-up.

If enabled, extract article material separately:

| Article insight | Why it matters | Possible section |
| --------------- | -------------- | ---------------- |

Examples:

* why the initial problem was misleading
* how skill usage changed the investigation
* which wrong path was avoided
* why the final option was chosen
* what tradeoff mattered most
* what method can be reused by other engineers

Do not turn article insights into skills unless they represent a repeatable workflow.

---

## Guardrails

Do not:

* turn every lesson into a skill
* overfit the skill to one bug or one file
* produce a giant all-purpose skill
* skip Phase 0
* force a full extraction from insufficient material
* ignore the actual sequence of the case
* pretend the process was cleaner than it was
* hide uncertainty or failed attempts
* treat a useful prompt sentence as a complete skill
* create overlapping candidates without explaining merge options
* recommend implementation before extracting the workflow
* write the final `SKILL.md` unless the user explicitly asks for it
* invent data, benchmark results, or decisions that are not in the material
* make the skill sound more mature than the case evidence supports

---

## Context Hygiene

Decide where each extracted item belongs:

| Extracted item             | Better home                  |
| -------------------------- | ---------------------------- |
| Stable project vocabulary  | `CONTEXT.md` or project docs |
| Architecture decision      | ADR                          |
| Final option and tradeoff  | PRD, issue, ADR, or handoff  |
| Temporary debugging detail | Handoff or scratch note      |
| Benchmark result           | Performance note or report   |
| Reusable workflow          | Skill candidate              |
| Useful wording only        | Prompt snippet               |
| Case narrative             | Article draft                |
| Follow-up implementation   | Issue or checklist           |

Avoid copying the same decision into multiple places.

---

## Completion Criteria

This skill is complete when:

* material sufficiency has been judged
* the case path has been reconstructed at the right level of detail
* reusable patterns are separated from one-off details
* failure modes are linked to concrete patterns
* skill candidates are prioritized
* weak candidates are rejected or merged
* one best next skill is recommended
* a self-contained skill brief is produced
* the output is ready to pass into `write-high-quality-skill`