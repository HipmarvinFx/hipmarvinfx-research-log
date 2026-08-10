# HipMarvin FX — Standing Protocol v5

Updates v5: adds Rule 22 — the Thesis Invalidation Flag — a Position Ledger
rule requiring that when newly published research (Weekly Outlook, Daily
Update, or Week-End Review) materially contradicts the specific analytical
basis for a currently OPEN Ledger position, that contradiction is recorded
in the position's Notes the day it's identified. The rule is deliberately
disclosure-only: it never changes Status, modifies a stop, or closes a
position — Rule 3's requirement that Status changes come only from actual
recorded price action (or a separately logged discretionary close) is
preserved untouched. Rule 22 is also distinct from Rule 18: Rule 18 fires
once a second, actually-open Ledger row exists in the opposing direction;
Rule 22 fires as soon as contradicting research is published, whether or
not it has yet triggered into a position. Added as a new phase-specific
rule appended after Rule 21 — following the same precedent Rule 21 itself
set at v3→v4 — rather than inserted into the original Position Ledger
block (Rules 17–19), for the same renumbering-avoidance reason documented
throughout the Migration Note below.

Updates v4: adds Rule 21 — the Zone Alignment Check — formalizing the Daily
Zone calculation (previously an unstructured visual read) into a fixed
20-trading-day High/Low range measured backward from the most recent
Friday, and requiring every Trade Priority List idea to be checked for
directional conflict against its own zone. Added as a new phase-specific
rule appended after Rule 20 rather than inserted into the Weekly Outlook
block (Rules 5–7), for the same renumbering-avoidance reason documented at
v2→v3 in the Migration Note below.

Updates v3: adds Rule 20 — the Parser Integrity Rule — formalizing the
separation between the research record (Weekly Outlook, Daily Update,
Week-End Review, Position Ledger) and any downstream publication/rendering
layer (e.g. the Post-Event Publication / "MarvinX voice" article). Added as
a new cross-phase rule appended at the end rather than inserted into the
Global block, since Global Rules 1–4 are explicitly frozen ("never
renumbered") — see the Migration Note below for the same reasoning applied
to earlier numbering changes.

This is the single canonical rule set referenced by WEEKLY_RESEARCH_TEMPLATE.md,
DAILY_UPDATE_TEMPLATE.md, POSITION_LEDGER_TEMPLATE.md, and
HipMarvinFX_Generation_Prompts_v4.md. If a rule is cited by number anywhere in
those files, this document is the definition it points to.

Rules are grouped by scope: Global (apply at every phase), then
phase-specific (Weekly Outlook, Daily Update, Week-End Review, Position
Ledger), then cross-phase rules added after the phase-specific ones for the
same reason Global rules are frozen — stable numbering. Global rules are
numbered first and never renumbered — phase-specific and cross-phase rules
are added after them, so a rule's number stays stable as this document
evolves.

---

## GLOBAL RULES (apply at every phase)

**Rule 1 — Never fabricate.**
Never fabricate a number, forecast, actual, COT figure, price, Friday close,
pip result, or resolution. No source = write "Pending," "not sourced," or
"no actual yet" in that exact field — don't estimate or guess to fill a gap.

**Rule 2 — Sourcing separation.**
Forecasts/priors come only from the attached FF screenshot. Speech/testimony
content comes only from web search, cited by source. Entry/stop/target levels
come only from charts, or are clearly labeled as an inferred technical read —
never presented as sourced when they're inferred.

**Rule 3 — Status only from actual recorded price action.**
Any status, verdict, or outcome (trade status, scenario verdict, ledger
status) is only ever changed based on actual recorded price action or a
sourced actual — checked against the full relevant range, not just the
latest print. Never inferred from vibes or narrative alone.

**Rule 4 — Every trade idea gets a stop.**
The moment a trade idea is written down — in the Weekly Outlook or the
Position Ledger — it gets a stop. No exceptions, no "stop to follow."

---

## WEEKLY OUTLOOK PHASE RULES

**Rule 5 — Correlation check.**
Before finalizing the Trade Priority List: check whether most entries bet
against the Scenario Matrix's own highest-probability branch, or whether
several "different" ideas are really one correlated bet (e.g. four
USD-direction trades wearing four pair names). If so, say that plainly in
the list itself — don't present it as independent, equally-weighted ideas.

**Rule 6 — Daily Game Plan is forward-only.**
The Daily Game Plan synthesizes the Trade Priority List and Scenario Matrix
into forward guidance only (what to watch, discipline windows, reassessment
triggers). It never resolves or verdicts anything — that's the Daily Update
file's job once the day actually happens. Don't duplicate Daily Update
content backward into this section.

**Rule 7 — Carryover is noted, not resolved, here.**
If a carried-over position from last week is running opposite this week's
new idea on the same pair, note it once in plain text in the Weekly Outlook.
Full resolution happens in the Position Ledger, not in this file.

---

## DAILY UPDATE PHASE RULES

**Rule 8 — Partial vs. Closed discipline.**
Don't mark a day "Closed" unless every scheduled event that day has happened
and been sourced. Otherwise mark "Pending" or "Partial" and say what's still
outstanding.

**Rule 9 — Only add what's actually supported.**
Only add or revise what today's new input actually supports — leave
everything else in the file exactly as it stands.

**Rule 10 — Verdict values.**
Verdict (only set on the run that actually closes the day) is one of:
Pending / Confirmed / Invalidated / Mixed.

**Rule 11 — Flag unscheduled developments immediately.**
Flag any genuinely new, unscheduled development the moment it's seen — don't
wait for day-close to log it.

**Rule 12 — Trade impact and Thesis update are conditional.**
- Trade impact: only fill in if today's outcome actually affects a
  pair/direction already on the current week's Trade Priority List (still
  valid / stopped / target hit / invalidated). Reference the existing
  entry/stop/target already on file — never invent a new number here. If no
  trade idea is affected, write "none."
