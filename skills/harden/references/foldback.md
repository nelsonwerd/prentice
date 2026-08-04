# Fold-back: HARDEN.md, brief revisions, and the route-back

Phase 5 and Phase 6 live here. Findings become durable in exactly three places — `build/fixtures/` (see `fixtures.md`), the revised `TOOL_BRIEF.md`, and `build/HARDEN.md` — and the rules differ sharply between the last two, because one is the employee's document and one is yours.

## Revising TOOL_BRIEF.md

The brief is a living, revision-bound document the employee owns. You are a contributor with a narrow mandate: make the design harder to build wrong, without silently redefining the work or inheriting authorization across a material change.

**What harden may add or sharpen:**
- **Must-be-true lines** (builder's half) — each demonstrated break becomes a constraint the build must satisfy, with a pointer to its fixture. This is the main channel.
- **How to verify:** — sharpen the declared shapes with the obligations audited in Lane 6: the liveness stamp, the variant coverage number, the isolation caveat stated honestly.
- **Inputs / Outputs precision** — where Lane 3 found an ambiguity the build would guess at, resolve it in place (when the resolution is design-neutral) or route it back (when it isn't).
- **Honest edges** (plain-English half) — a finding that changes what the employee was promised goes **above the divider, in their words**: a new "what it won't do" line, a sharpened "if it breaks" description. No jargon, no grades, no fixture paths. If the builder's half hardened and their half still overpromises, the fold-back isn't done.
- **Open asks** — a newly discovered gate (something diagnose missed that needs approval, access, or a decision only the employee can make) goes in the brief's Open asks in the four-field shape: **what's needed · who can approve it · roughly how long · what works today without it.** Attach the evidence — the finding that surfaced it.

Before folding any item, classify it. A **non-material clarification** preserves the employee-visible workflow, intervention, data path, risk, output, cost, and acceptance method; fold it and log that classification. A change to any of those is **material**: write the proposed delta, create a new revision, set `Accuracy: Draft — needs reconfirmation for <new revision>`, `Evaluation: Not selected for <new revision>`, and `Build authorization: Not authorized` for that new revision, then route it back. Old confirmation, selection, and authorization remain evidence about the old revision only.

**What harden may never do:**
- **Override a LOCKED decision.** Every bullet under Decisions is in force. If a finding contradicts one, that's a route-back (below), not an edit — the employee owns the decisions, and IT (or this pipeline) doesn't get to redefine the work.
- **Add decisions.** Hardening constraints are must-be-trues, not Decisions-block entries. The Decisions block records what the *employee* chose.
- **Shrink the scope.** Cutting a feature is redefining the work. Constraining how it must behave is hardening.
- **Delete anything.** Retraction, never deletion (next section).

### The retraction discipline (applies to every brief edit)

When a finding falsifies something the brief asserts — a fossil sealed set, a `Needs:` line the resolved design contradicts, a claim a lane demonstrated wrong:

1. **Overturned decisions move to `### Reversed`**, restated in past tense with what overturned them. Never strikethrough — a struck LOCKED still greps as LOCKED. (You'll rarely touch decisions at all; when a *factual* lock is overturned by demonstration — not by preference — quote the demonstration as the overturning evidence and consider whether it's really a route-back instead.)
2. **A reversal is not done when the new fact is written. It's done when every sentence asserting the old one is retracted.** Grep the brief for the thing you stopped believing — the vendor name, the count, the shape that changed — and fix every hit in the same edit. A gate row filled three sections ago, a cost line, an ask that echoes the dead claim: all of them.
3. **Neighbours become unverified.** Any claim whose truth *depended* on the fact that changed is now unverified, not merely stale — mark it so.

Log every edit — additions, sharpenings, retractions — in HARDEN.md's "What changed in the brief" section, so `sequence` and the employee can see the delta without diffing.

## The route-back

A route-back fires when hardening cannot proceed honestly within the brief as decided — a demonstrated Blocker contradicts a LOCKED decision, an ambiguity is genuinely the employee's call, or a proposed change is material rather than a design-neutral clarification.

Emit it in the same four-field shape as everything else in this pipeline, so it can be forwarded cold:

```markdown
### Route-back — <one line: the decision this touches>
> **What's needed:** <the question, concretely, with the demonstration attached —
>   "the brief locks X, but fixture <name> shows X produces silent-wrong output when Y">
> **Who can approve it:** <the named decision-holder for this exact decision —
>   the employee only when they actually own it; never infer authority from title>
> **Roughly how long:** <usually one conversation>
> **What works today without it:** <the version harden can finish now — hardened
>   around the contested decision, with the contested part's findings held, not folded>
```

It lands in two places: the brief's Open asks, and HARDEN.md's verdict. Then **keep going where you honestly can** — a route-back on one decision does not stall the hardening of everything else, and the hand-back tells `commission` exactly which parts are cleared. Never fake a fold, never quietly build around the recorded decision-holder's decision, never stall the whole run when a degraded-but-real hardening exists.

## build/HARDEN.md — the schema

IT- and build-facing. Lead with the verdict; keep it navigable months later.

```markdown
# HARDEN — <tool name, from the brief>

**Brief:** <path> · **State at intake:** <Accuracy + Evaluation + Build authorization, with exact revision>
**Mode:** <Quick / Standard / Exhaustive> — <N> lanes · **Date:** <date>

## Verdict

**<Evaluation-ready / Authorized and ready to sequence / Ready with asks / Reconfirmation needed / Route-back needed>** — <one paragraph, plain>

**Confidence the design survives contact: N/10.** <reasoning, and the required
ground-truth tally: "K of M load-bearing findings demonstrated (fixture / diff /
command run); the rest rest on model judgment." The headline number is capped by
that ratio.>

## What the design already gets right
<genuine, specific — the cross-check that exists, the shape that bounds the blast
radius. Hardening includes knowing where it's already hard.>

## Findings
<ranked, Blocker first. Each:>
### <id>. [<Severity>] <one-line break>
- **The break:** <what goes wrong, on what input, and what the user would see —
  or fail to see>
- **Demonstrated:** <yes — fixture `build/fixtures/<name>` / no — plausible-
  undemonstrated, what would demonstrate it / falsified in follow-up>
- **Folded:** <the brief edit that absorbs it / route-back / held — why>

## Verification plan, shape by shape
| Part | Declared shape | Obligation | Verdict |
|---|---|---|---|
| <part> | deterministic | replay fixtures cover N of M variants | <met / gap: …> |
| <part> | monitor | replayed state + silence test + liveness stamp in v1 | <met / Blocker: …> |
| <part> | generative | sealed set real, sealed, isolated run named | <met / limit stated: …> |

## Fixtures
<count, one line each — full detail lives in build/fixtures/MANIFEST.md>

## What changed in the brief
<every edit: additions, sharpenings, retractions (with what was grepped),
anything moved to Reversed, and material/non-material classification. For a material
change: new revision plus accuracy/build-authorization reset.>

## Open asks and route-backs
<each in the four-field shape, evidence attached>

## What this pass cannot establish
<the standing bounds, stated for THIS run: same-model blind spots; security
self-pass limits where the surface warrants an external review; anything labeled
unverified — no web access; the sealed set's isolation honesty. Plain sentences,
no hedging boilerplate — name the specific things.>

## Hand-back (for commission)
- **Verdict:** evaluation-ready | authorized-ready-to-sequence | ready-with-asks | reconfirmation-needed | route-back-needed
- **Confidence design survives contact:** N/10 (ground-truth tally: K/M demonstrated)
- **Blockers folded:** <count> · **Blockers held on route-back:** <count + ids>
- **Fixtures shipped:** <count> at build/fixtures/ (MANIFEST.md)
- **Brief revised:** <yes — see "What changed" / no>
- **New asks:** <count, one line each>
```

The hand-back block is the machine-readable-ish seam: `commission` carries the verdict forward without re-reading the file, and `sequence` starts from the revised brief + the findings, knowing exactly what state everything is in.

## The seam contract (what downstream reads)

- **`sequence`** reads the revised `TOOL_BRIEF.md` and `build/HARDEN.md`. Everything it needs to plan units — the constraints, the fixtures' existence, the held route-backs — must be in those two files. The lane files under `build/harden/` are evidence, not required reading.
- **`make`** runs `build/fixtures/` against the built tool, driven by `MANIFEST.md` alone. Surviving-behavior lines must be executable-in-principle by an agent that read nothing else.
- **`commission`** reads the hand-back block. It proceeds only when confirmed accuracy and build authorization still bind the hardened revision. `ready-with-asks` means authorized construction proceeds safely to each seam. `reconfirmation-needed` or `route-back-needed` stops affected construction until the named owner acts.
- **The employee** reads only the brief's top half. Nothing harden produces is ever shown to them as assurance — no grades, no confidence numbers. What they get is honest edges, in words.
