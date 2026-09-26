# Test-pruning campaign

Campaign mode prunes one subsystem's whole test surface as one coherent change set. The value bar, retention bar, candidate evidence, and validation rules in [SKILL.md](SKILL.md) apply to every lane.

A subsystem may be a package, service, plugin, adapter family, UI area, feature domain, or other production-owned boundary. Determine it from the repository rather than assuming a directory layout.

Each step ends on its completion criterion; do not start the next step early.

## 1. Baseline

Choose and record a pinned baseline commit from the repository's normal integration/default branch or other agreed baseline.

Record:

- in-scope test and test-support line counts;
- the complete in-scope test-file inventory;
- every in-scope test file's pass/fail state;
- relevant test/CI routing;
- baseline failures in their own list.

Do not assume a baseline failure is a stale test. Treat it as evidence until the production owner and failure mode are understood.

**Done when:** every in-scope test file and applicable QA/live scenario has a recorded baseline result.

## 2. Lanes and inventory

Split the subsystem into **lanes** along production-owner boundaries, not filename prefixes.

Possible lanes include domain/core behavior, commands/controllers, inbound/outbound adapters, persistence, transport, rendering/UI, shared helpers, harness/support, and live/QA scenarios. Use only boundaries the repository actually has.

Include:

- tests located inside the subsystem;
- shared-boundary tests whose behavior is owned by the subsystem;
- relevant QA/live/integration scenarios;
- test-support code and production seams used only by those tests.

**Done when:** every in-scope test declaration/scenario belongs to exactly one lane, with shared ownership explicitly resolved.

## 3. Read-only ledger per lane

Perform a read-only pass for each lane.

If independent sub-agents are available, each lane may be assigned to a separate read-only agent. Otherwise perform the lanes sequentially. The evidence requirement is the same.

Read every assigned test in full, including parameter tables, fixtures, and helper definitions. Also inspect:

- the requirement, user-visible outcome, public contract, regression history, or other independent source that defines expected behavior;
- production owners;
- entry points and non-test callers;
- relevant callees/sibling implementations;
- repository history where useful;
- CI/test routing.

Each test declaration goes into a written **ledger** with one mark. A parameterized test may be one declaration unless individual rows protect meaningfully different contracts.

Marks:

- `R` — retain. Name the contract and credible failure it catches. A retained test that only moves to a better owner/file remains `R`.
- `F` — retain the contract but fix the test/assertion because the current proof is vacuous, misleading, unreachable, or otherwise defective.
- `C` — consolidate. Name the owner/keeper that will absorb the contract first.
- `D` — delete. Name the stronger proof that remains, or explain why no meaningful contract exists.

Judge a test by what its assertions can detect, not by its name.

**Done when:** every in-scope declaration has a mark and an evidence line.

## 4. Layer plan per lane

Treat the ledger as input, not as the edit list.

Run a second read-only pass that looks for redundant **layers** and determines the canonical **keeper** for each contract.

Prefer the strongest practical owner boundary. When the real boundary can be exercised with a controlled external dependency (for example, a fake network/server/store), prefer that over a mock that re-implements the collaborator's behavior.

For every lane, name:

- retired files/suites/layers;
- keeper suite per contract;
- assertions/contracts that must move into keepers before deletion;
- test-only production seams unlocked;
- ledger mistakes corrected during this second pass.

**Done when:** every lane has an explicit layer plan and every contract has a keeper or a justified deletion.

## 5. Cutover

Edit lane by lane.

Serialize changes to shared harnesses, fixtures, test support, and shared production owners through one editing owner to avoid conflicting rewrites.

With each lane:

- move any retained contracts first;
- remove redundant tests/layers;
- repair defective retained assertions;
- remove test-only production seams the deletion unlocks;
- update real CI/test routing and inventories when moved suites require it;
- update repository-maintained size/baseline checks only when the underlying contract truly changed.

If the repository has durable scoped instruction files, add test-ownership rules only when the campaign uncovered a recurring repository-specific mistake worth preserving. Do not create instruction files merely because this skill mentions them.

**Done when:** every lane plan is applied and each lane's keepers pass focused validation.

## 6. Preservation review

Before claiming completion, perform a review that compares deleted coverage against the keepers by boundary group.

Prefer an independent reviewer/agent when available. Otherwise perform a distinct second pass that does not rely on the original deletion rationale.

Look for:

- contracts that lost their only proof;
- moved assertions that no longer reach the production path;
- expectations whose only authority is the current implementation rather than an independent requirement/contract/oracle;
- negative cases that pass for unrelated reasons;
- expected values derived from the implementation under test;
- mocks/fixtures that manufacture the very behavior being asserted;
- keepers retained only to preserve coverage percentage or inventory;
- new assertions that cannot fail.

For each contract restored because the review found a real gap, perform a deliberate **mutation check** when it is safe and practical:

1. make a minimal temporary mutation in the production owner that should violate the contract;
2. confirm the keeper fails for the intended reason;
3. restore the source exactly;
4. rerun the keeper.

Do not leave mutation changes in the final diff.

**Done when:** every preservation finding is either repaired or rejected with source evidence, and restored contracts have meaningful failure proof where practical.

## 7. Product defects

A baseline failure that survives in a retained keeper may be a product defect.

When repairing such a defect is within the authorized scope:

- fix it at the production owner;
- keep the defect repair logically separable from test pruning (for example, a separate commit when the repository workflow uses commits);
- prove the real user/production flow;
- perform a control that demonstrates the old behavior, by reverting/temporarily disabling the fix or using another safe baseline comparison.

Record unrelated product discrepancies as follow-ups instead of expanding campaign scope.

**Done when:** each in-scope repaired defect has both failing control evidence and passing candidate evidence on the same meaningful harness.

## 8. Reconcile and hand off

Long campaigns may outlive upstream changes.

Follow the repository's normal integration policy. Do not assume rebase or merge is always preferred.

When upstream changed a file/layer the campaign removes:

- do not restore obsolete structure merely to simplify conflict resolution;
- identify any new contract added upstream;
- port that contract into the correct keeper before removing the obsolete layer;
- confirm every new regression upstream added still has an owner.

Rerun:

- the complete subsystem suite or repository-prescribed equivalent;
- relevant live/integration proof;
- final diff/review gates.

Hand off with the [SKILL.md](SKILL.md) report, plus:

- baseline and final test/test-support line counts, with production/tooling counted separately;
- lanes, retired layers, and keepers;
- preservation gaps found and mutation evidence;
- product defects and their control/candidate proof;
- upstream reconciliation decisions;
- unresolved risks and follow-ups, including architecture/changeability smells observed but deliberately left outside campaign scope.
