# Verification — the target the loop runs toward, and why you don't get to write it

The loop is only as honest as its target. Upstream builds derive their own acceptance criteria; **a Prentice build may not.** The workflow target was confirmed where the knowledge lives, then bound to an exact authorized revision and sharpened by `harden`; it arrives in three places:

1. **`TOOL_BRIEF.md` → `How to verify:`** — names the verification **shape** (deterministic / generative / monitor, or which parts are which). The shape decides the whole check and **the build cannot infer it.**
2. **`TOOL_BRIEF.md` → `Must be true:`** — hard acceptance criteria in the brief's own words, including the end-user safety defaults (below).
3. **`build/PLAN.md`** — per-unit verification from `sequence`, each unit's "how you'll know this unit is done."

**The shape is named upstream — never derived here.** For an older brief that predates `How to verify:`, `build/PLAN.md` or the commission kickoff may carry a derivation marked **derived, not declared** (legitimate only where `Model: None` makes it unambiguous) — build to that. **If neither the brief nor the plan names a shape for a part you're about to build — STOP and ask.** Route it back to whoever owns the brief. Do not guess: a check run in the wrong shape proves nothing and looks like it proved everything, which is strictly worse than no check. (Real briefs predating the field exist; for them the plan's derivation is the designed path, and the stop fires only when even that is absent.)

## What makes a criterion usable (unchanged from upstream)

- **Binary** — it passes or it doesn't; no "mostly."
- **Checkable by machine or scripted flow** — a command, a headless assertion, a byte comparison can settle it. If settling it needs a human's judgment, it's a **handback item for the named build/technical owner or domain expert**, not a loop criterion (see the tail, below).
- **Tied to the brief's promise** — it tests the thing the employee is actually getting.
- **Stated before you build toward it** — here, guaranteed by construction: the brief and plan predate the build.

## The three shapes — verify each part in its own

Most real tools mix shapes. The brief says which parts are which; check each part in its shape and never let one shape's green stand in for another's.

### Deterministic — no model in this part

**Replay fixtures: real inputs → the real output they actually sent → byte comparison.** Visible to the local build under `build/fixtures/`, not sealed — it's a test, not an answer key. The real pair is private workspace evidence, never source-history material, and follows the brief's retention/deletion rule. Synthetic fixtures may be allowlisted. A deidentified derivative needs a named authorized owner/date, exact artifact digest, exact repository/history destination, scanner/version/ruleset/covered types, and explicit passing result. There is no generalization claim to protect: if the merge is supposed to reproduce the message they actually sent, reproducing it exactly is *correct behavior*. **"Tuning to the answer" IS the spec here.**

The isolation that matters isn't "hasn't read the conversation" — it's **"didn't read the expected output while writing the merge."** Write the code from the input and the rules; only then compare.

- From `TOOL_REPO`, run one harness that recomputes the manifest's SHA-256 or canonical directory digest, stops on mismatch, and exercises those same bytes. Capture fixture ID, expected digest, observed digest, match, and the empty comparison diff in the private case ledger without printing contents. Wrap it only when recorder-storage preflight proves that no private path, value, case name, or digest will persist; otherwise mark the direct run UNRECEIPTED.
- Keep the evidence boundaries separate: the receipt binds the command to the sealed source tree; the digest match identifies the private fixture outside that tree. `tree-exact` alone does not bind that external input.
- A near-miss is a defect, not a rounding note. Byte-exact or it fails. If the brief itself allows variance (a date stamp, an ID), the fixture must encode the allowance explicitly — never you deciding a diff "doesn't matter."
- Where fidelity permits, commit an allowlisted synthetic smoke/regression subset so a clean checkout can exercise the core path. Label every behavior that still requires private validation; the synthetic subset never upgrades or replaces that evidence.

### Generative — a model in this part

**An isolated run against the sealed set.** The brief carries a pointer and a count for `Sealed:` examples the build was never handed. The rules:

- **The builder that wrote this part must never read the sealed outputs.** Not before, not during, not "just to check." Once read, the exam is open-book and the run proves nothing.
- Verification is a **separate run whose entire input is the tool + the sealed inputs** — not the brief, not this conversation. Dispatch it as a subagent with exactly that. Compare its outputs to the sealed expected outputs.
- **If you cannot isolate it** (no subagents, one session), say so in the ledger rather than claiming a guarantee you don't have. "I won't look" is a promise, not a control — record the check as weakened, name why, and put the real isolated run on the named build/technical owner's list; involve IT/security/access only when the run needs one of its controls.
- Grade against the brief's stated bar for this part, and log misses as defects with the exact sealed case that failed (the case, not its expected answer, if the loop continues — the builder still must not absorb the answers).

