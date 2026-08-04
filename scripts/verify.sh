#!/usr/bin/env bash
# Verification for Prentice. Everything here is mechanically checkable — the
# skills themselves are prose and make no claims this script can settle.
#
# Two rules this script has to live by, because the project's whole subject is
# checks that lie:
#   1. A check that cannot run must never print PASS. It prints SKIP and the
#      run grades nonzero. A pass over an absent condition is the exact bug
#      this project exists to prevent.
#   2. Every check runs. `set -e` would abort at the first failure and hide the
#      rest, so checks are wrapped rather than allowed to kill the shell.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
skipped=0

say()  { printf '%s\n' "$*"; }
pass() { say "  PASS  $1"; }
bad()  { say "  FAIL  $1"; fail=1; }
skip() { say "  SKIP  $1 — $2"; skipped=1; }
# run <description> <<'EOF' ... python ... EOF
run()  { local d="$1"; if python3 - ; then pass "$d"; else bad "$d"; fi; }

say "== manifests parse =="
run "plugin.json is valid JSON" <<'EOF'
import json; json.load(open('.claude-plugin/plugin.json'))
EOF
run "marketplace.json is valid JSON" <<'EOF'
import json; json.load(open('.claude-plugin/marketplace.json'))
EOF

say "== plugin manifest schema =="
run "repository field is a string" <<'EOF'
import json, sys
m = json.load(open('.claude-plugin/plugin.json'))
r = m.get('repository')
if not isinstance(r, str):
    sys.exit(f"repository must be a string, got {type(r).__name__}")
EOF

say "== marketplace name does not collide with idea-to-ship =="
# Asserted against the known constant, NOT against a file on one laptop.
# The earlier version probed <user-home>/idea-to-ship and, when absent, printed
# PASS having compared nothing — a green check over a condition that never ran.
run "marketplace name is not 'nelsonwerd' (idea-to-ship owns it; a collision silently overwrites one)" <<'EOF'
import json, sys
mine = json.load(open('.claude-plugin/marketplace.json'))['name']
if mine == 'nelsonwerd':
    sys.exit("marketplace name collides with idea-to-ship — adding both under one name "
             "silently overwrites the first and still prints a success checkmark")
EOF

say "== skill descriptions within the 1024-char cap =="
run "every SKILL.md description <= 1024 chars (over truncates the trigger surface)" <<'EOF'
import re, sys, glob
bad = []
for p in sorted(glob.glob('skills/*/SKILL.md')):
    t = open(p).read()
    m = re.search(r'^description: >-\n((?:  .*\n)+)', t, re.M)
    if not m:
        bad.append(f"{p}: no folded description"); continue
    n = len(' '.join(l.strip() for l in m.group(1).strip().split('\n')))
    if n > 1024:
        bad.append(f"{p}: {n} chars")
if bad:
    sys.exit("; ".join(bad))
EOF

say "== skill name matches its directory =="
run "every SKILL.md name field matches its folder" <<'EOF'
import re, sys, glob, os
bad = []
for p in sorted(glob.glob('skills/*/SKILL.md')):
    want = os.path.basename(os.path.dirname(p))
    m = re.search(r'^name:\s*(\S+)\s*$', open(p).read(), re.M)
    got = m.group(1) if m else None
    if got != want:
        bad.append(f"{p}: name '{got}' != folder '{want}'")
if bad:
    sys.exit("; ".join(bad))
EOF

say "== every reference named in a SKILL.md exists =="
run "backticked lowercase references/*.md paths in skill spines exist" <<'EOF'
import re, os, glob, sys
missing = []
for p in sorted(glob.glob('skills/*/SKILL.md')):
    d = os.path.dirname(p)
    for ref in sorted(set(re.findall(r'`(references/[a-z0-9-]+\.md)`', open(p).read()))):
        if not os.path.exists(os.path.join(d, ref)):
            missing.append(f"{p} -> {ref}")
if missing:
    sys.exit("; ".join(missing))
EOF

