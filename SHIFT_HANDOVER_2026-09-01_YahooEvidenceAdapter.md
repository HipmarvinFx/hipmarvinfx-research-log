# HipMarvinFX v7 QMR/HTF — Shift Handover (continued)
**Date:** 1 September 2026
**Continues from:** `SHIFT_HANDOVER_2026-08-31_QMR_HTF.md`
**Scope this session:** Brief §20 Steps 1–2 continuation — wiring `yahoo-fx.ts`
toward the real Evidence Packet system (§6 items 4–6 from the prior
handover), not yet Step 3 (HTF structure engine).

---

## 0. Where this picked up

The 08-31 handover left off with three unread files blocking real progress:
`lib/evidence/store.ts`, `lib/evidence/packet-builder.ts`,
`lib/evidence/types.ts`, plus `lib/ai/adapters/index.ts` and the
`lookupPairsForCycle()` stub. Per the standing lesson repeated at the end
of every prior handover in this project ("verify before building"), this
session read real files before writing anything further, rather than
continuing to extend `yahoo-fx.ts` in isolation.

---

## 1. Done this session (verified against real files, not just claimed)

**Real market-data pipeline for Daily/4H/1H OHLC** — sourced from live
Yahoo, integrity-validated, evidence-status tracked. Registered through
the guard's allowlist and the router's `createProvider`.

**Two real bugs found and fixed:**
- XAU/XAG symbol mapping (Yahoo FX symbol convention issue).
- Found and flagged, deliberately **not** fixed this session: an orphaned
  `exchangerate-host.ts` file, and the existing `YahooFinanceAdapter`'s
  silent 4H→1H mislabeling. Both are real, pre-existing issues surfaced by
  reading the actual repo — left for a dedicated fix pass rather than
  bundled into this session's scope, per the same "don't guess, don't
  overreach" discipline as the rest of this handover chain.

**`lib/evidence/types.ts` read directly** (the smallest of the three
evidence files, and the one the other two depend on). This surfaced two
genuine schema/convention gaps between `yahoo-fx.ts`'s model and how the
two existing real adapters (`twelve-data.ts`, `mock.ts`) actually behave:

1. **Status handling mismatch.** Both existing adapters only ever return
   `status: "VERIFIED"` — any failure is thrown as an error, not encoded
   via the status field. `yahoo-fx.ts` has a richer model: it can
   correctly return `STALE` for real, validated-but-old data, and
   `NOT_AVAILABLE`/`INVALID` for bad fetches, instead of always throwing.
2. **No existing convention for multiple timeframes on one subject.**
   Existing adapters fetch a single daily OHLC value per subject (e.g.
   `"EURUSD"`). `yahoo-fx.ts` produces three series per pair (1D/4H/1H).
   `EvidenceItem`'s schema doesn't currently discriminate timeframe —
   `subject` is just the bare pair — so three items for `"EURUSD"` won't
   collide (random UUID ids) but can't be cleanly filtered by timeframe
   either.

**Both gaps were resolved this session, decision confirmed, not left
open:**

1. **Status handling:** `NOT_AVAILABLE`/`INVALID` results from
   `yahoo-fx.ts` become a thrown error at the evidence-adapter boundary —
   matching the existing two-adapter convention, so the priority/fallback
   mechanism keeps working exactly as it already does elsewhere. `STALE`
   is passed through as a real status rather than forced into a throw,
   since `packet-builder.ts`'s `aggregateStatus()` already knows how to
   handle it and it's a genuinely useful signal `yahoo-fx.ts` already
   computes correctly from real data.
2. **Timeframe discrimination:** use the existing
   `metadata?: Record<string, unknown>` field on `EvidenceItem` — e.g.
   `metadata: { timeframe: "1D" | "4H" | "1H" }` — and have
   `queryEvidence` callers filter on it when they need one specific
   timeframe. Additive, no schema change, doesn't collide with the
   existing single-timeframe convention the other two adapters use.

These two decisions are the specification for the not-yet-written
Yahoo evidence adapter — see Section 3.

---

## 2. Fallback behavior — clarified this session, partially still unwired

Two different things, worth keeping separate:

**Yahoo → TwelveData fallback: the mechanism exists at the router level,
but isn't wired for `yahoo-fx.ts` yet.**
`MarketDataRouter` (in `adapters/index.ts`) already holds a
`providers: MarketDataProvider[]` array and tries each in order, catching
errors and falling through to the next provider. If something
instantiates `new MarketDataRouter([yahooFxAdapter, twelveDataAdapter])`,
a Yahoo failure would correctly fall through to TwelveData — but where
(or whether) that instantiation happens for the real pipeline is still
unlocated. Not guessed at, for the same reason the XAU bug happened in
the first place: guessing this and being wrong is worse than leaving it
open.