- Thesis update: only fill in if today's outcome materially changes the
  weekly thesis. May explain the mechanism and forward implication, not
  just state that something changed — capped at roughly one to a few
  sentences, not a full paragraph. If nothing changed, write "none" —
  don't restate the thesis for the sake of filling the field.

**Rule 13 — Pre-generation sanity check.**
Run once, as the final step, right before generating or closing out each
day's entry — not on every intermediate draft. If anything is logged under
"Anything unscheduled that happened today" that isn't already explained by a
scheduled FF event, web search for a plausible cause tied to the pair(s) and
approximate time window (headline, data revision, central bank chatter,
geopolitical development) before finalizing the entry.
- If a plausible, well-supported cause turns up: state it as the likely
  cause per available reporting, cited, and clearly hedged as probable
  rather than confirmed. This is not a Rule 1 violation — Rule 1 bans
  fabricating an actual/price; attributing a likely cause to a move already
  sourced from a chart is a separate thing and is allowed here as long as
  it's hedged and cited.
- If nothing turns up: leave the line as "no source identified for this
  move" — don't force an attribution just to fill the field.
- Scope check: if the same move shows up across multiple unrelated pairs at
  once, look for a broad/dollar-wide cause rather than assuming it's
  specific to whichever single pair the move was first noticed on.
- This check runs once per day-closing entry, not retroactively rewriting
  earlier days unless something material turns up that changes a Verdict
  already logged.

---

## WEEK-END REVIEW PHASE RULES

**Rule 14 — Re-read before writing.**
Before writing anything: re-read the week's full file and the Position
Ledger top to bottom. Confirm every day marked "Closed" was actually
resolved, and every position's status matches its latest verdict elsewhere
in the documents — the newest call wins.

**Rule 15 — Don't average away a messy week.**
If most entries stopped out around -1R, say that plainly rather than
computing a flattering average.

**Rule 16 — Name the biggest error plainly.**
Name the week's single biggest analytical or process error plainly, in one
sentence — don't bury it in a longer paragraph.