say "== no reference file is orphaned =="
run "every references/*.md is loaded by its spine" <<'EOF'
import glob, os, sys
orphans = []
for spine in sorted(glob.glob('skills/*/SKILL.md')):
    d = os.path.dirname(spine)
    body = open(spine).read()
    for r in sorted(glob.glob(os.path.join(d, 'references', '*.md'))):
        if f"references/{os.path.basename(r)}" not in body:
            orphans.append(r)
if orphans:
    sys.exit("orphaned (never loaded): " + "; ".join(orphans))
EOF

say "== public-release hygiene =="
run "no identifying home paths, email addresses, private keys, or common token shapes" <<'EOF'
import glob, re, sys

paths = sorted(glob.glob('skills/**/*.md', recursive=True)) + [
    'README.md', 'docs/DESIGN.md', 'docs/VALIDATION.md', 'docs/DATA-HANDLING.md',
    'scripts/verify.sh', '.claude-plugin/plugin.json', '.claude-plugin/marketplace.json',
]
patterns = {
    r'/(?:Users|home)/(?!<[^>]+>)[^/\s]+/': "identifying user-home path",
    r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b': "email address",
    r'-----BEGIN (?:RSA |OPENSSH |EC )?PRIVATE KEY-----': "private key",
    r'\bAKIA[0-9A-Z]{16}\b': "AWS access key shape",
    r'\bgh[opurs]_[A-Za-z0-9_]{20,}\b': "GitHub token shape",
    r'\bsk-[A-Za-z0-9_-]{20,}\b': "API token shape",
}
hits = []
for path in paths:
    body = open(path).read()
    for pattern, why in patterns.items():
        if re.search(pattern, body, re.I):
            hits.append(f"{path} ({why})")
if hits:
    sys.exit('; '.join(hits))
EOF

say "== no retired vocabulary in shipped instruction text =="
run "named retired 'fenced' language is absent from skills/ and README" <<'EOF'
import glob, re, sys
# 'fenced' is the REVERSED build-then-wire position: wiring defers activation,
# never construction. It must not survive in text that instructs a model.
# docs/DESIGN.md is exempt by design — the reversal log's whole job is to name
# the position it retired, in the past tense. ('fence' for Out-of-scope is a
# different, live use and is not matched.)
hits = []
for p in sorted(glob.glob('skills/**/*.md', recursive=True)) + ['README.md']:
    for i, line in enumerate(open(p), 1):
        if re.search(r'\bunfenced\b|\bfenced\b', line):
            hits.append(f"{p}:{i}")
if hits:
    sys.exit(f"{len(hits)} site(s): " + "; ".join(hits[:5]) + (" …" if len(hits) > 5 else ""))
EOF

say "== workflow instruction contract =="
# These are narrow text-integrity checks. They catch known contract regressions;
# they do NOT prove that a model will follow the instructions or that a run is safe.
run "required diagnose instruction markers are present" <<'EOF'
import sys

required = {
    'skills/diagnose/SKILL.md': [
        'Confirmed accurate',
        'Selected for evaluation',
        'Authorized for build',
    ],
    'skills/diagnose/references/gates.md': [
        'before the opening work question',
        'stop real-work disclosure',
    ],
    'skills/diagnose/references/conversation.md': [
        'untrusted content',
        'stable ID',
        'model inference — unsupported',
    ],
    'skills/diagnose/references/brief.md': [
        '**Brief ID:**',
        '**Revision:**',
        '## Corrections and unresolved contradictions',
    ],
}
missing = []
for path, needles in required.items():
    body = open(path).read()
    for needle in needles:
        if needle not in body:
            missing.append(f"{path}: missing {needle!r}")
if missing:
    sys.exit('; '.join(missing))
EOF

run "named retired go-button, categorical-IT, and zero-run phrases are absent" <<'EOF'
import glob, re, sys

patterns = {
    r'approval is the go button': "approval conflated with build authorization",
    r'the employee hits go': "employee confirmation conflated with build authorization",
    r'there is no queue in front of the build': "evaluation/prioritization categorically removed",
    r'IT never builds': "IT role stated categorically",
    r'IT does not run the build': "IT role stated categorically",
    r'IT does not evaluate briefs': "IT role stated categorically",
    r'IT runs the build': "IT role stated categorically",
    r'zero proven runs': "stale zero-run claim",
    r'has never once run': "stale zero-run claim",
    r'snag has none': "stale zero-run claim",
    r'Selected for evaluation <date, by whom>': "evaluation selection not bound to an exact revision",
}
hits = []
for path in sorted(glob.glob('skills/**/*.md', recursive=True)):
    for line_no, line in enumerate(open(path), 1):
        for pattern, why in patterns.items():
            if re.search(pattern, line, re.I):
                hits.append(f"{path}:{line_no} ({why})")
                break
