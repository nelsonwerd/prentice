# The gates

Three gates. Gate 1 has a room-level precondition **before any work detail is disclosed** and a per-artifact check before anything is shared; the other two run before an intervention is recommended or selected. They are not formalities: a thing someone else has to decide costs nothing to name while the case is still fluid and costs a wasted build to discover at the end. Clearing them does not authorize construction.

## What is not a gate

**Market demand.** Never. This case concerns their workflow, not a market of strangers. "Would other people want this?" is not a question this skill asks and its answer is never a reason to discourage anything. Their participation does not prove they would adopt a proposed intervention; real use remains unproven. If you're reasoning about market size, you've imported the wrong skill.

**Size.** Not a gate either. "This is quite big" is not a reason to talk them down. Name what the job needs.

**A forecast of whether they'd really use it.** Not yours to relitigate with a deferential *would*. What a shaky answer tells you is where an intervention would have to live — something they must remember to open loses to the habit it replaces. Establish the past habit instead. Whether software is the right intervention is still a design conclusion: process, training, policy, an existing setup, further observation, or no action may fit better.

## The shape of a gate

A gate is **not a silent refusal and not a route-around.** It's a precisely-named ask, handed to the person who gets to decide. They may have the budget, the authority, or exactly the right colleague — you don't know, and guessing costs them the right intervention.

Every time:

> **What's needed · who can approve it · roughly how long · and what works today without it.**

> *"To read your campaign numbers straight from Meta, someone with admin on the agency's Business Manager has to approve access — often an ops or system owner, and the timing must be checked. A file-based version may work from the CSV you already export without that connection. Should the brief recommend evaluating that version, preserve the direct version as an open ask, or stop here while you check with the owner?"*

Three things make that work: it names a **person**, not a technology; it gives a **duration**, so they can weigh it; and it always offers **what works today**, so the gate is a fork rather than a dead end.

### Most gates are somebody's normal job

The person who clears a gate usually exists and handles decisions like it routinely. Getting an app approved, provisioning a credential, granting a scope, standing something up, or deciding whether policy covers it may belong to IT, security, ops, procurement, a system owner, or the participant themselves. **Name the actual decision-holder; never infer a department from the technology.**

So the honest failure mode here is **not** "this needs approval, therefore no." It's writing an ask so vague, so technical, or so incomplete that the person who could have cleared it in ten minutes can't act on it. **Write the ask for the person who'll receive it**, and do the work of making it small *before* you hand it over — the point is that nobody has to jump through hoops to fire the thing up. That means: name the exact thing, the exact scope, the exact system, what it's for, what it costs, what happens without it. Not *"we'll need OAuth configured."*

If no organizational owner exists, say so plainly and preserve the version that needs nobody as an option. If an owner does exist, that is an asset, not an obstacle — and it means gates you might otherwise route around are worth naming, because someone can actually decide them.

Never: route around a gate silently, build the 80% and leave the blocked part stubbed behind something that looks finished, or hand back "this requires OAuth configuration" and stop.

---

## Gate 1 precondition — is this room cleared for the conversation?

This happens before the opening work question. Establish without inviting examples:

1. Which data classes may be discussed, and which must stay out?
2. Which model account and environment are approved?
3. Where may the brief and any transcript live, who may see them, how long are they retained, and how are they deleted?
4. Is recording or transcript retention allowed?

For workplace or client work, the participant's willingness is not organizational permission unless they actually hold those rights. Record the named authority or approved policy. If any answer is unknown, stop real-work disclosure and continue only with synthetic, public, redacted, or explicitly cleared material. Do not ask for a “quick example” while this is unresolved; the example is the disclosure.

If unexpected sensitive material has already appeared, stop inspecting it, do not repeat it into the brief, and return to the operator or named policy owner for the permitted handling and deletion path.

---

## 1. Is this specific material allowed?

**Two halves, and the first one runs for each artifact before you ask them to share it**, because room-level clearance does not mean every file or field is allowed, and you can't un-receive a file.

**Before the first artifact:** *"Before you send me anything — whose information is in these?"*

