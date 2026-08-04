---
name: commission
description: >-
  Take an AUTHORIZED TOOL_BRIEF.md revision to a working tool: orchestrate
  harden → sequence → make → snag, then write the FIRE_IT_UP.md handback.
  Construction requires confirmed accuracy, an exact authorized revision,
  an authority holder, a cost cap, and a named build owner; evaluation selection
  alone is insufficient. What the brief cannot answer becomes a wiring ticket
  or one batched question, never mid-run interrogation. Build-then-wire: ship
  no-wiring scope first; discovered gates become evidence-backed tickets; a
  tickets-only stop is valid. ALWAYS invoke on "commission this
  brief", "build this tool brief", "run the prentice pipeline", "take this brief
  to a working tool", or "this revision is authorized — go". It composes the Prentice
  build skills, never reimplementing them; never judges worth, never reopens
  LOCKED decisions, never shows a green checkmark over a stub. Do NOT use to work
  out WHAT to build (diagnose), to drive one phase by hand, or for a product
  aimed at strangers.
---

# Commission — authorized brief revision → working tool, autonomously

`commission` flies the **Prentice build pipeline end to end, autonomously**, from one input: an **exact authorized revision of `TOOL_BRIEF.md`**. The workflow account must be confirmed accurate, and the build authorization must name that revision, its authority holder, its cost cap, and its build owner. Selection for evaluation alone is not construction authority. commission takes it from there and hands back a **working tool + `FIRE_IT_UP.md`**: how the employee starts using it today, what the build owner must review, what IT/security/access must stand up where applicable, and every wiring ask as an owner-ready ticket with evidence.

It is an **orchestrator: it composes the existing skills and never reimplements them.** It invokes `harden`, `sequence`, `make`, and `snag`, carries each one's file output into the next, and adds only the connective tissue — the entry contract, the autonomy contract, build-then-wire, the wiring/parked ledger, and the handback. If you find yourself pasting a sub-skill's procedure into this run, stop: invoke the skill instead.

There is no founder-persona here and no market. A named authority has authorized this exact scope for construction. **commission may not reopen market worth** — not by shrinking scope to look modest, not by relitigating a LOCKED decision. The authorized revision is the boss; commission is the orchestrator serving its named build owner.

## When to use this

**Strong triggers — invoke without asking:**
- "Commission this brief" / "build this tool brief" / "this revision is authorized — go"
- "Run the prentice pipeline" / "take this brief to a working tool"

**Softer triggers:**
- A `TOOL_BRIEF.md` exists in the working directory and the user asks for the tool it describes to be built end to end.

**Do NOT use this for:**
- Working out **what** to build — that's `diagnose`, and it ends where this starts.
- Driving one phase by hand — invoke `harden` / `sequence` / `make` / `snag` directly.
- A product aimed at a market or strangers — wrong suite entirely.
- A brief that doesn't exist yet, half-exists, or lives only in someone's head — hand back to `diagnose`.

**Routing tie-breaker:** commission automates the seam between "this exact revision is authorized for construction" and "it runs on their desk." Reach for it only when that authorization and build owner are recorded — not to replace discovery, evaluation, or prioritization.

## What it produces — and its honest bounds (read this before you trust it)

Load-bearing, stated up front so no one reads an autonomous run as more than it is.

**Produces:** a hardened `TOOL_BRIEF.md` (revisions folded in under the retraction discipline), `build/HARDEN.md`, `build/PLAN.md`, `build/LEDGER.md`, `build/SNAGS.md`, the tool source in the recorded `TOOL_REPO` (normally `CASE_WORKSPACE/tool` for a new tool), and `build/FIRE_IT_UP.md` — the handback.

**The 4 eyes-open limits it does NOT escape:**
1. **~80% ceiling + a last-mile tail.** "Working" is the aim, not a guarantee; a correctness/security tail remains — and it lands on the named build/technical owner, with IT/security/access owning only the controls actually assigned to them. `FIRE_IT_UP.md` names the residual instead of papering over it.
2. **Self-verification has blind spots.** The builder and the checker are the same model family. The counterweights are structural — sealed sets the build never saw, replay fixtures byte-compared, a monitor killed to prove its silence is visible — and they only cover what they cover. A receipt records what ran; it never proves correctness.
3. **Judgment quality isn't measurable.** harden's design calls and snag's triage are signals a human weighs, never proof. An un-vetoed call and an unchecked call look identical from here.
4. **Adoption is the only real validation, and it can't be run.** The employee using the tool for two weeks is the test. Accuracy confirmation, evaluation selection, and build authorization are not adoption — see the firewall below. commission ends before the only evidence that matters can exist, and says so.

