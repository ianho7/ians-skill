---
name: case-study-writing
description: >
  Turn a completed engineering case, debugging session, performance optimization, architecture
  decision, AI-agent workflow, or product iteration into a detailed case study article. Use when
  the user wants to write a public or internal article that explains the problem, investigation
  process, evidence, skill or agent workflow usage, tradeoffs, final decision, and reusable lessons.
---

# Case Study Writing

The goal is not to produce a polished victory story. The goal is to preserve the real engineering process — problem, investigation, evidence, tradeoffs, decision, and reusable lessons.

---

## Purpose

Use this skill to turn a real engineering case into a detailed case study article.

The goal is to preserve the real engineering process:

* the original problem
* why it was hard to reason about
* what was tried
* what evidence was collected
* which assumptions were wrong
* which tools, skills, prompts, or agent workflows helped
* which options were rejected
* why the final decision was chosen
* what reusable lessons can help future work

A good case study should help another engineer understand both the result and the reasoning path.

---

## Core Principle

A case study is not a summary.

A case study is a reconstructed decision trail.

Do not make the process look cleaner than it was.

Preserve:

* uncertainty
* detours
* false starts
* rejected ideas
* tradeoffs
* measurement gaps
* user decisions
* agent contributions
* final constraints

The article should be honest, useful, and specific.

---

## When To Use

Use this skill when the user says things like:

* "I want to write an article about this case."
* "Help me turn this performance optimization into a detailed write-up."
* "I want to summarize this debugging process as a blog post."
* "This Codex/Claude session has a lot worth writing about."
* "Help me write a case study from this engineering work."
* "I want to explain how skills helped solve this problem."
* "Turn this optimization process into a technical article."
* "Help me write a retrospective with technical depth."

Also use it for:

* performance optimization case studies
* debugging retrospectives
* architecture decision write-ups
* AI agent workflow articles
* MVP planning retrospectives
* code review process write-ups
* incident analysis articles
* tool-building case studies
* product engineering decision records

---

## When Not To Use

Do not use this skill when:

* The user only wants a short summary.
* The case has not happened yet.
* The user only wants a PRD, issue, or handoff.
* The user wants to extract reusable skills rather than write an article.
* There is no real evidence, process, or decision trail.
* The material is too thin to support a case study.
* The user wants marketing copy rather than an engineering article.

If the user wants to extract reusable skills from the case, use `extract-skill-from-case` first.

If the user wants to create a skill from the case, use `write-high-quality-skill` after extraction.

Recommended workflow:

```text
real engineering case
→ extract-skill-from-case
→ optional write-high-quality-skill
→ case-study-writing
```

---

## Phase 0: Material Gate

Before writing, judge whether the available material is enough.

This phase is mandatory.

Classify the material:

| Level        | Condition                                                                    | Action                                                   |
| ------------ | ---------------------------------------------------------------------------- | -------------------------------------------------------- |
| Enough       | The case has a clear problem, process, evidence, final decision, and outcome | Proceed with full article planning                       |
| Partial      | The case has a clear problem and outcome, but lacks details or evidence      | Produce an outline, mark gaps, and ask focused questions |
| Insufficient | The case is only a vague topic or success claim                              | Stop and ask for minimum material                        |

Minimum useful material:

* what problem was being solved
* why the problem mattered
* what the initial symptoms were
* what evidence or data was available
* what approaches were considered
* what tools, skills, prompts, or agent workflows were used
* what final option was chosen
* why other options were rejected
* what the final result was
* what lessons should be preserved

If material is insufficient, do not write a fake full article.

Ask for the smallest useful input:

```text
Please provide these 6 items:
1. What problem was solved?
2. What was the initial symptom or pain point?
3. What evidence, logs, benchmark reports, or outputs do you have?
4. Which skills, prompts, or agent workflows helped?
5. What final solution was chosen?
6. What options were rejected and why?
```

If material is partial, continue with a lightweight outline and clearly label:

* Known
* Inferred
* Missing
* Needs confirmation

Completion criterion:

* The agent has decided whether to write fully, outline only, or stop for missing material.
* The agent does not invent data, decisions, or results.

---

## Phase 1: Reconstruct The Case Story

Reconstruct the case as a compact story path.

Use this table:

| Stage | What happened | Evidence or artifact | Turning point |
| ----- | ------------- | -------------------- | ------------- |

Look for:

* the original problem
* the first misleading assumption
* the moment the scope became clearer
* the first useful measurement or evidence
* the skill or prompt that changed the investigation
* the comparison of alternatives
* the final decision point
* the result
* the reusable lesson

