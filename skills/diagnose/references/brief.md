# Saying what should change, and writing it down

## Fit, not size

Match the intervention to the job. **Any size, any shape — including no tool.**

If one prompt, a handoff change, training, policy clarification, an existing configuration, or no action is right, say so — that is a complete session, not a letdown. If the job genuinely needs a real program with a scheduler, a database, and a pile of edge cases, **say that** — the optional build skills can take an authorized brief. Rounding down to look modest is the same failure as rounding up to look impressive. Neither is honest and both cost them the right intervention.

There is no quota. The answer is whatever the job is.

## Shapes it can take

Not a menu to pick from — just the space, so you know what's possible. The evidence decides.

No new intervention. A clearer handoff. Training. A policy decision. An existing setting changed. Something they paste and keep. A saved setup that already knows their format. **A page they open, drag a file onto, and get their thing back.** Something living in the spreadsheet where the data already is, running Monday at 8 whether their laptop's open or not. A script. A thing in the menu bar. Something that watches a folder. A real program with a real interface. Something bigger than any of that.

Four facts worth knowing, because they make delivery much cheaper than it looks:

- **A web page can reduce installation friction**, but browser-to-model calls, client-side credentials, hosting, and data movement still need the real approved path. Never turn a convenient personal-prototype pattern into a workplace-policy claim.
- **Something bound to their spreadsheet or mail may operate under their permissions**, but that does not make the connection, account, scopes, retention, or automation review-free. Establish the actual owner and policy.
- **A credential is a dependency, not a diagnosis task.** Never request or paste it here. Record expected cost, storage/rotation needs, and the named technical/security decision-holder.
- **Plenty of tools need no model at all.** If the job is arithmetic, reformatting, renaming, or moving things around, that's simpler *and* free *and* it never sends their data anywhere. Don't reach for the model reflexively. **And when the answer is no model, say so in gate 1 — it often dissolves the gate.** If the rule is about client data reaching an AI and no AI is involved, the conversation may be over before it starts. Be exact about the boundary: no model *in the tool* is not no model *in their work*.

What a shape has to survive: can they actually get it? can they run it without help? does it live where the work already is? and when it breaks — because it will — what do they see?

## Don't argue about whether it'd work. Probe the load-bearing assumption.

A probe inside `diagnose` is small, reversible discovery evidence — not the start of construction. Use only cleared material, no live-system write, no new credential, and no new external service. A disposable prompt or an existing configuration may qualify. If answering the question requires code, an integration, deployment, or consequential data, write the requirement in the brief and stop for evaluation and authorization.

**Run a permitted probe somewhere that hasn't read this conversation.** You've absorbed the whole interview; the eventual intervention has none of that. Run it yourself in the same context and you'll produce the right answer out of knowledge it doesn't carry. When isolation is available and authorized, dispatch only the probe plus the cleared test input — no transcript, sealed material, unrelated folder, or broader access. What comes back is evidence about that probe and nothing more.

**Check it against something they already got right.** You have the thing they made and the thing they started from — an input paired with a known-correct output, an answer key they handed you without realizing. Run the tool on last week's input and put its output **beside what they actually sent**:

> *"Before I build anything — let me just try it. [runs it clean on last week's input] That's what it produced. Here's what you actually sent that week. Where do these differ?"*

*"Did that do it?"* is a yes/no question asked of the person who says yes to everything — and a glance at an unfamiliar output isn't a check, especially from someone who's impressed and grateful. **"Where do these differ?" can't be answered deferentially.** It names a comparison they're the world expert on, and every difference they find is either a bug or a requirement they'd never have thought to state.

What comes back:

- **"They're the same."** → The probe passed on this case. Record the evidence. If the prompt or existing setup already solves the job, show them where it lives and stop; otherwise do not promote it to a build.
- **"Close, but it missed X."** → That's the real requirement, from their mouth, about an output they're looking at. Fix, re-run.
- **It worked when you ran it, not when the subagent did.** → The tool is missing something you knew and it didn't. The gap names it exactly. Put it in, re-run isolated.
- **"No — it can't see the other twelve files."** → Now you know what the job actually needs. That's not a failure, that's the spec arriving.