**The grounding firewall, Prentice edition:** real workflow evidence — the files `diagnose` opened, the incident story, the known-correct outputs that became fixtures — discovers the problem and seeds the build. **Confirmed accuracy and authorized construction never count as validation that the tool works; only real use does.** `FIRE_IT_UP.md` says which is which.

## The entry contract — authorization is revision-bound

Before anything else, read the whole brief — both halves, including the builder's half below the divider. Then check all three state lines and the build boundary.

- **`Accuracy: Confirmed accurate <date, exact revision, by whom>` + `Build authorization: Authorized for build <date, same exact revision, by whom, named build owner>` + an authorized cost cap** → construction may begin. Emit the kickoff and fly.
- **`Evaluation: Selected for evaluation` without matching build authorization** → **refuse to build.** The case may be evaluated or hardened, but selection is not construction authority.
- **Anything else — Draft, not authorized, mismatched revision, missing authority/cap/build owner, or needing reconfirmation** → **refuse to start.** Name exactly which field is missing or stale and offer the appropriate handback. Evaluation selection is independent: a valid build authorization does not become invalid merely because evaluation remains `Not selected`. A confirmed case with no build authorization is a valid complete outcome; do not turn it into a failure or a provisional build. Do not authorize it yourself. **The refusal is the designed behavior, not a failure** — report it as a complete outcome.

The narrow single-authority shortcut applies only when the brief explicitly records that the same named person controls data permission, evaluation selection/prioritization, spend, connection/access, construction, and acceptance. Never infer that authority from "one user" or a job title.

What commission never does at intake or after: run ideation, re-derive whether the tool is worth building, reason about market or demand, or reopen a LOCKED decision. The Decisions block is in force; anything under `### Reversed` stays reversed. If the build wants to deviate from a lock, that's a conversation routed back to the employee — never an override.

Full intake procedure (the inventory, the batched question, the wiring map, mechanics): read `references/pipeline-playbook.md` **before starting the run.**

## The pipeline it flies (compose, never copy)

Hard rule: **invoke** each skill and carry its file forward; never inline its content. Private case outputs live next to the brief in `build/`; tool source lives in the recorded `TOOL_REPO`.