Do not include every chat turn.

Include only steps that changed understanding or decision-making.

Completion criterion:

* The article has a clear narrative spine.
* The case is not reduced to a flat chronological log.
* The main turning points are visible.

---

## Phase 2: Define The Article Angle

Choose one primary article angle.

Do not try to write every possible article at once.

Common angles:

| Angle                               | Use when                                                                               |
| ----------------------------------- | -------------------------------------------------------------------------------------- |
| Technical deep dive                 | The main value is explaining the problem and solution in detail                        |
| Debugging retrospective             | The main value is how the root cause was found                                         |
| Performance optimization case study | The main value is measurement, bottleneck isolation, and tradeoff selection            |
| AI agent workflow article           | The main value is how skills or prompts constrained the agent and improved the process |
| Architecture decision article       | The main value is comparing options and explaining why one was chosen                  |
| MVP scope article                   | The main value is explaining why attractive options were rejected                      |
| Process methodology article         | The main value is extracting a reusable workflow from the case                         |

Output:

```text
Primary angle:
Secondary angle:
What this article is about:
What this article is not about:
Target reader:
Reader takeaway:
Main narrative line:
Supporting thread:
```

Completion criterion:

* The article has one main promise.
* Secondary topics support the main promise instead of hijacking it.
* If the user has not made the primary angle clear enough, the agent asks before drafting.
* The draft has one main narrative line and any secondary thread is explicitly subordinate.

---

## Phase 3: Build The Evidence Map

Before drafting, map claims to evidence.

Use this table:

| Claim | Evidence | Strength | Missing proof | How to write it safely |
| ----- | -------- | -------- | ------------- | ---------------------- |

Evidence can include:

* benchmark results
* logs
* screenshots
* code diffs
* timing data
* test results
* reports
* user observations
* agent outputs
* rejected option analysis
* final implementation notes

Evidence strength:

| Strength | Meaning                                                  |
| -------- | -------------------------------------------------------- |
| Strong   | Supported by direct data or reproducible result          |
| Medium   | Supported by several observations but not fully measured |
| Weak     | Plausible but not proven                                 |
| Unknown  | Mention only as uncertainty or future work               |

Writing rules:

* Do not turn weak evidence into strong claims.
* Do not invent benchmark numbers.
* Do not say "proved" when the case only suggests.
* Do not say "best" when the real decision was "best for current constraints."
* Keep missing evidence visible when it matters.

Completion criterion:

* Important claims are grounded.
* Uncertainty is not hidden.
* The article will not overstate the result.

---

## Phase 4: Design The Article Structure

Create one article outline before drafting.

Use this base structure unless the case clearly needs a different shape.

Before locking the outline, explicitly mark:

- which sections are core and deserve the most space
- which sections are supporting context only
- which sections should stay short even if the underlying process was long

Do not let every section become equally important. If everything is treated as a headline, the article will feel long without feeling focused.

Use this base structure unless the case clearly needs a different shape:

```markdown
# Title

## Introduction: What Problem Was Worth Writing About?

## 1. Problem Background

## 2. Why The Problem Was Harder Than It Looked

## 3. Investigation Path

## 4. Evidence, Measurements, Or Reports

## 5. Skill Or Agent Workflow Usage

## 6. Options Compared

## 7. Final Decision

## 8. Result, Remaining Risks, And Limits

## 9. Reusable Lessons

## Conclusion
```

Adjust this base structure instead of creating a second parallel structure.

For a performance optimization case, adjust the outline by:

* making "Problem Background" include the runtime path or execution path
* making "Why The Problem Was Harder Than It Looked" emphasize misleading bottleneck guesses
* making "Evidence, Measurements, Or Reports" include baseline, stage timing, benchmarks, or configuration comparisons
* making "Options Compared" include performance benefit, complexity, risk, maintainability, and rollback cost
* making "Result, Remaining Risks, And Limits" include before/after metrics and unmeasured areas
* getting to the first real technical bottleneck quickly instead of spending too much space on setup or background

For an AI agent workflow case, adjust the outline by:

* making "Why The Problem Was Harder Than It Looked" explain what the agent would likely do wrong without constraints
* making "Skill Or Agent Workflow Usage" the main body section
* making "Options Compared" include human decisions, rejected agent directions, and process tradeoffs
* making "Reusable Lessons" focus on how to constrain future agent work

For an architecture decision case, adjust the outline by:

