# The lane catalog

Six lanes, aimed at a tool design. Pick by scale (the table in the spine) and by what the brief actually contains — a lane with nothing to attack is spend, not rigor. Every lane runs from the prompt template in `specialist-prompt-template.md`, gets **only the brief and its artifacts**, and returns findings in severity tiers plus **candidate fixtures** in the fixture shape (`fixtures.md`).

The two lanes marked **core** run in every mode, including Quick.

## Lane 1 (core): Input reality — the variants the employee never showed

The exposed examples are a sample, not the population. The employee showed the files that were nearest to hand; the tool will meet everything else. This lane's job is to enumerate what else, and turn each variant into a fixture candidate.

Specific things to hunt:
- **The variant count itself.** The brief says "carrier layouts" and shows 3. How many exist? The employee's own numbers are gold — "I have twelve of these" said in passing outranks any inference. Look for counts in the brief's map, the file names, the folder they came from.
- **Same format, different author.** The export saved from Excel vs. Numbers vs. the vendor's own download. BOM, encoding, line endings, delimiter drift, a locale that writes 1.234,56.
- **Structural drift within one source.** The optional column that appears in March. The header row that's sometimes two rows. Merged cells. The extra sheet.
- **The boundary sizes.** Empty file. One row. The 50,000-row month. The field at exactly the length the template allots.
- **Truncation and partial arrival.** The download that stopped at 80%. The attachment that's the wrong file entirely but the right extension.
- **Third-party-authored content flowing through.** An inbound message, a client's reply, a supplier's description — text the tool will merge or process that nobody at the company wrote. What happens when it contains the delimiter? A merge token? Something that reads like an instruction?

Deliverable emphasis: a **variant inventory** (what varies, over what population, with evidence for the count) and one fixture candidate per class the design doesn't visibly handle.

## Lane 2 (core): Silent-wrong — output that looks right and is wrong

The only failure class that can genuinely hurt the employee, because the whole point of the tool is that they stopped doing the check by hand. A wrong sentence looks wrong; a wrong total looks exactly like a right one. This lane traces every number, date, name, and status in the tool's output back to its source and asks: **what makes this wrong while looking fine?**

The silent killers to hunt in a design (adapt to the domain; add the brief's own incident from gate 2 — it's the acceptance test):
1. **A check the design computes but nothing enforces.** The brief says "flags a mismatch" — flags it *where*, and what stops the output from shipping anyway? A `Configured ✓` that means "an env var exists" is the founding cautionary tale of this whole pipeline.
2. **A value that lives in two places.** Anywhere the same number can be typed, carried, or derived twice, the design has a path to disagreement. Prefer deleting the second copy over cross-checking it; if the brief cross-checks, verify the check stops loudly.
3. **Money or quantities in floats.** Rounding drift that corrupts totals silently.
4. **Errors swallowed.** Any step that can fail and leave the pipeline proceeding on empty or partial data — the sum over the rows that didn't parse.
5. **"What it processed" unstated.** If the output doesn't say what went in, a mismatch (48 of 50 files read) is invisible by construction. The brief's must-be-trues should force the statement and the loud stop.
6. **Off-by-one at a window.** Date ranges, pagination, batch boundaries that drop or double the edge record — the report that misses the last day of the month, forever.
7. **Stale state presented as current.** A cached or carried-forward value surviving past the update that should have replaced it.
8. **Retry or double-fire without idempotency.** A trigger that runs twice, a resumed job that re-sends — the monitor that nags about the same thing as if it were two things, or worse, acts twice.
9. **Timezone and clock assumptions.** UTC-vs-local, DST, the morning trigger that fires an hour early or late twice a year.
10. **Provenance missing.** Every number in the output should carry where it came from. Where the design doesn't show its work, a wrong value has no audit path at all.

And one document-level silent-wrong check, **core at every scale** (moved here from Lane 3 so no lane selection can skip it):

11. **Stale claims — the brief contradicting itself.** Anything the brief still asserts that its own later text has overturned — a LOCKED decision a recorded correction or resolved gate contradicts, a fossil sealed set for a tool that was cut, a `Needs:` line contradicting a resolved gate, a withdrawn ask still echoed elsewhere. A live lock the build carries verbatim while every unit contradicts it is the silent-wrong path at the document level. These are retraction-discipline violations to fold back in Phase 5 — where the stale claim is a Decision, the brief's own overturning evidence is quoted and the lock moves to `### Reversed` (a route-back only if the reversal isn't already the employee's own recorded word).

Deliverable emphasis: for each path, the **input that produces plausible-but-wrong output**, as a fixture candidate — subtly-wrong inputs are this lane's specialty (the file where one column is shifted, the figure that's plausible but stale).

## Lane 3: Assumptions — the stated rule vs. the actual rule

The brief records what the employee *said*, corrected by what diagnose *verified*. This lane attacks the residue: every claim that is asserted rather than shown, every rule that will turn out to have exceptions, every place the brief's two halves or the brief and its artifacts disagree.

Specific things to hunt:
- **The stated rule's exceptions.** "If it's under 20% I flag it" — always? Year-end? The one client with different terms? A rule stated in one sentence almost never survives contact whole. Name the probe that would settle it (often: a question for the route-back, or a fixture at the boundary).
- **Claims the brief itself marks unverified** — anything tagged `[unverified]`, "their description only", or resting on the employee's say-so where diagnose noted the deferential yes. These are the softest ground in the design.
- **Internal contradictions.** The plain-English half promises something the builder's half doesn't build; a must-be-true the shape can't satisfy; a gate row that contradicts a decision.
- **Underspecified areas where the build will guess.** The brief's next reader is another agent (`sequence`, then `make`). What's the worst plausible reading of each ambiguous line? A field with two plausible formats, a path that could match two files, an order dependency that isn't stated — each is a place the build goes wrong politely.
- *(Stale claims — assertions a later section of the brief itself reversed — are Lane 2's, core at every scale; don't duplicate them here.)*
- **Cost and feasibility as stated.** Not "is this worth it" — the brief's own `Cost:` line is a claim like any other. If the design cannot land inside its recorded evaluation/build cap, that's a finding and usually a route-back to the named authority.

