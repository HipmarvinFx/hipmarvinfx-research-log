# HipMarvinFX v7 QMR/HTF — Shift Handover
**Date:** 4 September 2026
**Scope this shift:** Verification of `SHIFT_HANDOVER_2026-08-31_QMR_HTF.md`'s
claimed state, plus closing the Step 9/10 gap (Structured Evidence Packet →
AI prompt integration).

---

## 0. How this shift started

Unlike the 31 August shift, this one had live read access to the real
application repo via terminal (grep/Get-Content round-trips), not just
`HIPMARVINFX_STATE_AUG31_2026.md`. Everything below is verified against
actual source and actual `information_schema`/`pg_constraint` output, not
inferred from a state file. Per this repo's own standing lesson ("verify
before building on top of something"), every claim below cites the file
and line it was confirmed against.

## 1. Verification of prior claims

Three items flagged as open/unknown in earlier handovers were checked
against live code and live Supabase schema:

| Item | Prior claim | Verified status |
|---|---|---|
| Position Ledger DB table | `HANDOVER_NOTE.md`: "no database table, route, or code at all" | **False, corrected.** `app/api/position-ledger/route.ts` is a complete GET/POST/PATCH implementation (176 lines) enforcing Rule 4 (stop required, stop ≠ entry) and Rule 3 (status only via explicit PATCH) in code. Live `position_ledger` table confirmed via `information_schema.columns` — 24 columns, exact match to what the route reads/writes. `admin/page.tsx:2107` calls it inside `loadLedger()`. Table → route → UI, all three layers confirmed. |
| Week-Close Review parser | `HANDOVER_NOTE.md`: parser "doesn't exist in usable form," built around an obsolete B1–B6 format | **False, corrected.** `app/lib/parseWeekCloseReview.ts` exists (176 lines... [48+ lines confirmed]), imported and called from `admin/page.tsx`'s `importWeekCloseReviewBlock()` (line 2128), which POSTs to `/api/week-close-review` (confirmed full route: GET + POST with upsert-by-`cycle_id` logic, admin-gated). `app/review/weekly/[cycle_id]/page.tsx` GETs the same route and renders it alongside trade log, scenarios, COT. Fully wired end to end. The garbled-Unicode claim attached to this file did not reproduce (`â€` search: 0 matches in `parseWeekCloseReview.ts`) — that encoding issue was actually in `position-ledger/route.ts`'s header comment instead (`Ã¢â‚¬â€` for an em dash), a different file than originally named. |
| `research_cycles_week_unique` constraint | "UNKNOWN" | **Confirmed live** via `pg_constraint`: `UNIQUE (week_start, week_end)`. No matching `.sql` migration file found anywhere in the repo — this constraint was added directly in the Supabase dashboard, not tracked in version control. Flagged as its own small infra-drift item, not urgent. |

**Action for whoever owns `HANDOVER_NOTE.md`:** the Position Ledger and
Week-Close Review claims above should be corrected at the source per this
repo's Editorial Standard (Principle 9 — cross-reference rather than
duplicate). This document is that cross-reference; `HANDOVER_NOTE.md`
itself was not edited this shift (same read-only-project-files constraint
noted in the Aug 31 shift).

## 2. The real finding: HTF/QMR evidence was computed but discarded

Tracing `lib/pipeline/daily.ts` and `lib/pipeline/weekly.ts` end to end
surfaced a live bug, not a documentation gap:

- Both pipelines correctly run the full v7 HTF/QMR block per pair —
  `buildHtfComposite()` → `classifyQmrPhase()` → `classifyQmQml()` →
  `buildHtfEvidencePacket()` — populating a real `Map<FXPair,
  HtfEvidencePacket>` (`htfPackets`), and both return it to the caller.
- Both pipelines also compute `priceLevels` correctly (confirmed present
  in both the early-return and success-return branches).
