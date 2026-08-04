# Handoff Guide — relaying a dying run to a fresh session

Use this when a run is filling up mid-unit, when `commission` needs to park a build and resume later, or when work is relaying to another agent/tool. A handoff is a **degenerate one-unit plan**: the same self-contained, read-first discipline, sized to resume a single thread of work.

Output: a self-contained briefing saved to `build/HANDOFF.md` (overwritten per relay — it describes *now*, and stale handoffs are landmines). The reader is the next session and named build/technical owner — with control-specific portions available to the assigned IT/security/access owner — never the employee; it can be properly technical.

## What a good handoff contains

Write it as a message addressed to the next session. Include, in roughly this order:

1. **Run one-liner and roots.** What tool this is, for whom, and the absolute `CASE_WORKSPACE` and `TOOL_REPO`. The case workspace is never inside the tool repo. Point at `TOOL_BRIEF.md` with all three states and exact authorized revision.
2. **Read these first.** The brief's Clearance and lifecycle + builder half + Decisions, `build/HARDEN.md`, `build/PLAN.md` front matter, `build/LEDGER.md`. Restate the evidence deadline. Tell it to verify file references and fixture digests before trusting them, and name the sealed examples as do-not-open (path + count only).
3. **What's already landed / decided.** Which units are done, with their local commit hashes and didrun verdicts — **grades verbatim** — plus any plan decisions made mid-run and any wiring tickets already recorded in `build/LEDGER.md`, flagged for `FIRE_IT_UP.md` (`commission` writes that file last). This is what stops the new session from redoing or relitigating settled work.
4. **Current state of the tool tree and external evidence.** Use explicit `git -C "$TOOL_REPO"` facts; state what is uncommitted, the last receipt grade, each still-live private fixture digest, and which claims require it. A source-tree grade does not bind external bytes.
5. **The landmines / gotchas.** The non-obvious things that will bite a fresh session — fragile areas, must-be-trues most at risk, "looks wrong but is intentional" facts, known false leads, `harden` findings still unaddressed.
6. **The exact next step.** Usually: "execute U<n> from `build/PLAN.md` per the execution guide." Concrete and bounded — one unit. If the remaining work no longer matches the plan, say so: the next step is re-planning, not forcing units onto a drifted tree.
7. **Build/verify commands.** Exact commands run from `TOOL_REPO`; recorder-safe commands contain no private metadata. Direct private-fixture commands use the exact case path, verify the digest inside the exercising harness, and are labeled UNRECEIPTED unless preflight proved a safe recorder boundary.
8. **Working rules.** Inherit the plan's RULES block and restate: exact revision/build owner; evidence lifecycle; two explicit roots; receipt order run → claim → allowlist stage/inspect → commit → seal → strict verify; never push; never fake a gate; source-tree and external-digest evidence reported separately.

## End with an orientation handshake

Close the handoff with an instruction for the new session to **prove it's oriented before acting**:

> First, read the files above. In 3–4 sentences, record: (1) your understanding of the current state, (2) the unit you'd execute first and why, (3) one assumption you want confirmed. Under `commission`, record this in the ledger and proceed; standalone, wait for the operator's green light.

This catches misunderstandings before any code is touched.

## Cross-tool relay

When the handoff is going to a different agent or tool that won't auto-load this plugin's context:
- Make the briefing fully self-contained — restate the RULES block inline rather than by reference, with the never-fake-a-gate and sealed-set rules spelled out, and the gate protocol restated inline (machine: run the check · wiring: build the unit to the seam with an honest not-connected state, record the four-field ticket + activation step in `build/LEDGER.md` flagged for `FIRE_IT_UP.md`, continue · human-decision: stop that scope and route back) — a plan consumed outside this plugin cannot resolve `references/` paths.
- Prefer concrete file paths + "verify before editing" over any assumed shared context.
- If the remaining work is many units, don't relay unit-by-unit prose — point at `build/PLAN.md` itself: it's already written to be executed by a session with zero memory.

## Quality bar

- [ ] Could a cold session with **zero memory** of this run resume from the briefing + the named files alone?
- [ ] Does it say what's **done/decided** (commits, verdicts verbatim, tickets emitted) — not just what's left?
- [ ] Are the **landmines** and the at-risk **must-be-trues** spelled out?
- [ ] Is anything **half-done** declared honestly?
- [ ] Is the **next step** exactly one unit (or an explicit re-plan)?
- [ ] Does it name the sealed set as **do-not-open**?
- [ ] Does it name both roots, the evidence deadline, fixture digests, and private-only claims?
- [ ] Does it end with the **orientation handshake**?

## When a handoff should become a re-plan

If the remaining work no longer matches `build/PLAN.md` — the tree drifted structurally, a discovered gate reshaped the scope, units collapsed or split in practice — don't write a handoff that papers over it. Flag for re-planning (under `commission`, re-invoke `sequence`) and let the handoff just say: "the plan is stale as of U<n>; re-sequence before executing further."