**Be precise about what a pass settles.** It proves the thing works **on what it ran on**. It proves nothing about the other parts of their week, nothing about the fifty files they didn't send, and nothing about a failure that's silent by nature — something that sums a column right on one file will pass every demo you can afford and still be wrong on Thursday. So: where their work has two halves, try both. Where gate 2 said nobody but a downstream human ever caught the error, a passing demo doesn't settle it. And *"I have fifty of these"* is a real finding — they demonstrated it with the number, and you don't make them sit through fifty runs to prove it.

*"Did that do it?"* is trustworthy about **shape** — did it see all twelve files, are the sections right, is this the thing they meant. They can answer that by looking. It is **not** trustworthy about **correctness** — a wrong total looks exactly like a right one, and *"the numbers look right"* from someone who checked none of them is the deferential yes wearing a demo as a costume. Shape is the glance's question. Correctness is gate 2's.

**Where you can't isolate it** (a chat app, no subagents), you don't have evidence — so don't bank it. Run it anyway, then say the true thing:

> *"That worked — but I've had your file in front of me for ten minutes and the tool hasn't. Try it once in a fresh window before you trust it. If it comes out worse there, tell me what's missing."*

## The examples that prove it works

**First: which kind of tool is this?** The answer changes the whole check, and the build can't infer it — so name it in the brief as **How to verify:**.

**Generative — there's a model in it.** Sealing applies. A model is stochastic and plausible: it produces output that *looks* right, so without a hidden answer key the build tunes to the examples and the test proves nothing. Expose about half, seal the rest, verify in a run that never sees the sealed set. This is the case the rest of this section is about.

**Deterministic — no model.** Sealing is the **wrong control**, and mandating it produces a fossil. A merge tool has no exam to cheat on: if the template is supposed to reproduce the message they actually sent, then reproducing it exactly is *correct behavior*, not overfitting. There's no generalization claim to protect. What this needs is a **replay fixture**: their real inputs → the real output they actually sent → byte comparison. The real pair is private workspace evidence, outside source history and subject to the brief's retention/deletion rule. Its manifest records a SHA-256 of each file, or a canonical directory digest for a multi-file fixture; before every run, recompute it and capture expected digest, observed digest, and match in the verification evidence. A source-tree receipt binds the source tree; this separate digest evidence binds the external fixture input. The isolation that matters isn't "hasn't read the conversation," it's "didn't read the expected output while writing the merge."

When durable source-history regression is useful, prefer a separately constructed **synthetic** fixture and allowlist it. A deidentified derivative is ineligible without a named authorized data/security owner and date, exact artifact digest, exact repository/history destination, scanner and version/ruleset, covered data types, and explicit passing result; approval of one artifact or destination never generalizes to another. Missing, unsuitable, incomplete, or non-passing evidence keeps it private. Where fidelity permits, the eventual tool should carry a committed synthetic smoke/regression subset; name the cases that still require private validation rather than making a clean checkout look self-verifying.

**A monitor — it watches for something.** The hardest, because **a monitor's answer key is an event that didn't happen.** You can't verify "it would have caught the one that slipped" from a document. Replay the state: reconstruct the row as it stood the day the thing went wrong, run the job, check it says the right thing. Then the test that matters most — **kill it and confirm the silence is visible.** A monitor that fails quietly passes every other test you can write.

Most real tools are more than one of these. Say which parts are which.

---

For the generative case: collect more real examples than you show the build. Expose about half; **seal the rest.**

**The sealed ones do not go in the brief.** The brief is the file the builder reads — put the answers in it and there's no test, just an open-book exam. Sealed examples live in a sibling folder the build is never handed; the brief carries a pointer and a count and nothing else. Verification is a separate run whose input is the tool and the sealed examples, **not** the brief.

Be honest about the limit: this is only real if the checking happens somewhere that genuinely can't see the sealed set. In one session, *"I won't look at the other six"* is a promise, not a control. If you can't isolate it, say so in the brief rather than claiming a guarantee you don't have.

