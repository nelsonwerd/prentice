# Execution Guide — running one unit from build/PLAN.md

Use this when executing a unit — normally `make` under `commission`, sometimes a fresh session resuming a run after context death ("run U2", "resume the plan"). The discipline here is what makes plans safe: do exactly one unit, verify it in its named shape, and stop at a clean boundary.

## The loop

### 1. Read first, then acknowledge
- Read the brief's Clearance and lifecycle + builder half + Decisions block, `build/HARDEN.md`, `build/HANDOFF.md` if one exists, the plan's front matter, and this unit. If resuming: `build/LEDGER.md`, for what already landed.
- Resolve the plan's two absolute roots before any command: `CASE_WORKSPACE` contains the brief and `build/`; `TOOL_REPO` is the Git root for source. The case workspace must not be inside the tool repository. Never rely on ambient cwd: private paths are explicit from `CASE_WORKSPACE`; every source, Git, and receipt command targets `TOOL_REPO`.
- Treat those names as plan fields, never inherited environment. At the start of each copyable command block, the finished plan must bind unexported local shell variables from the actual shell-quoted absolute paths: `CASE_WORKSPACE=<actual>` and `TOOL_REPO=<actual>`. Every later `$CASE_WORKSPACE` or `$TOOL_REPO` in that block depends on those explicit assignments. An unfilled placeholder or a variable used before binding is a stop, not a command to try.
- In **2–3 sentences**, state what you understand: the goal of this unit, the files in play, and the one regression you're most worried about. Record it (it opens this unit's ledger entry). This catches a wrong-unit or stale-context situation before any edit.

### 2. Verify references against the current tree
- Open every file the unit names and **check its references against the current tree before editing** — the tree moves between authoring and execution. Greenfield first unit initializes Git at `TOOL_REPO`, normally `CASE_WORKSPACE/tool`; never initialize around private evidence. An existing target repository must be physically separate from `CASE_WORKSPACE`, not a parent containing it, and its explicit commit allowlist must already exist.
- Run `git -C "$TOOL_REPO" status --short`. If a file you're about to edit already has **unrelated** uncommitted changes, stop and report — don't layer your change on top of in-progress work.
- Confirm the private/version-control split and lifecycle before editing: `TOOL_BRIEF.md`, `private/`, `artifacts/`, `sealed/`, raw or real fixtures, logs, and receipt state are private evidence and expire under the brief's recorded rule. Synthetic fixtures may be allowlisted. A deidentified derivative requires a named authorized owner and date, exact artifact digest, exact repository/history destination, scanner and version/ruleset, covered data types, and an explicit passing result. Missing, unsuitable, incomplete, or non-passing evidence means never commit. Never write a credential or secret value into any artifact or test output.
- If reality disagrees with the unit (a function moved, an assumption is false, the change already landed), **push back and record it** rather than forcing the edit. The unit's assumptions are hypotheses; the tree is truth.
- **Escalate to re-plan when the drift is structural, not local.** If the tree has moved far enough that not just this unit but the plan's *later* units are now wrong (the architecture changed, a unit already happened, an assumption the whole sequence rests on is false), **stop and flag the plan for re-planning** — name what changed and which downstream units are affected — instead of forcing the current unit through. Under `commission` that means re-invoking `sequence`; a plan is only safe while its sequencing assumptions still hold, and one unit succeeding into a stale plan still ships a broken whole.

### 3. Do only the scoped change
- Implement exactly what "Scope — exact changes" specifies.
- Honor **"What MUST NOT change"** strictly — including the must-be-true safety defaults folded into it. Do not refactor adjacent code, rename things, or "improve" beyond the unit.
- If you discover necessary work outside the scope, **record it as a follow-up and stop at the original scope** — don't expand the unit mid-flight. (It becomes a later unit, or a snag for `snag`.)
- **Build only the gated scope — never more to look "complete."** Over-delivering breadth past what the unit gated is scope creep even when it's impressive. If completion hinges on a gate you can't clear, see *When a gate needs something you don't have* below.
- Match existing style; no premature abstractions; minimal comments; no emojis in files.

### 4. Verify — in the unit's named shape, receipt-wrapped only when safe
- Run the unit's **exact verification commands from `TOOL_REPO`**. A recorder-safe source or synthetic check may use `(cd "$TOOL_REPO" && didrun run -- <command>)`. Never place a private path, value, case name, or digest in recorded arguments, environment, labels, stdout, or stderr. If the check cannot cross that boundary safely, run it directly from `TOOL_REPO`, label it UNRECEIPTED, and retain its result only in the private case ledger.
- A private external fixture is not bound by the tool repository's tree digest. Its exercising harness must first match the manifest's content/directory digest and then exercise those same bytes before any tool output; prefer one read, otherwise check immediately before and after. A separate earlier hash print is insufficient. Missing, expired, deleted, or mismatched input means the private-fixture check is **not run**, never inherited from an earlier pass or silently replaced by a derivative.
- Verify in the shape the unit names — the build cannot substitute one shape for another:
  - **Deterministic** → replay fixtures, byte comparison. Reproducing the real output they actually sent exactly is correct behavior, not overfitting.
  - **Generative** → the sealed set, in an **isolated run whose input is the tool + the sealed set** — not this plan, not the brief, not this session's context. **Never open the sealed examples here.** If isolation genuinely isn't possible, say so and record the check as unisolated — never claim a guarantee you don't have.
  - **Monitor** → replayed state (reconstruct the day it went wrong, run the job, check it shouts) **plus the silence test**: kill it and confirm the silence is visible to the employee — and the v1 liveness stamp; a monitor that ships without it doesn't ship. A monitor without a passing silence test is unverified by definition.
