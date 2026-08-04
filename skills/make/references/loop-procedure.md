# Loop Procedure — running one build → see → exercise → check → critique → rebuild cycle

This is the detailed playbook for each iteration of the loop. The discipline that makes it work: every iteration ends with an **objective ledger** (numbers, not adjectives) and a **defect list tied to the brief's criteria** — so progress is measured, not felt. Read `verification.md` first; you cannot run this without the brief's target, and you may not invent one.

## The unit contract — how the plan drives the loop

`make` consumes `build/PLAN.md`'s units **in order**. Each unit is self-contained and names its own verification; the flow per unit is:

Before unit 1, use the current preflight the kickoff records. In a standalone run with no current result, load `../../snag/references/receipt-discipline.md` and prove the installed recorder's storage/Git-note/object/preview/export/deletion boundary in a neutral disposable repository under `CASE_WORKSPACE`. If that cannot be proven, invoke no recorder command; all affected checks run directly and remain UNRECEIPTED.

1. Build the unit.
2. Run its verification **in its shape** (`verification.md`) from the plan's absolute `TOOL_REPO`; private fixtures come from `CASE_WORKSPACE` and are permission/deadline/digest-checked inside the harness that exercises them. Wrap only recorder-safe commands; keep unsafe-to-record private checks direct and UNRECEIPTED.
3. Loop (below) until the unit's criteria pass or a stop-condition fires **for that unit**.
4. At a PASS-candidate boundary, from `TOOL_REPO`: claim only recorder-safe results → stage only the plan's allowlist with `git -C "$TOOL_REPO"` and inspect cached paths/required scans/status → create a **provisional** commit → seal → strict verify. Nonzero → fix, rerun direct and wrapped checks, re-claim safely, restage/reinspect. If source changed, commit the fix; if source did not change and the intended unit commit is already HEAD, never create an empty commit—re-seal that commit after the rerun/re-claim. Then re-verify. Only PASS plus a green strict result promotes the provisional commit(s) to LANDED. Never weaken a test or upgrade an UNRECEIPTED result.
5. If PLATEAU, BUDGET, or BLOCKED fires before landing, scope-check the provisional commits and working tree against the unit allowlist and unrelated work. Create scoped local revert commit(s) for the unit's provisional commits, record failed/revert SHAs, and mark `REVERTED / NOT LANDED`; dependent units become `NOT ATTEMPTED`. If uncommitted unit work cannot be isolated safely, leave it untouched and stop BLOCKED for the named build owner. Never reset, clean untracked files, rewrite shared history, or touch unrelated work.
6. Ledger entry (below) before moving on.

After the last unit, run a **final whole-tool pass**: the full loop once against the brief's complete acceptance — all shapes, the whole refusal suite, the safety defaults, cross-unit flows. Units passing in isolation is not the tool passing; seams are where builds die.

A one-unit plan (the degenerate case) collapses this to a single pass of the same discipline.

## Iteration 0 — get a green build

A red build blocks everything downstream — you can't *see* or *exercise* what won't run. If the build is broken, the first iteration's only job is to make it green:
- Confirm the plan's absolute `CASE_WORKSPACE` and `TOOL_REPO`; the case workspace is not inside the tool repository. Initialize only `TOOL_REPO` for a new tool. For an existing target repository, require a physically separate case workspace and the plan's explicit allowlist. Run the project's own build + type-check + tests from `TOOL_REPO`, using its real commands; don't guess.
- Fix compile/type/test failures only. Don't start polishing on a tree that doesn't build.
- Record the baseline ledger before you change anything you're judging — you need a before to claim an after.

## The per-iteration ledger (record every iteration, in build/LEDGER.md)