## Lane 4: Time and drift — the format change in November

Everything in the design that is true today and will stop being true, silently. A tool that works for six weeks and then quietly starts being wrong is worse than one that never worked — nobody's watching anymore.

Specific things to hunt:
- **Every external format the tool reads.** The vendor export, the platform's message format, the template someone else owns. Who changes it, how often, and what does the tool do on the day it changes — refuse loudly, or keep producing output from a misparse?
- **Calendar traps.** DST (twice a year, the scheduled trigger), year rollover in date parsing, month-length assumptions, holidays that make "3 days stale" mean something different.
- **Accumulation.** The sheet at 5,000 rows. The folder at year three. Quotas and rate limits the design will grow into.
- **Dependency drift.** The API version, the deprecation calendar, the login flow that gets a second factor next quarter. For each: what's the failure *appearance* — an error the employee sees, or silence?
- **The people.** The employee changes roles; a new person inherits the tool. Does anything in the design assume knowledge that lives only in the original employee's head?

Deliverable emphasis: a **drift register** — each dependency, its realistic change cadence, and whether the design fails loud or silent when it moves. Silent entries are Blockers or Highs.

## Lane 5: Security and data-path — where the surface warrants it

Scaled hard by the brief's `Needs:` line. No network, no credential, no other-people's-data → this lane doesn't run; a note in the synthesis says why. Any of them yes → it runs at matching depth.

Specific things to hunt:
- **Where the data actually goes, hop by hop.** The brief promises "to your own Drive and nowhere else" — trace every path in the design that could falsify that, including error reporting, logging, and any model call. **Never let "local" stand in for "private":** a tool that reads files locally and sends each to a model API has kept nothing local, and the brief must say so in words.
- **Credential surface.** What holds the credential, what scope it really has vs. needs, what can read it, what happens when it expires (loud or silent?).
- **Injection through inputs.** Third-party text flowing into merges, prompts, queries, or HTML. If there's a model in the tool: what does a hostile or merely weird input do to its instructions? If output lands in a spreadsheet: formula injection (`=`, `+`, `@` prefixes). If in email: header/content injection.
- **Other people's data at rest.** PII the tool stores, and where. Name what's already true before the tool (the brief often inherits an existing situation) versus what the tool newly creates — findings, not moralizing; the employee's asks already route the policy question to the right approver.
- **The blast radius of the tool being wrong or compromised.** What's the worst thing this tool can do with the access it has? Drafts-only designs bound this well — verify the design actually can't act, rather than merely doesn't.

**And carry the honest bound:** this lane is the one a self-pass is worst at. Where the surface is real, the lane's own report must say an external review is the control it cannot be.

## Lane 6: Verification obligations — does the plan prove anything?

The brief names its shape(s) in `How to verify:` — deterministic, monitor, generative, or a mix per part. This lane audits the verification plan against the obligations of each shape (full checklist in `fixtures.md`):

- **Deterministic** → replay fixtures exist, are real (actual inputs → the output actually sent), specify byte comparison, and **cover the variants Lane 1 found** — a replay suite covering 3 of 12 layouts verifies a quarter of the tool.
- **Monitor** → replayed state exists or is specified (reconstruct the day it went wrong, run the job, check the output) **plus the silence test**: kill it and confirm the silence is visible. The liveness stamp ("last checked 08:00") is in the v1 spec, not a later phase — a monitor without it doesn't ship.
- **Generative** → the sealed set is real and actually sealed: path exists, count and hash match the brief, **contents unread by this run**, and the plan names an isolated verification run whose input is the tool + sealed set and *not* the brief. "Sealed by promise" (one session pinky-swearing not to look) is a finding — report the limit honestly rather than upgrading it.
- **The refusal suite** — for every shape: do the acceptance criteria include the negative cases? Garbage, empty, wrong-format, truncated, subtly-wrong inputs must produce a **visible refusal**, never degraded output that looks fine. Criteria that only name happy paths admit a trivially-passing build.
- **Criteria robustness.** For each must-be-true, ask: what's the laziest build that technically satisfies it? If a stub passes, the criterion is a finding.

This lane usually authors the most fixture candidates. In Quick mode it doesn't run separately — Lanes 1 and 2 absorb its checklist.

## Lanes deliberately not in the catalog

- **Alternative approaches / "do nothing" baseline** (upstream's design-evaluation Lane 4): serve the brief's recorded selection or authorization without market relitigation. Redefining its shape is outside this lane, and "do nothing" is an evaluation decision wearing a lane costume. If a finding genuinely requires a different shape, that's a route-back.
- **Market / demand / adoption anything**: not harden's decision and not a substitute for the recorded evaluation/build states. Not a lane, not a sub-question, not a sentence.
- **Timeline/effort estimation as its own lane** (upstream Lane 5): the cost claim is audited inside Lane 3; `sequence` owns the build plan.

## Combining and splitting

Most real briefs mix shapes and surfaces — verify each part in its shape, and let one lane cover a small surface rather than spinning a thin lane per part. If the brief is big enough that a lane would exceed one focused analysis (e.g., three distinct input sources each with variants), split Lane 1 by source rather than adding new lane types.