- **Neither value was ever passed into `generateResearch()`.** The actual
  call sites, before this shift's fix, were:
  ```ts
  await config.ai.generateResearch(validated, "daily");
  await config.ai.generateResearch(validated, "weekly");
  ```
  `generateResearch()`'s real signature (`lib/ai/adapters/index.ts`)
  accepted an optional third argument, `priceLevels?: any[]` — never
  supplied — and had **no parameter at all** for HTF/QMR data.
- Consequence: `buildCompactPrompt()`'s price-data block always fell
  through to its own documented fallback ("REAL PRICE DATA: not available
  this run — do not state any specific price level"), even on runs where
  real validated OHLC had just been fetched moments earlier in the same
  function. HTF/QMR classifications never reached the model at all — no
  fallback message even existed for them prior to this fix, since the
  prompt template had no HTF section to begin with.

This means Steps 1–8 of the v7 sequence (market-data pipeline through
QM/QML refinement) were further along than the 31 August handover assumed
— fully wired and running on every pipeline execution — but the output
was silently discarded at the exact boundary between Step 9 (Structured
Evidence Packet, which does exist and is well-formed per
`lib/engine/htf-evidence-packet.ts`) and Step 10 (AI prompt integration,
which did not exist for HTF data and was broken for price data too).

### A second undocumented gap surfaced during this trace

`lib/evidence/adapters/yahoo.ts` and `lib/market-data/adapters/yahoo-fx-adapter.ts`
both cite a "`SHIFT_HANDOVER_2026-09-01`" session in their header comments,
describing real, specific, verified-sounding work (confirming
`source-registry.ts`'s priority-sort behavior, confirming `EvidenceItem`'s
real field shape, wiring Yahoo as priority-0 ahead of TwelveData). **No
file by that name, or any September-dated handover, exists anywhere in the
repo.** The work described is real and verified independently in this
shift (the adapters exist, are registered, and Yahoo genuinely sorts
before TwelveData in `source-registry.ts`) — so the session likely
happened — but it left no continuity document, breaking this repo's own
established handover convention for the first time. Flagged, not fixed:
whoever did that work should retroactively write it up, or this shift's
own writeup (this file) should be treated as the closest thing to a
record of it that exists.

## 3. Fix applied this shift

**Files changed:** `lib/ai/adapters/index.ts`, `lib/pipeline/daily.ts`,
`lib/pipeline/weekly.ts`. All three backed up (`.bak_<timestamp>`) before
editing; each patch verified to match its target pattern exactly once
before applying (no blind/ambiguous replacements).

1. **`lib/ai/adapters/index.ts`**
   - Added imports: `HtfEvidencePacket` (from
     `lib/engine/htf-evidence-packet.ts`), `FXPair` (from
     `lib/market-data/types.ts`).
   - `generateResearch()` signature extended with a fourth parameter:
     `htfPackets?: Map<FXPair, HtfEvidencePacket>`.
   - `buildCompactPrompt()` signature extended to match, now threads
     `htfPackets` through to a new `buildHtfBlock()` helper.
   - New `buildHtfBlock()` function: renders one line per pair from the
     evidence packet (Daily/4H trend + confidence, trend alignment +
     preferred direction, structural breaks, 20D location, liquidity
     state, flow regime + confidence, QMR phase + eligibility, QM/QML
     presence + eligible direction). Packets with
     `validation.readyForAiSynthesis === false` render as an explicit
     `NOT READY — missing [fields]. Treat as WAIT/NO-TRADE` line instead
     of a synthesized-sounding read. No `htfPackets` at all → explicit
     "not available this run" fallback, same pattern as the existing
     price-data fallback.
   - Evidence Constraints list in the prompt template extended (was 4
     items, now 5) with an explicit instruction: use only the exact
     HTF/QMR classifications given, never infer a trend/phase to fill a
     gap, treat `NOT READY` pairs as WAIT/NO-TRADE.
   - Per `htf-evidence-packet.ts`'s own documented scope decision, the
     new prompt block explicitly tells the model **not** to state
     Entry/Stop/Target levels from this section — those fields
     deliberately aren't in `HtfEvidencePacket` yet (require 1H data not
     wired into price-level computation), and the prompt now says so
     rather than leaving it ambiguous.

