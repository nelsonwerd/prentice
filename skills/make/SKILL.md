---
name: make
description: >-
  Build the tool an exact build-authorized TOOL_BRIEF.md revision describes and drive it until it
  actually works — looping build → see → exercise → check → critique → rebuild
  through the units in build/PLAN.md until the brief's own acceptance passes or
  an explicit stop-condition fires; no infinite thrash. Acceptance comes FROM
  THE BRIEF, per verification shape: deterministic parts replay real fixtures
  byte-exact, generative parts run isolated against the sealed set, monitors get
  replayed state + the silence test + a liveness stamp in v1. Plus the refusal
  suite — broken input must produce a loud stop, never plausible output. Writes
  build/LEDGER.md, leaves source in the plan's TOOL_REPO. Mostly invoked BY commission.
  Invoke standalone on "run make on this plan", "execute the build units in
  build/PLAN.md", or "make the brief's tool". Do NOT use to attack a brief's design (harden), to break a
  build into units (sequence), for the post-build defect pass (snag), or for a
  build with no TOOL_BRIEF.md behind it.
---

# Make — build the brief's tool and drive it until it actually works

`make` takes the units in `build/PLAN.md` and drives the tool an exact build-authorized `TOOL_BRIEF.md` revision describes to **actually-works** by repeating one disciplined cycle — **build → see → exercise → check → critique → rebuild** — until the brief's own acceptance passes or a stop-condition fires. It doesn't just re-read its own plan; it *runs, sees, and exercises what it built*, then feeds those observations back into the next rebuild.

It is **composition-first**: it orchestrates tools the agent already has — `bash` (build/test), a headless screenshot + vision to *see*, Playwright/headless to *exercise* the flows, `axe`/Lighthouse to *check* — via prose. It is **not** a new program, and not a reinvention of the see-and-exercise agents vendors already ship; it's the discipline that wraps them: a target, a loop, a stop-condition, and an honest ledger of what was actually checked.

This skill is the build engine of the optional Prentice construction branch: `diagnose` produced the case, named decision holders selected and authorized the exact revision, `harden` attacked the design, `sequence` broke it into units, and `commission` orchestrates. `make` carries `sequence`'s execute-discipline (**never fake a signal you didn't run**) and the conditional-design rule (**a design bar only when feel is load-bearing** — where the tool is a plain utility, plain-but-clear is correct).

**Two readers, never blended.** The iteration ledger, receipts, and residual are for the **build/technical owner**, with IT/security/access receiving only items tied to its actual controls. The **employee** sees only the tool itself, and the tool's own surface is governed by the brief's safety defaults. **Nothing unfinished is ever visible to the employee as if finished** — an honest gap in the ledger is fine; a green checkmark over a stub is the exact failure this pipeline exists to prevent.

## When to use this

**Strong triggers — invoke without asking:**
- "Run make on this plan" / "make the brief's tool"
- "Execute the build units in build/PLAN.md"
- `commission` invoking you mid-pipeline with an exact authorized revision and a plan — the common case.

**Do NOT use this for:**
- Attacking a brief's design before building → that's `harden`.
- Breaking the build into units → that's `sequence`. If there's no `build/PLAN.md`, get one first (the degenerate plan — one unit — still counts, and says so).
- The post-build defect pass → that's `snag`.
- A build with no `TOOL_BRIEF.md` behind it → that's upstream `build-loop`'s job, not this suite's.

**Preconditions — check before the first unit:**
- `Accuracy: Confirmed accurate` and `Build authorization: Authorized for build` bind the same exact revision, authority holder, cost cap, and named build owner. Selected for evaluation alone is insufficient; stop and name the exact state gap. (`commission` checks too — verify independently.)
- `build/PLAN.md` exists and names units in order.
- The verification shape is named — by the brief's **How to verify:** field, or, for an older brief that predates it, by `build/PLAN.md` / the commission kickoff carrying a derivation marked **derived, not declared** (legitimate only where `Model: None` makes it unambiguous). make never derives a shape itself: if neither brief nor plan names one for a part you're about to build, **STOP and ask.**
- A current recorder-storage preflight is recorded for this installed version and these two roots. In a standalone run, if commission/snag did not supply one, load `../snag/references/receipt-discipline.md` and perform its installed-version, storage, Git-note/object, preview/output, export/report, and deletion-plan checks in a neutral disposable repository under `CASE_WORKSPACE` before any wrapped command. If the boundary cannot be proven, do not invoke the recorder: run direct and label the full affected set UNRECEIPTED.

