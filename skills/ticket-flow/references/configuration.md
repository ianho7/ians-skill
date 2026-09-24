# Ticket Flow Configuration

Load this reference only when preferences need to be created, changed, resolved, or repaired.

## Scope and precedence

Resolve effective preferences in this order:

```text
Invocation override
        ↓
Project preferences
        ↓
System preferences
        ↓
Built-in defaults
```

Higher-precedence values override only the fields they specify.

Do not require a full project copy of the system configuration.

## Recommended locations

System:

```text
~/.code-agent/ticket-flow/preferences.yaml
```

Project:

```text
<repo>/.code-agent/ticket-flow/preferences.yaml
```

A host runtime may use a different conventional configuration root. Prefer the host's established user/project configuration location when one exists, while preserving the same System vs Project semantics.

## Schema

Keep the schema small:

```yaml
version: 1

implementer:
  model: ...
  reasoning: ...

reviewer:
  model: ...
  reasoning: ...

replanner:
  model: ...
  reasoning: ...

max_repair_rounds: 3
```

`replanner` is a recovery-only role. If omitted, inherit the Reviewer profile.

The Orchestrator is the invoking agent, not a separately configured specialist role. Do not add an `orchestrator` model setting unless a future host runtime genuinely requires one.

Do not add configuration knobs for internal workflow behavior unless repeated real-world use proves that users need control over them.

Settings that should normally remain skill rules rather than preferences include:

```text
reviewer isolation
DAG scheduling policy
orchestration topology
blocker policy
state format
review prompt shape
PLAN_INVALID handling
replan limit
session outcome format
```

## First-use setup

If usable saved preferences exist, do not interrupt the task.

If no saved preferences exist, perform a single-shot setup.

Present recommended defaults together, for example:

```text
Implementer: <model> / <reasoning>
Reviewer:    <model> / <reasoning>
Replanner:   inherits Reviewer
Repair limit: 3
```

Ask the user only to:

1. accept or modify those defaults;
2. choose where to save them: System or Project.

A response such as:

```text
use defaults, system
```

must be sufficient.

Do not ask every field in a separate turn.

After saving preferences, continue the original Ticket flow immediately.

Do not require reinvocation.

## Project preferences

Project preferences should normally contain overrides only.

Example:

```yaml
implementer:
  reasoning: high
```

Do not duplicate unchanged system settings.

Treat project preferences as local user preferences by default, not as team policy.

Do not assume they should be committed to version control.

If a team later needs shared enforcement, model that as a separate project policy concept rather than overloading personal preferences.

## Invocation overrides

Invocation overrides apply only to the current run.

Example:

```text
Use ticket-flow on issues/. For this run only, use high reasoning for the implementer.
```

Do not write invocation overrides back to persistent preferences unless the user explicitly asks.

## Compatibility

If the configured model or reasoning level is unavailable in the current host runtime:

1. use the closest supported equivalent only when the fallback is obvious and low-risk;
2. otherwise surface the mismatch before starting expensive work;
3. do not silently downgrade a role in a way that materially changes cost or expected capability.
