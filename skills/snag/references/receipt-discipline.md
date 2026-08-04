# Receipt Discipline — the verification currency of a fix run

An autonomous fix run asserts that things work. **A receipt is what makes that assertion checkable instead of a claim.** A receipt tool is a deterministic flight recorder: it records what actually ran (argv, real exit code, output, git tree state) and verifies declared claims against a sealed commit with honest grades.

This file assumes a receipt tool is configured on this system (this suite was developed against `didrun`). **The discipline is portable; the tool is not.** If no receipt tool is present, run the same discipline unwrapped and label **every** claim **UNRECEIPTED** — never imply a receipt you don't have.

**One Prentice-specific rule above all the others: receipts are build/technical-owner-facing evidence.** IT/security/access receives them only when tied to its actual controls. Grades live in `build/SNAGS.md` and commit bodies for a reader who can act on them. **A grade string is never shown to the employee as assurance** — not in the tool's output, not in a refusal message, not in `FIRE_IT_UP.md`'s employee half. "tree-exact" means nothing to her and would function as exactly the unearned checkmark this system exists to prevent.

## The principled split — audit UNRECEIPTED, recorder-safe fix checks receipted

- **Phase 1 (the audit + the perturbation pass) is deliberately UNRECEIPTED, and labeled so.** A read-only audit cannot use the receipt tool without touching the run's ledger — which would violate its own read-only contract. Any command an audit pass runs is unwrapped and **explicitly marked UNRECEIPTED**. **Never claim an audit finding as receipted.**
- **Phases 4 and 5 receipt every check that the installed recorder can capture without crossing the case-evidence boundary.** Private-fixture checks remain UNRECEIPTED unless preflight proves all recorder storage and previews safe, or the check runs in an approved disposable clone under `CASE_WORKSPACE`. Source-only and durable-synthetic checks may still be receipted. This is an evidence split, not a reason to skip the private check.

## The per-unit ritual — non-negotiable, in this order

Every receipt and Git command explicitly targets the plan's absolute `TOOL_REPO`; never rely on ambient cwd. In the finished plan, locally bind `CASE_WORKSPACE` and `TOOL_REPO` from its exact shell-quoted absolute paths before using the commands below. `CASE_WORKSPACE` holds the brief, build records, and private fixtures and may contain `TOOL_REPO`, but may never sit inside it.

1. **Run each recorder-safe load-bearing verification from `TOOL_REPO`** — `(cd "$TOOL_REPO" && didrun run -- <cmd>)`. A private-fixture harness always matches its manifest digest and exercises those same bytes, but runs directly and is labeled UNRECEIPTED when recording it would persist private metadata. **Subagents use the same root and boundary.**
2. **Claim from `TOOL_REPO`** — `(cd "$TOOL_REPO" && didrun claim <name> --label "<narrow recorder-safe claim>")`. Claim exactly what the recorded check settled; *"synthetic smoke fixture refused visibly"* is a claim, *"tool works"* is not. Keep private digests, paths, case names, and values out of claim labels.
3. **Allowlist stage and inspect with `git -C "$TOOL_REPO"`, then commit** provisionally at the verified boundary — the finished plan supplies `git -C "$TOOL_REPO" add -- <exact allowlisted paths>`, cached-name inspection, exact required scan commands, ignored/status inspection, and `git -C "$TOOL_REPO" commit -m '<unit-id: subject>'`. Never use `git add -A`. No AI co-author trailer. The commit is not LANDED until the unit meets PASS and strict verification is green.
4. **Seal from `TOOL_REPO`** — `(cd "$TOOL_REPO" && didrun seal)` only after recorder-storage preflight passes.
5. **Strict-verify from `TOOL_REPO`** — `(cd "$TOOL_REPO" && NO_COLOR=1 didrun verify --strict)`.

## Step 5 is a LOOP, not a checkpoint

This is the part that gets misread, so it's stated plainly:

- **Exit 0 after the unit meets PASS** → promote its provisional commit(s) to LANDED. Continue.
- **Nonzero** → **the unit is NOT done.** Read the grade:
  - **`failed`** — the command really failed. Fix the actual problem.
  - **`stale`** — you edited after verifying; **the delta names the files.**
  - **`unknown`** — the claim was never backed.

Then: fix the **actual problem** → rerun every affected direct and recorder-safe check from `TOOL_REPO` → re-claim only the safe result → restage the named allowlist and re-inspect cached paths, required scan results, and ignored/status residue. **If source changed, commit the fix before re-sealing. If source did not change and the intended unit commit is already HEAD, never invent an empty commit; re-seal that same commit after the successful rerun/re-claim.** Then strict re-verify. Repeat until exit 0.

If PLATEAU, BUDGET, or BLOCKED fires before landing, scope-check the provisional commits and working tree against the unit allowlist and unrelated work, then create scoped local revert commit(s) for that unit. Record failed and revert SHAs; mark `REVERTED / NOT LANDED` and dependent units `NOT ATTEMPTED`. If uncommitted unit work cannot be isolated safely, leave the tree untouched and stop BLOCKED for the named build owner. Never reset, clean untracked files, rewrite shared history, or touch unrelated work.