## What it can and cannot do (read this before you trust it)

The honest bounds are load-bearing — they're stated here, up front, so no one reads a green loop as more than it is.

- **Catches (objective, trustworthy ground truth):** broken builds, failing tests, dead/half-wired flows, console errors, a control that doesn't actually change its output, replay fixtures that don't reproduce byte-exact, a refusal that didn't fire, a missing liveness stamp, missing-asset/404s, contrast and other `axe`-checkable a11y violations. These are *machine-checkable* — this is the part that moves a scaffold toward a tool someone can actually use.
- **Soft on (self-graded taste):** a model screenshotting its own UI and calling it "tasteful" is the monoculture, at the visual layer. Rarely load-bearing on a plain utility — but when feel IS the wedge, the different-model critic blunts it and **a human spot-check is the final taste gate**.
- **Cannot see (the last-mile tail — it lands on the named build/technical owner):**
  - **Content wrong against a source of truth it doesn't hold** — a value the tool marks fine that the employee's world says is wrong. Green build, working flow, clean screenshot, wrong content. Without the external oracle, the loop can't know. The brief's replay fixtures and sealed examples exist to shrink exactly this gap — but only for the cases they cover.
  - **Subtle correctness/security defects with no failing check** — a race, an auth edge, an off-by-one no fixture exercises.
- **Ceiling: ~80% of the craft, not 100%.** The last-mile tail goes in `build/LEDGER.md` for the build/technical owner — a named residual, never a silent one. IT/security/access receives only the portion tied to its controls; the employee never sees the tail dressed as done.
- **Worth is not a question here.** This skill neither selects nor authorizes work; it serves the recorded authorization. If you catch yourself weighing demand, market size, or "is this worth building," that's a bug — delete the thought and build what the exact revision says.

If a defect lands in "cannot see," the loop's job is to **name it and hand it to the named build/technical owner** — with control-specific findings routed to IT/security/access — never to paper over it with a passing-looking screenshot.

## Prerequisite — acceptance comes from the brief, not from you

You cannot loop without a target — but here **the target already exists and you may not invent it.** Read `references/verification.md` before the first unit. In short:

1. **The brief's `How to verify:` field names the shape** — deterministic, generative, monitor, or which parts are which — and the shape decides the whole check. Deterministic → replay real fixtures, byte comparison. Generative → an isolated run against the sealed set the builder never reads. Monitor → replayed state + the silence test + the liveness stamp in v1. For an older brief that predates the field, build to the derivation `build/PLAN.md` / the kickoff carries, marked **derived, not declared**. **If neither names a shape for a part, STOP and ask** — route it back rather than guessing; a check run in the wrong shape proves nothing and looks like it proved everything.
2. **The brief's `Must be true:` block and `PLAN.md`'s per-unit verification are acceptance criteria** — including the end-user safety defaults (provenance on numbers, completeness accounting, draft-never-send, no green checkmark over a stub). They are acceptance, not style; a violation is a defect with severity.
3. **The refusal suite is acceptance too** (`references/refusal-suite.md`) — broken input must produce a loud stop, and any output at all on broken input is a defect.
4. **The design bar — conditionally.** If experience/feel is load-bearing to this tool, carry a substantive design direction from the brief plus concrete design acceptance criteria, and the visual design loop is mandatory every iteration. If it's a plain utility — expected to be common (unverified — n=1) — the bar is **plain-but-clear**: say so and don't gold-plate it. Note that even a plain utility's *safety surfaces* (the refusal message, the staleness escalation, the liveness stamp) must be legible to a non-technical reader — that's acceptance, not polish.

## The loop

Consume `build/PLAN.md`'s units **in order**; each unit gets built and verified in its own shape before the next starts, and the whole tool gets a final full pass against the brief's complete acceptance. The detailed per-step playbook is in `references/loop-procedure.md` — read it before the first iteration.

