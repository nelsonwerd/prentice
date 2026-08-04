# Why Prentice is built this way

**What this is:** the locked design calls behind Prentice itself, with the reasoning that produced each one — so nobody re-derives them, and so a reversal has to argue with the actual reason rather than a summary of it. Read it before changing anything load-bearing.

**What this is not:** a template, an example, or anything a person using Prentice ever sees. Those people get a `## Decisions` block inside their own `TOOL_BRIEF.md` — *"LOCKED — the final read-through stays manual; it's their judgment and it isn't the pain"* — which lives in their workspace next to their tool and exists so the next session doesn't ask them the same questions twice. Same discipline, different subject: **that log is about one person's tool. This one is about the machine that builds it.**

It's here because the skills demand it of everyone else. A decision log is the thing that stops a project re-litigating settled ground every time someone new picks it up, and this project has an unusual amount of settled ground that looks arbitrary until you know the reason. Most of these were won by being wrong first; that's noted where it's true, because the wrong version is usually the one someone will independently reinvent.

Every entry below is **in force.** Anything overturned moves to [Reversed](#reversed), restated in the past tense with what overturned it — never struck through, because a struck `~~LOCKED~~` still reads as LOCKED to anyone skimming.

Historical *Earned* notes describe author-reported internal development unless they cite an inspectable repository artifact. No published run artifact independently verifies the detailed claims from the author's single self-run; see [Validation](VALIDATION.md).

---

## The product and operating model

**LOCKED — Prentice starts with one confirmed workflow case, not a promised tool.**
The independently complete output of `diagnose` is an evidence-linked `TOOL_BRIEF.md`: what happened in a recent occasion, what supports each load-bearing claim, what was corrected or remains contradictory, who is affected, and what intervention the evidence supports. A process change, training, policy clarification, existing tool, further observation, or no action is as complete an outcome as a software recommendation.

**LOCKED — The skills are instructions, not enforcement.**
Prentice is Markdown that guides an AI model. Structural checks can establish that files, fields, references, and selected contract language exist; they cannot guarantee that a model follows the method, that the diagnosis is good, or that generated code is correct, secure, scalable, or production-ready.

**LOCKED — Market size is not the test, and workflow confirmation is not intervention approval.**
`ideate` asks whether strangers would buy a product. `diagnose` serves one known person or team and does not reject an intervention because strangers would not want it. It still compares software with process, training, policy, existing-tool, further-observation, and no-action alternatives. Confirming the workflow case does not select an intervention, authorize construction, or prove that anyone will use the result.

**LOCKED — Fit, not size.**
Name what the evidence says the job actually needs. If one prompt or an existing setting resolves it, hand that over and stop. If a real program is warranted, preserve the requirement for optional evaluation and authorization. **Rounding down to look modest is the same failure as rounding up to look impressive.**
*Earned:* an early draft had a ladder that systematically biased the answer toward small artifacts rather than the intervention supported by the case.

**LOCKED — The count is a clue, never a verdict.**
Volume is diagnostically useful — it may rule out overload and redirect the investigation toward waiting, risk, checking, or displaced work — but it is never a verdict on the appropriate intervention. The better question is *what does this compete with, and what happens when it loses?*

---

## States, decision hats, and handoffs

**LOCKED — Accuracy, evaluation, and construction are three separate states.**

- `Accuracy: Confirmed accurate <date, exact revision, by whom>` means the participant confirmed that revision's account of the workflow.
- `Evaluation: Selected for evaluation <date, exact revision, by whom>` means a named decision-holder chose to assess that revision's intervention.
- `Build authorization: Authorized for build <date, exact revision, by whom, named build owner>` permits construction of that revision inside its recorded cost cap.

Never infer one from another. A material hardening change creates a new revision, resets accuracy to Draft, evaluation to Not selected for that revision, and build authorization to Not authorized, then routes the case back.

**LOCKED — `diagnose` normally stops at the confirmed case.**
The participant may keep it, a facilitator may use it, a sponsor or process owner may select it for evaluation, or a named build owner may later receive an authorized revision. A confirmed but unselected case is a complete outcome. A selected but unauthorized case cannot enter construction.

**LOCKED — Roles are decision hats, not departments.**
The domain expert owns workflow truth and later acceptance; a facilitator/operator owns the discovery process; a sponsor or process owner may select evaluation; a build owner owns construction and code-level review; IT/security/access owners control the credentials, infrastructure, deployment, or safeguards that actually belong to them; and the accepting user judges the result in real use. One person may hold several hats only when that is recorded explicitly — never by title or implication.

**LOCKED — Technical and employee-facing evidence remain separate.**
The employee-facing workflow case and tool surface stay plain and legible. Technical findings, receipts, code-level residuals, and review obligations go to the named build/technical owner, with IT/security/access receiving only evidence tied to their actual controls. A grade string never becomes employee-facing assurance.

---

## Gates and wiring

**LOCKED — Gates fire up front, at `diagnose`, in one shape.**
**What's needed · who can approve it · roughly how long · what works today without it.** A blocker named at minute eight is a decision that can be routed to its actual owner and costs nothing. The same blocker discovered at hour thirteen is a wasted build and an artifact nobody in the room can finish.

**LOCKED — A gate is a named decision, not a vague wall.**
Record **what is needed · who can approve it · roughly how long · what works today without it**. The owner may be the participant, sponsor, system owner, IT, security, procurement, or someone else. Never infer the owner from the technology, and never treat a clear ticket as authorization that has not yet been granted.

**LOCKED — Build-then-wire applies only after exact-revision authorization.**
The named build owner constructs and tests everything safely possible to the seam: adapter, error paths, dormant state, and checks that do not require live access. The ticket names the actual remaining activation work, its owner, and the real smoke test. Activation may be more than a paste. IT/security/access may be the build owner when named, but construction never lands on them by implication. A key merely existing is never `Configured ✓`; the light flips only when a real call succeeds.

**LOCKED — Decision boundaries stay separate.**
Data permission, workflow accuracy confirmation, evaluation selection, build/spend authorization, connection/access authority, and user acceptance answer different questions and may have different owners. The fact that one boundary is clear never silently clears another.

---

## The conversation

**LOCKED — Open conversation, not a protocol.**
Start open, then narrow. Give the model principles and things to listen for, never a decision tree — a tree makes it interrogative and it breaks on the case nobody anticipated.
*Earned:* two drafts rejected for being "boxed in." The second one built an *evidence ladder* and went looking for documents — and stalled on the person who produces none, who is frequently the **easiest** job to automate, because someone doing the same thing by hand all day is a program nobody wrote down.

**LOCKED — Never ask someone to describe their job. Get them onto one real occasion.**
*"What do you do?"* queries semantic memory and returns a job description they've told people at parties. *"What did you do at 2 yesterday?"* queries episodic memory and returns the actual work, including the steps that went automatic years ago. It isn't a trick — it's what watching looks like when you can only use words.

**LOCKED — The second law: ask only what only they can answer.**
Everything else, go find out yourself. **This is the rule that predicts which questions survive a deferential user.** A question they uniquely own gets a real answer. A question you could have answered yourself gets a guess, a shrug, or a polite yes — and you'll bank it as evidence because it arrived shaped like an answer.
*Earned:* this line already existed in the skill, filed under "their time," as though it were about efficiency. Every question that failed in the first real run was one the user didn't uniquely own — *where does your email live* (findable), *where do these two files differ* (the AI already knew), *would you look at a pinned tab* (unanswerable by anyone). The two that worked were the two only he had.
*The corollary:* every mechanism that depends on the user correcting the AI gets weaker the more agreeable they are. **Move as much work as possible into the half that opens files** — that half worked without any help.

**LOCKED — Their approval is not evidence.**
Someone who came in worried about falling behind agrees with almost anything. Ground everything in a correction, a number, or an output they're looking at. *"Yeah, that sounds great"* is politeness.

**LOCKED — Guess out loud, be specific enough to be wrong.**
Nobody can author a workflow; everybody can correct one. A blank page gets a shrug; a wrong map gets a precise correction with the real constraint attached. **If nobody has corrected you yet, you weren't specific enough — go back and guess harder.**

**LOCKED — Vendors are facts to establish, not questions to ask.**
Which systems the work runs on is one of the most important things to learn — you can't build against Meta Ads without knowing it's Meta Ads. But ask in *their* nouns, ask every surface separately (files, mail, chat, and the data source are often four different companies), then **go look** — the vendor is checkable, which makes it the second law's problem. An *"idk"* in the answer is a flag that you asked in your language, never a data point to build on.
*Earned:* the first run asked *"Google Workspace or Microsoft 365?"*, got *"idk what workspace is,"* and locked an architecture on it for two hours — then banked its own wrong turn as a helpful user correction.

---

## Verification

**LOCKED — Three shapes, and the brief names which. The build can't infer it.**

| Shape | Check |
|---|---|
| **generative** (a model in the tool) | Sealed examples the build never sees; an isolated verification run |
| **deterministic** (no model) | Replay fixtures: real inputs → the real output they actually sent → byte comparison. The private pair is digest-bound and stays outside source history under its retention rule. Synthetic derivatives may enter the allowlist; deidentified derivatives need the canonical named-owner/date, exact-digest, exact-destination, scanner/version/ruleset/coverage, and explicit-passing-result record. "Tuning to the answer" *is* the spec; there's no generalization claim to protect |
| **monitor** (it watches for something) | Replayed state, **plus the silence test**: kill it and confirm the silence is visible. A monitor's liveness stamp ships in v1 or the monitor doesn't ship |

*Earned:* the design mandated sealing unconditionally. The first real brief specified a tool with **no model in it** — so its sealed set was a fossil, an answer key for a tool that got cut. A merge tool has no exam to cheat on.

**LOCKED — Source trees and private case evidence have separate roots.**
The plan records absolute `CASE_WORKSPACE` and `TOOL_REPO`. Git and receipt commands explicitly target the tool repo; private artifacts and fixtures remain in the case workspace under their deletion rule. A source-tree grade binds source only. External fixture bytes are identified by a digest verified inside the harness that exercises them. Local version-control eligibility never grants publication permission.

**LOCKED — Ask for the incident, never the prediction.**
*"Would you notice if it were wrong?"* asks someone to forecast their own perception and returns *"yes, obviously, I read everything"* — a claim about the exact check the tool is about to remove. Ask **"show me a time this went wrong — how did you find out?"** and grade on **who caught it**. And know that **reading output verifies prose and never verifies a number**: a wrong sentence looks wrong; a wrong total looks exactly like a right one.

**LOCKED — The refusal suite. Negative acceptance is a first-class check.**
Garbage, empty, wrong-format, truncated, and subtly-wrong inputs must produce a **visible refusal**, never degraded output that looks fine. Break their real file the way their world breaks it; the only correct behavior is a loud stop; **any output at all is a defect.** For a stochastic part, refusal is a **rate** — sample it. `refused 7/10` is a failure, not a pass with a caveat.
*Why:* upstream `build-loop` has no concept of negative acceptance. For a tool operated by someone who can't detect a wrong answer, refusing correctly matters more than succeeding correctly.

**LOCKED — Delete the second copy before building a cross-check.**
A cross-check catches a wrong number. Removing the place it could be typed wrong means there's no wrong number to catch — no alert to ignore, no threshold to tune, no failure that's silent because the checker didn't run. Say which one you got: *"there is no path for this to happen"* and *"this reduces it a lot"* are different promises.
*Earned:* the first real run invented this, and it beat what the skill asked for.

**LOCKED — No green checkmark over a stub. Ever.**
A "Configured ✓" that means "an env var is non-empty" is the exact inversion this project exists to prevent.

**It is not hypothetical, and this is the project's founding cautionary tale.** In an earlier project of mine, an `envConfigured()` helper returned `true` the instant an env string was non-empty. The settings UI rendered that as a green check reading **Configured**. The four methods behind that check had **zero call sites** — the entire integration was unreachable. Every artifact was honest: the file's own header said the clients were stubbed, the TODO markers were right there, and the build's ledger declared it. Honest to a competent reader; **false assurance to anyone else** — paste in a key and the screen tells you it's working over a subsystem that is 0% implemented.

Nothing was done wrong to produce that. It's what "wired but empty" looks like when the reader who could decode it isn't in the room. **The whole of Prentice is downstream of that observation.**

*Kept honest by:* this rule fires on the repo itself, not just its output. An earlier `verify.sh` here probed for a file on one specific laptop and, when absent, printed `PASS` having compared nothing — the same bug, in the gate script, of the project whose founding story it is. See [Reversed](#reversed).

---

## Documents

**LOCKED — One living brief, edited in place, never re-derived from memory.**
Carrying it forward verbatim is editing; re-authoring it is not. The brief is the memory; the chat is disposable.

**LOCKED — The retraction discipline. Every bullet under Decisions is in force.**
An overturned decision **moves** to a `### Reversed` subsection, restated in the past tense, naming what overturned it. **Never strikethrough** — a struck `~~LOCKED — no Google~~` still greps as "LOCKED — no Google" and still reads that way to anyone skimming. And **a reversal is not done when you write the new fact down; it's done when you grep out the old one** — the stale claim is somewhere else: a gate row, a phase label, a cost line, a section that only made sense for the thing you just cut.
*Earned:* the first real brief contradicted itself in **eight places** after one correction reopened a path. The worst wasn't the obvious one — the monitor's liveness stamp got filed under "Phase 2, deliberately not in v1" while the thing it protects *was* v1. That one fails silently, which is exactly what it exists to prevent.

**LOCKED — Sealed examples never live in the brief.**
The builder reads the brief. Put the answers in it and there's no test, just an open-book exam.

---

## Department synthesis — future manual experiment, not a feature

**NOT IMPLEMENTED — no department-synthesis skill or department-level capability exists.**

The current hypothesis is manual and operator-led. Only after multiple individual cases are confirmed, sanitized for the comparison, and explicitly permitted for aggregation may an operator compare them. The comparison must:

- retain source links back to each confirmed case and its evidence limits;
- preserve dissent, contradictions, and role-specific differences rather than manufacturing one department truth;
- look for shared handoffs, dependencies, queues, duplicated checks, and common root causes — not rank employees or count proposed tools;
- consider process, training, policy, an existing tool, further observation, and no action alongside software;
- create hypotheses for named decision-holders, never automatic evaluation selection or build authorization.

No skill exists because the comparison contract has not been observed. At least one outside `diagnose` session and one small manual cohort must first show which fields remain comparable, which create false equivalence, and where human judgment must stay explicit. Until then, department synthesis is a research direction, not a product claim.

---

## Reversed

- **WAS LOCKED — "Approving the brief is the go button; the employee hits go and `commission` builds."** — reversed 2026-08-04 by the diagnose-first contract review. **Now:** confirmation establishes workflow accuracy only. Evaluation selection and exact-revision build authorization are separate states, and `diagnose` normally stops at the confirmed case.
- **WAS LOCKED — "There are two roles: employee and IT."** — reversed 2026-08-04 because it collapsed workflow truth, facilitation, evaluation, construction, infrastructure, and acceptance into job titles. **Now:** domain expert, facilitator/operator, sponsor/process owner, build owner, IT/security/access owner, and accepting user are separate decision hats that may collapse only when recorded explicitly.
- **WAS LOCKED — "IT pastes and tests; IT never builds."** — reversed 2026-08-04 because IT may be the named build owner, while an IT help desk may own no construction at all, and activation is not always a paste. **Now:** the named build owner constructs to the seam; IT/security/access owns only its actual controls unless also named as build owner.
- **WAS LOCKED — "There is no evaluation queue; wiring scarcity does the filtering."** — reversed 2026-08-04 because a confirmed case may remain unselected, enter explicit evaluation, route to a non-tool intervention, or stop. **Now:** scarcity may inform prioritization, but it never substitutes for the recorded evaluation and authorization states.
- **WAS LOCKED — "Never ask a vendor question."** — reversed 2026-07-16 by Drew: *"why not ever ask a vendor question? that IS an important question... for workers dealing with data coming from an API source."* The rule was drawn correctly from a real failure and generalized wrongly. **Now:** vendors are facts to *establish* — ask in their nouns, then go look. See the vendors entry above.
- **WAS LOCKED — "The tool is a Claude Project."** — reversed 2026-07-15 by Drew: *"isn't that literally just a claude chat? that is NOT what I'm going for."* This was a retreat: research hit API keys, code signing, and `npm install`, and the response was to fall back to the one option with no gates and call it an insight. **Now:** the shape is a finding per job, and gates are priced or worked around rather than fled from. Keys flagged up front were always acceptable — Drew said so twice before the retreat happened.
- **WAS LOCKED — "Wiring-dependent scope is fenced and not built."** — reversed 2026-07-16 by Drew: *"the backend wiring/scaffolding SHOULD be built... they should not ideally have to do more building."* **Now:** build-then-wire means the wired path is built in full to the seam; only activation waits. See the build-then-wire entry above.
- **WAS LOCKED — "IT runs the build."** — first reversed 2026-07-16 into an automatic employee-triggered pipeline, then superseded by the 2026-08-04 role repair above. **Now:** construction begins only from an exact authorized revision and belongs to its named build owner; IT/security/access handles its actual controls and may or may not be that owner.
- **WAS LOCKED — `verify.sh` cross-checks the marketplace name against the local `idea-to-ship` checkout.** — reversed 2026-07-16 by an audit. **Now:** it asserts against the known constant. *The reason is the point:* the probe used a machine-specific path below `<user-home>/idea-to-ship/`, so on any other machine the condition was absent, the assert never ran, and the script printed **`PASS  marketplace name is unique vs idea-to-ship`** having compared nothing. That is `envConfigured()` — a green check over an absent condition — **in the gate script of the project whose founding story it is.** It shipped, and the README advertised the check. Written down here because the lesson clearly needs repeating: the inversion isn't a mistake other people make.
