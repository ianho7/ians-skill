---
name: plan
description: Create a clear implementation plan from a user request, repository context, and project constraints.

---

# Plan

## Purpose

Use this skill when the user wants to turn an idea, requirement, bug, refactor, architecture change, or investigation goal into a structured implementation plan.

The goal is to produce a practical, actionable plan that future coding sessions can follow with minimal ambiguity.

---

# Instructions

Based on:

- The user's request
- Current conversation context
- Repository state
- Existing project documentation
- Relevant code structure
- Known constraints and risks

Generate a plan document that explains what should be done, why it should be done, how it should be implemented, and how success should be validated.

When repository access is available, inspect the relevant files before writing the plan. Do not assume the implementation details if they can be verified from the codebase.

---

# Required Output Structure

## Objective

Summarize the goal of the plan.

Include:

- What problem is being solved
- What outcome is expected
- What is in scope
- What is out of scope

---

## Background and Context

Explain the relevant context needed to understand the plan.

Include:

- Existing behavior
- Current architecture or workflow
- Important files or modules
- Prior decisions or constraints
- Any assumptions being made

Clearly mark assumptions that have not been verified.

---

## Current State Analysis

Describe the current project state.

Include:

- Relevant files and their roles
- Existing implementation details
- Known limitations
- Known bugs or risks
- Dependencies or external systems involved

If information is uncertain, state what needs to be checked.

---

## Proposed Solution

Describe the recommended solution.

Include:

- High-level approach
- Main design decisions
- Expected behavior after implementation
- How the solution fits into the existing project
- Why this approach is preferred

---

## Alternatives Considered

List meaningful alternatives that were considered.

For each alternative, include:

- Description
- Advantages
- Disadvantages
- Risks
- Reason it was not selected

Do not invent alternatives if none are relevant, but include at least the obvious options when the problem involves design tradeoffs.

---

## Implementation Plan

Break the work into clear phases.

For each phase, include:

- Goal
- Files likely to be changed
- Concrete tasks
- Expected result
- Dependencies on previous phases

Use this structure:

### Phase 1: <Name>

- Goal:
- Files:
- Tasks:
- Expected Result:

### Phase 2: <Name>

- Goal:
- Files:
- Tasks:
- Expected Result:

Add more phases as needed.

---

## Validation Strategy

Describe how to verify the implementation.

Include:

- Unit tests
- Integration tests
- Manual checks
- Commands to run
- Expected outputs
- Failure cases to test

If tests do not exist yet, recommend what tests should be added.

---

## Risks and Mitigations

List major risks.

For each risk, include:

- Risk
- Impact
- Likelihood if known
- Mitigation
- Fallback plan

---

## Open Questions

List unresolved questions that need user input, code inspection, or further investigation.

Only include questions that are genuinely blocking or materially affect the plan.

---

## Recommended Next Step

State the single best next action to begin execution.

This should be concrete, such as:

- Inspect a specific file
- Create a specific module
- Add a specific test
- Implement Phase 1
- Confirm a specific design choice

---

# Generation Rules

1. Prefer verified facts over assumptions.
2. Inspect code and documentation when available.
3. Do not over-engineer the solution.
4. Make the plan actionable for a coding agent.
5. Separate decisions from assumptions.
6. Include tradeoffs when multiple approaches are possible.
7. Keep the plan concise but complete.
8. Avoid vague tasks such as "improve the code" without concrete steps.
9. Optimize for implementation clarity.
10. The output should be suitable to save as a project planning document.