if hits:
    sys.exit('; '.join(hits[:8]) + (' …' if len(hits) > 8 else ''))
EOF

run "required receipt-order and retry markers are present; named wrong orders are absent" <<'EOF'
import glob, re, sys

path = 'skills/snag/references/receipt-discipline.md'
body = open(path).read()
ordered = [
    '1. **Run each recorder-safe load-bearing verification from `TOOL_REPO`**',
    '2. **Claim from `TOOL_REPO`**',
    '3. **Allowlist stage and inspect with `git -C "$TOOL_REPO"`, then commit**',
    '4. **Seal from `TOOL_REPO`**',
    '5. **Strict-verify from `TOOL_REPO`**',
]
positions = [body.find(item) for item in ordered]
if any(pos < 0 for pos in positions) or positions != sorted(positions):
    sys.exit(f"{path}: per-unit receipt order is missing or reordered")

required_retry = {
    'skills/make/SKILL.md': [
        'If source changed, commit the fix before re-sealing',
        'never invent an empty commit',
    ],
    path: [
        'If source changed, commit the fix before re-sealing',
        'never invent an empty commit',
    ],
}
missing = []
for candidate, needles in required_retry.items():
    candidate_body = open(candidate).read()
    for needle in needles:
        if needle not in candidate_body:
            missing.append(f"{candidate}: missing retry marker {needle!r}")
if missing:
    sys.exit('; '.join(missing))

wrong = [
    r'claim, seal, verify, commit',
    r'claim[^\n.]{0,80}seal[^\n.]{0,80}(?:strict[- ]?verify|verify --strict)[^\n.]{0,80}(?:then|→)[^\n.]{0,30}commit',
    r'(?:strict[- ]?verify|verify --strict)[^\n.]{0,50}(?:then|→)[^\n.]{0,30}commit',
]
hits = []
for candidate in sorted(glob.glob('skills/**/*.md', recursive=True)):
    for line_no, line in enumerate(open(candidate), 1):
        if any(re.search(pattern, line, re.I) for pattern in wrong):
            hits.append(f"{candidate}:{line_no}")
if hits:
    sys.exit("wrong receipt order: " + '; '.join(hits[:8]))
EOF

run "required revision-reset markers are present" <<'EOF'
import sys

pipeline = open('skills/commission/references/pipeline-playbook.md').read()
commission = open('skills/commission/SKILL.md').read()
harden = open('skills/harden/SKILL.md').read()
required = {
    'pipeline reset accuracy': 'Accuracy: Draft — needs reconfirmation' in pipeline,
    'pipeline reset evaluation': 'Evaluation: Not selected for <new revision>' in pipeline,
    'pipeline reset authorization': 'Build authorization: Not authorized' in pipeline,
    'commission exact revision binding': 'same exact revision' in commission,
    'harden exact revision binding': 'same revision' in harden,
    'diagnose evaluation exact revision binding': 'Selected for evaluation <date, exact revision, by whom>' in open('skills/diagnose/references/brief.md').read(),
}
missing = [name for name, present in required.items() if not present]
if missing:
    sys.exit('; '.join(missing))
EOF

run "required authority, audit, and non-PASS lifecycle markers are present" <<'EOF'
import glob, re, sys

