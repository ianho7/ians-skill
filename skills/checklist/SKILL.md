---
name: checklist
description: Convert a plan, requirement, or technical goal into an actionable implementation checklist with automatic task reflection generation.

---

# Checklist with Automatic Reflection

## Purpose

Use this skill to convert a plan, requirement, bug fix, refactor, or implementation goal into a concrete checklist **and automatically generate a reflection document for each completed task**.

The reflection captures:

- Encountered problems
- Thought process
- Options considered
- Chosen solution
- Rationale

This enables session-level documentation and post-mortem analysis without manual prompting.

---

# Instructions

Based on:

- The user's request
- Existing plan or design notes
- Current conversation context
- Repository state
- Relevant project files
- Known constraints and risks

Generate a checklist with ordered, executable tasks. For each task, after completion, generate a reflection Markdown automatically.

---

# Required Output Structure

## Checklist Objective

Summarize what this checklist is intended to accomplish:

- Target outcome
- Scope
- Non-goals if relevant

---

## Pre-Implementation Checks

- [ ] Confirm target files or modules
- [ ] Review existing implementation
- [ ] Check related documentation
- [ ] Confirm dependencies
- [ ] Identify test commands

Only include items relevant to the task.

---

## Implementation Checklist

Break implementation work into phases.

Each checklist item must be:

- Atomic
- Actionable
- Verifiable
- Written as a task
- Small enough to complete independently

### Phase 1: <Name>

- [ ] Task 1 (on completion, automatically generate reflection.md)
- [ ] Task 2 (on completion, automatically generate reflection.md)

### Phase 2: <Name>

- [ ] Task 1 (on completion, automatically generate reflection.md)
- [ ] Task 2 (on completion, automatically generate reflection.md)

Add more phases as needed.

---

## Validation Checklist

- [ ] Unit tests (generate reflection.md upon any issue encountered)
- [ ] Integration tests
- [ ] Manual checks
- [ ] Build commands
- [ ] Runtime checks
- [ ] Edge case testing
- [ ] Regression checks

Each validation item should include expected result when useful.

---

## Documentation Checklist

- [ ] Update README
- [ ] Update architecture notes
- [ ] Add usage examples
- [ ] Update changelog
- [ ] Add comments for non-obvious logic

---

## Cleanup Checklist

- [ ] Remove unused code
- [ ] Remove temporary logs
- [ ] Remove experimental files
- [ ] Ensure naming consistency
- [ ] Ensure error messages are clear
- [ ] Ensure no secrets or local paths committed

---

## Completion Criteria

Define how to know the work is complete:

- Required behavior
- Required tests
- Required documentation
- Acceptable known limitations
- Final repository state

---

## Reflection / Task Summary Generation

**For each completed checklist item, automatically generate a Markdown file with the following template:**

```
docs/reflections/task-<task-id>-<timestamp>.md

- Task: <task name>
- Encountered Problem: <problem description>
- Thought Process: <how problem was analyzed>
- Options Considered: <list of solutions considered>
- Chosen Solution: <final decision>
- Rationale: <reason for choosing this solution>
```

**Rules for automatic reflection:**

1. Reflection must be generated without explicit user prompt.
2. Timestamped and saved in `docs/reflections/` directory.
3. Task ID must correspond to checklist item ID or name.
4. Include all significant reasoning steps and tradeoffs.
5. Format consistently for future review and post-mortem analysis.

---

# Checklist Quality Rules

1. Every item must be checkable.
2. Avoid vague tasks such as "improve implementation".
3. Prefer small, atomic tasks over large tasks.
4. Keep task order logical.
5. Separate implementation, validation, documentation, and cleanup.
6. Mark uncertain tasks clearly.
7. Include tests or validation wherever possible.
8. Generate reflection.md automatically for each task.
9. Optimize for execution clarity.
10. Output must be suitable for coding agents and future session review.