# Ticket Flow Verification

Load this reference only when AI-behavioral or hybrid verification is materially involved, or when acceptance design is genuinely ambiguous.

Do not load it for ordinary deterministic work by default.

Verification is scoped to the current Ticket unless that Ticket explicitly requires project-level or release-level evidence.

## 1. Verification profiles

Use these concepts when useful:

```text
deterministic
ai_behavioral
hybrid
```

The profile guides verification style; it does not need to become a heavy schema or framework.

## 2. Deterministic behavior

Use normal engineering verification when important behavior can be specified and reproduced deterministically.

Use whatever evidence is appropriate to the Ticket, such as tests, type checks, builds, browser validation, fixtures, contracts, or direct inspection.

Do not weaken deterministic guarantees merely because AI agents are performing the work.

Do not automatically broaden a scoped Ticket into full-project verification.

## 3. AI-behavioral behavior

Use AI-behavioral verification when model behavior is part of the product itself, such as agents, skills, prompts, LLM workflows, AI analysis, or generative interfaces.

The goal is not to force one exact output.

Preserve:

```text
required behavior
important constraints
useful flexibility
```

### Hard invariants

Verify hard invariants strictly.

Examples include:

```text
required schema
tool permission boundaries
forbidden operations
file safety
required state transitions
required fields
repair limits
API compatibility
crashes or exceptions
deterministic routing rules
```

These may use ordinary executable tests.

### Behavioral quality

For inherently variable qualities, use outcome-oriented evaluation rather than exact-output assertions.

Examples include:

```text
analysis quality
usefulness
relevance
intent adherence
finding important hidden issues
planning quality
robustness across inputs
appropriate tool choice
avoiding unnecessary work
recommendation quality
```

Prefer:

```text
rubric
+
representative cases
+
observable evidence
```

over exact wording.

Do not fail a criterion merely because wording, ordering, or a valid reasoning path changed without harming the intended outcome.

Distinguish behavioral regression from harmless variation.

## 4. Do not overconstrain generative behavior

Avoid constraints that exist only to make evaluation easier.

Bad examples:

```text
always mention X first
use exactly three recommendations
use these exact phrases
```

unless those are real product requirements.

Prefer outcome constraints such as:

```text
surface material findings
prioritize evidence-backed issues
avoid unsupported conclusions
give actionable recommendations when justified
```

Consistency is not automatically quality.

Do not optimize an AI product into rigid but less useful behavior.

## 5. Representative evaluation

Use a small but meaningful set of cases relevant to the current Ticket.

Possible categories include:

```text
normal case
edge case
ambiguous input
failure case
tool-use case
long-context case
misleading input
previous regression
```

Do not require every category mechanically.

Repeated sampling may be useful when nondeterminism materially affects confidence, but do not repeat runs merely as ceremony.

## 6. Hard gates vs behavioral judgment

For AI products, distinguish hard gates from behavioral quality.

Hard gates can block immediately when a required invariant is violated.

Behavioral quality should usually be judged across evidence rather than one subjective weak sample.

Use `FAIL_BLOCKING` for behavioral criteria only when evidence shows a material failure against the Ticket's Acceptance Criteria.

Use `FAIL_NON_BLOCKING` for minor inconsistency, style preferences, or optional improvements that do not prevent the required outcome.

## 7. Hybrid products

Many AI products contain both deterministic software and generative behavior.

Apply the appropriate method per Acceptance Criterion rather than choosing one philosophy for the whole Ticket.

Keep this lightweight. Do not build a large evaluation framework unless the Ticket genuinely requires one.

## 8. Independent verification

The Implementer may run tests and evals for development feedback, but must not be the sole authority that accepts its own work.

Authoritative verification should occur in an independent agent context whenever the host supports it.

Within the dedicated Ticket Session, the Ticket Session's main agent should construct the Reviewer / Verifier context from the current Ticket, per-Ticket state, current implementation, relevant artifacts, and open blockers rather than forwarding the full Build conversation.

The Reviewer should independently inspect or reproduce the evidence needed for acceptance when practical.

If specialized verification needs another worker, keep that verification inside the Ticket Session. The Workflow Session should receive only the Ticket's compact terminal outcome, not intermediate verifier dialogue.

After a repair, first verify the blocker, then reconsider the complete Acceptance Criteria of the current Ticket to catch regressions.

This means full Ticket acceptance regression, not maximum possible test execution and not automatic re-verification of the whole DAG.
