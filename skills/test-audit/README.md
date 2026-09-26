# test-audit (standalone)

A repository-agnostic adaptation of OpenClaw's `test-audit` agent skill.

It keeps the original idea: tests should earn their maintenance cost by protecting observable behavior, credible regressions, or independent contracts. It supports:

1. **Authoring mode** — gate new or changed tests.
2. **Audit mode** — find low-value, implementation-coupled, duplicative tests and test-only production seams.
3. **Campaign mode** — systematically reduce one subsystem's test surface while preserving real contracts.

## Files

- `SKILL.md` — main skill; sufficient for authoring and focused audit mode.
- `CAMPAIGN.md` — required when running a full subsystem campaign.
- `README.md` — installation and adaptation notes.

## Install for Codex

Copy the folder to:

```text
~/.codex/skills/test-audit/
├── SKILL.md
├── CAMPAIGN.md
├── README.md
└── LICENSE
```

On Windows PowerShell, `~` normally resolves to your user profile, so the path is typically:

```text
C:\Users\<you>\.codex\skills\test-audit\
```

The two files that matter to the agent at runtime are `SKILL.md` and `CAMPAIGN.md`.

## Runtime requirements

There are no bundled scripts and no package dependencies.

The skill expects the coding agent to be able to:

- read repository files and instructions;
- inspect Git/history when available;
- search callers/tests;
- run the repository's existing test/build/lint/type-check commands;
- edit files when the user authorizes implementation.

Sub-agents and independent reviewers are optional. The standalone version explicitly falls back to sequential discovery and a distinct second-pass review when they are unavailable.

## What was changed from OpenClaw

The standalone adaptation removes OpenClaw-specific orchestration while retaining the test-value model.

### Removed hard dependencies

The original references these OpenClaw-specific skills/workflows:

- `$openclaw-testing`
- `$crabbox`
- `$autoreview`
- `$openclaw-pr-maintainer`

The standalone version uses the current repository's own testing/review workflow and treats independent review tooling as optional.

### Removed hard-coded OpenClaw commands

The original names repository scripts such as:

- `node scripts/run-vitest.mjs`
- `node scripts/check-changed.mjs`
- `scripts/pr`

The standalone version first detects commands from repository instructions, manifests, task files, and CI configuration.

### Removed framework assumptions

The original validation text assumes Vitest. The standalone version is test-runner and package-manager agnostic.

### Removed directory-layout assumptions

The original discovery lanes explicitly mention `src/`, `packages/`, and `extensions/`. The standalone version derives lanes from actual production-owner boundaries.

### Generalized repository instructions

Instead of requiring only `AGENTS.md`, the standalone version checks applicable repository guidance such as `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, `README.md`, scoped instructions, and CI configuration when present.

### Generalized branch/landing workflow

References that assumed `main`, one particular PR tool, or a specific landing script were changed to the repository's baseline/default branch and contribution workflow.

### Generalized Campaign examples

OpenClaw/Telegram-specific examples and historical campaign counts were removed. The underlying `R/F/C/D` ledger, layer-plan, keeper, preservation-review, mutation-check, defect-control, and reconciliation workflow remains.

### Made sub-agents optional

The original Campaign flow assumes separate read-only agents/reviewers. The standalone version uses them when available but defines sequential/second-pass fallbacks.

### Added an explicit "repository contract first" rule

The standalone version begins by detecting the repository's actual tools and instructions and prohibits inventing production seams, helper scripts, or dependencies merely to satisfy the skill.

## Refinement: test-quality rules added after the standalone split

This revision deliberately incorporates only ideas that directly improve the judgment **"is this a good test?"**:

- expected behavior should come from a requirement, user-visible outcome, public contract, regression history, or other independent oracle—not be inferred from the implementation being tested;
- bug regressions should demonstrate a credible failing control (pre-fix or deliberately broken behavior) when practical;
- mocks/fakes are not banned, but they must not implement or manufacture the behavior being asserted; contract-sensitive substitutes should be checked against the real boundary when practical;
- coverage is a discovery signal rather than a target that justifies tests by itself;
- test style is not prescribed globally: choose the strongest practical boundary and evidence for the contract;
- architecture/changeability smells discovered through tests are reported as follow-ups rather than turning `test-audit` into an architecture-refactoring skill.

The following related ideas were intentionally **not** folded into this skill because they belong to other responsibilities:

- interface-change ratios, change coupling, modularization metrics, boundary-enforcement coverage, or shared-module parameter proliferation;
- repository-wide architecture redesign or module split/merge decisions;
- precise-test selection, CI queue/runner optimization, or test scheduling strategy;
- a complete goal-driven acceptance/E2E workflow with UI operation, screenshots, recording, and product-level sign-off;
- blanket policies such as "no mocks", "mostly E2E", or a universal coverage percentage.

This keeps the skill focused on test value and proof quality rather than general software architecture, CI optimization, or product acceptance.

## Provenance

Adapted from:

`openclaw/openclaw/.agents/skills/test-audit/`

Source project: OpenClaw, copyright (c) 2026 OpenClaw Foundation.

The OpenClaw repository is licensed under the MIT License. This distribution retains the MIT copyright and permission notice in `LICENSE`.