| Track | Signal | How | Ground truth? |
|---|---|---|---|
| Machine | Build exit code | recorder-wrapped build command from `TOOL_REPO` → exit | Yes |
| Machine | Test pass count | the project's test runner → "N passed / M total" | Yes |
| Machine | Core flows passing | the *exercise* scripts → pass/fail per flow | Yes |
| Machine | Replay fixtures matching | external digest match + byte comparison per fixture → match/diff | Yes, for the captured digest and run only |
| Machine | Refusal fixtures firing | per fixture → refused / produced output (rate + n for stochastic parts) | Yes |
| Machine | Monitor checks | replayed state caught / silence visible / stamp present | Yes |
| Machine | Console errors/warnings | captured during *see*/*exercise* | Yes |
| Machine | a11y violations (impact ≥ serious) | `axe` run → count (UI surfaces only) | Yes |
| Design | Design-bar criteria met / defects open | the *see* critique (`design-critique.md`) | Partly — checkable items yes; taste self-graded |

The machine track is ground truth. The design track only exists when design is load-bearing; for a plain utility it collapses to a single "plain-but-clear / nothing broken / safety surfaces legible" check. **Neither track substitutes for the other.** Generative-part results enter the ledger only from **isolated runs** — a builder-run sample against exposed examples is a smoke test, listed as exactly that.

## Steps 1–6

**Step 1 — Build & test.** Run build, type-check, unit/integration tests from `TOOL_REPO` through the recorder. Quote the summary lines (exit code, "N passed"). Exit codes end debates a screenshot can't.

**Step 2 — See (the design-critique pass).** Launch what can be launched; confirm it boots. When design is load-bearing, run the full iterated critique every iteration — `design-critique.md`, no substitutes, NOT RUN reported honestly if no renderer exists. For a plain utility, glance for plain-but-clear — **and check that the safety surfaces read**: the refusal message, the staleness escalation, the liveness stamp are things a non-technical person must be able to parse at a glance; illegible safety text is a real defect even on a utility. Capture the console either way.

**Step 3 — Exercise.** Script the core flows from the brief's promise: drive them end-to-end, assert completion. Assert **control→output coupling** — every control that claims to govern an output actually changes it (this catches the field wired to the preview but not to the merge). Non-browser surfaces: run the script, call the function, trigger the job, assert outputs. **Platform-bound pieces** (a bound script, a scheduled trigger): keep the logic a pure core exercised locally; trigger the binding once for real and record exactly that — one live firing is one live firing, not "verified over time."

**Step 4 — Check (two halves, both first-class).**
- **(a) The refusal suite** — every still-permitted private fixture under `CASE_WORKSPACE/build/fixtures/` plus the tool repo's durable synthetic subset, per `refusal-suite.md`. The harness matches an external fixture's manifest digest before exercising those bytes. Broken input → visible refusal; any output is a defect; stochastic parts sampled with n stated.
- **(b) Machine checks** — where a UI exists: `axe` (impact ≥ serious), perf against any stated budget, broken assets/links, clean console. Skip-and-report what can't run; the refusal suite never skips.

**Step 5 — Critique.** Consolidate into one defect list, each entry carrying: **severity** (Blocker / High / Medium / Low), **the brief criterion, plan-unit criterion, or safety default it blocks**, and a one-line checkable description — points at a signal or a named criterion, never "feels off." Safety-default violations (silent partial output, a status light over a stub, an irreversible default action, "local" claiming "private") default to High/Blocker. Fold in the different-model critic's findings when it ran. Pick the top few defects for this rebuild — don't fix everything at once.

**Step 6 — Rebuild.** Fix **only** the selected top defects. Don't refactor adjacent code, rename things, or gold-plate — a tight diff is reviewable. Re-enter at Step 1; re-run the full ledger so the delta is measured, not assumed. **This is the start of the next pass, not the end.** Keep looping while any Blocker/High/Medium is open and BUDGET isn't hit.

Before any unit commit, use `git -C "$TOOL_REPO"` to stage named allowlisted source paths and synthetic fixtures only by default — never `git add -A`. A deidentified derivative additionally requires a named authorized owner/date, exact artifact digest, exact repository/history destination, scanner/version/ruleset/covered types, and explicit passing result. Missing, unsuitable, incomplete, or non-passing evidence means never commit. Inspect cached names, run required scans without printing values, and inspect ignored/status residue. Never put credential values in any artifact. Never push, publish, connect, or activate autonomously. If sensitive material reached a commit, stop; later ignore/deletion does not erase history.

## Closing an iteration — apply the stop-condition

After rebuild + re-measure, check **PASS / PLATEAU / BUDGET / BLOCKED** (defined in `SKILL.md`). PASS requires no open Blocker/High/Medium — shape verification green, refusal suite green, safety defaults met, design bar met when load-bearing — not a green build/test alone. PLATEAU only after 2 consecutive iterations of genuinely no progress. BUDGET (default 5 per unit; never below 3 for a load-bearing design build; caller-settable) is the unconditional backstop. If none fires, loop again.

## Handling BLOCKED mid-loop

Do **not** guess a fix or hide the gap behind a clean screenshot. Route by flavor:

- **Needs a human signal** (content oracle, taste call, real-use question) → log it in the ledger's residual for the build/technical owner: what would settle it and who must answer.
- **Discovered gate** (an API, key, scope, approval `diagnose` missed) → write it in the four-field shape — **what's needed · who can approve it · roughly how long · what works today without it** — into the ledger for `commission` to carry into `FIRE_IT_UP.md`, plus the real activation work, owner, and smoke test. Build the no-wiring version and construct the authorized wired path safely to the seam. Missing live access alone does not park it; stop only where information or authority makes construction unsafe. Never stub the gated part behind something that looks finished.
- **Conflicts with a LOCKED decision** → stop that path and route the conversation back to whoever owns the brief. Never override. If they reverse the decision, the brief's owner moves it under `### Reversed` (past tense, what overturned it) and the ledger records the change the same way.

Finding the edge of its own competence and saying so is the loop doing its job.

## What build/LEDGER.md holds

The ledger is the durable memory of the build and the handback artifact — **written for the build/technical owner**, with IT/security/access findings limited to their actual controls. Structure:

- **What was built** — per unit: what it is, where it lives relative to `TOOL_REPO`, what it does.
- **How it was verified** — per unit and for the final pass: the shape, exact commands, fixture/sample counts, each external fixture's captured digest and deadline, and the strict receipt verdict **verbatim**. The source-tree grade and external-input binding are separate; anything unwrapped is marked UNRECEIPTED.
- **Iteration log** — the per-iteration ledger tables: the before→after delta in numbers.
- **Decisions** — build decisions made along the way, each with a one-line why. Overturned ones move under **`### Reversed`**, restated in past tense with what overturned them — never deleted (the next session re-derives the same wrong answer), never struck through (a struck LOCKED still greps as LOCKED). A reversal isn't done until every sentence asserting the old fact is retracted — grep the ledger for what you stopped believing.
- **Honest residual** — everything open at stop: still-open defects by severity, the cannot-see tail, weakened isolations, one-firing-only bindings, discovered gates in four-field shape. Each item: what would settle it, who must. **Nothing in this section may be visible on the employee's surface as if finished.**
- **Evidence lifecycle** — the brief-derived deletion deadline, method, and owner for private fixtures, logs, recorder ledgers, Git-note refs/objects, exports, and reports; plus the durable synthetic/approved derivative paths that remain after private evidence expires.

## What to report at the end

- The **unit count and iteration count per unit** — a one-pass run on a non-trivial unit is visibly incomplete.
- The **per-iteration ledger** — the concrete craft-delta, not a vibe.
- **Which stop-condition fired**, per unit and for the whole run.
- The final strict receipt verdict verbatim for the recorder-safe set, or **NOT RUN — no safe recorder boundary**.
- The **open-defect queue at stop** — split into *machine-checkable but deferred*, *the cannot-see tail for the build/technical owner*, *discovered gates (four-field, assigned to their real owners)*, and *Low/Note residue*. If anything ≥ Medium is still open, only BUDGET or BLOCKED justifies stopping — say which.
- Any signal **not run** (and why) — reported as not-run, never as passed.