Their own work product and internal notes are eligible **only when that artifact and the requested fields are inside the recorded clearance**; then ask for the real thing. Otherwise use a cleared synthetic, public, redacted, or explicitly approved substitute, or route to the named owner. **A client's, a customer's, a patient's — or they don't know which** → name it now, while nothing has moved. "They don't know" is the common case and it is not a pass.

**And the question nobody asks:** *"Does your company have a rule about using AI on client work — do you know what it is, or is there someone who would?"*

Ask it. They won't raise it, and the whole product is aimed at exactly the people least likely to: someone worried about falling behind is not going to open by asking permission. Then follow the actual boundary — cleared, inspect only the permitted material; unknown, stop disclosure, name the person who would know, and offer a synthetic, public, redacted, or explicitly cleared route. Don't moralize and don't guess. It has to be **settled before the material moves**.

**Then, after the recommendation is clear — say where the information would actually go.** *"Runs on your machine"* and *"never leaves your machine"* are different promises, and only the second one answers the contract question. A proposed tool that reads files locally and sends each one to a model **has not kept anything local** — that hop is the exact thing the contract is about. State the proposed path in words: *"the report would go to the approved model service and nowhere else"* or *"this one would never send anything anywhere — it's just arithmetic on your machine."* **Never let "local" do the work of "private."**

What you may not do: decide on their behalf that it's probably fine, or bury it in a disclaimer nobody reads.

## 2. Has it ever gone wrong — and who caught it?

**This is the one that matters.** The other two are about effort and access. This one is about whether the tool can hurt them.

A tool that's right on the three examples you tried and quietly wrong on the fourth is **worse than no tool**, because they can't tell — and the whole reason they wanted it is that they stopped doing the check by hand.

**Ask for the incident, never the prediction.** Do not ask *"would you notice if it were wrong?"* That asks someone to forecast their own perception, and it comes back *"yes, obviously, I read everything before it goes out"* nearly every time. It's the deferential default, and it's a claim about precisely the check the tool is about to remove. *"Did it ever go wrong?"* is a **did**. *"Would you notice?"* is a **would**. Only the first is evidence.

> *"Show me a time this went wrong. How did you find out?"*

**Ask once, then sort it out yourself** — don't run this at them step by step, they have fifteen minutes. Take their story back to the map and grade **each kind of thing the tool would produce**, because **reading the output checks prose and never checks a number.** A wrong sentence looks wrong. A wrong total looks exactly like a right one — checking it means redoing the arithmetic the tool just did, which is the work they came here to stop doing. So *"yes, I read everything before it goes out"* is an honest answer that covers the paragraph and covers nothing inside it. If one tool writes the summary **and** computes the figures in it, that's two verdicts, and **the strictest one governs its own output.**

Grade on **who caught it**:

- **They caught it themselves, before it left.** *"I spotted it in my read-through."* The check is real, it's theirs, and it happens before anything ships. → **Proceed.** Most drafting work lands here.
- **Someone else caught it** — a client, their boss, the next person downstream — or it surfaced a week later. → The check isn't theirs. A downstream human has been doing it for free and won't be in the loop once the tool runs. → Any later tool must **draft and show its work**, never act: every number carries where it came from, every list says what it processed, and a mismatch stops loudly instead of quietly guessing.
- **They caught it only because they were doing it by hand** (*"I'd have seen it, I type every number in"*) **or only because it was big** (*"that one was fourteen grand"*). → Treat as "someone else caught it." Their check is a by-product of the very labor you're removing, or it only fires above a threshold. **Showing the source won't save this one** — a citation only helps if they go look, and going to look *is* the two hours. **Before recommending a cross-check, first try to delete the second copy.** A cross-check catches a wrong number. Removing the place it could be typed wrong means there's no wrong number to catch — no alert to ignore, no threshold to tune, no failure that's silent because the checker didn't run. Their process almost always holds the same value in three or four places; find which one is *authored* and which are *copies*, then specify that every copy reads from the author. That's strictly better than detecting the disagreement.

**If you can't remove the second entry point, then require a cross-check**: two independent routes to the same number that have to agree, and a loud stop when they don't. Their own workflow usually hands you one — the printed total they don't trust, the invoice they reconcile against, the figure they retype.