**`/api/price-strip` specifically has no fallback at all today.** That
route calls `fetchPairStructure()` from `yahoo-fx.ts` directly, bypassing
`MarketDataRouter` entirely. A Yahoo failure for a pair just comes back
`NOT_AVAILABLE` in the JSON — no TwelveData fallback in that code path.

**If both Yahoo and TwelveData fail: no automated "manual rescue," and
that's deliberate**, not a gap. Per the v6.2 Fix A precedent this project
already follows (`hasMinimumCoverage()` mirrors it), the pipeline is
supposed to **block** on insufficient real coverage, not substitute
anything. `guard.ts` exists specifically to prevent silently falling back
to synthetic/fabricated OHLC when real sources fail. "Manual rescue" here
means a human sees a blocked/insufficient-coverage state and investigates
— never an automatic third data source.

---

## 3. Still open — next in line, in order

1. **Write the actual Yahoo evidence adapter**, implementing the two
   confirmed decisions from Section 1: throw on `NOT_AVAILABLE`/`INVALID`,
   pass through `STALE`, tag each of the three per-pair series with
   `metadata.timeframe`. Not yet written — Section 1 only settled the
   design, this session did not implement it.
2. **`lib/evidence/store.ts` and `lib/evidence/packet-builder.ts` — still
   unread.** `types.ts` alone was enough to make the two design decisions
   above, but confirming `aggregateStatus()`'s actual `STALE` handling
   (referenced in Section 1 by description, not by reading the function)
   still needs the real file before the adapter is wired in for real.
3. **Locate where the pipeline actually constructs its provider list** —
   most likely inside `lib/ai/adapters/index.ts` or `lib/pipeline/daily.ts`
   — so the Yahoo→TwelveData fallback described in Section 2 can be wired
   for real, per the state file's locked §5 decision (Yahoo primary,
   TwelveData fallback). Neither file has been read yet.
4. **`lookupPairsForCycle()` in `app/api/price-strip/route.ts`** — still a
   deliberate stub that throws. Needs the real Supabase client/query shape
   before it can be un-stubbed.
5. **Only after 1–4:** brief §20 Step 3, the HTF structure engine itself
   (Daily/4H trend classification, protected swing high/low
   identification). Per the brief's own explicit ordering, do not start
   Step 3 or QM/QML pattern detection before Steps 1–2 are fully wired and
   live-verified.

Unchanged from the 08-31 handover and still not touched this session:
`lib/pipeline/daily.ts`, `lib/pipeline/weekly.ts`,
`lib/market-data/adapters.ts` (existing TwelveData stub), the orphaned
`exchangerate-host.ts` file, the existing `YahooFinanceAdapter`'s 4H→1H
mislabeling, Gemini/Groq provider fixes, the `week_start`/`week_end` date
bug, weekly-cycle mislabeling, the `research_cycles_week_unique`
constraint, the Week-Close Review parser rewrite, and the Position Ledger
DB table.

---

## 4. Recommended next step

Read `lib/evidence/store.ts` first (smaller of the two remaining evidence
files, and the one `packet-builder.ts` likely depends on), then
`packet-builder.ts`, then write the Yahoo evidence adapter per the
confirmed spec in Section 1. This keeps the session's one working pattern
intact: every guess made without reading the real file so far has needed
correction (the wrapper shape, the guard allowlist, the XAU symbol); every
decision made after reading the real file has held.

```powershell
Get-Content lib/evidence/store.ts
```

---

**Process note carried forward, again:** same lesson as every prior
handover in this chain — verify before building. This session's version:
two design decisions (status handling, timeframe discrimination) were
correctly resolved from reading one file, but the temptation to keep
extending the adapter on that basis alone, without also reading
`store.ts`/`packet-builder.ts` or locating the provider-list construction
site, was deliberately not acted on. Half-verified is still unverified for
the parts not yet checked.

---

## UPDATE — SESSION CONTINUED: WIRING COMPLETED, LIVE-VERIFIED, TWO BUGS FIXED

Everything below happened after the section above. The plan two sections
up ("wire `yahoo-fx` into the Evidence Packet as the AI's primary source")
turned out to be based on a wrong assumption, corrected below — read that
part first if picking this up cold.

### Real finding: the Evidence Packet is not upstream of the AI call