required = {
    'skills/diagnose/SKILL.md': [
        'evaluation selection/prioritization',
    ],
    'skills/commission/SKILL.md': [
        'a valid build authorization does not become invalid merely because evaluation remains `Not selected`',
    ],
    'skills/harden/SKILL.md': [
        'Phase 5 and recorder use are disabled',
        'do not invoke the receipt tool or create its ledger/Git-note state',
        'NOT RUN — private validation unavailable',
    ],
    'skills/make/SKILL.md': [
        '../snag/references/receipt-discipline.md',
        'REVERTED / NOT LANDED',
    ],
    'skills/sequence/SKILL.md': [
        'NOT RUN — private validation unavailable',
    ],
    'skills/snag/SKILL.md': [
        'provisional commit',
        'Only PASS becomes a landed unit',
        'REVERTED / NOT LANDED',
    ],
    'skills/snag/references/snag-playbook.md': [
        'do not initialize during read-only preflight',
        'only PASS becomes LANDED',
        'REVERTED / NOT LANDED',
    ],
}
missing = []
for path, needles in required.items():
    body = open(path).read()
    for needle in needles:
        if needle not in body:
            missing.append(f"{path}: missing {needle!r}")
if missing:
    sys.exit('; '.join(missing))

retired = {
    r'working tool in ten minutes': "unsupported speed promise",
    r"they['’]d use it": "unsupported adoption claim",
    r'PASS is the only stop-condition that commits': "pre-seal commit contradiction",
    r'only PASS commits': "pre-seal commit contradiction",
    r'Never commit a non-PASS unit': "pre-seal commit contradiction",
    r'by resetting its own commits': "unsafe reset wording",
    r'that was decided at `diagnose`, by the employee': "diagnose treated as selection authority",
    r'Their own work product and internal notes → fine': "artifact clearance inferred from ownership",
}
hits = []
for path in sorted(glob.glob('skills/**/*.md', recursive=True)) + ['README.md']:
    for line_no, line in enumerate(open(path), 1):
        for pattern, why in retired.items():
            if re.search(pattern, line, re.I):
                hits.append(f"{path}:{line_no} ({why})")
                break
if hits:
    sys.exit('; '.join(hits[:12]) + (' …' if len(hits) > 12 else ''))
EOF

run "cross-skill receipt references resolve" <<'EOF'
import os, sys

path = 'skills/snag/references/receipt-discipline.md'
if not os.path.isfile(path):
    sys.exit(f'missing canonical receipt protocol: {path}')
for candidate in [
    'skills/make/SKILL.md',
]:
    if '../snag/references/receipt-discipline.md' not in open(candidate).read():
        sys.exit(f'{candidate}: canonical receipt reference missing')
for candidate in [
    'skills/make/references/loop-procedure.md',
    'skills/sequence/references/execution-guide.md',
    'skills/sequence/references/plan-template.md',
]:
    if '../../snag/references/receipt-discipline.md' not in open(candidate).read():
        sys.exit(f'{candidate}: canonical receipt reference missing')
EOF

say "== target-workspace source-history boundary =="
run "required source-history, cwd, lifecycle, and fixture-control markers are present" <<'EOF'
import sys

required = {
    'skills/commission/references/pipeline-playbook.md': [
        '`CASE_WORKSPACE`',
        '`TOOL_REPO`',
        'physically separate tree',
        'git -C "$TOOL_REPO"',
        '(cd "$TOOL_REPO" && didrun run -- …)',
        'explicit commit allowlist',
        'Missing, unsuitable, incomplete, or non-passing evidence means never commit',
        'Local source history still does not authorize push or publication',
        'does **not** erase history',
    ],
    'skills/harden/references/fixtures.md': [
        '**Data class:**',
        '**Version-control disposition:**',
        '**Content digest:**',
        '**Retention / deletion:**',
        '**Deidentification approval:**',
        '**Suitable scan:**',
        'the builder cannot self-approve',
        'committed synthetic smoke/regression subset',
        'Never put credential or secret values',
    ],
    'skills/sequence/references/plan-template.md': [
        '**Case workspace (`CASE_WORKSPACE`):**',
        '**Tool repository (`TOOL_REPO`):**',
        '**Case-evidence lifecycle:**',
        '**Durable synthetic suite:**',
        'CASE_WORKSPACE=<actual shell-quoted absolute CASE_WORKSPACE>',
        'TOOL_REPO=<actual shell-quoted absolute TOOL_REPO>',
        'UNRECEIPTED private check',
        '(cd "$TOOL_REPO" && didrun claim',
        'git -C "$TOOL_REPO" commit -m',
        '(cd "$TOOL_REPO" && didrun seal)',
        '(cd "$TOOL_REPO" && NO_COLOR=1 didrun verify --strict)',
    ],
    'skills/sequence/references/execution-guide.md': [
        'Never rely on ambient cwd',
        'same bytes before any tool output',
        'A separate earlier hash print is insufficient',
        'never `git add -A`',
        'Missing, unsuitable, incomplete, or non-passing evidence means never commit',
    ],
    'skills/snag/references/receipt-discipline.md': [
        'Stage by explicit allowlist',
        'Case evidence expires',
        '`refs/notes/didrun`',
        'Credential values never enter an artifact',
        'A sensitive commit is a hard stop',
    ],
    'skills/harden/SKILL.md': [
        '(cd "$TOOL_REPO" && didrun run -- <cmd>)',
        'run it directly and label it UNRECEIPTED',
    ],
    'skills/make/SKILL.md': [
        '(cd "$TOOL_REPO" && NO_COLOR=1 didrun verify --strict)',
        'NOT RUN — no safe recorder boundary',
    ],
}
missing = []
for path, needles in required.items():
    body = open(path).read()
    for needle in needles:
        if needle not in body:
            missing.append(f"{path}: missing {needle!r}")
