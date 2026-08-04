# Validation and evidence status

This is an evidence ledger, not a quality certificate. It separates repository mechanics, author report, behavioral samples, outside use, and independent production assurance. A stronger evidence class never follows automatically from a weaker one.

**Last reviewed:** 2026-08-04

## Current snapshot

| Evidence class | Status | What it supports |
|---|---|---|
| **Repository mechanics** | VERIFIED | All six intended skill spines and their referenced files are present; manifests parse; selected contract vocabulary is mechanically checked. |
| **Isolated installation** | VERIFIED | `./scripts/verify.sh` has completed an isolated Claude plugin installation on the reviewed source tree. |
| **Author self-use** | AUTHOR-REPORTED, n=1 | Drew reports one end-to-end author self-run. It is evidence of self-use, not outside usability or reliability. |
| **Published run evidence** | NONE | No published run artifact or receipt set independently verifies the self-run's detailed claims. |
| **Outside participants** | NONE | No outside participant has completed `diagnose` or the full system. |
| **Department synthesis** | NOT IMPLEMENTED | There is no department skill, cohort result, or department-level capability evidence. |
| **Independent technical assurance** | NONE | No independent review establishes generated-code correctness, security, scalability, deployment safety, or production readiness. |
| **Adoption** | NONE | No sustained outside use, retention, or organizational outcome is demonstrated. |

“Structurally complete” means the intended instruction files, references, manifests, and optional execution chain exist. It does **not** mean the instructions reliably produce the intended behavior.

## Evidence classes used here

- **VERIFIED mechanics** — a command or repository inspection directly establishes a narrow structural fact.
- **AUTHOR-REPORTED** — Drew reports an event, but no source artifact available here independently demonstrates its details.
- **BEHAVIORAL SAMPLE** — a fresh run on a named scenario demonstrates what one model/context did once; it is not a general guarantee.
- **OUTSIDE OBSERVATION** — a participant other than the author used the method under recorded conditions.
- **USER ACCEPTANCE** — the intended user tried the resulting intervention and accepted or rejected it in real work.
- **INDEPENDENT TECHNICAL ASSURANCE** — a qualified reviewer who did not generate the implementation assessed the relevant code, security, infrastructure, and operating risks.
- **ADOPTION EVIDENCE** — repeated real use or an organizational outcome measured over time.

## What `scripts/verify.sh` establishes

The verifier makes narrow, mechanically checkable claims. On a fully green run it checks:

- both plugin manifests parse and selected schema fields have the expected type;
- the marketplace name does not collide with the known `idea-to-ship` marketplace name;
- skill descriptions fit the client limit and skill names match their directories;
- referenced files exist and reference files are loaded by their skill spine;
- public-hygiene patterns and selected retired instruction phrases are absent from the checked surfaces; private-vocabulary review remains an external release check so the repository does not publish the denylist itself;
- the three workflow states, pre-disclosure boundary, untrusted-content language, provenance fields, revision reset, role vocabulary, and receipt order retain selected required strings;
- selected markers for the private-evidence/source-history boundary, two-root command contract, fixture digest/lifecycle fields, and staging safeguards remain present, while named retired phrases remain absent;
- an isolated plugin installation succeeds when the Claude CLI is available.

These are **text and installation integrity checks**. They do not prove that a model obeys the prose, that a diagnosis is useful, that an artifact is deidentified, that the checks chosen for a generated tool are sufficient, or that resulting code is correct or safe.

## Receipts and test results

A receipt records that a command ran against a particular tree or state. It does not prove that the command was sufficient, that the claim was framed correctly, or that the code is correct. `tree-exact` means *recorded against the sealed tool-source tree*, never *proven correct*. A private fixture outside that tree is separate evidence and must be identified by the digest captured inside the same exercising harness.

The build skills instruct an operator to label unwrapped checks **UNRECEIPTED**, report grades verbatim, and preserve the order `run → claim → commit → seal → strict verify`. Even a correctly formed receipt remains execution evidence, not independent review.

The author-reported self-run has no published artifact or receipt set here. Do not reconstruct a stronger claim from commit identity, passing tests, or prose that describes what a run was intended to do.

## Sanitized chronology

1. `diagnose` was created as a conversational workflow-discovery skill.
2. `harden`, `sequence`, `make`, `snag`, and `commission` were added as an optional execution chain derived from `idea-to-ship` patterns.
3. Drew reported one end-to-end author self-run; case-derived material was subsequently scrubbed from the current tree.
4. The diagnose-first repair made the workflow case independently complete, separated accuracy/evaluation/build states, corrected role ownership, and added target-workspace evidence boundaries.
5. No outside pilot or department cohort has followed yet.

This chronology intentionally excludes real names, briefs, transcripts, fixtures, and private workflow vocabulary.

## Validation ladder

| Stage | Evidence required | Current state | Claim it would earn |
|---|---|---|---|
| 0. Repository mechanics | Green verifier and isolated install | Complete | Installable instruction structure on the tested environment |
| 1. Author self-run | Recorded author run with an inspectable sanitized artifact | Reported; artifact not published | Inspectable self-use sample |
| 2. Outside `diagnose` | One or more cleared outside sessions with participant-confirmed cases | Not begun | Outside behavioral evidence for the primary hypothesis |
| 3. Manual cohort comparison | Multiple confirmed, sanitized, aggregation-permitted cases compared by an operator | Not begun | Evidence about whether department comparison fields are stable |
| 4. Authorized outside build | Exact-revision authorization, named build owner, recorded checks, and user acceptance | Not begun | One outside construction and acceptance case |
| 5. Independent assurance | Independent code/security/operations review on the actual target | Not begun | Assurance limited to that reviewed implementation and environment |
| 6. Adoption | Repeated use and measured workflow outcome over time | Not begun | Evidence of practical value in that context |

## Highest-priority hypothesis

`diagnose` is the first claim worth testing outside the author because it can produce value without construction: a participant-confirmed, evidence-linked account of a workflow and the best-supported intervention, including a non-tool outcome. That makes it the strongest **candidate** wedge in the system. It is not yet a proven wedge.

A useful outside test should record whether the participant corrected substantive claims, whether sources and inference limits stayed traceable, whether affected handoffs were represented fairly, and whether the case remained useful when it ended without software.

## Department synthesis boundary

Department synthesis is not implemented. The future experiment described in [`DESIGN.md`](DESIGN.md) must remain manual until outside cases reveal stable comparison fields and failure modes. It may not rank employees, flatten dissent, aggregate cases without permission, or convert a pattern directly into evaluation selection or build authorization.

## Publishing future evidence

Publish only a synthetic artifact or a deidentified artifact whose exact digest and publication destination the participant, data owner, and organization have authorized and whose suitable scan passed. Preserve the evidence class, model/client/environment, revision, what was not run, and what remains unknown. A polished case study without those limits is marketing, not validation.

See [`DATA-HANDLING.md`](DATA-HANDLING.md) before retaining, comparing, or publishing any case material.
