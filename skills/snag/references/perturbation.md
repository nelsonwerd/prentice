# The Perturbation Pass — break her files the way her world breaks them

On a tool this size, the highest-value audit isn't reading the code — it's feeding the tool the inputs her world will actually produce and watching what it does. `make` built the refusal suite (negative acceptance is its contract); this pass is that suite's **adversary and its regression fence**: extend it with new mutations, confirm every loud stop still stops loudly, and confirm the stops never fire on her real work.

**The principle, over any checklist:** *break their real file the way their world breaks it; the only correct behavior is a loud stop; any output at all is a defect.* A checklist below is a starting quiver, not the pass — the mutations that matter come from **her** world: the brief's gate-2 stories, the incident list, what the exposed examples reveal about how her files actually vary.

## Where the raw material comes from

- **`build/fixtures/`** — harden's adversarial inputs from the design stage. Run every still-permitted, digest-matching one. Missing, deleted, expired, or mismatched means NOT RUN — private validation unavailable, never an inherited pass.
- **The still-permitted exposed examples and replay-fixture inputs** — her real files. Check permission, deadline, classification, and digest before opening them. These are the templates you mutate and the false-positive control set below. *(Never the sealed set — it stays sealed from this pass like every other.)*
- **The brief's own stories** — gate 2's verbatim incidents and the must-be-trues name the failures her world has already produced. Reconstruct each one as an input — the value that changed after it was committed to, the stage that advanced with its follow-up never sent, the monitor that stopped firing.

## The mutation quiver

Start from a real file and break it one way at a time, in roughly this order of value:

1. **The plausible corruption** — the one that produces class-1 failures. A figure that disagrees between two places that must agree. A date from the wrong year that's still a valid date. A row duplicated with one cell changed. A column renamed to a near-synonym. **These are the mutations that separate a loud tool from a lying one** — a truncation test passes trivially in code that fails all of these.
2. **The silent absence** — the empty-but-valid export; the missing row; the stage that never advanced. For anything with a monitor part: **reconstruct the day it went wrong** (the brief usually names one), run the job against that state, and check it *says the right thing* — then **kill it and confirm the silence is visible.** A monitor that fails quietly passes every other test in this file.
3. **The structural break** — truncated mid-record; wrong format with the right extension; the extra sheet/tab the tool didn't expect; header row missing or doubled; encoding garbage that opens fine in her app.
4. **The world's calendar** — the thing that breaks in November: year rollover, DST, fiscal boundaries, the first run of a new month/quarter, a 366th day. Run the tool *as if* on those dates where dates matter.
5. **The vendor's quiet change** — export formats drift. Simulate the plausible next version: a new column inserted in the middle, a changed date format, quotes where there were none.
6. **The half-state** — for anything stateful: a row mid-transition, two stages advanced at once, a stage skipped, an edit landing during a scheduled run.

For each mutation record in `SNAGS.md`: the mutation, the file, **what the tool did, verbatim** — and grade it:

- **Loud stop** — it refused, visibly, and said what stopped ✅
- **Degraded output that looks fine** — a defect, class by triage-guide ❌ *(this is the finding the pass exists to produce)*
- **Crash** — better than a lie, still a finding: she gets a stop she can't read. Downgrade-severity, but the message becomes a fix item.
- **Silence** — for monitors, the worst grade there is ❌

## The refusal regression — both directions, every time

A guard has two failure modes and only one gets tested by instinct:

- **Direction one (misses):** every still-permitted, digest-matching fixture in `build/fixtures/` — harden's originals plus this pass's additions — produces its loud stop.
- **Direction two (false alarms):** **every still-permitted, digest-matching exposed example and replay-fixture input passes clean through every guard.** A guard that fires on her real work is a defect of equal rank to the one it guards against: she'll learn to click past the refusals, and then the loud stop protects nothing. *(This is triage-guide's class 5 — a crying-wolf guard silently unguards classes 1 and 2.)*

This regression runs **at every fix unit that touches a guard** (Phase 4) and **in full at Phase 5** over evidence still permitted then. A new guard gets a classified mutation fixture. Real/private fixtures stay outside source history and only for the brief's authorized retention period. For durable source-history regression, construct an allowlisted synthetic fixture where fidelity permits. A deidentified derivative needs the canonical named-owner/date, exact-digest, exact-destination, scanner/version/ruleset/coverage, and explicit-passing-result record.

## The refusal itself is an audited surface

The stop is only loud if she can read it. For every refusal observed, check the message against the two-audience rule:

- It says **what stopped** and **what to do next**, in plain English, in her terms — *"This file is missing the 'Price' column, so nothing was generated. Check you exported the right sheet."*
- It is not a stack trace, an exit code, or a grade string. (Those can follow for the named build/technical owner — never lead; route control-specific evidence to IT/security/access when applicable.)
- It **never claims more than was checked** — a refusal that says "file invalid" when it only checked the header is a small lie in the same family as the green checkmark over a stub.
- It follows the safety defaults: says what it processed; a partial result is never presented whole.

A correct stop with an unreadable message is a finding — usually a cheap, high-value unit.

## What lands where

- New mutation fixtures → **`build/fixtures/`**, named for what they break (`price-mismatch-after-quote.csv`), each with a one-line expected-refusal note, classification, retention/deletion rule, and file SHA-256 or canonical directory digest. Before each run, recompute the digest and record expected, observed, and match in `SNAGS.md`; mismatch stops the check. Keep it explicit that a later source-tree receipt binds source while this digest evidence identifies the external fixture.
- Durable regression follows the lifecycle rather than defeating it: use a synthetic fixture, or a deidentified derivative carrying the exact approval and scan above. Where fidelity permits, the tool repo gets a committed synthetic smoke/regression subset; `SNAGS.md` names every case that still requires private validation.
- The mutation record and grades → the findings section of **`build/SNAGS.md`**.
- This pass is **read-only against `TOOL_REPO`** and **UNRECEIPTED, labeled so** (it's part of the audit — see `receipt-discipline.md`). Fixes come later, gated and receipted where the recorder boundary is safe.

## The honest limits

- **A pass here proves the tool stops on what you broke.** It says nothing about the mutation you didn't think of — absence of findings is not absence of defects. Say so in the ledger.
- **The mutations are authored by the same mind that reads the code.** Where the stakes are data leaving the machine or PII, the fresh-context critic at Phase 5 should propose its own mutations, blind to yours.
- **Some breakage can't be simulated honestly** — the real mail server rejecting the real message, the scheduled trigger not firing on the platform's servers. Those are named in the ledger as what only real use can test, in the brief's own terms — never quietly marked covered because a simulation passed.