## The brief

One file, **edited in place, never re-typed from memory.** Carrying it forward word-for-word is editing; re-authoring it is not.

Everything above the divider is **plain English they could read to their boss.** Everything below is for whoever builds it, and they never need to open it. Don't split the difference — mushy semi-technical prose serves neither reader.

```markdown
# <plain name, in their words>

**Brief ID:** <stable case ID>
**Revision:** <r1, r2, ... — increment whenever a load-bearing field changes>
**For:** <person / role>
**The job:** <one sentence they'd actually say — "the Monday client report">
**Accuracy:** Draft   ← becomes: Confirmed accurate <date, exact revision, by whom>
**Evaluation:** Not selected   ← or: Selected for evaluation <date, exact revision, by whom>
**Build authorization:** Not authorized   ← or: Authorized for build <date, exact revision, by whom, named build owner>
**Single-authority prototype:** Not claimed   ← or: Confirmed <named person controls data permission, evaluation selection/prioritization, spend, connection/access, construction, and acceptance>
**Last updated:** <date>

## Clearance and lifecycle

**Allowed / prohibited material:** <data classes and limits>
**Approved account / environment:** <named account and environment, or synthetic/public only>
**Brief location / access:** <cleared location + who may see it>
**Retention / deletion:** <duration + deletion owner/path>
**Recording / transcript:** <not allowed / allowed location, access, retention>
**Later aggregate use:** <not permitted / permitted only after named minimization and for the stated comparison; never implied by workflow confirmation>

## What you do today

<Your map, corrected by them. Give every load-bearing step, decision, exception,
handoff, and intervention assumption a claim ID (C1, C2, ...); cite its evidence
IDs inline. Mark participant correction, artifact support, and model inference
distinctly — their corrections outrank your draft.>

**Where the time actually goes:** <often not where they said>
**The part that's yours:** <the judgment — what stays theirs>
**How often / how long:** <n per week · duration>

## People and handoffs

| ID | From → to | What moves / system | Friction or risk | Effect of recommendation | Evidence | Affected role consulted? |
|---|---|---|---|---|---|---|
| H1 | <role → role> | <artifact / decision / data> | <what happens now> | <including displaced work> | <E#> | <yes / no / unknown> |

## What I looked at

| ID | Source class | Date / context | Cleared location | What it supports | Limits |
|---|---|---|---|---|---|
| E1 | <participant report / artifact observation / observed demo / external source> | <when / which occasion> | <safe locator, not raw confidential content> | <C#> | <what this cannot establish> |

## Corrections and unresolved contradictions

| ID | Claim | Before → after | Corrected by / evidence | Date |
|---|---|---|---|---|
| COR1 | <C#> | <model guess → participant correction> | <person + E#> | <date> |

| ID | Competing accounts | Evidence | What would settle it | Status |
|---|---|---|---|---|
| D1 | <account A vs account B> | <E# vs E#> | <named person / artifact / occasion> | Unresolved |

## The gates

| | |
|---|---|
| Is this room cleared? | <authority/policy + allowed data, environment, lifecycle, recording> |
| Whose information is in it? | <theirs / a client's + what that means> |
| Does your company have a rule about this? | <approved policy / named authority / unknown — never a participant guess> |
| Has it ever gone wrong — who caught it? | <their story, verbatim> |
| ↳ per output: prose / numbers / lists | <who catches each. Strictest one decides.> |
| Does it need anything you don't control? | <nothing / needs X from Y> |

## Recommended disposition

**Outcome:** <no action / further observation / process / training / policy / existing tool or configuration / prompt / candidate software>

<One paragraph. What should change, where it belongs, and what they would do. If
software is not the answer, say that plainly.>

**Alternatives considered:** <process · training · policy · existing setup · further observation · no action — why this recommendation fits the evidence better>

**What it won't do:** <the honest edges>
**How you'll know it's right:** <from gate 2, in their words>
**Where your information goes:** <"to Claude and nowhere else" / "nowhere at all">
**If it breaks:** <what they'd see. Then: come back with this brief and the tool.>
**What it costs:** <to build, and per month to run — real numbers>

## Open asks (if any)

> **What's needed:** <the thing>
> **Who can approve it:** <the actual person or role>
> **Roughly how long:** <duration>
> **What works today without it:** <the version that ships now>

For a credential or secret, record its **name, owner, scope, and approved destination only — never its value.** No value belongs in the brief, ticket, fixture, log, handoff, or receipt.

## Decisions

- **LOCKED** <the plain case decision or recommendation> — <why: C# + E#>

### Reversed

- **WAS LOCKED — <the old decision>** — reversed <date> by <what overturned it,
  their correction quoted>. **Now:** <the decision that replaced it>.

---
--- Below here is for whoever evaluates or builds this. You don't need to read it. ---

**Shape:** <what it is, concretely — a page at a URL / a script bound to their
Sheet on a morning trigger / a program on their machine / no software>
**Authorized revision:** <exact revision, or "not authorized">
**Named build owner:** <person/team, or "none">
**IT/security/access owner:** <actual role for credentials, scopes, environment,
deployment controls — may be the build owner, but never assume>
**Needs:** network <y/n> · credential <y/n> · other people's data <y/n>
**Model:** <which one and why in one clause — or "none, this is arithmetic">
**Cost:** <build: the agreed cap. Run: runs/month × cost per run.>

**Inputs:** <format, where from, what varies across the examples + C#/E#>
**Outputs:** <format, exact shape, where it lands + C#/E#>

**How to verify:** <generative / deterministic / monitor — or which parts are
which. This decides the whole check; the build cannot infer it. Or: not applicable,
because the recommendation is not software.>
**Generative → Exposed:** <path — the build may use these>
**Generative → Sealed:** <path, count, hash — the build NEVER sees these. Verify
in a run whose input is the tool + the sealed set and NOT this brief.>
**Deterministic → Replay fixtures:** <real inputs + the real output they sent.
Visible to the local build, not sealed. Byte comparison. Real/private pair stays
outside source history and follows Retention / deletion. Record each file's SHA-256
or the canonical digest of a multi-file fixture; verify it before every run and
capture expected digest + observed digest + match as evidence. A source-tree
receipt binds source; the external-fixture digest is separate evidence. Synthetic
fixtures may be allowlisted. A deidentified derivative is ineligible without a named
authorized owner/date, exact artifact digest, exact repository/history destination,
scanner + version/ruleset + covered data types, and explicit passing result. Where fidelity permits, commit a synthetic
smoke/regression subset and label what still requires private validation.>
**Monitor → Replayed state + the silence test:** <the day it went wrong,
reconstructed. And: kill it, confirm the silence is visible.>

**If software is proposed, must be true:**
- Shows its work — every number carries where it came from
- Says what it processed; a mismatch stops loudly
- Bad input produces a visible refusal, never degraded output that looks fine
- Never acts irreversibly on its own — drafts, they press the button
- <the cross-check, if gate 2 called for one — the two routes that must agree>

**Out of scope:** <named, so the build doesn't grow>
```

