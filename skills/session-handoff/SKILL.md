---
name: session-handoff
description: Generate a comprehensive session handoff document from conversation history and repository state.

---

# Session Handoff Generator

## Purpose

Generate a handoff document that captures:

- Objectives
- Completed work
- Current project state
- Problems encountered
- Decision-making process
- Outstanding work
- Recommended next steps

The goal is to preserve enough context for a future session to continue work without rereading the entire conversation history.

---

# Instructions

Based on:

- Current conversation history
- Repository state
- Git status
- Git diff
- Git log
- Existing project documentation

Generate a handoff document and save it to:

docs/handoff/YYYY-MM-DD-HHMM.md

Create the directory automatically if it does not exist.

---

# Required Document Structure

## Session Objectives

Summarize the original goals of the session.

Include:

- Problems being solved
- Desired outcomes
- Scope of work

---

## Completed Work

List only work that was actually completed.

For each item include:

- Files modified
- Files added
- Files removed
- Purpose of the change
- Impact of the change

Do not include ideas that were only discussed.

---

## Current State

### Repository Status

- Build status
- Runtime status
- Test status

### Known Issues

- Bugs
- Risks
- Technical debt
- Unverified assumptions

### Module Status

For each major module:

- Current state
- Stability level
- Remaining concerns

---

## Problems Encountered and Decision Process

For every significant problem:

### Problem

Describe the issue.

### Investigation

Explain how the problem was analyzed.

Include:

- Evidence
- Logs
- Metrics
- Observations

### Solutions Considered

List all major options discussed.

For each option:

- Description
- Pros
- Cons
- Risks

### Final Decision

State the selected solution.

### Rationale

Explain why this solution was chosen.

### Future Implications

Describe any tradeoffs, risks, or follow-up considerations.

---

## Outstanding Work / TODO

### High Priority

Critical unfinished work.

### Medium Priority

Important but non-blocking work.

### Low Priority

Future improvements.

### Deferred Ideas

Ideas discussed but intentionally postponed.

### Validation Tasks

Items that still need testing or verification.

---

## Key Decisions and Context

Capture long-term project knowledge.

Include:

- Architectural decisions
- Design principles
- Constraints
- Assumptions
- Rejected approaches and reasons

Focus on information that cannot be easily inferred from code.

---

## Recommended Next Steps

### Starting Point

Where should the next session begin?

### Suggested Execution Plan

Ordered list of recommended actions.

### Context to Review

Files, documents, or discussions that should be reviewed first.

### Success Criteria

How to determine that the next phase is complete.

---

# Generation Rules

1. Prefer facts over assumptions.
2. Use Git information whenever available.
3. Never report unfinished work as completed.
4. Clearly mark uncertain information.
5. Preserve important reasoning and tradeoffs.
6. Capture why decisions were made, not just what was done.
7. Optimize for future session continuity.
8. Assume the next engineer has not read the conversation.
9. Write concise but information-dense content.
10. The document should be sufficient for another engineer to continue the project with minimal additional context.