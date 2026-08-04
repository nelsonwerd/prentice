# The Refusal Suite — negative acceptance

Everything else in the loop checks that good input produces the right output. This file checks the other half, and for a Prentice tool the other half is where the danger lives: **the end user is non-technical, will feed the tool whatever their real week produces, and cannot tell degraded output from correct output.** The person this tool is for stopped doing the check by hand — that's why they wanted it. A tool that is right on clean input and quietly plausible on broken input is worse than no tool.

## The principle

> **Break their real file the way their world breaks it. The only correct behavior is a loud stop. Any output at all is a defect.**

Principle over checklist. The categories below are where to start, not where to finish — the real suite comes from *their* world: the export that truncates, the column a colleague renames, the file saved in the wrong format, the row filled in halfway. `harden` already attacked the design and left adversarial input fixtures under `build/fixtures/` with a `MANIFEST.md` naming each fixture's **surviving behavior**. Run every **still-permitted, digest-matching** fixture and assert that line. Check permission, deadline, classification, and digest before opening bytes. Missing, deleted, expired, or mismatched means **NOT RUN — private validation unavailable**; an older result never substitutes. Then add what building the tool taught you that harden couldn't know.

## The categories

Feed the tool, at minimum:

- **Garbage** — the wrong kind of thing entirely: a PDF where a CSV goes, binary noise, another tool's export.
- **Empty** — zero-byte file, empty sheet, blank required field, no rows.
- **Wrong format** — right kind, wrong dialect: renamed columns, shifted headers, a different delimiter, last year's template.
- **Truncated** — the first half of a real input, cut mid-record. Exports and copy-pastes do this constantly.
- **Subtly wrong** — the dangerous one: a real input with one load-bearing value missing, duplicated, or from the wrong context. It parses fine. Everything downstream would run. The output would look exactly right.

The subtly-wrong case is the whole reason this suite exists. Garbage usually crashes on its own; subtly-wrong sails through and ships a document with a hole where a fact should be.

## What "refusal" means — and doesn't

A refusal is **visible, plain, and specific**: what it got, what it needed, and that it did **not** produce the thing. Written for the person whose job it is, not for whoever built it.

- *"Row 4 has no price — I can't build that document until it's filled in"* is a refusal. Note the register: it names the row, names what's missing, and says plainly that it produced nothing.
- The same document with a **blank** where the price should be is **not** a refusal — it's the defect this suite exists to catch, wearing finished clothes. A blank on a page of filled fields is exactly how a hand-typed value becomes a wrong one nobody notices.
- An unexplained stack trace is a *loud* stop but a failed one for this audience — it stops, which beats silence, but the acceptance bar is a stop the end user can read and act on.
- An output with the bad part quietly skipped — "processed 11 of 12" said nowhere — is the worst outcome on this page: degraded output that looks fine. Completeness accounting (see `verification.md`) is what makes this one impossible.

**Any output at all on broken input is a defect.** Not a partial pass, not "graceful degradation," not "it did its best." If a degraded mode is genuinely wanted, the brief has to say so — and the degraded output has to announce its own degradation louder than its content.

## For stochastic parts: refusal is a RATE — sample it

A deterministic tool refuses a broken input every time or never; run each fixture once. A part with a model in it refuses *probabilistically* — the same broken input can be refused on one run and confabulated into plausible output on the next.

So for any stochastic part: **run each broken-input fixture N times (N≥10) and count.**

- **Refused 7/10 is a FAILURE.** Three of those ten runs shipped plausible output built on a broken input, and the end user can't tell which three. "Mostly refuses" is not a safety property.
- The bar is **N/N on the sample**, and the ledger states the sample size — "refused 10/10 (n=10)" is an honest claim; "refuses bad input" without an n is not.
- A sampled pass is still a sample: say so. N/N bounds the failure rate; it doesn't zero it. If the brief's stakes demand more, that's a bigger n or a deterministic guard *in front of* the model (validate the input before the model ever sees it — usually the right fix anyway, and it turns the rate back into a property).

## Running the suite

- It runs in **step 4 (Check) of every iteration** — not once at the end — over every fixture still permitted at that moment. A rebuild can un-fix a refusal as easily as it fixes a flow.
- Before opening any fixture, verify manifest permission, deadline, and classification; then recompute its file SHA-256 or canonical directory digest. Missing, deleted, expired, or mismatched means NOT RUN. Capture neutral fixture ID, expected digest, observed digest, and match in the private verification evidence without printing contents.
- Every still-permitted fixture invocation runs from `TOOL_REPO`, with the digest match inside the harness that exercises the bytes; the assertion is "refused, visibly, with the right message" and it's as machine-checkable as any exit code. Wrap only recorder-safe invocations. A private path/value/identifier that would persist in recorder state makes that invocation direct and explicitly UNRECEIPTED.
- Each refusal fixture is an acceptance criterion in the ledger: fixture name + digest match → expected refusal → fired / didn't. A fixture with no assertion is a demo, not a check.
- New breakage discovered mid-loop (the build taught you a way their world breaks that harden missed) becomes a **new classified fixture**, not a mental note. Real/private fixtures remain in the case workspace only for the brief's authorized retention period. Durable regression uses a synthetic fixture where fidelity permits; a deidentified derivative is source-history-ineligible without the canonical named-owner/date, exact-digest, exact-destination, scanner/version/ruleset/coverage, and explicit-passing-result record.
- Where fidelity permits, keep a committed synthetic smoke/regression subset that a clean checkout can run. Name every case that still requires private validation; a smaller public-safe suite must never be described as the whole evidence set.

## Pitfalls

- **Testing only garbage.** Garbage crashes by itself. The suite earns its keep on subtly-wrong.
- **Calling a crash a refusal.** It stopped, which beats silence — but grade it honestly: the end user can't read it, so it's a defect (Medium, not Blocker) until the stop speaks their language.
- **Letting the model grade its own refusal.** "I would refuse this" is not a run. Run it.
- **Averaging a rate into a pass.** 7/10 is a failure. So is 9/10. Fix the tool, don't lower the bar.
- **Softening a refusal into a warning above real output.** A warning banner over a generated document is output with a disclaimer, and nobody reads disclaimers — the brief's own words: buried in a disclaimer nobody reads. Refuse means no output.