---

## POSITION LEDGER RULES

**Rule 17 — New row timing.**
A new row is added the moment a new idea is published — per Rule 4, the
stop is filled in at the same time as the entry, never after.

**Rule 18 — Same-pair opposite-direction flag.**
If two rows exist for the same pair going opposite directions at once, note
it in "Notes" the day it happens — don't wait to discover it later.

**Rule 19 — Single source of truth.**
This file is the single source of truth for "what's open right now." The
Weekly Outlook does not repeat this — it only links to the Ledger if a new
idea overlaps with something already open here.

---

## CROSS-PHASE RULES

**Rule 20 — Parser integrity (research vs. publication separation).**
The research record — Weekly Outlook, Daily Update, Week-End Review, and
Position Ledger — is the system's canonical, auditable source of truth.
Revisions to these files may improve clarity, reasoning, organization
within existing fields, and explanatory depth, but must never alter
parser-visible structure: section names, field names, ordering, parser
markers, evidence hierarchy, or confidence/sourcing language ("confirmed,"
"likely," "possible," "unconfirmed," etc. — these are structural
guarantees, not writing style). Publication-style narrative — leading with
conclusions, institutional/journalistic voice, "so what" framing for
readers — belongs in the downstream rendering layer (the Post-Event
Publication / public-facing article), not in the research schema.

In short: reasoning may be strengthened; evidence and confidence may not.
Deepen the "why does this matter" analysis inside a field like Verdict or
Thesis update all you want — but the same facts, the same hedges, the same
field name, in the same place, every time. If a change would require
touching a heading, a field label, the dash-line format, or a confidence
word, it belongs in the publication layer's own template, not here.

This rule applies across all four research-record file types equally, which
is why it's numbered here rather than inserted into the Global block above —
Global Rules 1–4 are frozen per this document's own numbering policy (see
Migration Note).

