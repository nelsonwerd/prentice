# Fixtures and the per-shape verification obligations

Two jobs live in this file: how to author the adversarial fixtures harden ships under `build/fixtures/`, and the checklist for auditing the brief's verification plan shape by shape (Lane 6's spine).

## What a fixture is

A fixture is **an input paired with the behavior that counts as surviving it.** Not a test script — `make` writes those — but the raw material a test is made of, in a shape `make` can run against the built tool **without reading harden's reasoning.** That last clause is the seam contract: if understanding a fixture requires reading `build/harden/02-silent-wrong.md`, the fixture is broken.

```
build/fixtures/
├── MANIFEST.md
├── truncated-march-export.csv
├── carrier-layout-07.csv
├── price-changed-after-quote/      ← multi-file fixtures get a directory
│   ├── row-before.csv
│   └── row-after.csv
└── ...
```

### MANIFEST.md — one entry per fixture, this shape

```markdown
## <fixture-file-or-dir>
- **What it is:** <one sentence — "the March export truncated at 80%, mid-row">
- **Real or constructed:** <real (a copy/variant of the employee's actual file) / constructed (say from what)>
- **Data class:** <real/private / synthetic / deidentified for commit>
- **Version-control disposition:** <never commit / eligible only under the tool repo's explicit allowlist>
- **Content digest:** <SHA-256 of file bytes / canonical directory digest, with the exact algorithm or command>
- **Retention / deletion:** <the brief's duration + deletion owner/path>
- **Deidentification approval:** <not applicable / named authorized data or security owner + date + exact artifact digest + exact repository/history destination>
- **Suitable scan:** <not applicable / scanner + version/ruleset + covered data/file types + date + explicit passing result; never print matched values>
- **Surviving behavior:** <exactly what the built tool must do. For refusal fixtures:
  "a loud, visible stop that names the problem — ANY output at all is a defect."
  For correctness fixtures: the specific right output or the specific loud flag.>
- **Shape:** deterministic / monitor / generative / refusal
- **From finding:** <HARDEN.md finding id, severity>
```

The **surviving behavior** line is the behavioral contract. Write it so a build agent that has read nothing else can turn it into a pass/fail check. "Handles it gracefully" is not a behavior; "refuses, and the refusal names the file and the row where parsing stopped" is.

The **content digest** is the identity contract. For one file, hash its bytes with SHA-256. For a directory fixture, use a canonical directory digest: reject symlinks, special files, and paths containing tabs or newlines; sort every included regular file by its relative POSIX path; form one UTF-8 record per file as `<relative-path>\0<file-sha256>\n`; then SHA-256 the concatenated records. Name exclusions explicitly; never include a digest field in its own digest. Before opening a fixture, confirm its permission, deadline, and classification; then recompute and compare the digest. Missing, deleted, expired, or mismatched evidence means **NOT RUN — private validation unavailable** until deliberately reauthorized. Capture neutral fixture ID, expected digest, observed digest, and match in the private verification evidence without printing contents.

This is separate from the source receipt. A `tree-exact` receipt binds the command to the sealed source tree; it does **not** bind a private fixture outside that tree. The digest comparison is the evidence that names that external input. Report both, never translate one into the other.

## The refusal suite — principle over checklist

The negative half of acceptance. Upstream build tooling has no concept of it; here it is a locked requirement: **garbage, empty, wrong-format, truncated, and subtly-wrong inputs must produce a VISIBLE refusal — never degraded output that looks fine.**

The principle that generates the fixtures: **break their real file the way their world breaks it.** Don't enumerate abstract corruptions — start from the employee's actual artifacts and the actual ways files go wrong around them:

- **Garbage**: the wrong file with the right extension (the invoice PDF renamed .csv; last year's version).
- **Empty**: zero bytes, or headers with no rows — the export run before the data landed.
- **Wrong format**: the same data saved by the other tool — different delimiter, encoding, BOM, the vendor's "new improved" layout.
- **Truncated**: stopped mid-row at 80% — the download that died. The subtlest of these still parses.
- **Subtly wrong**: the highest-value class and the hardest to author. One column shifted. A stale copy that's internally consistent but two weeks old. A plausible price that isn't the quoted one. A date column that silently changed locale. These are the inputs where "any output at all is a defect" bites hardest, because the degraded output *will* look fine.

Author at least one fixture per class for every input the tool reads. Where Lane 1 found N real-world variants and the exposed examples cover fewer, the gap is fixtures too — variant coverage is a correctness matter, not just a refusal one.

**What refusing must look like** (fold into surviving-behavior lines; these come from the tool-safety defaults the whole pipeline runs on):
- The stop is **loud and in front of the user** — never a log line, never a silently-skipped row.
- It **says what it processed and what it couldn't** — "read 48 of 50 files" is a refusal trigger, not a footnote.
- It **never ships partial output dressed as complete output.**

## Per-shape verification obligations (Lane 6's checklist)

The brief names its shape(s) in `How to verify:` — the build cannot infer them, and neither can you; audit what's declared, and flag a missing or wrong declaration as a Blocker. Most real tools mix shapes: **verify each part in its shape.**

### Deterministic (no model in this part)

The control is a **replay fixture**: the employee's real inputs → the real output they actually sent → byte comparison. It is visible to the local build, not sealed — "tuning to the answer" IS the spec here; if the template is supposed to reproduce the message they actually sent, reproducing it exactly is correct behavior, not overfitting. **Visible to the build does not mean safe to commit.** The real pair remains private. A synthetic derivative may be allowlisted; a deidentified derivative needs every approval and scan field in the manifest above.

Audit:
- [ ] Replay fixtures **exist** and are the real pair (actual input, actual sent output) — not reconstructions from memory. **Greenfield exception:** when the tool's input surface is new (the input format didn't exist before the tool — expected to be common (unverified — n=1)), the real half of the pair is the **sent output**; the input is constructed to carry the real values it was sent from, and the manifest says so (`constructed input — real sent output`). What is never acceptable is reconstructing the *output* side from memory.
- [ ] Every still-permitted file or multi-file fixture has the manifest digest above; permission/deadline/classification and the exact expected/observed match are checked before opening it. Missing, deleted, expired, or mismatched evidence is NOT RUN.
- [ ] Comparison is specified as **byte comparison** (or an explicitly-named normalization, e.g. "modulo the date field," with the exemption justified).
- [ ] **Coverage matches Lane 1's variant inventory.** Replays covering 3 of 12 known layouts verify a quarter of the tool; the gap is a High and a fixture-authoring job.
- [ ] The isolation that matters is named: the build may not read the expected output while writing the transform.
- [ ] Where fidelity permits, a synthetic smoke/regression subset is eligible for the tool repo's allowlist; anything that still requires the private fixture is labeled as private validation, not implied to run from a clean checkout.