Reading `app/api/cron/daily/route.ts` directly (not previously read in
this chain — only inferred from `lib/ai/adapters/index.ts`, a different
file) showed that `buildEvidencePacket()` only feeds `parseAndValidate()`,
a **parallel, non-blocking verification step**, wrapped in its own
try/catch, explicitly commented "parallel validation, non-blocking." It
never touches the `priceLevels`/`ledger` that `runDailyPipeline()` hands
to the AI. **The real integration point for getting real price data into
what actually gets published is `MarketDataRouter`'s provider list**, not
the Evidence Packet system. The Evidence Packet's job is downstream
fact-checking of AI output, not upstream data supply. This corrects the
plan carried since the original 08-31 handover.

### `yahoo-fx` wired into the real pipeline (Option A, confirmed)

`lib/market-data/adapters/yahoo-fx-adapter.ts` already existed (built
31/08, same session as `yahoo-fx.ts`) — a `MarketDataProvider`-conforming
wrapper, already registered as `createProvider("yahoo-fx")` in
`lib/market-data/adapters/index.ts`, already allowlisted as `'yahoo-fx'`
in `lib/integrity/guard.ts`'s `REAL_OHLC_SOURCES` (via the pre-existing,
previously-unrun-until-verified `scripts/patches/patch-guard.ps1` and
`patch-index.ps1`). None of that had been confirmed applied until this
session re-read the real files.

**What was actually missing and is now fixed:** `app/api/cron/daily/route.ts`
and `app/api/cron/weekly/route.ts` both still constructed
`new MarketDataRouter([twelve-data, yahoo-finance])` — the old buggy Yahoo
adapter as fallback, the new `yahoo-fx` not referenced at all. Both files
now construct `new MarketDataRouter([yahoo-fx, twelve-data])` —
`yahoo-fx` primary, `twelve-data` fallback, `yahoo-finance` dropped
entirely (Option A, chosen deliberately over keeping the old buggy adapter
as a third, rarely-firing fallback — a rare failure mode that's harder to
catch than a clean block). Committed `30a4a41`, pushed to `origin/main`.

Type-checked clean against this specific change (confirmed via
`git stash`/`stash pop` — the only errors present were three pre-existing,
unrelated ones, described below).

### Live verification against the real Yahoo endpoint — completed, not just mock-tested

This was Blocker #3 in the original 08-31 handover, carried open across
this entire chain until now. Verified directly against
`query1.finance.yahoo.com`, not mocks:

- **Daily fetch (`EURUSD=X`, `interval=1d`): confirmed real and correct.**
  Found a genuine edge case in the live feed: the in-progress "today" bar
  has `close: null` in Yahoo's raw JSON (confirmed via a real fetch, not
  inferred). Read `isValidCandle()`'s actual source: its first check is
  `typeof c.close !== "number"`, which correctly and safely rejects a
  `null` close before any numeric comparison is reached. **Confirmed by
  reading the real function, not by reasoning about JS coercion rules** —
  an earlier coercion-based guess in this session (that a loose `>=`
  comparison might let `null` slip through) was wrong, and the real
  code is stricter/safer than that guess assumed. This was the single
  biggest open risk in the whole chain; it is now closed with evidence.

- **Native `interval=4h`: works and returns real data (27 bars,
  `dataGranularity: "4h"` reported) — but is boundary-misaligned with
  what `aggregate1hTo4h()`'s own comment targets** (00:00/04:00/08:00 UTC
  buckets). The native bars align to a different offset (observed at
  hour-3-past-cycle, e.g. 3/7/11/15/19/23). This **confirms, with a
  specific and now-understood reason, the original decision to always
  derive 4H from 1H rather than trust native `interval=4h`** — previously
  an unverified claim in the state file, now a confirmed-correct decision
  for a concrete, evidenced reason (boundary mismatch, not just general
  unreliability).
  - Also observed: the native series' trailing bar had
    `open === high === low === close` (a flat, zero-range snapshot). This
    passes `isValidCandle()` legitimately — it's real, valid data, just
    uninformative. Not a bug, just worth knowing it can occur.