**Scope clarification:** Rule 20 governs *revisions to an existing research
file instance* — editing a specific week's or day's entry must not silently
drift its structure. It does not prohibit the templates themselves from
evolving over time. Rule 21 is the precedent: it added four new required
fields (Timeframe, Correlation Class, Daily Zone, Tier) to
`WEEKLY_RESEARCH_TEMPLATE.md`, and that was legitimate schema evolution, not
a Rule 20 violation, because it was deliberate, versioned, documented in
this document's own Migration Note, and reflected consistently across the
protocol, the template, the generation prompts, and the parser at the same
time. What Rule 20 actually forbids is *informal, undocumented* structural
drift — a field that starts appearing in real files (like an ad hoc "still
open" section) without ever being added to the canonical template, so the
schema and practice quietly diverge. Deliberate schema changes are
permitted; silent ones are not.

---

## WEEKLY OUTLOOK PHASE RULES (added v4)

**Rule 21 — Zone alignment check (soft flag).**

*Part A — Daily Zone calculation.* Daily Zone is calculated, not eyeballed.
Take the High and Low of the most recent 20 trading days, measured
backward from the most recent Friday (Friday's own daily candle counts as
day 1 of the lookback). That High–Low range is the reference range. Locate
the entry price as a percentage position within that range:

  zone % = (entry price − 20-day Low) / (20-day High − 20-day Low) × 100

State the result as "X% up the 20-day range" plus the corresponding label:
0–20% Discount, 20–40% Lower Equilibrium, 40–60% Equilibrium, 60–80% Mild
Premium, 80–100% Deep Premium. This replaces the prior "your own visual
read off the Daily chart" convention — the range is now a specific,
chart-verifiable High/Low, not a subjective read. As with Rule 2, the
20-day High/Low itself must come from an actual chart, not from memory or
estimation.

*Part B — Alignment check.* Before finalizing the Trade Priority List,
check every idea's direction against its own Daily Zone:
- A **Buy** idea priced in the **Premium** zone (60–100%) runs against the
  zone's own directional logic — the zone framework favors selling
  premium, not buying it.
- A **Sell** idea priced in the **Discount** zone (0–40%) is the same
  conflict in reverse — the zone framework favors buying discount, not
  selling it.

This is a **soft flag, not a hard block** — same treatment as Rule 5's
correlation check. A zone-conflicted idea may still be published, but the
conflict must be stated plainly in that idea's own Reasoning field (e.g.
"Buy idea priced in the Premium zone — against the zone's own directional
bias; taken anyway because [stated reason]"). Silence on a real zone
conflict is not permitted; only omitting the idea entirely avoids the
flag requirement. An idea sitting in Lower/Mild Equilibrium bands (20–40%
or 60–80%) with a direction that leans the "wrong" way is a softer version
of the same conflict and should still get a brief note, though it is less
severe than a Deep Discount sell or Deep Premium buy.

---

## POSITION LEDGER RULES (added v5)

**Rule 22 — Thesis invalidation flag (disclosure only).**

If a currently OPEN Ledger position is materially contradicted by newly
published research (Weekly Outlook, Daily Update, or Week-End Review) that
directly affects the analytical basis for that specific position, the
contradiction must be recorded in that position's Notes the day it is
identified. The added specificity matters — a new AUD employment thesis
does not flag an unrelated EUR/USD position merely because both appear in
the same Weekly Outlook; the contradiction has to actually bear on the
reason that position exists.

The note should **cite where the contradiction was established**, rather
than restate the analysis — this is a pointer to already-sourced content,
not a new independent judgment requiring its own sourcing:

- "per Day 3 Verdict: Invalidated"
- "per Week 33 Priority 2, opposing thesis"
- "per Rule 21B, now Deep Premium"

**This flag is informational only.** It does not change Status, modify the
stop, or close the position. Status changes remain governed entirely by
Rule 3 (actual recorded price action) or a separately logged discretionary
close — Rule 22 never substitutes for either.

**Distinct from Rule 18.** Rule 18 applies once a second, actually-open
Ledger row exists in the opposing direction. Rule 22 applies as soon as
contradicting research is *published*, whether or not it has yet triggered
into an open position. The two can legitimately coexist on the same row —
Rule 22 may flag a contradiction well before Rule 18 would ever apply, and
Rule 18 may still separately apply later if that contradicting idea itself
becomes a second open position.

---

## KNOWN OPEN ITEMS (not yet resolved by this document)

- **Status vocabulary mismatch:** the Position Ledger uses 4 states (OPEN /
  STOPPED / CLOSED @TP / CLOSED @breakeven). The `/pairs` (now `/live-trades`)
  page's status field uses 7 values (Waiting/Triggered/Active/etc.). These
  have never been reconciled — this document does not resolve that, it only
  records that the conflict exists. Rule 22 does not add a fifth status
  value to this list — it was deliberately scoped as a Notes-only flag for
  exactly this reason, to avoid compounding an already-unresolved schema
  question with a new status value that would need its own reconciliation.
- **Triggered vs. Active status convention:** the `/pairs` (now `/live-trades`)
  page's 7-value status field includes both "Triggered" and "Active" with no
  documented distinction between them. First real-world resolution: Week 32's
  NZD/USD Long was set to "Active" rather than "Triggered" on the reasoning
  that "Triggered" implies a just-fired entry, while "Active" better describes
  a position confirmed live and currently tracking toward a target days later.
  This was a judgment call, not a ratified convention — logged here so future
  cases don't re-litigate it from scratch, but not yet formally adopted as
  the rule.
- **Correlation check's database home** is still undecided (`research_cycles`
  vs. `trade_ideas`) — Rule 5 above describes the check itself, not where
  its result is persisted.
- **Whether "Carryover Resolved This Week" is what writes to the Position
  Ledger** is still unanswered (see Rule 7 and the Week-End Review
  structure) — the Ledger is currently updated "directly" per the Week-End
  Review prompt, but the mechanics of that update aren't yet specified in
  code.