* making "Problem Background" describe the design pressure or codebase friction
* making "Evidence, Measurements, Or Reports" include code examples, dependency shape, maintenance pain, or test friction
* making "Options Compared" the central section
* making "Final Decision" explain why the chosen option fits current constraints

Completion criterion:

* The outline supports the chosen angle.
* There is only one active outline.
* Case-specific adjustments modify the base outline instead of replacing it with a competing structure.
* The article has a clear beginning, middle, and end.
* The article reaches the core technical problem early enough.
* Side topics do not consume the same weight as the main thread.

---

## Phase 5: Write The Draft

Write the article from the outline.

Prioritize clarity over decoration.

The draft should include:

* concrete problem statement
* technical context
* what made the problem non-obvious
* how the investigation progressed
* where skills, prompts, or agents helped
* evidence tables where useful
* options considered
* final decision
* rejected alternatives
* result
* remaining limitations
* reusable lessons

Use tables when they make the reasoning clearer:

* before / after metrics
* hypothesis validation
* option comparison
* skill usage mapping
* rejected alternatives
* final tradeoff summary

Actively look for places where a figure, chart, flow diagram, or compact table would improve comprehension.

Especially consider visuals when the article contains:

* multiple benchmark or timing comparisons
* baseline vs variant comparisons
* configuration or experiment matrix comparisons
* option evaluation and tradeoff decisions
* workflow loops or investigation paths that are easier to understand visually

If a visual would materially reduce explanation burden, explicitly note the opportunity in the draft instead of leaving it implicit.

Writing style:

* Be specific.
* Be honest.
* Preserve uncertainty when evidence is incomplete.
* Show the decision trail.
* Explain tradeoffs in plain technical language.
* Keep the role of skills or agents concrete.
* Avoid excessive ornament when the article needs evidence.
* Do not flatten the story into a dry changelog.
* Get to the core theme early instead of spending too long on preamble.
* Keep secondary material disciplined so the article does not become “all important sections, therefore no clear focus.”

Completion criterion:

* The draft explains both what happened and why decisions were made.
* The article is useful even to someone who does not know the original project.
* The role of skills or agents is specific, not promotional.
* The draft reaches the main technical thread early enough.
* The article can be written and refined in stages if the case is long or evidence-heavy, rather than forcing a single monolithic drafting pass.

---

## Phase 6: Review The Draft

Review the draft before finalizing.

Use this checklist:

| Check              | Question                                                                  |
| ------------------ | ------------------------------------------------------------------------- |
| Problem clarity    | Can a reader understand the original pain point?                          |
| Evidence           | Are major claims backed by data, logs, reports, or explicit observations? |
| Scope              | Is the article focused on one main angle?                                 |
| Narrative priority | Does the article clearly distinguish the main thread from supporting material? |
| Front-loaded value | Does the article reach the core technical problem early enough?                |
| Tradeoffs          | Does it explain why the final option was chosen over alternatives?        |
| Skill usage        | Does it explain how skills helped without exaggerating them?              |
| Human judgment     | Does it show where the user made key decisions?                           |
| Honesty            | Are uncertainty, missing data, and remaining risks visible?               |
| Reusability        | Can readers apply the method to their own work?                           |
| Readability        | Is the structure easy to follow?                                          |
| Non-marketing tone | Does it avoid sounding like an AI tool advertisement?                     |

If the draft fails any important check, revise it.

Pay special attention to these failure modes:

- the article spends too long warming up before reaching the main technical problem
- several themes are treated like co-equal main stories
- useful but secondary material consumes too much space
- the article describes many interesting details but leaves the reader unclear about the real point

Completion criterion:

* The final article is grounded, readable, and reusable.
* It does not overclaim.
* It preserves the real decision trail.

---

## Required Final Output

When this skill finishes, output:

1. Material status
2. Case story path
3. Article angle
4. Evidence map
5. Article outline
6. Missing material, if any
7. Draft article, if material is enough
8. Revision notes or next questions, if material is partial

If material is insufficient, do not output a full article. Ask for the minimum missing material.

---

## Section Writing Guide

This guide explains how to fill the outline from Phase 4.

It is not a second outline.

Use only the guidance that fits the active outline.

### Introduction: What Problem Was Worth Writing About?

Explain:

* what happened
* why the case is worth writing about
* what the article will teach
* what the article will not cover

Avoid starting with a long tool introduction.

Start from the problem.

### Problem Background

Explain:

* what the system does
* what the user was trying to achieve
* what went wrong
* why it mattered
* what constraints existed

For performance cases, include the execution path or data path.

For architecture cases, include the codebase pressure or design friction.