1. **Build & test** — run the project's own build, type-check, and unit/integration tests via `bash`. Capture exit codes and pass counts as ground truth. **A red build is iteration 0's only job** — get it green before anything else; you can't see or exercise what won't run.
2. **See — the design-critique pass.** Render the *running* UI and critique it. **When design is load-bearing this is mandatory and runs every iteration — a unit/coupling test never substitutes for it.** Prefer an interactive renderer; fallback is a Playwright script that launches the app and screenshots it. Capture key states across ≥2 viewports, critique against the brief's direction and general craft, emit design defects with severity, capture console errors. **No renderer? Report the visual loop NOT RUN** — never fake it. For a plain utility, glance for plain-but-clear and move on. Full checklist: `references/design-critique.md`.
3. **Exercise** — drive the core flows headless: click, fill, navigate; assert each flow completes end-to-end. Assert **control→output coupling** — drive each input and confirm the output it claims to govern actually changes. For non-browser surfaces, drive whatever the surface is — run the script, call the function, trigger the job — and assert outputs.
4. **Check — two halves, both first-class.** (a) **The refusal suite** (`references/refusal-suite.md`): feed the tool garbage, empty, wrong-format, truncated, and subtly-wrong inputs — harden's fixtures under `build/fixtures/` (assert each one's **surviving-behavior** line from `build/fixtures/MANIFEST.md`) plus your own — and confirm each produces a **visible refusal, never degraded output that looks fine**. (b) The machine checks where a UI exists: `axe` for a11y, perf against any stated budget, broken assets/links, clean console.
5. **Critique** — turn the above into a **defect list with severity** (Blocker / High / Medium / Low) and the brief criterion each one blocks. Every entry points at a checkable signal or a named criterion — **no vibes.**
6. **Rebuild — then loop again; don't stop because something got fixed.** Fix the **top** defects only; don't refactor adjacent code or gold-plate. Re-enter at step 1 and re-ask the improvement questions every pass. **Keep iterating while ANY Blocker/High/Medium defect is open and BUDGET isn't hit.**

Every iteration updates the **ledger** in `build/LEDGER.md` — objective signals (build exit, test counts, flows passing, fixtures matching, refusals firing, console errors) plus the design column when it applies. The ledger is the craft-delta evidence, not "it looks better." It carries the **Reversed discipline**: a build decision that gets overturned mid-loop moves to a `### Reversed` subsection, restated in past tense with what overturned it — never deleted, never struck through.

## Receipts — wrap every recorder-safe load-bearing check

The loop's claims are only worth what backs them. Load the plan's absolute `CASE_WORKSPACE` and `TOOL_REPO`; bind both as unexported local shell variables from those exact shell-quoted values before commands, never from inherited environment. The case workspace is never inside the tool repository, and an existing target repo must be physically separate. Every source/Git/receipt command targets `TOOL_REPO`, while private fixtures are addressed from `CASE_WORKSPACE` under their retention rule.

- Before every fixture-backed check, confirm permission/deadline/classification and recompute its manifest SHA-256 or canonical directory digest. Missing, deleted, expired, or mismatched means NOT RUN. Capture neutral fixture ID, expected digest, observed digest, and match in the private case ledger without printing contents. A source-tree receipt binds the source tree; this digest match is separate evidence for a private input outside it.
- Run each recorder-safe load-bearing verification from `TOOL_REPO`, for example `(cd "$TOOL_REPO" && didrun run -- <cmd>)`. A private-fixture harness verifies the digest and exercises those same bytes before output, but runs directly and is labeled UNRECEIPTED when recording would persist private metadata.
- At each PASS-candidate unit boundary, run claim and seal from `TOOL_REPO` only after recorder-storage preflight passes; keep private paths, values, case names, and digests out of recorded arguments and labels.
- Before that commit, use `git -C "$TOOL_REPO"` to stage named allowlisted paths only, inspect cached names, run required scans without printing values, and inspect ignored/status residue. Never stage raw/real fixtures, secrets, private artifacts, or receipt state. Synthetic fixtures may be allowlisted; a deidentified derivative requires a named authorized owner/date, exact artifact digest, exact repository/history destination, scanner/version/ruleset/covered types, and explicit passing result.
- Gate progression on `(cd "$TOOL_REPO" && NO_COLOR=1 didrun verify --strict)` for the recorder-safe receipt set — **a loop, not a checkpoint.** Nonzero → the unit is NOT done: read the grade, fix the real problem, rerun direct and safe wrapped checks, re-claim, restage/reinspect. If source changed, commit the fix before re-sealing. If source did not change and the intended unit commit is already HEAD, never invent an empty commit; re-seal that commit after the successful rerun/re-claim. Then re-verify. Direct private checks remain UNRECEIPTED. Never weaken a check or delete a claim.
- Report grades verbatim; anything not run through the wrapper is **UNRECEIPTED**, never "verified." If didrun itself misbehaves, record the bug, fall back unwrapped and clearly marked, keep going — never fake a receipt.
- **Receipts are build/technical-owner-facing evidence.** A grade string never appears on the employee's surface as assurance — `tree-exact` binds the sealed tool-source tree, not external fixture bytes and not correctness.