- **Publication / "MarvinX voice" template** — referenced by the roadmap
  (Phase 2's Publication Builder) but no standalone written specification
  has been confirmed to exist as of this revision. Treat as undefined until
  a real file is produced or located, not assumed to already exist.

---

## MIGRATION NOTE

Prior to this document, each prompt file used its own independent 1–N rule
numbering. The Weekly Outlook prompt's old "Rule 4" for mandatory stops lines
up with this document's Global Rule 4. But the Position Ledger template's
references to "Rule 2" and "Rule 3" for stop-timing and status-from-price-action
do **not** line up with this document — those are now Rule 17 and Rule 3,
respectively. Any file still citing the old per-prompt numbering should be
updated to reference this document's numbers instead, or the reference will
point to the wrong rule.

**v2 → v3:** Rule 20 (Parser Integrity Rule) added. It applies across all
phases, not just one, but is numbered after the phase-specific rules rather
than inserted into the Global block — inserting it as a new Rule 5 would
have forced renumbering everything from Rule 5 onward, breaking every
existing citation of Rules 5–19 in the phase-specific templates and in
`HipMarvinFX_Generation_Prompts_v4.md`. Appending preserves every existing
citation's validity.

**v4 clarification #2 (no renumbering):** Rule 20 now includes an explicit
scope clarification distinguishing single-file revision integrity (what
the rule restricts) from deliberate, versioned template evolution (what it
permits) — citing Rule 21's own introduction as the precedent for the
latter. Added after an external review characterized Rule 20 as barring
any new parser-visible field outright, which is stricter than the rule was
ever intended to be.

**v4 clarification (no renumbering):** Rule 12's Thesis update cap corrected
from "one sentence, no more" to "roughly one to a few sentences." This
brings the rule in line with the deeper-reasoning allowance
`HipMarvinFX_Generation_Prompts_v4.md` already applied to the Daily Update
prompt as of its own v4.1 update, and with how Thesis update fields have
actually been written since (multi-sentence, sourced, hedged — not
one-line). The prior "one sentence" text was never updated to match,
leaving the Protocol and the deployed prompt in conflict even though the
prompt explicitly defers to the Protocol on conflicts. This is a wording
correction to an existing rule, not a new rule, so no renumbering applies.

**v3 → v4:** Rule 21 (Zone Alignment Check) added. Although it's a
Weekly Outlook-phase rule in substance, it's appended after Rule 20 rather
than inserted as a new Rule 8 (which would sit naturally after Rule 7 in
the Weekly Outlook block) — inserting it there would force renumbering
every Daily Update, Week-End Review, and Position Ledger rule from Rule 8
onward, breaking every existing citation across all templates and prompts.
Appending after Rule 20 preserves every existing citation's validity, at
the cost of the rule numbering no longer being perfectly grouped by phase —
a deliberate, repeated tradeoff of this document (see v2→v3 above for the
same reasoning).

**v4 → v5:** Rule 22 (Thesis Invalidation Flag) added. The rule records
analytical contradictions affecting already-open Ledger positions without
changing their Status. This preserves Rule 3's requirement that Status
changes occur only from actual recorded price action or a separately
logged discretionary close, while ensuring that materially-invalidated
trade theses cannot remain undocumented. Although it's a Position
Ledger-phase rule in substance, it's appended after Rule 21 rather than
inserted into the original Position Ledger block (Rules 17–19) — inserting
it there would force renumbering Rules 20 and 21 and every citation of
them across the protocol, templates, and generation prompts. As with Rule
21 at v3→v4, appending preserves every existing citation's validity at
the cost of perfect phase-grouping — the same deliberate, repeated tradeoff
this document has now made three times.

**Post-v5 (Known Open Items log entry, no rule change):** added a Known
Open Item documenting the first real-world Triggered-vs-Active status
decision (Week 32, NZD/USD Long → "Active"). This is a log entry, not a
rule — it records that a judgment call was made and the reasoning behind
it, so the next case has precedent to reference or dispute, but it does
not formally adopt a Triggered/Active convention. No rule numbering is
affected.
