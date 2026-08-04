# Triage Guide — the inverted lens, the verdict, and the one gate

Use after the audit and the perturbation pass hand back their findings and before a single line of code moves. Triage is what turns a list of findings into a **scope**. Skip it and you fix the untriaged list.

The audit gives you severity and fix order. Triage adds the decisive axis — and here it is **not** upstream's *"value against the user's next goal."* The lens is **fixed by the system and you don't ask for it:**

> **The tool ships to a non-technical person. Rank every defect by how invisible its failure is to her, times its blast radius.**

## The inversion, spelled out

Upstream triage served an operator who reads stack traces; a crash was the headline. Prentice's end user cannot read one — and doesn't need to, because **a crash is the failure the system already handles**: the tool stops loudly, she sees it stopped, she comes back with the brief. Nothing false entered the world. The founding cautionary tale runs the other way — a "Configured ✓" over a stub, a plausible number nobody typed, a scheduled digest that stopped arriving and looked exactly like good news.

**Rank by failure class, most-invisible first:**

1. **Plausible wrong output.** A number, date, name, or price that is wrong and looks right. The employee can't see it, so they act on it — paste it into the document, send it to the client. The expensive failure, always at the top. *(A generative tool inventing a confident, fluent, false claim is this class — the output reads perfectly and is simply untrue.)*
2. **Silent omission / dead monitor.** The thing that didn't happen and nothing said so — the overdue item never flagged, the morning digest that quietly stopped. Silence and all-clear must never look the same; a defect that makes them look the same ranks here regardless of how "minor" the code change is.
3. **A lying success indicator.** A checkmark, a "done," a liveness stamp that asserts more than was checked. The exact inversion Prentice exists to prevent — **treat as top-tier regardless of code severity.**
4. **Data going somewhere she wasn't told.** The brief says where her information goes, in words; any path that quietly widens that — a log that captures PII, an error handler that ships file contents to a third party, "local" quietly standing in for "private" — is invisible by nature and ranks by what leaks.
5. **A false refusal.** The guard that fires on a real file she's given. Invisible in a different way: not to her (she sees it) but to the system — every false alarm teaches her to ignore the loud stop, and then class 1 and 2 defects inherit the whole blast radius. A crying-wolf guard ranks with the defects it unguards.
6. **The loud crash.** Cheapest, ranked last among equal blast radius — it is its own alarm. Fix it, but never let it outrank a quiet lie.

**Then multiply by blast radius:** what do they *do* with the output — send it to someone outside, or read it themselves? Is the action reversible (a draft vs. anything that leaves)? Does it touch personal data, money, or a legal document? A class-1 defect in a number that lands in a contract outranks everything; a class-6 crash in a convenience menu ranks near the bottom.

**The count is a clue, never a verdict** — same as diagnose's rule. A defect that fires rarely but lands in the document that goes to a client outranks one that fires daily in a preview pane.

## The verdict shape (an opinion, not a menu)

Deliver a **verdict**, not a decision request. Each bucket carries *the reason*, in the reader's terms — the reader is the named build/technical owner; IT/security/access receives only findings tied to its actual controls:

- **Clearly worth it** — with the reason. The house exemplar is the defect that makes the tool **lie**: a wrong-but-plausible output, a stamp that overstates, a silence that reads as all-clear. Fixing before handoff is strictly cheaper than the employee trusting it for two weeks first.
- **Worth it, but scope it small** — the smaller fix, not the redesign. (A redesign-class fix isn't snag's anyway — it routes back through the brief's owner.)
- **Worth it now, oddly enough** — the cheap high-leverage item: a fixture that pins today's correct behavior, right before a fix-heavy stretch when regressions are likeliest.
- **Genuinely fine to defer** — an **explicitly named list**, never a silence, each with what would flip it.
- **A fair counterpoint** — the honest case against the whole pass. *(The shape to hope for: "every failure found fails closed — nothing threatens the numbers she sends.")* If the honest answer is "nothing here is worth fixing," **say that** and stop. Never manufacture a snag list to justify the audit's cost.
- **A direct recommendation** — closing with what to consciously **not** fix until real use earns it. The brief often names the experiment already (*"you'd know within a couple of weeks of real use"*) — don't pre-empt with speculative engineering the two weeks will answer for free.

**Deliberate non-fixing is part of the deliverable.** The defer list ships in `SNAGS.md` as recorded, not force-fixed. Nothing is silently dropped.

**What triage never does:** re-open whether the exact revision should proceed (that belongs to its recorded evaluation selection and build authorization, not snag); reverse a LOCKED decision to make a fix cheaper (route it back); or re-litigate the design `harden` already cleared.

## The gate message — everything in one block (posted whether or not the gate is live)

**Check the entry point first** (SKILL.md's table). Commission-invoked under the exact revision's build authorization, or explicit "don't stop to ask" from the authorized build owner → the gate is **waived**: post **this exact block, unchanged**, as an FYI before unit 1 dispatches; only the closing line changes. **Never convert a waived gate back into a question.**

*(The waiver is bounded: a LOCKED reversal or material change to employee-visible workflow, intervention, data path, risk, output, cost, or acceptance stands outside every waiver — reset the new revision's three states and post it as a routed-back finding, not a unit.)*

The gate carries everything the authorized build owner needs in order to say one word:

- **The fix set** — the triaged units, in rank order, each with its one-line reason *in failure-class terms* ("S1: the price can silently disagree with what was quoted — class 1, lands in a contract").
- **The refusal record so far** — what the perturbation pass broke, what stopped loudly, what didn't.
- **The branch, and the commit cadence** — one commit per verified unit; **not pushed.**
- **The frozen core** — the named guards and invariants the run will prove intact.
- **What this pass CANNOT clear** — the wiring tickets, the real-use signal only the employee generates, the named human gates. Up front, not discovered at the end.
- **An honest duration + cost estimate** — sized for the tool in front of you, not upstream's repo-scale anchors.
- **The artifact path** — `build/SNAGS.md` and the plan section in `build/PLAN.md`, readable while it runs.
- **Any dirty-tree finding from pre-flight** — the files, why, and the default.
- **What the gate does and doesn't cover** — plainly: *"You're approving the verdict and the bound, not the plan — the plan is authored after your go and dispatched without further review. Correcting the ranking here, in one line, is your cheapest control and the only one before commits land."*

Then one line — **if the gate is live:** ***"Say go and I'll run it to completion without stopping."*** **If waived:** ***"Nothing needed from you — this is already running. Correct the ranking or the fix set in one line if I got it wrong."***

## After the go

**The gate never re-opens.** No plan approval, no per-unit approval, no pause offers. Report at unit boundaries in plain English with an explicit **"nothing needed from you."** Stopping because the evidence says stop is not re-opening the gate.

**Hard gates — no phrasing unlocks these:** push, merge, tag, publish, unapproved spend, perform wiring, touch a live account or the employee's running instance. Each belongs to its recorded owner as an explicit act after this run ends. See SKILL.md for the full autonomy line.

## An honest note on triage's authority

Upstream's triage was never once vetoed across its real runs — **which is not evidence it was right**; an un-vetoed triage and an unchecked triage look identical. Snag has only a **USER-CONFIRMED author self-run (n=1), with no source artifact independently verifying its detailed claims**, and the person best placed to catch a wrong ranking — the employee who knows which outputs she actually double-checks — may not be in the room when this gate posts. Her knowledge is in the brief's gate-2 rows; triage must read those rows as the ground truth about invisibility. Invite correction from the domain expert or named build owner; do not assume an IT title carries workflow knowledge.