### Monitor (it watches for something)

The hardest shape, because **a monitor's answer key is an event that didn't happen.** Two obligations, both mandatory:

- **Replayed state:** reconstruct the state as it stood the day the thing went wrong (the brief's gate-2 incident is the canonical case), run the job against it, check it says the right thing. Audit: is the day-it-went-wrong reconstruction specified concretely enough to build? If diagnose captured the incident, the fixture is buildable; build it.
- **The silence test:** kill the monitor and confirm the silence is VISIBLE. A monitor that fails quietly passes every other test you can write. Audit: does the design carry a **liveness stamp** ("last checked 08:00") on every report, *in v1*? **If the liveness stamp isn't in the v1 spec, the monitor doesn't ship** — this is never a later phase, never a nice-to-have. A dead monitor and an all-clear must never look the same, and if they do, that's a Blocker, folded into the brief's must-be-trues in Phase 5.
- Also audit the double-fire: what happens when the trigger runs twice, or resumes after three missed days? (Lane 2's territory; the fixture lands here.)

### Generative (a model in this part)

The control is a **sealed set**: real examples the build NEVER sees, verified in an isolated run whose input is the tool + the sealed set — not the brief.

Audit — all of it **without opening the sealed files**:
- [ ] The sealed path exists; the count matches the brief; the hash matches if the brief recorded one (if it didn't, record one now — from the file bytes, not the contents rendered).
- [ ] The exposed/sealed split is real — exposed examples exist separately and the sealed ones aren't duplicated among them (compare hashes/sizes, not contents).
- [ ] The plan names an **isolated verification run**: fresh context, given only the tool and the sealed set. "I won't look at the other six" within one session is a promise, not a control — if true isolation isn't available in the runtime, the brief must say so rather than claim a guarantee it doesn't have. Report the honest limit; never upgrade it.
- [ ] **A sealed set for a part that no longer exists is a fossil.** If the brief carries sealing machinery for a generative feature that was cut, that's a stale claim — flag it for retraction in Phase 5, don't inherit obligations for a tool that isn't being built.

### Criteria robustness — every shape

For each acceptance criterion and must-be-true, ask: **what is the laziest build that technically satisfies this?** If a stub passes — a "Configured ✓" that means an env var exists, a "tests pass" with tests that assert nothing, a monitor that emails "all good" unconditionally — the criterion is the finding. Rewrite it in Phase 5 so the trivial implementation fails.

## Handling the employee's real data

Fixtures are often derived from real files carrying real PII (names, addresses, amounts). Rules:
- Real/raw fixtures live in `build/fixtures/` as **private workspace evidence**. They may be used by local checks; they are never copied into `tool/`, staged, committed, pushed, or published. Their retention and deletion follow the exact rule in the brief; a useful regression case does not authorize keeping private data longer.
- Where a fixture's adversarial value doesn't depend on the real values, construct it with obviously fake values and classify it **synthetic**. Synthetic fixtures may enter the tool repository only through its recorded allowlist and after the suitable staged-content scan.
- Where structural realism matters, a separately produced derivative may be considered **deidentified for commit** only with the manifest's named authorized owner/date, exact artifact digest, exact repository/history destination, scanner/version/ruleset/covered types, and explicit passing result. Record what changed and what fidelity may have been lost. Renaming or deleting obvious names is not enough; **the builder cannot self-approve.** Missing, unsuitable, incomplete, or non-passing evidence makes the derivative ineligible for source history.
- For durable regression after private evidence expires, create a synthetic fixture or use a still-current approved deidentified derivative. Where fidelity permits, the tool repository carries a committed synthetic smoke/regression subset. Where it does not, label the omitted cases and the private validation they require; never make the source checkout appear to prove them.
- The manifest records classification and disposition; never infer safety from location, file extension, a previous approval, or a scanner pass.
- Never put credential or secret values in fixtures, expected outputs, manifests, logs, or receipts. Use placeholders that cannot authenticate.
- Sealed files are never fixture sources. Ever.