### Monitor — this part watches for something

A monitor's answer key is an event that didn't happen; you cannot verify "it would have caught it" from a document. Three checks, all three, no substitutes:

1. **Replayed state** — reconstruct the state as it stood the day the thing went wrong (the brief's gate-2 incident is the test case: build the thing that would have caught *that*), run the job against it, assert it says the right thing, loudly, to the person.
2. **The silence test** — kill it (disable the trigger, break the job) and confirm the silence is **visible**: a missing liveness stamp, a gap someone would notice. A monitor that fails quietly passes every other test you can write, which is exactly why this one is mandatory.
3. **The liveness stamp ships in v1 or the monitor doesn't ship.** Every output stamps when it last successfully checked ("last checked 08:00, Jul 15") whether or not it found anything. Never a later phase, never a nice-to-have. Its presence is an acceptance criterion; the refusal suite's truncated/garbage cases must not be able to produce a stamped all-clear.

## The safety defaults are acceptance criteria, not style

These come from the brief's `Must be true:` block and they bind whether or not the brief restates them. Each violation is a defect, default severity High or Blocker. They exist because the tool's end user is non-technical — the tool must be safe for a reader who cannot audit it:

- **Shows its work** — every number carries where it came from. Provenance the employee can follow, in words, not a debug log.
- **Says what it processed** — completeness accounting: "read 12 of 12 files." A mismatch stops loudly; a silent partial run that looks complete is a Blocker.
- **Never acts irreversibly by default** — it drafts; the human presses send. If the brief locked "never sends anything, ever," that lock is in force and a convenience auto-send is a LOCKED-decision violation, routed back, never shipped.
- **No green checkmark over a stub** — a status indicator may only assert what was actually exercised. "Configured ✓" that means "an env var exists" is the exact inversion this pipeline exists to prevent; test the indicator by breaking the thing it reports on and watching it change.
- **Never let "local" stand in for "private"** — the tool says where the data goes, in words, and the words must be true. "Runs on your machine" while POSTing each file to a model API is a Blocker, not copy-editing.

## Name the tail you can't check — up front, for its owner

Some of "done" is genuinely not machine-checkable. Name it *before* you loop, so it's a planned handback and not a silent gap:

- **Content correctness against a source of truth the loop doesn't hold** — beyond what the fixtures and sealed set cover.
- **Subtle correctness/security** no fixture exercises.
- **Real-world liveness over time** — a scheduled trigger verified by one live firing, not two weeks of mornings.

These go in `build/LEDGER.md`'s residual section — **for the build/technical owner**, with IT/security/access receiving only items tied to its actual controls, and with what would settle each and who must. They are never loop criteria, and they are **never visible on the employee's surface as if finished.** Evaluation selection and build authorization are upstream states, not loop criteria.

## Mini-example — the criteria sheet for a tracker-that-also-writes (deterministic + monitor)

- **Builds & passes:** the project's own build/tests run from `TOOL_REPO` through the recorder and exit 0.
- **Deterministic (the merges):** each output document replays byte-exact from the private real fixture — real row in, the real message they actually sent out — after its manifest digest is recomputed and recorded as a match. The source receipt and external-input digest are reported separately. An allowlisted synthetic smoke fixture may be committed; a deidentified derivative needs the canonical complete record above, and neither derivative upgrades the private evidence class. The price merges from the single quoted-price cell; there is no second field to retype (assert the field doesn't exist, not just that it matches).
- **Monitor (the 7:30 nag):** replay the incident day — the order that sat delivered-with-no-invoice-raised — and assert the email names it. Kill the trigger; assert the silence is visible. Every email stamps "last checked 07:30" — assert the stamp on every output, including all-clears.
- **Refusal suite:** a row missing a required value → loud refusal, never a finished-looking document with a blank where that value belongs (see `refusal-suite.md`).
- **Safety defaults:** nothing auto-sends (every output is copy-to-paste); the staleness view says what it counted; no status light asserts anything it didn't exercise.
- **Tail (assigned):** build owner — trigger reliability over weeks; domain expert — whether the workflow is actually followed. Named in the ledger, out of the loop's reach.

That sheet is enough to run the loop to a confident PASS — and equally to know exactly when to stop.
