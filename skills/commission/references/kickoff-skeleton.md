# Kickoff Skeleton — what commission emits at the start of every run

commission opens each run by emitting this kickoff, filled in for the brief, then **executes it**. The kickoff is the run's frame: it locks the entry contract, the decisions in force, the verification shapes, the wiring map, the spend cap, the autonomy contract, the pipeline order, and the safety-net — so the autonomous run stays inside the brief, inside the budget, and honest.

There is no persona to invent and nothing in here you author. **Every field below is read out of the exact authorized revision of `TOOL_BRIEF.md`** — the kickoff is a pure function of that revision, which is why a fresh session can re-derive it exactly by re-running intake. If a field can't be filled from the brief or established from a file, it is either a wiring ticket or part of the one batched question — filling it with a guess is the failure this skeleton exists to prevent.

Fill the `<placeholders>`, delete the guidance comments, emit it, then run it.

---

````markdown
# Commission kickoff — <tool name, from the brief's title>

**The brief:** `<path>/TOOL_BRIEF.md` — **Accuracy: Confirmed accurate <date, exact revision, by whom>** · **Build authorization: Authorized for build <date, same revision, by whom, named build owner>**.
<!-- ENTRY CONTRACT: if accuracy is unconfirmed, build authorization is absent or bound
     to another revision, or authority/cap/build owner is missing, you do not emit this
     kickoff. Selected for evaluation alone is insufficient. Refuse and name the exact gap. -->
**The tool, in their words:** <one sentence from "What you're getting">
**For:** <the employee, by name/role> · **Build owner:** <named person/team> · **IT/security/access owner:** <named person/team, or "none required", per the brief>
**Case workspace (`CASE_WORKSPACE`):** <absolute path containing TOOL_BRIEF.md and build/>
**Tool repository (`TOOL_REPO`):** <absolute Git root; normally CASE_WORKSPACE/tool, never a parent containing CASE_WORKSPACE>
**Evidence lifecycle:** location <brief value> · access <who> · retain until <deadline> · delete <method + owner>

## Decisions in force (carried verbatim — never reopened)
<!-- Every LOCKED bullet from the brief's Decisions block, as written. Anything under
     ### Reversed stays reversed. A build that wants to deviate from one of these routes
     a conversation back to the employee; it never overrides. -->
- LOCKED — <…>
- LOCKED — <…>

## Verification shapes (from "How to verify:" — the build may not infer these)
<!-- Per part: generative → sealed set at <path>, count, never shown to the build;
     deterministic → replay fixtures at <path>, byte comparison;
     monitor → replayed state + the silence test + the v1 liveness stamp.
     Older brief with no How-to-verify field: record the unambiguous reading the builder's
     half supports, or put it in the batched question. Flag any FOSSIL artifacts —
     verification material for scope the brief itself cut — as not-live. -->
- <part> → <shape> → <fixture path + digest + deadline / sealed path + count, and who may see it>

## Wiring map (build-then-wire)
<!-- Every open ask from the brief, four fields each. Withdrawn asks stay withdrawn.
     The union of "what works today without it" is the NO-WIRING SCOPE — that is v1. -->
- **Ask:** <what's needed> · <who can approve> · <roughly how long> · <what works today without it>
- **No-wiring scope (v1):** <the version that ships with zero tickets cleared>

## Bounds
- **Spend cap:** <the brief's Cost line — build cap, run cost>. The run stays inside it; about to exceed → stop and say so.
- **Connect:** never this run's to grant. Scopes, keys, systems move only through a ticket.
- **Authorized revision:** <exact revision>. A material harden change creates a new revision and reopens accuracy confirmation, evaluation selection, and build authorization before sequence.
- **Fence:** <Out of scope, verbatim>. The build never grows past it.

## Run contract (autonomy)
- Answer every question **from the brief**; establish from files what a file can establish. The employee already answered everything only they could answer — do not ask again.
- What the brief can't answer: a **wiring ticket** (access/approval/credential) or the **one batched question** — asked now, at intake, or not at all. Batched question this run: <the question(s), or "none — the gates were fired at diagnose">.
- **Never fake a gate.** A gate needing a human is emitted in the four-field shape — never auto-passed, never a stub behind a checkmark.
- **Never rely on ambient cwd.** Address private evidence from `CASE_WORKSPACE`; run Git as `git -C "$TOOL_REPO" …` and receipt commands from `TOOL_REPO`. The case workspace is never inside the tool repo. Private evidence expires under the lifecycle above.
- **Narrate each phase:** name the skill running and the file it produced.
- **Fit, not size:** heuristics scale the process, never the tool. Phases skipped this run: <e.g. "harden — one-prompt tool (sequence collapses to its degenerate one-unit plan; make requires the plan file)" | "none">.

## Pipeline (in order; each writes a file the next phase reads)
1. **harden** → `build/HARDEN.md` + `build/fixtures/` — attack the design, never the worth; fold revisions into the brief under the retraction discipline.
2. **sequence** → `build/PLAN.md` — self-contained units, each naming its shape; no-wiring units first; one unit is a legitimate plan.
3. **make** → source in `TOOL_REPO` + `build/LEDGER.md` — build and drive each unit until it works, verified in its shape, refusal suite included; unsafe-to-record checks remain explicitly UNRECEIPTED.
4. **snag** → `build/SNAGS.md` — audit → triage → fix, verified local commits. <"runs" | "skipped below threshold — will be named in the handback">
5. **handback** → `build/FIRE_IT_UP.md`, written LAST: for <employee> in plain English · for the build/technical owner, review and stand-up · for IT/security/access, only its assigned tickets + the parked ledger.

## Honest handback (produce at the end)
- Claim exactly what the ledger's source-tree receipts and separately captured external-fixture digests support, **in those words** — never "done/verified/working" beyond them, no green checkmark over a stub.
- Surface every parked unit with what would unpark it — never silently dropped.
- Restate the evidence deletion deadline, method, owner, and the durable synthetic/approved derivative coverage that remains afterward.
- The firewall line: confirmed accuracy, evaluation selection, and build authorization are not validation. **Only real use validates fit** — and that can't be run from here.

## Context safety-net
Files are the memory — the brief and everything in `build/` — never chat. If context runs low, emit a **sequence Mode C handoff** to resume in a fresh chat with no amnesia.
````

---

## Notes on filling it

- **The state-and-revision check is the whole gate.** Do not soften it. Confirmed accuracy or selected evaluation without a matching build authorization remains non-buildable. Never write authorization yourself, and never launder in-brief enthusiasm into authority.
- **Decisions are carried verbatim, not summarized.** A paraphrased lock is how a lock quietly loosens. Copy the bullets.
- **The batched question is one message, once.** If you're drafting a second question mid-run, you're interrogating the employee — stop; it's a ticket, a narrowed scope, or it waits for the handback.
- **The wiring map is the run's spine.** "What works today without it" is not a consolation note — it's the day-one live scope, and build-then-wire orders the whole plan around it. Authorized wired paths still build safely to the seam; tickets-only is an honest stop only where information or authority prevents safe construction, not evidence of a working tool.
- **The kickoff is emitted, then executed.** Don't keep it in your head; write it out so the user sees the frame — and so a fresh session, re-running intake on the same brief, lands on the same frame.