if missing:
    sys.exit('; '.join(missing))
EOF

run "named private-fixture path spellings are absent from recorded run examples" <<'EOF'
import glob, re, sys

hits = []
for path in sorted(glob.glob('skills/**/*.md', recursive=True)):
    for line_no, line in enumerate(open(path), 1):
        if 'didrun run --' not in line:
            continue
        tail = line.split('didrun run --', 1)[1]
        if re.search(r'CASE_WORKSPACE|build/fixtures|private/', tail, re.I):
            hits.append(f"{path}:{line_no}")
if hits:
    sys.exit('private fixture path in recorded argv example: ' + '; '.join(hits[:12]))
EOF

run "named retired fixture, lifecycle, cwd-label, and source-history phrases are absent" <<'EOF'
import glob, re, sys

patterns = {
    r"check it in\s*[—-]\s*it['’]s a test": "real fixture directed into history",
    r'checked in, not sealed': "real fixture described as checked in",
    r'\bthe suite only grows\b': "unbounded fixture retention",
    r'stay forever as the regression suite': "unbounded fixture retention",
    r'regression test forever': "unbounded fixture retention",
    r'accumulate across runs': "unbounded fixture retention",
    r'publishable source': "local Git eligibility mislabeled as publication authority",
    r'private/publishable split': "local Git eligibility mislabeled as publication authority",
}
paths = sorted(glob.glob('skills/**/*.md', recursive=True)) + [
    'README.md', 'docs/DESIGN.md', 'docs/VALIDATION.md', 'docs/DATA-HANDLING.md'
]
hits = []
for candidate in paths:
    for line_no, line in enumerate(open(candidate), 1):
        for pattern, why in patterns.items():
            if re.search(pattern, line, re.I):
                hits.append(f"{candidate}:{line_no} ({why})")
                break
if hits:
    sys.exit('; '.join(hits[:12]) + (' …' if len(hits) > 12 else ''))
EOF

say "== plugin actually installs (isolated config) =="
if command -v claude >/dev/null 2>&1; then
  TMP="$(mktemp -d)"
  if (
    export CLAUDE_CONFIG_DIR="$TMP"
    claude plugin marketplace add "$(pwd)" >/dev/null 2>&1
    claude plugin install prentice@nelsonwerd-prentice 2>&1 | grep -q "Successfully installed"
  ); then pass "claude plugin install prentice@nelsonwerd-prentice"
  else bad "claude plugin install prentice@nelsonwerd-prentice"; fi
  rm -rf "$TMP"
else
  skip "plugin installs" "the 'claude' CLI is not on PATH"
fi

say ""
if [ "$fail" != 0 ]; then
  say "FAILURES ABOVE"
  exit 1
elif [ "$skipped" != 0 ]; then
  say "PASSED, BUT A CHECK WAS SKIPPED — this is not a green run."
  exit 2
else
  say "ALL PASS"
  exit 0
fi