Every unit commit is **provisional** until the unit meets PASS and strict verification is green; only then is it LANDED. A terminal PLATEAU, BUDGET, or BLOCKED never leaves failed source landed. After proving the relevant commits and working-tree changes belong only to that unit and no unrelated work is present, create scoped local revert commit(s), record the failed and revert SHAs, and mark the unit `REVERTED / NOT LANDED`. If uncommitted unit work cannot be isolated safely, leave the tree untouched, stop BLOCKED, and ask the named build owner—never reset, clean untracked files, rewrite shared history, or touch unrelated work.

## The stop-condition (no infinite thrash)

Stop and report the moment **any** of these fires:

- **PASS** — **no open Blocker/High/Medium defect**: every unit's verification green in its shape, the refusal suite green, the brief's Must-be-trues (safety defaults included) met, and — when design is load-bearing — the design bar met via the visual loop. A green build/test alone is **not** PASS, and neither is "fixed a couple of things" while the ledger still lists open Medium+ defects.
- **PLATEAU** — **2 consecutive iterations with genuinely no progress** (no criterion newly passed AND no defect ≥ Medium closed). A re-critique surfacing new Medium+ defects is progress to act on next pass, not a plateau.
- **BUDGET** — the iteration cap is reached (**default 5 per unit; never below 3 for a design-load-bearing build; caller-settable** — `commission` may set it). The finite hard backstop.
- **BLOCKED** — the next defect needs something the loop can't get. Three flavors, three routes:
  - **A human signal** (a taste call, a content check against an oracle only the employee holds) → name it in `build/LEDGER.md` as residual, for the build/technical owner, with exactly what would settle it and who must.
  - **A gate diagnose missed** (an API, a key, a scope, an approval) → emit it in the four-field wiring-ticket shape (**what · who can approve it · roughly how long · what works today without it**) **plus the real activation work, owner, and live smoke test** — then **keep building: the wired path is built safely to the seam.** The adapter, the error paths, an honest **"Not connected — waiting on \<ticket\>"** state — verified as far as verifiable without the credential, ledgered as *verified to the seam; the live call is the ticket's smoke test*. The named build owner owns construction; IT/security/access owns its actual controls and may also be the build owner when named. Never fake past it: the light flips only when a real call succeeds — a key merely *existing* is not "Configured ✓".
  - **A conflict with a LOCKED decision in the brief** → that's a conversation routed back to the person who owns the brief, **never an override**. The employee owns the brief's decisions; the build doesn't get to redefine the work.

When PLATEAU, BUDGET, or BLOCKED fires, apply the provisional-commit rollback rule above before any later unit. Remaining dependent units are `NOT ATTEMPTED`; independent continuation is allowed only against the restored tree.

**Why this can't infinite-loop:** BUDGET is an unconditional counter — even if PASS, PLATEAU, and BLOCKED never trigger, the loop halts at N iterations. The other three only ever stop it *sooner*. Every run terminates.

Always report the **iteration count**, the **per-iteration ledger**, **which condition fired**, the final strict receipt verdict verbatim for the recorder-safe set (or **NOT RUN — no safe recorder boundary**), and the **open-defect queue at stop** — so a one-pass run on a non-trivial build is visibly incomplete and a premature stop is obvious.

## The different-model critic (default when design is load-bearing; optional for plain utilities)