**When a correction overturns a lock.** They will overrule something you locked — that's the skill working, not failing. Never *delete* it: delete it and the next session re-derives the same wrong answer and asks them the same question twice, which is the one thing the decision log exists to prevent. Never leave it in the live list either, struck through or otherwise — a `~~LOCKED — no Google~~` bullet still reads as "LOCKED — no Google" to any grep, any partial read, and any human skimming eight bullets. **Every bullet under Decisions is in force.** Move it under **Reversed**, restate it in the past tense, and name what overturned it. If a lock isn't under Reversed, it's live.

**A reversal is not done when you write the new fact down. It's done when every sentence asserting the old one is retracted.** The new finding is the easy half — you'll write it while the correction is still warm. The stale claim is somewhere else: a gate row you filled three turns ago, a `Needs:` line, a phase label, a cost, an open ask, a section that only made sense for the thing you just cut. **Grep your own brief for what you just stopped believing** — the vendor name, the word "closed," the tool that got dropped — and fix every hit in the same edit, before you reply. And note what a reversal does to its neighbours: any claim whose truth *depended* on the fact that just changed is now **unverified**, not merely stale.

**Notes on the fields that carry weight.** Within the cleared boundary, the gate-2 story goes in the participant's own words — *"Sometimes? I caught the fourteen grand. But sixty bucks I'd never see — and honestly I'd only catch it now because I'm typing every number in"* is three findings, and your summary of it is none. Use the minimum excerpt that preserves the mechanism; do not copy identifying detail for atmosphere. **"If it breaks: nobody"** is what almost everyone will say and it is **not** a blocker — a later tool must fail loudly, so an unowned break is a stop they can see, and the fix is coming back here with the brief. Keep any tool small enough to rebuild rather than clever enough to need repairing. Never name an owner who hasn't agreed to be one. And **the decision log is why this file exists** — without it the next session re-derives everything and they answer the same questions twice.

