# Design Critique — the iterated visual loop (the *See* step in detail)

This is how the *See* step actually runs when **design/feel is load-bearing** — when the brief's design direction says the experience *is* part of what the employee is getting, not just a wrapper on it. It is **mandatory and iterated**: you render the running UI, critique it against the bar, emit design defects, and the rebuild fixes the top ones — *every* iteration, alongside the objective machine facts. A passing unit/coupling test **never** substitutes for this (that shortcut ships a build that works but doesn't *feel* designed).

**Most Prentice tools are plain utilities** (design not load-bearing) — for those you still glance at the rendered UI for "plain-but-clear / nothing broken," but this full ritual is optional; don't gold-plate. One thing survives even on a utility: **the safety surfaces must read.** The refusal message, the "processed 12 of 12" line, the staleness escalation, the liveness stamp — these carry the tool's honesty, and if a non-technical person can't parse them at a glance the tool is unsafe, not just unpolished. Check those every time; they're acceptance, not taste.

## Step A — render the real UI (compose real tools; don't hand-wave)

Render the *running* app — not a mock, not a description. Prefer an interactive renderer so you can actually click and play with it; fall back to scripted screenshots.

1. **Interactive renderer (preferred — you can drive it):**
   - **Preview MCP** — `preview_start` (boot the app), screenshot, click/fill to drive states + flows, console logs to catch errors. Best when available: you see *and* exercise in one place.
   - **Claude-in-Chrome** — navigate, screenshot, click, read the DOM/console.
   - **computer-use** — drive a real desktop app or browser when the above don't fit.
2. **Fallback (always available): a Playwright script** that launches the app (dev server or the built output served statically), navigates to each key state, sets each viewport, and screenshots. Capture console + page errors while you're there.
3. **No renderer at all?** Report the visual loop **NOT RUN**, and — because design is load-bearing — the design bar is **unmet**, so the run **cannot PASS** (it stops at BLOCKED/PLATEAU and hands off). **Never** fake a visual pass or infer "it probably looks fine."

## Step B — capture the matrix (states × viewports)

Don't screenshot one happy-path view and call it seen. Capture the **key states**:

- **empty** (no data yet) · **loading** · **error/refusal** (what the employee actually sees when input is broken — this state is load-bearing for every Prentice tool) · **filled** (realistic content, including long/overflowing values) · **hover** · **focus** (keyboard focus visible?) · plus any state the brief's promise depends on (stale/escalated, selected, disabled).

…across **≥2 viewports**: **mobile** (~375px) and **desktop** (~1280px+); add tablet if the brief cares. A layout that's clean on desktop and broken on mobile is a real defect, not a footnote.

## Step C — critique against TWO things

For each captured screenshot, critique against:

**(a) The brief's design direction** — does it match the intended feel, the stated principles, the way the employee described wanting to work? Without a substantive direction you're grading against your own taste, which is the monoculture — and for a Prentice tool, remember whose surface this is: it must read to the person whose job it is, not to whoever built it.

**(b) General design craft** — the heuristics checklist:

- **Visual hierarchy** — does the eye land on the most important thing first? Is emphasis earned or noisy? (For a monitor's surface: does the *stalest* thing shout loudest? That's hierarchy doing safety work.)
- **Spacing & rhythm** — consistent spacing scale; aligned to a grid; breathing room; no cramped or random gaps.
- **Typography** — clear type scale; readable line-length/leading; limited, intentional font set; no orphaned sizes.
- **Color & contrast** — coherent palette; text/background contrast meets WCAG (this overlaps the objective `axe` check — fix it once); state colors meaningful.
- **Motion & interaction feel** — transitions purposeful, not gratuitous; durations/easing feel right; nothing janky; respects reduced-motion.
- **State coverage** — empty/loading/error/refusal states are *designed*, not afterthoughts; disabled/selected/hover are distinct and legible.
- **Responsiveness** — no overflow, truncation, overlap, or tap-targets-too-small at any captured viewport.
- **Polish** — alignment, consistent corner radii/shadows/borders, icon sizing, copy tone, favicon/title — the details that separate "scaffold" from "feels good."

**Compose `frontend-design`** (when available) for the *direction + craft* — i.e. *how to make it good*, not merely to detect what's bad. The heuristics above flag problems; that's where the positive design expertise comes from.

## Step D — emit design defects (exactly like machine defects)

Turn the critique into a **defect list with severity** (Blocker / High / Medium / Low), each tied to a design-bar criterion or a named heuristic. Examples:

- *[High] Mobile (375px): control panel overflows, horizontal scroll. — responsiveness*
- *[High] No refusal state — broken input shows a bare frame. — state coverage*
- *[Medium] 10-days-stale and 2-days-stale rows are visually identical. — hierarchy (safety)*
- *[Medium] Primary action and secondary action are visually identical. — hierarchy*

These join the machine defects in the iteration's critique; the rebuild fixes the **top** ones from **both** tracks. Concrete design defects (a missing state, an overflow, a contrast failure) are nearly as checkable as machine facts — keep those distinct from the genuinely subjective residue ("does this feel premium?"), which stays soft.

## Step E — the different-model critic (default when design is load-bearing)

Run a critic on a **different model** as the taste check. Give it **only** the screenshots + the brief's design direction + the design acceptance criteria — **not** the builder's own rationale (blind review). Ask for a blind score and a concrete defect list. Merge its defects into the critique.

It is **default-on** when design is load-bearing (the single biggest blunt against self-graded taste) and **optional** for plain utilities. It never gates the objective machine facts, and it never substitutes for rendering the UI. Honest limit: even with it, you have **two correlated models, not the employee**.

## Step F — the human spot-check is the final taste gate

"Looks good to two models" is **not** "a designer signed off." When design is load-bearing, the honest handback names a **human spot-check** as the final taste gate — the loop drives quality hard toward the bar and clears every checkable design defect, but the last increment of genuine taste belongs to a human. Put it in the ledger's residual for the named build/technical owner and accepting user; don't let a clean screenshot imply someone approved it.

## How this feeds PASS

When design is load-bearing, **PASS requires the design bar met via this visual loop** — not just green build/tests. If the visual loop couldn't run, the design bar is unmet and the run cannot PASS; it hands off (BLOCKED) with the gap named. The objective machine facts remain co-equal and are never replaced by design — both tracks must be green to PASS.