- Walk the **manual matrix**: the regression case first (earlier units intact), the new-behavior cases, then the **refusal cases** — the unit's slice of garbage / empty / wrong-format / truncated / subtly-wrong input. The only correct behavior is a loud stop; **any output at all on broken input is a defect**, even output that looks fine.
- Then the gate loop for the recorder-safe set, with every receipt command run from `TOOL_REPO`: run → claim → use `git -C "$TOOL_REPO"` to stage named allowlisted paths — never `git add -A` — and inspect cached names/scans/status → provisional commit → seal → strict-verify. Use the complete commands in `../../snag/references/receipt-discipline.md`. **This is a loop, not a checkpoint.** Nonzero → fix, rerun direct and wrapped checks, re-claim the safe result, restage/reinspect. If source changed, commit the fix; if source did not change and the intended unit commit is already HEAD, never create an empty commit—re-seal that commit after rerun/re-claim. Then re-verify. Only PASS plus green strict verification becomes LANDED; terminal non-PASS follows the scoped local-revert policy in that canonical reference. Never weaken a check or upgrade an UNRECEIPTED result. If the recorder boundary is unsafe or broken, keep the affected check UNRECEIPTED.

### 5. Record and stop at the boundary
Record for `build/LEDGER.md`:
- **Files changed** with key line numbers, and the **local commit hash**.
- **Verification results** — command outcomes quoted, receipt **grades verbatim** (`tree-exact` means recorded against the sealed tool-source tree, never proven correct), plus each external fixture's captured digest and deadline as separate evidence.
- **Refusal cases exercised** and what each did.
- **Anything you adapted** from the unit (with the one-line reason), and any follow-up recorded as out-of-scope.

The commit is local, made at the verified boundary above. **Never push, tag, publish, insert a live credential, connect, or activate** — the named owners perform those separately authorized acts. Local source-history eligibility does not mean publishable. If sensitive material entered a commit, stop and report the path without repeating the value; later ignore/deletion does not erase history. Private fixtures and every recorder ledger/ref/object/export/report remain subject to their deletion deadline. Then the next unit.

## If the unit is under-specified

A good unit is self-contained. If one isn't — missing files, vague scope, no verification shape — don't guess:
- Reconstruct what you can from the brief's builder half, `build/HARDEN.md`, and the tree.
- **A missing How-to-verify shape is never inferred silently** — the brief names it or a human confirms it. State the gap and your proposed reading; under `commission`, flag it for the operator with one sharp question.
- Then proceed once unblocked, and record the gap so the plan can be tightened.

## When a gate needs something you don't have

Every unit ends on a **gate** — a checkpoint that decides whether this unit (or the next) may proceed. Sort it before you build:

- **Machine-cleared** — the check is something you can actually run here (replay green, refusal suite refusing, silence test visible, `didrun verify --strict` at 0). Run it; report the result.
- **Wiring-cleared** — passing needs a connection a human must approve: an API key, a scope, an app approval, a tenant setting. This belongs to the named IT/security/access owner or other recorded authority.
- **Human-decision-cleared** — passing needs an answer only a named domain expert, sponsor, accepting user, or other decision holder owns.

If the gate is **wiring-cleared**:
- **Build the unit safely to the seam anyway.** The adapter, the request construction, the error paths, the retries — everything safely constructible, committed and verified as far as verifiable without the credential. The tool shows an honest dormant state — **"Not connected — waiting on \<ticket\>"** — never a green check; the light flips only when a real call succeeds. The named build owner owns construction. IT/security/access owns its actual controls and may also be the build owner when the brief names it; activation may require more than a paste, so state the real work.
- **Emit the ticket.** Record it in `build/LEDGER.md`, flagged for `FIRE_IT_UP.md` (`commission` writes that file last, after `snag`), in the four-field shape — **what** is needed · **who** can approve it · **roughly how long** · **what works today without it** — **plus the activation step**: exactly where the credential goes, the one command or click that tests it live, and what "working" looks like. Attach whatever evidence the run already has. The brief's Open asks usually pre-name the ticket — reuse its text; if the build *discovered* a gate diagnose missed, emit it in the same shape anyway.
- **Ship the no-wiring version as the day-one scope** — the brief's "what works today without it" field names it — real and working, not a consolation.
- **The run continues.** A wiring gate stops a unit's *live activation*, never its build and never the run. The ledger entry says honestly: *verified to the seam; the live call is the ticket's smoke test.*

If the gate is **human-decision-cleared**:
- **STOP and emit the question.** State what's built, what the gate requires, that it is *not yet cleared*, and who must clear it — routed back through `commission` to the brief's owner. That's a complete, honest unit — not a failure.

In every case:
- **Never fake it** — don't render a "passed"/inert gate the code never enforces, hardcode a check to a constant, or narrate gate language over scope that skipped the check. A "Configured ✓" that means "an env var exists" is the exact inversion this pipeline exists to prevent — a gate dressed as passed is worse than none, because it *looks* validated while having skipped the very thing it protected.
- **Never activate or connect past it to look complete.** Build only to the safe seam; leave the live remainder genuinely gated, and say so.

Discipline on *what* to build is free even when the gate isn't runnable — the failure mode to avoid is over-delivering the scope your own gate forbade, then dressing it in gate microcopy.

## Reminders

- One unit, one shippable increment. Don't pull in the next unit "while you're here."
- The plan is the source of truth. Unsure how this unit fits the whole? Read the front matter (How to use, Sequencing rationale, Carried from the brief, Architecture map).
- The brief's decisions are the employee's. If this unit seems to require breaking one, that's a route-back, not an override.
- Leave the tool in a working state. If you can't, stop and record honestly rather than committing a half-change.