0. **Intake** (commission's own) → entry contract, exact authorized revision, named build owner, brief inventory, the one batched question, the wiring map, the kickoff.
1. **`harden`** → `build/HARDEN.md` + adversarial fixtures under `build/fixtures/` — attacks the authorized DESIGN (inputs, variants, silent-wrong paths, security, the thing that breaks in November); **never the concept's worth.** Non-material clarifications fold back under the retraction discipline. A material change reopens accuracy confirmation, evaluation selection, and build authorization for the new revision; commission stops before sequencing it.
2. **`sequence`** → `build/PLAN.md` — the briefed scope as self-contained, verifiable units, each naming its verification shape; no-wiring units first. Degenerate case: one unit, and the plan says so.
3. **`make`** → source in `TOOL_REPO` + `build/LEDGER.md` — builds each unit and drives it until it actually works, verified **in its brief-named shape**, refusal suite included, with receipts only where the recorder boundary is safe.
4. **`snag`** → `build/SNAGS.md` — post-build defect pass: audit → triage → fix, verified local commits. Optional below a threshold (say so).
5. **The handback** (commission's own) → `build/FIRE_IT_UP.md`, written **last**, after snag.

Phase-by-phase orchestration (what each invocation gets, what carries forward, where each phase can stop): `references/pipeline-playbook.md` — read the relevant phase's section before invoking it.

## The autonomy contract

- **The brief is the answer sheet.** No persona gets invented to answer gates. The decision hats are explicit: domain expert, facilitator/operator, sponsor/process owner, build owner, IT/security/access owner, and accepting user; one person may hold several, but never by implication. Answer every question the run has **from the authorized revision**; establish from files what a file can establish (the second law: ask only what only they can answer).
- **What the brief doesn't answer and a file can't establish** becomes either (a) a **wiring ticket**, if it's an access/approval/credential question, or (b) part of **one batched question**, asked at intake — **never a mid-run interrogation of the employee.**
- **Never fake a gate.** Build only the briefed scope. A gate that genuinely needs a human — an approval, a credential, a scope, a real-use signal — is emitted honestly in the four-field shape, never auto-passed, never rendered as a "passed" gate, never built past with a stub behind a checkmark. The autonomy makes it easy to rationalize past a gate; this is the rule that keeps the run honest.
- **Keep the two roots explicit.** Record absolute `CASE_WORKSPACE` for the brief/private evidence and `TOOL_REPO` for source; the case workspace is never inside the tool repo, and an existing target repo must be physically separate. Git and receipt commands target `TOOL_REPO`; private evidence follows the brief's lifecycle. Local history is not publication permission. No secret value enters any artifact.
- **Narrate the phases.** Say which skill is running and what file it produced, so the run is legible and resumable.
- **Fit, not size.** Scale heuristics scale the *process* (skip harden for a one-prompt tool), never the *tool*. If the brief needs something big, build something big.

## Build-then-wire — the autonomy contract's core

Building is cheap, parallel, and autonomous. Wiring — keys, scopes, app approvals, admin consent, plan upgrades — is scarce, serial, and human. So:

- **Always build the version that needs no wiring first, if one exists.** The brief carries "what works today without it" for exactly this; it is the day-one usable scope.
- **The wired path gets built too — in full, to the seam.** The adapter, the error paths, an honest **"Not connected — waiting on \<ticket\>"** state, verified as far as verifiable without the credential. What waits on the ticket is *activation*, never safely possible construction. The named build owner owns construction; IT/security/access owns only the access, infrastructure, or deployment work assigned to it and may also be the build owner when the brief says so. The activation step may be more than a paste; name the real work and smoke test. The light flips only when a real call succeeds.
- **A gate the build discovers that `diagnose` missed** is emitted in the same four-field shape as any wiring ticket — **what's needed · who can approve it · roughly how long · what works today without it** — plus the activation step, and the run keeps building. Never fake it; never stall the whole run if a degraded-but-real version can ship.
- **Wiring asks arrive as tickets with evidence** ("the file-drop version is live and receipted; the API path is built and dormant — this named activation work and smoke test make it automatic"), never flyers. Evaluation and prioritization belong before commission; access tickets go to their actual owner.
- **The run stalls on a human only when missing information or authority makes further construction unsafe.** Missing live access alone does not park a buildable path: construct and test everything safely possible to the seam. A tickets-only stop is an honest stopped outcome, not evidence of a working tool.

## Decision hats, never conflated

- **Confirmation of ACCURACY** belongs to the domain expert and does not select or authorize a build.
- **Selection for EVALUATION** belongs to the named sponsor/process owner and does not authorize construction.
- **Authorization to BUILD and SPEND** belongs to the named authority, binds one exact revision and build owner, and carries the cost cap. commission runs inside it; a run about to exceed it stops and says so.
- **Permission to CONNECT** (scopes, keys, systems, other people's data) belongs to the named IT/security/access owner or other recorded authority and is **never commission's to grant.** It moves only through a wiring ticket.

Don't rebuild the slow queue by accident: a spend question routed to IT is a week lost; a connect question waved through as "small" is the exact incident `diagnose`'s gates exist to prevent.

## Verification shapes, carried through

The brief names how each part is verified (**How to verify:** — generative / deterministic / monitor); **the build can't infer it**, so commission carries it into every `make` invocation and holds `make` to it:

- **generative** → sealed examples the build **never sees**; verification is an isolated run whose entire input is the tool + the sealed set — never this chat, never the brief.
- **deterministic** → replay fixtures: real inputs → the real output they actually sent → byte comparison. Visible to the local build, digest-bound, not sealed. The real pair remains private and lifecycle-bound. Synthetic derivatives may enter the allowlist; deidentified derivatives additionally require the canonical named-owner/date, exact-digest, exact-destination, scanner/version/ruleset/coverage, and explicit-passing-result record.
- **monitor** → replayed state (reconstruct the day it went wrong, run the job, check the output) **plus the silence test**: kill it and confirm the silence is visible. The liveness stamp ships in v1 or the monitor doesn't ship.

Most real tools mix shapes; each part is verified in its own, and the strictest verdict governs its own output. `make` also owes the **refusal suite** on every unit: garbage, empty, wrong-format, truncated, and subtly-wrong inputs must produce a visible refusal — break their real file the way their world breaks it; the only correct behavior is a loud stop; **any output at all is a defect.** And the brief's tool-safety must-be-trues ride into every unit: the tool shows its work (numbers carry provenance), says what it processed and stops loudly on a mismatch, and never acts irreversibly by default — it drafts; the human presses send.

Recorder-safe load-bearing checks carry receipts (grades reported verbatim; `tree-exact` means "recorded against the sealed source tree", never "proven correct"). Checks that would persist private values, case names, or identifying paths run directly and are labeled UNRECEIPTED. **Receipts are build/technical-owner-facing evidence, shared with IT/security/access only for its actual controls. A grade string is never shown to the employee as assurance.**

## The wiring/parked ledger (LOCKED)

Nothing in this pipeline dies for market reasons — but units can be **dormant** (built in full to the seam, awaiting their wiring ticket's activation — the normal, healthy state of a wired unit) or **parked** (failed the verification bar, or cut by a reversal the employee would have to grant). The two are different and the ledger says which: dormant units are *done building*; parked units are not. Neither is **ever silently dropped.** Each is surfaced in `FIRE_IT_UP.md` with its state named honestly and **what changes it** — for a dormant unit, the ticket's real activation work, owner, and smoke test; for a parked one, the fixture it has to pass or the conversation to have. A dormant or parked unit with a named condition is a deliverable; a quietly missing one is a lie of omission.

## The handback — `build/FIRE_IT_UP.md`

Written by commission itself, **last, after snag** — no sub-skill creates or writes this file; commission folds in every wiring ticket the run flagged in `build/LEDGER.md` and `build/SNAGS.md` when it writes it. Three sections, in this order:

1. **For \<employee\>:** how to start using it today — plain English, no jargon, written for the person whose job it is. Where their information goes, in words. What it won't do. No grades, no receipts, no builder vocabulary — **the end user is non-technical and this section must never require a competent reader to be safe.**
2. **For the build/technical owner — review and stand it up:** the reduced setup steps, what was verified in the ledger's own words, where the receipts and fixtures are, the honest residual, and what was skipped and why.
3. **For IT/security/access — only the assigned tickets:** each in the four-field shape, with evidence, the real activation work and smoke test, plus the dormant/parked ledger. Omit this section when no such owner is needed.

**What it may claim:** exactly what `build/LEDGER.md`'s receipts and fixtures verified, in those words. **What it may never claim:** "done", "verified", or "working" for anything unverified — and **no green checkmark over a stub, ever.** A "Configured ✓" that means "an env var exists" is the exact inversion Prentice exists to prevent.

**Every "we checked / verified / confirmed" claim carries its trace.** A verified claim that can't be traced to *what settled it* isn't fully honest — the reader has to take "we checked" on faith, which is the same "trust me" the whole pipeline refuses everywhere else. So a verified claim points at the finding behind it: the ledger row, the `HARDEN.md` finding, the exact one-line command that settled it (*"your domain's mail routes straight to your provider — confirm with `dig MX <domain>`"*). In the employee's plain-English half the pointer stays light and often reproducible-by-them; in the build/technical owner's half it's the file and line. This is not optional politeness — a "we checked" with no trace reads as verified and cost a reviewer of this very pipeline twenty minutes to wrongly conclude it *wasn't*, when a two-word pointer would have settled it in seconds. Whatever a claim can't point at, it may not call checked.

## The kickoff (emitted each run)

commission opens each run by emitting a **kickoff** that locks the run's frame, then executes it. The full fill-in template is `references/kickoff-skeleton.md` — read it at intake. It captures: the brief's identity and exact authorized revision, authority holder, named build owner, decisions in force, verification shapes, wiring map, spend cap, autonomy contract, pipeline order, and safety-net. The kickoff is a pure function of that revision — a fresh session re-derives it by re-running intake, which is what makes the run resumable.

## Context / handoff safety-net

A full run is long and may outlive one chat. **Files are the durable memory** — the brief, `build/HARDEN.md`, `build/PLAN.md`, `build/LEDGER.md`, `build/SNAGS.md` — never chat memory. Each phase's output is a file the next phase (or a fresh session) reads; `PLAN.md`'s unit statuses and the ledger say where a dead run stopped. If the run risks a context limit, emit a **`sequence` Mode C handoff** (state snapshot + read-these-first + exact next step) so a fresh chat resumes cleanly with no amnesia.

## Pitfalls to avoid

- **Re-implementing a sub-skill** instead of invoking it. Compose, don't copy. (If you're pasting a red-team procedure or a build loop, stop.)
- **Starting without a matching authorized revision, authority holder, cost cap, and named build owner** — or worse, authorizing it yourself. Accuracy confirmation and evaluation selection are not substitutes; refuse and hand back.
- **Reopening the go/no-go.** Judging worth, market, or "is this big enough to bother" anywhere in the run is a bug — delete the thought.
- **Interrogating the employee mid-run.** One batched question at intake, or a ticket. They answered everything once; that was the deal.
- **Faking or auto-passing a human gate** — a scope you don't have, an approval that hasn't landed. Emit the ticket; build to the seam; ship the no-wiring scope live.
- **Leaving safely possible wired construction undefined for someone else.** The named build owner constructs to the seam; the ticket states the actual remaining access/infrastructure/deployment work and smoke test without pretending it is always a paste.
- **Stalling the whole run on one blocked unit** when a degraded-but-real version can ship — or its mirror, **shipping past a block with a stub behind a green checkmark.** A "Configured ✓" over a stub is the cautionary tale.
- **Reversing a LOCKED decision because the build would be easier.** Route the conversation back; build inside the lock or park the unit.
- **Folding a harden revision without the retraction discipline** — grep the brief for the claim you just stopped believing; fix every hit in the same edit.
- **Letting `make` verify in the wrong shape** — sealed examples leaking into the build, a fossil sealed-set treated as live scope, a monitor shipping without its liveness stamp.
- **Silently dropping a parked unit** — the wiring/parked ledger forbids it.
- **Writing `FIRE_IT_UP.md` before snag finishes**, or writing section 2 without doing the reduction first.
- **Showing the employee a didrun grade, a receipt, or builder jargon as assurance** — the two audiences are separated by artifact, never blended.
- **Versioning or recording the case instead of the tool** — a broad Git/recorder root, ambient cwd, blanket staging, or copied real fixture can capture private evidence. Use `git -C "$TOOL_REPO"`, run receipts from that root, stage only the allowlist, and keep `CASE_WORKSPACE` physically outside an existing repo. If sensitive material lands in history, stop — later ignore/deletion does not erase it.

## Scale heuristics

| Situation | What commission runs |
|---|---|
| A one-prompt tool (the brief says "a saved prompt") | Skip `harden` — **say so.** `sequence` collapses to its degenerate case: a one-unit `build/PLAN.md` that says so (`make` requires the plan file; the degenerate plan is cheap and keeps the seam). `make` verifies it once in its shape; `snag` skipped; a short `FIRE_IT_UP.md` still ships. |
| A small deterministic tool, no model | Light `harden`; a plan from `sequence`'s threshold heuristic — often one unit, and the plan says so; full `make` with replay fixtures + the refusal suite; `snag` optional if the tool reads in one sitting and every shape verified — say so in the handback. |
| A real program, or anything with a monitor in it | Full pipeline. Monitor units carry the silence test + the v1 liveness stamp, non-negotiably. `snag` runs. |
| The brief needs something big | Build something big. Fit, not size — the heuristics scale process, never the tool. |
| Every path needs live access | Build each authorized path safely to its seam; stop only where missing information or authority prevents safe construction, and name the honest residual. |
| Accuracy/build authorization is missing, mismatched, or stale | Refuse, name the exact state problem, and offer the appropriate handback. A confirmed case without a build is still a complete outcome. |

commission is the autonomous tier of Prentice's optional build half: it turns one authorized brief revision into a working tool, a fire-it-up checklist, and a queue of evidence-backed wiring tickets — serving a named build owner, eyes open on the 4 limits, never claiming what the receipts don't show.
