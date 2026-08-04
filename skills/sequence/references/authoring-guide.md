# Authoring Guide — turning an authorized brief revision into build/PLAN.md

Use this when `commission` reaches its planning phase, or when the user says "sequence this brief" / "plan the build units." Output: a complete plan saved to `build/PLAN.md` next to the exact build-authorized `TOOL_BRIEF.md` revision, plus a short summary of the unit count, the order, and what ships without wiring.

The scaffold to fill is `references/plan-template.md`. This guide is the *process* to fill it well.

## Step 0 — Check the preconditions, and establish the source of truth

Four checks before any planning. Each is cheap; skipping any of them poisons everything downstream.

**1. The exact revision is confirmed and authorized.** Read `TOOL_BRIEF.md` in full. `Accuracy: Confirmed accurate` and `Build authorization: Authorized for build` must name the same exact revision, with authority holder, cost cap, and named build owner. Selected for evaluation alone is insufficient. Any missing, stale, or mismatched field → **refuse and stop**: name the exact gap and hand back. Do not plan provisionally. This refusal is a feature — `commission` checks the same contract, and `sequence` verifies it independently rather than trusting its caller. (`harden` may run on a confirmed-accurate revision selected for evaluation; planning and building may not.)

**2. `harden` has run.** In the normal pipeline, `build/HARDEN.md` exists and its revisions are already folded into the brief, with adversarial fixtures under `build/fixtures/`. Read it — its findings are per-unit guardrails waiting to be placed. If it's absent (a standalone invocation), don't manufacture one: proceed, but flag in the plan's front matter that the design was not hardened and the fixture set is whatever the brief carries.

**3. The verification shape is named.** The brief's builder half carries a **How to verify:** field naming generative / deterministic / monitor per part — the build cannot infer it, so the plan must carry it into every unit. If the field is missing (older briefs predate it), **don't infer silently.** Derive it only where the brief makes it unambiguous — `Model: None` rules out a generative part, leaving deterministic and monitor to be read off the outputs — write the derivation into the plan marked **derived, not declared**, and flag it in your summary so a human can veto it. If it's genuinely ambiguous, stop and ask one sharp question rather than planning a check that proves nothing.

**4. The evidence lifecycle and two roots are explicit.** Copy the brief's exact case location, access, retention deadline, deletion method, and owner. Resolve absolute `CASE_WORKSPACE` and `TOOL_REPO`; the case workspace may contain a new tool repository at `tool/`, but may never sit inside a tool repository. An existing target repository must be physically separate from the case workspace. Missing lifecycle or ambiguous roots → stop and repair the intake; an allowlist cannot protect private untracked files from every recorder.

**Never replace recorded authorization with your own go/no-go.** Sequencing weighs *order and boundaries*, nothing else.

## Step 1 — Reconnaissance (read-only)

Do not plan from memory. Read the real material before writing a single unit.

- Read the brief's Clearance and lifecycle plus builder half in full: Shape, Needs, Model, Cost, Inputs, Outputs, How to verify, Must be true, Out of scope. These are the plan's raw inputs.
- Read the Decisions block and the gate rows — they carry guardrails ("nothing auto-sends", "one authoritative price cell") that must land in specific units' MUST-NOT-CHANGE lists.
- Read `build/HARDEN.md` and list the fixtures under `build/fixtures/` with their paths, content/directory digest, data class, retention/deletion rule, durable derivative, approval/scan disposition, plus `build/fixtures/MANIFEST.md`'s **surviving-behavior** line for each. Before opening a fixture, confirm current permission, classification, deadline, and digest. Missing, deleted, expired, unauthorized, or mismatched material stays unopened and is recorded `NOT RUN — private validation unavailable`; no older result substitutes. Only eligible fixtures travel into a unit. Note which finding each fixture attacks.
- Note the exposed examples' path if the brief names one. **Never open the sealed examples** — record their path and count from the brief's pointer and nothing else. If you find sealed content quoted anywhere the build will read, that is a defect to raise, not context to use.
- If a tree already exists (a rebuild, or `commission` re-planning mid-run): map it. Identify every file each unit touches and capture them in the **Architecture map** with real paths, so executing sessions don't rediscover them. Record the commit validated with `git -C "$TOOL_REPO" rev-parse --short HEAD` and the explicit commit allowlist. If there's no tree yet — the common greenfield case — the Architecture map lists the files each unit will *create*, and U1's scope initializes `TOOL_REPO`, leaving private case evidence outside source history.
- Note the runtime target and exact verify commands. Every recorder-safe receipt command runs from `TOOL_REPO`. The same exercising harness verifies each private fixture's recorded digest and exercises those bytes before output, so a later fixture change cannot inherit the old result. Never put an identifying private path, value, case name, or digest in recorder arguments, environment, labels, stdout, or stderr. If a safe neutral boundary is not proven, emit the direct private-fixture command labeled UNRECEIPTED and a separate recorder-safe source/synthetic command.