### Why The Problem Was Harder Than It Looked

Explain:

* what seemed obvious at first
* why that explanation was tempting
* why it was not enough
* what could have gone wrong if the team acted too early

This section should make the reader understand why a disciplined process was needed.

### Investigation Path

Explain:

* how the problem was narrowed
* which hypotheses were created
* what evidence was collected
* what changed the direction
* which assumptions were rejected

Do not make the path look more linear than it was.

### Evidence, Measurements, Or Reports

Explain:

* what was measured or compared
* what the data showed
* what the data did not prove
* which evidence was strong or weak

Use tables where possible.

For performance cases, include:

* baseline
* stage timing
* configuration comparison
* before / after metrics
* unmeasured risks

### Skill Or Agent Workflow Usage

Explain each skill or prompt by its role in the process.

Example table:

| Skill or workflow | Role in the case | What it prevented | Output |
| ----------------- | ---------------- | ----------------- | ------ |

Skill usage should be specific.

Bad:

```text
The skill helped analyze the problem.
```

Better:

```text
The skill forced the agent to separate render time from PNG encode time before proposing optimizations.
```

### Options Compared

Compare options with criteria.

Example table:

| Option | Benefit | Cost | Risk | Why accepted or rejected |
| ------ | ------- | ---- | ---- | ------------------------ |

Do not compare only by performance.

Also consider:

* implementation complexity
* maintenance cost
* API impact
* output quality
* compatibility
* testability
* rollback cost
* MVP fit
* future extension

### Final Decision

Explain:

* what was chosen
* why it was chosen
* what it solved
* what it did not solve
* what evidence supported it
* what tradeoff was accepted

Avoid claiming the final option is universally best.

It only needs to be best for the case constraints.

### Result, Remaining Risks, And Limits

Use before / after data if available.

If exact data is missing, say so.

Explain:

* what improved
* what remained unresolved
* what risks still exist
* what would be measured next

Do not invent numbers.

### Reusable Lessons

Extract practical lessons.

Good lessons are process-shaped:

* Build the path before optimizing.
* Separate hypotheses from conclusions.
* Measure before choosing an option.
* Compare multiple configs as experiments.
* Use skills to constrain agent behavior.
* Choose the best current option, not the theoretical maximum.

Weak lessons are generic:

* AI is useful.
* Performance matters.
* Testing is important.

### Conclusion

Return to the case.

Explain:

* what was learned
* what changed because of the process
* what readers can reuse
* what future work remains

Avoid motivational fluff.

---

## Guardrails

Do not:

* let the article drift into multiple competing main topics without explicitly choosing one
* spend so long on background that the article reaches the core problem too late
* treat every interesting branch as equally worthy of full expansion
* miss obvious opportunities for visuals when comparisons, measurements, or tradeoffs are central
* invent data
* hide uncertainty
* write a generic tutorial if the user asked for a case study
* write marketing copy for AI tools
* claim the skill solved the problem by itself
* ignore the user's role in the decision
* treat the final option as universally best
* skip option comparison when the case involved tradeoffs
* skip evidence mapping when the article makes technical claims
* write the full draft if the material is insufficient
* convert every lesson into a skill inside this article
* use multiple competing outlines in the same draft

---

## Context Hygiene

Decide where each output belongs:

| Output                  | Better home                                     |
| ----------------------- | ----------------------------------------------- |
| Full article            | Blog draft, docs article, or publication folder |
| Raw benchmark data      | Performance report                              |
| Stable project decision | ADR or project docs                             |
| Follow-up task          | Issue or checklist                              |
| Reusable workflow       | Skill                                           |
| Long-session context    | Handoff                                         |
| Prompt wording          | Prompt snippet                                  |
| Case-specific details   | Article or project notes                        |

Do not duplicate the same decision across multiple files.

Reference existing artifacts when possible.

---

## Completion Criteria

This skill is complete when:

* material sufficiency has been judged
* the case story path is reconstructed
* the article angle is chosen
* claims are mapped to evidence
* one active outline is produced
* missing materials are clearly marked
* a draft is written only when evidence is sufficient
* the draft explains problem, process, skill usage, tradeoffs, final decision, and reusable lessons
* the article does not overclaim or invent data

---

## Suggested Next Skills

After this skill, consider:

* `extract-skill-from-case` if the article reveals reusable workflows that should become skills
* `write-high-quality-skill` if the user wants to turn one extracted workflow into a skill
* `handoff` if the article project needs to continue in another session
* `review` if the article draft needs technical or editorial review