2. **`lib/pipeline/daily.ts`** — call site updated to
   `config.ai.generateResearch(validated, "daily", priceLevels, htfPackets)`.

3. **`lib/pipeline/weekly.ts`** — call site updated to
   `config.ai.generateResearch(validated, "weekly", priceLevels, htfPackets)`.

## 4. What was verified after the fix

- `tsc --noEmit`: clean, no type errors.
- Both call sites re-grepped post-patch: confirmed both now pass
  `priceLevels, htfPackets` (daily.ts:256, weekly.ts:228).
- `buildHtfBlock`/`htfBlock` references re-grepped: exactly one definition
  of `buildCompactPrompt` and one of `buildHtfBlock` (no duplicate-apply
  artifacts).
- Diff against pre-patch backup: 61 lines differ — consistent with a real,
  substantial change landing correctly, not a silent no-op.

## 5. What remains open — NOT verified this shift

- **No live pipeline run performed.** Everything above confirms the code
  compiles and the wiring is structurally correct. It does **not** confirm
  that `htfPackets` is actually non-empty and well-formed at the moment
  `generateResearch()` is called in a real execution, or that the
  generated prose reads sensibly with real HTF/QMR classifications
  substituted in. **This is the single most important next step** —
  same category of gap as the Aug 31 shift's own unverified live-Yahoo-call
  caveat.
- **The missing `SHIFT_HANDOVER_2026-09-01` document** (Section 2 above) —
  someone should locate or reconstruct it if it exists elsewhere (local
  drafts, chat history, etc.), or accept this document as the retroactive
  record of that work's existence.
- All items already open per the 31 August handover and unrelated to this
  shift's work remain untouched: Gemini/Groq provider fixes,
  `week_start`/`week_end` date bug, weekly-cycle mislabeling, Rules 18/22
  in `position_ledger`'s schema having no corresponding definition found
  in any Standing Protocol version seen so far (v4 tops out at Rule 21;
  something between v4 and the v7 brief referenced in the Aug 31 shift
  must define these — not yet located).
- Steps 11–14 of the v7 sequence (Parser v7 fields, Weekly/Daily/Ledger
  sync, test suite, end-to-end publication test) remain fully unstarted,
  same as before this shift — this shift only closed the Step 9→10
  boundary, it did not begin Step 11.

## 6. Exact next task

1. Trigger one real daily or weekly pipeline run (test cycle acceptable)
   with a valid `config.ai` provider configured, and inspect the actual
   `research` string returned for the new `HTF/QMR STRUCTURE` block —
   confirm it renders with real classifications, not the "not available"
   fallback, and reads coherently.
2. If the live run's `htfPackets` map comes back empty despite pairs
   having valid Daily/4H candle data, trace why — the `for (const pair of
   pairs)` loop in both pipelines silently `continue`s on missing
   `dailyCandles`/`h4Candles`, which is correct fail-safe behavior per
   Rule 1/18-adjacent conventions but should be confirmed as the actual
   cause if packets are missing, not assumed.
3. Track down what defines Rules 18 and 22 (referenced by
   `position_ledger`'s schema columns `rule_18_flag`/`rule_22_flag` but
   absent from every Standing Protocol version seen in this conversation
   so far) — likely lives in `STANDING_PROTOCOL_v7.md`, referenced by the
   Aug 31 shift but never itself pasted/read in full.
4. Resolve or reconstruct the missing 1 September handover per Section 2.
5. Only after Step 1 above is confirmed live: proceed to Step 11 (Parser
   v7 fields) — there is no point building a parser for AI output that
   hasn't yet been confirmed to contain the fields it would parse.

---

**Commit message suggestion, once applied to the real repo:**
`fix(v7): wire priceLevels + htfPackets into generateResearch() prompt — closes Step 9/10 gap, HTF/QMR evidence was computed but never reached AI output. tsc clean, live-run verification still required.`