If you skip this step, your file lists and sequencing will be wrong. This reconnaissance is the foundation.

## Step 2 — Carry the decisions; fence the scope

- **Restate the brief's LOCKED decisions** in the plan's Decisions block, verbatim or near it, each with its one-line why. Executing sessions treat them as fixed — this prevents re-litigating the employee's calls in every session. The plan may **add** sequencing decisions of its own (also LOCKED, with a why). It may never reverse a brief decision: if sequencing genuinely cannot proceed under a lock, that's a conversation routed back through `commission` to whoever owns the brief.
- If a plan decision is later overturned, follow the retraction discipline: move it under **### Reversed**, restate it in past tense with what overturned it, and grep the plan for every sentence asserting the old fact — a struck LOCKED still greps as LOCKED.
- **Copy the brief's Out of scope list into "What this plan does NOT cover", verbatim, then add anything sequencing itself defers.** A scope fence is as important as the scope — it's what stops a session from "improving" its way into the work the employee explicitly kept.

## Step 3 — Apply the threshold heuristic, then sequence

**First decide the unit count — and default to one.** A boundary earns its cost only when at least one of these holds: a wiring fence, a second verification shape that muddies the first, or more scope than one session can build *and* verify. None true → **one unit**, and the plan says so in its opening line: *"This tool is one unit."* Do not pad. (The template shows the collapsed one-unit form.)

When boundaries are earned, sequence by these laws, in order:

1. **BUILD-THEN-WIRE.** Every unit that needs no wiring comes before any unit that does. Wired units are **built to the seam** — everything safely constructible, the adapter, the error paths, an honest "Not connected — waiting on \<ticket\>" state — with only live activation waiting on the ticket: each names the ticket plus the real activation work, smoke test, and owner. The plan's front matter states plainly **what's usable without them**. The build owner owns construction; IT/security/access owns only its assigned controls and may be the build owner when named. If a wiring-free version exists, it is a *separate, earlier, live unit*.
2. **Dependency order.** Foundation before the things standing on it: data/state layer before the surfaces that read it, shared merge logic before the documents that use it.
3. **Monitors last among what they watch.** A monitor's silence test needs something real to go silent — the monitor unit comes after the state it watches exists. Its liveness stamp ("last checked 08:00") is in the *same unit* as the monitor, not a follow-up: **the stamp ships in v1 or the monitor doesn't ship.**
4. **Each unit leaves the tool working.** If an ordering forces a broken intermediate state, the boundary is in the wrong place — move it.

Write a short **Sequencing rationale**: why this order, what each unit unblocks, why each is safe to ship alone. Every executing session will rely on it.

## Step 4 — Decompose into units (one shippable increment each)

For each unit, fill the per-unit anatomy from the template:

- **Risk** (very low → HIGH) + a one-line why. HIGH-risk units deserve extra guardrails and a fuller manual matrix.
- **Files** — the exact files created or touched (and tests). In an existing tree, mark line references "verify before editing."
- **Read first** — the brief's Clearance and lifecycle + builder half + Decisions, `build/HARDEN.md`, this plan's front matter, the specific fixtures.
- **Goal** — the problem and the precise outcome, in 2–4 sentences. Invite push-back if the tree disagrees.
- **Scope — exact changes** — concrete. This is the spec.
- **What MUST NOT change** — the guardrails. **Always fold in the brief's must-be-true safety defaults that this unit's surface can violate** (shows its work; says what it processed, mismatch stops loudly; never acts irreversibly by default — drafts, the human presses send; never lets "local" stand in for "private"; no green checkmark over a stub, ever). These aren't polish; they're what makes the tool safe for a non-technical user, and the unit that forgets one ships the exact failure Prentice exists to prevent.
- **How to verify** — the shape(s) this unit's scope falls under, copied from the brief, with fixture paths, digest bindings, and deadline: replay fixtures for deterministic parts (visible to the local build, byte comparison; real/private pairs stay outside source history), the sealed set's *path and count only* for generative parts, replayed state + the silence test for monitor parts.
- **Verification** — exact commands run from `TOOL_REPO`, plus a manual matrix covering regression, new behavior, and refusal cases. A harness using external private input must verify the manifest digest and exercise those same bytes before output. Expired, deleted, or mismatched input means that private-fixture check is not run. Require a version-control-eligible synthetic smoke/regression subset where fidelity permits and label every stronger claim that still requires private evidence.
- **Gate — who clears it** — machine / wiring / human-decision (see `references/execution-guide.md` for the full protocol). Wired units name their ticket and its activation step here.
- **Risk register** — what could break + how to detect/mitigate. `harden`'s findings slot in here.
- **Commit message** — ready to use, in the repo's format, no co-author trailers.
- **When done** — what to record (this feeds `make`'s `build/LEDGER.md`): files, results with grades verbatim, anything adapted, the local commit hash. Then the next unit — a wired unit builds like any other and ends at its seam; only a human-decision block actually waits.

Sizing rule of thumb: if a unit's Scope sprawls past what one focused session can build and verify, split it at a seam where the tool still works. If two tiny units always ship together and share all context, merge them — probably back into one.

## Step 5 — Write the cost line

`sequence` is the first skill that knows the unit count, so the plan carries the pre-build cost line in its front matter:

- **The cap** — copied from the exact revision's build authorization. This is a ceiling the run must respect, **never a forecast**. If the unit count makes the cap look implausible, say so now — before the build — and route it back; discovering it at unit 6 is the expensive version of the same sentence. **A reference class only when real runs exist to quote.** "Similar plans have run $X (n=2)" is honest at n=2 *because it says n=2*. No real runs → no reference class → say nothing rather than inventing one.

Spend (tokens/dollars, inside this cap) and connect (scopes/keys — wiring tickets) are different approvals; the cost line covers spend only.

## Step 6 — Add the closers

- **Combined verification matrix** — the end-to-end checks after all units land (wired ones to their seams): a cross-unit regression pass, the full refusal suite across each still-permitted private input plus the durable synthetic subset, dormant states showing honestly, and — if any part is a monitor — the silence test. Record external fixture digests separately from the source-tree grade.
- **The resume ritual** — how a fresh session picks up at `Un`: read the brief's Clearance and lifecycle + builder half + Decisions, `build/HARDEN.md`, `build/HANDOFF.md` if one exists, this plan's front matter, and `build/LEDGER.md`; confirm both roots, the retention deadline, fixture digests, and the last recorded tool commit; then execute exactly one unit per `references/execution-guide.md`.

## Step 7 — Save and summarize

- Save to `build/PLAN.md` (create `build/` if this is the first artifact in it).
- **Invoked by `snag`: honor the caller's overrides.** Append the units to the *existing* `build/PLAN.md` under the caller's heading (`## Snag pass — <date>`) instead of overwriting — never a new file, never clobbering the build plan. Use the caller's ID prefix (`S1, S2, …`) in unit headings and commit messages. Skip the plan-level front matter (the original plan's still governs) and the status-table sections the caller owns in `build/SNAGS.md`.
- Summarize for the caller (usually `commission`): the unit count — saying "one unit" plainly if it is — the execution order, what's usable without wiring, which units end dormant at a seam and behind which ticket, and the cost line. Flag anything derived-not-declared or unhardened.

## Quality bar (self-check before delivering)

- [ ] Do confirmed accuracy and build authorization bind the same exact revision, authority holder, cap, and named build owner — and did you refuse if not?
- [ ] Are absolute `CASE_WORKSPACE` and `TOOL_REPO` recorded, physically separated safely, and used explicitly by every Git and receipt command?
- [ ] Does the plan carry the brief's exact case-evidence location/access/retention/deletion rule into every unit that touches private evidence?
- [ ] Could a fresh session with **zero memory** of this one execute each unit from the unit text + the named read-first files alone?
- [ ] If the tool is small, is the plan **one unit that says so** — no manufactured phases?
- [ ] Do **no-wiring units come first**, is every wired unit **built to the seam** with its ticket *and activation step* named, and does the plan state **what's usable without wiring**?
- [ ] Does every unit carry its **How-to-verify shape + fixture paths/digests/lifecycle**, verify external bytes inside the exercising harness, include refusal cases, and name the durable synthetic subset plus any private-only claims?
- [ ] Are the **must-be-true safety defaults** distributed into the MUST-NOT-CHANGE lists of the units that could violate them?
- [ ] Are the sealed examples present as **path + count only** — no contents anywhere the build reads?
- [ ] Is the cost line **a cap, not a forecast** — and any reference class quoted at its real n?
- [ ] Are the brief's LOCKED decisions restated, unreversed, and unre-litigated?
- [ ] Does any monitor unit include its **liveness stamp and silence test** in the same unit?
- [ ] Did you read the actual brief, HARDEN.md, and tree (not plan from memory), and are the paths real?

## Stress-test pass (recommended for HIGH-risk plans)

Before delivering a plan with HIGH-risk units, verify the units against reality — recheck lifecycle and digest first, open only still-eligible fixtures, re-check the brief's paths, dry-read each unit as if cold — and fix mismatches, noting corrections in a short **Revisions log** at the top. Any missing, deleted, expired, unauthorized, or mismatched fixture remains unopened and records `NOT RUN — private validation unavailable`. Bake genuine decision points into the unit as explicit options ("Path A: … / Path B: … — flag for the operator") rather than guessing. A plan that already absorbed reality's surprises is far more likely to execute cleanly across sessions.
