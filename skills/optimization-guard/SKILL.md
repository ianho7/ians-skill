---
name: optimization-guard
description: >
  Use during iterative skill or prompt optimization when newly discovered issues
  may expand scope, add complexity, or prolong an already sufficient solution.

---

# Optimization Guard

Keep optimization proportional to the stated objective.

Before acting on a newly discovered issue, decide whether the current approach should be:

- **KEEP** — the issue does not materially affect the current acceptance criteria.
- **ADJUST** — evidence shows a meaningful problem that can be addressed with a small coherent change.
- **REPLACE** — evidence shows the current approach is fundamentally wrong.

Do not propose patches before making this judgment.

A discovered issue is not automatically a task.

Choosing not to optimize is itself a valid decision. If the expected benefit is small, uncertain, or disproportionate to the added complexity or risk, prefer keeping the current approach.

Prefer the smallest coherent scope. Multiple failures may be handled together when they clearly share the same root cause; otherwise defer unrelated issues.

Reference answers are evidence, not exact targets. Differences matter only when they violate an explicit acceptance criterion.

Do not add rules, exceptions, abstractions, files, or configuration merely because they improve completeness or elegance. Added complexity must earn its cost through meaningful improvement in quality, risk, rollback, or evaluation results.

Prefer changing, simplifying, or replacing an existing principle over appending another case-specific rule.

Use external eval results as the source of truth. Preserve already-correct behavior.

`KEEP`, `REVERT`, and `STOP` are successful outcomes.

When the acceptance criteria are satisfied and remaining issues are non-blocking, stop.

Record worthwhile but non-blocking findings briefly for later rather than investigating them now.