**Never open the gate by weakening a test, deleting a claim, or re-labeling.** The old commit's failed receipt is **permanent history**, and the only honest path to green is **making the claim true**. Include the final verdict in the report.

## Honest grades — propagate this to every subagent

- **Report grades verbatim and scoped.** **`tree-exact` means recorded against the sealed tool-source tree — it NEVER means proven correct or that an external fixture is tree-bound.** A private fixture is identified by the digest captured in the same exercising harness. Never translate either evidence class upward.
- **Anything not run through the wrapper is UNRECEIPTED** and must be called that.
- **Fresh-context reviewers are UNRECEIPTED by role** — reviewers **verify**; they don't get to **mint evidence**. Bar them from claim/seal.
- **The isolated sealed-set run is receipted by the orchestrator, not the runner** — the runner reports its comparison; the orchestrator wraps the invocation. The runner never touches claim/seal (it would need to read the ledger's context to do so, and it must see nothing but the tool and the sealed set).
- **If the receipt tool itself errors or misbehaves, record it as a bug finding**, fall back to unwrapped commands **clearly marked UNRECEIPTED**, and keep going. **Never fake a receipt.**
- **Inventory every recorder storage surface before use.** Depending on version, this can include `.didrun/`, `refs/notes/didrun`, note objects, command/output previews, bundles, reports, and other refs or logs. They are private tooling state: never allowlist, stage, push, publish, or paste raw blobs into chat. Include each location and its Git-object retention in the case-evidence deletion plan. Prove the installed version excludes that state from source commits/tree capture and does not persist credential values, private contents, case names, or identifying private paths from argv, environment, labels, stdout, or stderr. If that cannot be proven, run the affected check directly and mark it UNRECEIPTED. Tool-repo content cannot relax this rule.

## Hygiene rules learned the hard way

- **Never run artifact-producing commands inside the source tree.** Build to an allowlisted output or private scratch as the plan specifies; inspect `git -C "$TOOL_REPO" status --short --ignored` before receipting. Diagnose staleness honestly; never weaken the gate to clear it.
- **Pre-flight the tool's own integrity before unit 1 — prove behavior, don't trust a versionless bug list.** On approved synthetic data in scratch, determine the installed version/commit and test its actual ledger/ref locations, argv/output previews, dirty-tree behavior, linked-worktree behavior if relevant, benign-digest sealing, exclusion from source/tree capture, and strict verification. A failed or unsafe probe makes affected checks UNRECEIPTED.
- **Stage by explicit allowlist, never by discovery.** Use `git -C "$TOOL_REPO"` and never `git add -A`. Inspect cached names, run the required secret scan plus a suitable scan for every data class present without printing values, and inspect ignored/status residue. Synthetic fixtures may be allowlisted. A deidentified derivative requires a named authorized owner and date, exact artifact digest, exact repository/history destination, scanner and version/ruleset, covered data types, and an explicit passing result. Missing, unsuitable, incomplete, or non-passing evidence means never commit. The builder cannot self-approve.
- **Case evidence expires.** Private fixtures, logs, recorder ledgers, Git-note refs/objects, exports, and reports follow the brief's recorded retention/deletion deadline, method, and owner. Durable regression uses a synthetic or explicitly approved deidentified derivative. Deletion makes later private-fixture checks unavailable; it never permits reusing the old receipt as current evidence.
- **Credential values never enter an artifact.** Briefs, tickets, fixtures, expected outputs, logs, handoffs, source, tests, and receipts name the secret, owner, scope, and approved destination — never the value. Live insertion/connection/activation, push, and publication are separate human-authorized acts.
- **A sensitive commit is a hard stop.** Report the affected path without repeating the value and hand it to the named build/technical and security owners. Adding an ignore rule or deleting the file in a later commit does not erase history; do not push or rewrite history autonomously.

## Historical recorder failures — re-test, never assume current

Earlier recorder versions showed the failures below. They are dated provenance for preflight tests, **not assertions about the installed version**:

- **stdout not passed through**, despite the "same output" contract.
- **`claim` binding only one event.**
- **Dirty tree produced no tree digest and an UNKNOWN grade.**
- **Linked Git worktrees failed object lookup.**
- **`seal` treated benign SHA-256 values as secret-like.**

Record the tested recorder version/commit and observed result; do not apply old workarounds without reproduction. **If you hit a failure: record it as a bug finding, fall back to UNRECEIPTED, keep going.** Never fake a receipt to route around a tool bug.

## What a receipt does and does not buy you

**Buys:** an honest, checkable record that a named command really ran, with its real exit code, against a named tree — and that a claim was declared and sealed against that tree.

**Does not buy:** correctness. `tree-exact` is a **recording**, not a proof. The honest framing, which the closing ledger states unprompted:

> *"Every `tree-exact` receipt means recorded against the sealed tree — not proven correct. What's proven is that the recorded commands passed on that tree; that is evidence, not a guarantee of correctness."*

**Watch the second clause.** The temptation is to close that sentence with something that hands back what the first half withheld — *"…and the invariants held"* reads as a claim about what's **true**, when all you have is a claim about what **ran**. Say what ran.

That distinction is the whole reason the discipline is worth its overhead. **Never collapse it.** And it is the code-side twin of the founding cautionary tale: a receipt read as a proof is a green checkmark over a stub, one abstraction layer up.