The builder grading its own taste is a monoculture at the visual layer. A critic on a **different model**, handed **only** the screenshots + acceptance criteria + design bar (blind to the builder's rationale), surfaces what the builder can't see about itself. Fold its defects into step 5.

**Modularity is locked:** for a **plain utility** — the common Prentice case — the critic is optional and the loop runs **fully without** it; the objective signals never need a second model. When design is load-bearing, run it by default — but it stays an enhancement on the design track, never a gate on the objective signals. Honest limit: two correlated models are still not the employee — the human spot-check is the final taste gate.

Note the structural rhyme with generative verification: the sealed-set run (`references/verification.md`) is the same move — an isolated judge that hasn't absorbed the builder's context — applied to correctness instead of taste. Keep both isolations real; a promise not to peek is not a control.

## Environment & fallbacks (run anywhere)

The method is portable; only the tooling degrades. Substitute the fallback and **say so in the ledger** — a signal you couldn't run is reported as **not run**, never as passed.

| Capability | If unavailable |
|---|---|
| `bash` build/test | Core — if you can't build/test, you can't loop; stop and say so. |
| Render + screenshot (*see*) | Prefer an interactive renderer; else a Playwright screenshot script. If **none** can run and design is load-bearing: the design bar is unmet, you cannot PASS — never fake it. For a plain utility, proceed on the objective signals and note the gap. |
| Playwright/headless (*exercise*) | Fall back to whatever drives the surface — run the CLI, call the function, hit the endpoint, trigger the job — and assert outputs. |
| `axe` / Lighthouse (*check*) | Skip the a11y/perf checks; report them as not run. The refusal suite has no such fallback — it always runs; it's just invocations and assertions. |
| didrun | Fall back to unwrapped commands, mark every affected claim UNRECEIPTED, record the didrun failure as a bug finding. |
| Different-model critic | Run the loop without it (optional by design). |

**When the shape runs somewhere you can't drive** — a script bound to a document, a scheduled trigger, a platform sandbox — keep the logic a **pure core you can replay locally** and the platform binding thin. Verify the core in its shape; verify the binding by triggering it once for real and reporting exactly that — one live trigger, not "verified." The residual goes to the build/technical owner and any access owner actually responsible for the platform.

## Pitfalls to avoid

- **Inventing acceptance criteria** — the brief and the plan own the target. A criterion you wrote to match what you happened to build is theater; a shape you guessed is worse.
- **Running a check in the wrong shape** — sealing a deterministic merge produces a fossil; letting the builder read the sealed set produces an open-book exam; skipping the silence test ships a monitor that lies by omission. The shape comes from the brief, and each part is verified in its own.
- **Counting output on broken input as working** — any output at all on a broken input is a defect. "It produced *something*" is the failure, not a partial pass. And for a stochastic part, refused 7/10 is a FAILURE — refusal is a rate; sample it.
- **A green checkmark over a stub** — a status indicator may only assert what was actually exercised. "Configured ✓" meaning "an env var exists" is the exact inversion Prentice exists to prevent.
- **Showing a didrun grade — or any builder-facing evidence — to the employee as assurance** — receipts are for the build/technical owner; the employee's assurance is the tool visibly showing its work.
- **Committing or recording the case workspace** — `CASE_WORKSPACE` is never inside `TOOL_REPO`; an existing repo is physically separate. Private/raw evidence and fixtures, sealed sets, logs, and receipt state never enter source history. Use explicit-root commands and never `git add -A`. A sensitive commit is a hard stop; later ignore/deletion does not erase history.
- **Substituting a unit test for the visual loop when design is load-bearing** — a green programmatic check is not a design pass. Render + critique every iteration, or report NOT RUN.
- **One-and-done** — fixing a defect or two, then declaring done while the ledger still lists open Blocker/High/Medium defects. Keep looping until none are open or BUDGET hits.
- **Faking a signal you couldn't run** — a skipped check is reported skipped, never green.
- **Overriding a LOCKED decision because the build would be easier** — route it back. The employee owns the decisions; a reversal that does happen goes under `### Reversed`, never a silent edit.
- **Stalling the whole run on a discovered gate** — emit the ticket, build safely to the seam, ship the no-wiring scope live, keep moving. Equally: never fake past the gate or leave safely possible construction undefined for an implied owner; state the real remaining activation work and smoke test without pretending it is always a paste.
- **Reasoning about whether the tool is worth building** — not this skill's decision; serve the recorded build authorization without market relitigation.
- **Looping past the plateau** — diminishing returns are a handback signal, not a reason to grind. The tail belongs to the named build/technical owner, with control-specific items assigned separately, and is named in the ledger.
- **Reinventing the harness** — compose the existing tools; if you're writing a bespoke test-runner/agent framework, stop.

## Scale heuristics

| Situation | What to run |
|---|---|
| A one-unit plan (the degenerate case — `PLAN.md` says so) | The full loop once: build, verify in shape, refusal suite, safety defaults, ledger. Small plan, same discipline. |
| A multi-unit plan, plain utility (the common Prentice case) | Per-unit loop N≈3–5 each + a final whole-tool pass; design bar = plain-but-clear; critic optional. |
| A build where feel **is** the wedge | Per-unit loops + the visual design loop every iteration + the different-model critic by default + a flagged human spot-check as the final taste gate. |
| A non-browser surface (script, scheduled job, bound macro) | Build/test + targeted exercise + refusal suite; pure-core/thin-binding split; skip *see*; objective signals only. |

The loop scales down to a single verified unit and up to a multi-unit, critic-augmented drive — but the discipline is constant: the brief's target, an honest ledger, a stop-condition, receipts behind every claim, and a clean handback of the tail it cannot see — to the named build/technical owner, and never to the employee dressed as done.