- **XAU/XAG symbol fix (`GC=F`/`SI=F`): confirmed resolving live**, both
  returning 4 real daily bars with plausible closes (gold ~4,488,
  silver ~67.4, roughly consistent with levels already seen elsewhere in
  this project's own research files).

### Two real bugs found and fixed this session (not carried forward as open items)

1. **`app/api/cron/daily/route.ts` — `packet` variable shadowing.**
   `let packet = null;` declared outside a `try` block was shadowed by
   `const packet = await buildEvidencePacket(...)` inside it, so the outer
   `packet` was always `null` and `evidenceSections: packet?.sections.length ?? 0`
   in the response always reported `0` regardless of what the packet
   actually contained. This was flagged as a likely bug the first time
   this file was read in this session, and confirmed as a real **compile
   error** (`TS2339: Property 'sections' does not exist on type 'never'`)
   once `tsc --noEmit` was actually run — not just a silent runtime bug.
   Fixed: `packet` now declared once, properly typed via
   `Awaited<ReturnType<typeof buildEvidencePacket>> | null`, assigned
   (not shadowed) inside the `try`.
2. **`lib/parser/types.ts` — `EvidencePacket`/`EvidenceItem` imported but
   never re-exported**, breaking `lib/parser/rules/price-rules.test.ts`
   and `lib/parser/v7-parser.test.ts` (`TS2459`, both importing
   `EvidencePacket` from `@/lib/parser/types` / `./types`, neither of
   which re-exported it). Fixed with an explicit
   `export type { EvidencePacket, EvidenceItem };` line.

Both fixes verified: anchor-based patch scripts (see
`scripts/patches/README.md`), confirmed via re-reading the patched files,
and `npx tsc --noEmit` now returns **zero errors** — the first fully clean
type-check in this entire handover chain. Committed `8b3398d`, pushed.

**Process note on these two patches, worth repeating exactly because it
happened twice this session:** the first patch attempt against
`app/api/cron/daily/route.ts` aborted with "anchor found 0 times" despite
the visible text matching exactly — the real cause was CRLF vs LF line
endings (the file is CRLF, the here-string anchor was LF), not a content
mismatch. Confirmed via `Select-String` before re-attempting, rather than
guessing at a second content-based fix. Same root-cause family as the
earlier BOM issue during live-Yahoo verification (`Out-File`'s default
encoding vs. Node's `JSON.parse` UTF-8 expectation) — different
manifestation, same lesson: encoding/line-ending mismatches produce
errors that look like content mismatches, and are worth checking for
explicitly before assuming the visible text is wrong.

### Repo housekeeping

- Five patch scripts (`patch-guard.ps1`, `patch-index.ps1`,
  `patch-symbols.ps1` — pre-existing from the 08-31 session, previously
  untracked; `patch-parser-types.ps1`, `patch-daily-shadow.ps1` — new this
  session) relocated to `scripts/patches/` with a `README.md` documenting
  what each one did and which commit it corresponds to. Committed as a
  deliberate audit trail, per this project's own documentation-over-
  terseness convention, rather than deleted. Committed `2ca7d30`, pushed.
- Throwaway live-verification scratch files (`check-4h.js`,
  `check-candle.js`, `check-live.js`, `check-metals.js`,
  `yahoo-test-eurusd-1d.json`) deleted, not committed — they served their
  one-time diagnostic purpose and had no ongoing value as fixtures.

### Still genuinely open (unchanged from the original handover's Section 3, items 4–5)

- `lookupPairsForCycle()` in `app/api/price-strip/route.ts` — still a
  deliberate stub that throws. Needs the real Supabase client/query shape.
- Brief §20 Step 3 (HTF structure engine) — **not started.** Per the
  brief's own explicit ordering, this correctly waits until Steps 1–2 are
  fully wired and live-verified, which is now true. This is the actual
  next unblocked step.
- **QMR (brief §20 Step 7) has not been started** and is not next in line
  — Steps 3–6 (HTF structure engine, trend alignment engine, protected
  swing/structural-break, 20D+liquidity+flow integration) all come first,
  per the brief's explicit ordering. Nothing skipped; correctly still
  queued several steps out.
- `queryEvidence()` has no metadata filter (flagged when reading
  `store.ts` this session) — once multiple timeframes are written per
  subject, filtering by `metadata.timeframe` requires a client-side filter
  after fetching all rows for that subject. Left as-is deliberately (three
  rows per pair is cheap at current scale); flagged, not fixed.
- `buildEvidencePacket()`'s `aggregateStatus()` collapses an entire
  section (e.g. all `PRICE_DATA` across every pair/timeframe) into one
  status — a single `STALE` item anywhere in `PRICE_DATA` makes the whole
  section report `STALE`, even if only one pair/timeframe is affected.
  Pre-existing behavior, not caused by this session's work; flagged as a
  real limitation once multi-timeframe data starts flowing through it,
  not yet fixed.

### Recommended next step

Brief §20 Step 3 — the HTF structure engine (Daily/4H trend
classification, protected swing high/low identification) — is now
genuinely unblocked for the first time in this handover chain. Everything
it depends on (real market data, live-verified, wired as primary; both
known bugs in the surrounding pipeline fixed; a clean type-check) is now
true and confirmed, not assumed.