## The handoff

`diagnose` ends at a **confirmed workflow case**. Confirmation is an event: the participant has read the map, evidence limits, handoffs, recommendation, honest edges, and open contradictions for one exact revision and confirmed that it accurately represents their work. Their enthusiasm during the conversation is not confirmation — the read-back is. Confirmation does not select an intervention or authorize construction.

- **No software recommended** → preserve the process, training, policy, existing-tool, further-observation, or no-action decision and stop. Complete session. Don't manufacture a build to make it feel finished.
- **Confirmed accurate; not selected and not build-authorized** → hand the case to the participant or facilitator and stop. It may later inform comparison or prioritization, but it is not a build ticket.
- **Selected for evaluation; not authorized** → only when the selection names this exact revision, hand that revision to the named sponsor, process owner, builder, engineer, or technical evaluator for feasibility and prioritization. They may ask questions; they may not start construction under this status.
- **Authorized for build** → hand only the exact authorized revision to the named build owner. Carry the exposed/sealed examples' permitted locations, must-be-trues, evidence limits, and shape. `diagnose` doesn't write build steps and doesn't supervise.
- **Open gate** → hand the brief to the participant or named decision-holder. The Open asks block is written so it can be forwarded cold. That's a real deliverable, not authorization.

### When an organization is involved, the brief has several readers

In a company, the decision hats often split: the domain expert owns workflow truth and later acceptance; a facilitator owns discovery; a sponsor or process owner may select evaluation; a build owner accepts implementation; and IT/security/access owners control the credentials, scopes, environment, deployment, or safeguards that actually belong to them. One person may hold several hats, but never infer that from their title. **Those readers change what good looks like, and they change it for the better:**

- **The builder's half can be properly technical.** It's being read by someone who wants the scope, the system, the version, the exact API. Don't dumb it down for a reader who isn't the primary one anyway.
- **The Open asks block is a ticket.** Write it so it can be pasted into one and actioned without a meeting: the exact thing, the exact system, the exact scope, what it's for, what it costs, what breaks without it, and who's asking. A vague ask is how a ten-minute job becomes a three-week thread.
- **Do the reduction before you hand it over.** The whole point is that the person firing this up doesn't jump through hoops. If the setup is five steps, work out whether it can be two *before* you write it down — that's your job, not theirs. Every hoop you remove is one nobody has to be talked through.
- **The person whose job it is still owns the workflow truth.** A build owner owns implementation; IT/security/access owners own their actual controls. Any reader who proposes something that breaks a confirmed case decision has found a conversation, not an override.

**And say plainly when a required owner does not exist.** Do not invent an IT team or assign the participant authority they lack. In a genuinely single-authority prototype, one named person may confirm, select, and authorize only after the brief records that they control data permission, evaluation selection/prioritization, spend, connection/access, construction, and acceptance. Otherwise the honest options narrow, defer, or stop.

If it starts sliding into "now let's build it," stop at the confirmed case. Hand off only under the recorded state above. If you're genuinely blocked on something only they know, ask.