**And say in the brief which one you got.** *"There is no path for this to happen"* and *"this reduces it a lot"* are different promises. Never swap them.
- **No incident at all** — *"it's never gone wrong"* / *"I'd notice."* → Grades as "someone else caught it" by default. One exception, and it's yours to establish rather than theirs to assert: if **you** can see from their files that a wrong answer would be structurally loud — the file won't open, the total won't reconcile, the field comes back empty — that's a mechanism you verified. Name the specific one in the brief. *"I'd notice"* with no story and no mechanism behind it is not a mechanism.

**Then find the mechanism.** *Who caught it* tells you what the tool is allowed to do. ***Why it happened*** tells you what to build — and it's usually sitting in a file you already have. Their incident is a symptom; go find the physical cause. The one field that's hand-typed. The one step with no template. The one number that lives in two places. *"Occasionally a number comes out wrong"* is a soft finding you can only design around. *"That number is the only hand-typed field on a form where everything else auto-fills"* is a hard one you can design **out**. Open the artifact the error happens in and find the seam it comes through.

**If the tool's job is to watch for something, ask one more:** *"if it stopped working, how would you find out?"* A monitor's fatal failure is silence, not a wrong answer — a dead feed and an all-clear are the same screen, and no amount of showing-your-work exists inside a message that never got sent. Anything that watches must say when it last successfully checked, and must fail **to the person**, not into a log. **The liveness stamp ships in v1 or the monitor doesn't ship.** It is never a later phase, never a nice-to-have, and never something the first version does without — a monitor you can't tell is dead is worse than no monitor, because it's actively telling them everything's fine.

**Nothing later built from this case takes an irreversible action by default** — sending, posting, paying, writing to the live system. It drafts; they press the button. If they later want the button gone, that is a separate authorized decision after they have watched it work — never a default you chose for them.

Their story is also the acceptance test for any later build, and it beats anything you'd invent: specify the intervention that would have caught *that*.

## 3. Does it need anything you don't control?

Three questions about the map. **You** answer them, not them:

1. Does it need **the network** — a live service, a website, someone else's server?
2. Does it need **a credential** — a login, a key, an approved app?
3. Does it touch **other people's data** — a shared system, a colleague's inbox, a client's account?

**All three no** → there is no access dependency on this map. Continue to compare interventions; this result does not select or authorize a build.

**Any yes** → resolve it to a named ask, in the shape at the top of this file, before evaluation can claim the dependency is clear and before any build authorization. Be concrete and current — **check what's actually required rather than assuming.** This changes constantly and your memory of it is stale.

The distinction that decides many designs: **something running inside a session they're already signed into may operate under their permissions; something running on its own usually needs its own credential.** Neither path is automatically allowed or review-free. A script bound to their spreadsheet, touching their mail, is still a different design from an app with its own approved identity. Work out which one the policy and technical owner actually permit before any build authorization.

A participant-controlled credential may make a personal prototype simpler, but never assume it is a five-minute paste or allowed at work. Do not request or handle the credential during diagnosis. Record its name, expected cost, storage and rotation requirements, approved destination, and the technical/security owner who must settle the real path — **never its value in the conversation, brief, ticket, fixture, log, handoff, or receipt.** The named owner enters it only during separately authorized live activation.

---

## Writing it down

End with a plain-English verdict in the brief:

- **What should change**, in one sentence they'd say themselves — including no tool when that is the answer.
- **Alternatives considered** — process, training, policy, an existing tool/configuration, further observation, and no action.
- **What the recommendation won't do** — the honest edges.
- **Every open gate**, with the ask, the person, and the duration.
- **How they'll know it's right** — from gate 2, in their words.
- **The three separate decisions.** Accuracy may be confirmed while evaluation remains unselected and construction remains unauthorized.

A session that ends at *"use the prompt you already have"*, *"fix this handoff; do not build software"*, or *"here's the exact ask for the named owner"* is complete. So is a confirmed case selected for later evaluation. None is a failure, and none silently authorizes construction.
