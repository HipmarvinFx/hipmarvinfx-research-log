# HipMarvin FX — Weekly Research File (v5 schema) — Week 42 DRAFT v5.1

Revised: Sun 11 Oct 2026. Status: DRAFT, not import-ready.
Rules applied: Standing Protocol v7 / Workflow Directive. Evidence is stated only where it was read from a source. Engine-owned fields are copied from stored engine output with its as-of time. Nothing is hand-derived unless labelled DERIVED with its method. Anything unsupported is marked NOT SOURCED.

Changes from v5: Price Strip replaced with a Friday 9 Oct close table (Yahoo 1H, cross-checked against TwelveData); 20-day range reference added; HTF map completed for all four engine-eligible pairs with structural-break and preferred-direction fields; central-bank evidence gap noted; Open evidence items rewritten.

---

## RESEARCH CYCLE

- **Week Label:** Week 42 · October 2026
- **Week Start ISO:** 2026-10-11 (from stored calendar window `weekly-2026-10-11-2026-10-17`)
- **Week End ISO:** 2026-10-17
- **Event Label:** NOT SOURCED
- **Impact Level:** High (every event in the supplied ForexFactory view is red-folder)
- **Thematic Focus:** NOT SOURCED (analyst)
- **Overall Bias:** NOT SOURCED (analyst)
- **Macro Thesis:** NOT SOURCED (analyst)
- **Analyst:** pending owner
- **Published:** Sunday, October 11, 2026, 18:00 WAT
- **Status:** Draft
- **Import Status Note:** see "Open evidence items" at the end

## PRICE STRIP

**Source:** Yahoo Finance 1H bars aggregated locally. Day window is 8 Oct 23:00Z to the Fri 9 Oct 20:00Z bar, the last full trading hour before the 21:00Z (5pm New York) close. Open, High and Low cover that window only, so they approximate a New York-close daily candle (the first two hours of that trading day are not included). Close is the last 1H bar of the day window and matches the stored as-of evidence. Cross-checked against TwelveData 1H (same 20:00Z bar): differences of 0.7 to 7.4 pips, so these are approximate closes, not official settlements. The stored daily bars were not used because two of them had open equal to close.

| Pair | Open | High | Low | Close (Yahoo, last 1H bar of day) | TwelveData close (20:00Z) |
|---|---|---|---|---|---|
| EUR/USD | 1.12158 | 1.12461 | 1.11919 | 1.12057 | 1.12025 |
| GBP/USD | 1.32307 | 1.32505 | 1.32076 | 1.32331 | 1.32348 |
| USD/JPY | 157.873 | 158.431 | 157.752 | 158.246 | 158.320 |
| AUD/USD | 0.69614 | 0.69911 | 0.69594 | 0.69876 | 0.69846 |
| NZD/USD | 0.56044 | 0.56278 | 0.56035 | 0.56120 | 0.56139 |
| USD/CAD | 1.42234 | 1.42987 | 1.42040 | 1.42540 | 1.42558 |
| DXY | 102.128 | 102.335 | 101.920 | 102.231 (last bar 20:59Z) | not checked |
| XAU/USD | NOT SOURCED | NOT SOURCED | NOT SOURCED | 4194.48 (TwelveData 20:00Z bar only; Yahoo returned 404; no second source) | n/a |

XAU/USD Open/High/Low are not stated because only the last five TwelveData bars were retrieved.

**20-day range reference (DERIVED).** Source: Yahoo 1H bars (gold: TwelveData 1H), 20 trading days 14 Sep to 9 Oct, each day running 21:00Z to 21:00Z, last bar 9 Oct 20:00Z. Highs and lows include wicks. This is my own derivation, not a chart-read value as the Daily Zone rule specifies. Position is shown at Friday's last close only. It is a reference, not a Daily Zone for any trade idea, because no entry prices exist yet.

| Pair | 20D High | 20D Low | Position at last close | Label |
|---|---|---|---|---|
| EUR/USD | 1.15996 | 1.11657 | 9.2% | Discount |
| GBP/USD | 1.35280 | 1.31813 | 15.1% | Discount |
| USD/JPY | 159.036 | 153.368 | 86.1% | Deep Premium |
| AUD/USD | 0.71649 | 0.69070 | 30.7% | Lower Equilibrium |
| NZD/USD | 0.58197 | 0.55838 | 12.5% | Discount |
| USD/CAD | 1.42987 | 1.38600 | 89.5% | Deep Premium |
| DXY | 102.535 | 99.073 | 91.2% | Deep Premium |
| XAU/USD | 4399.22 | 4061.73 | 39.3% | Lower Equilibrium |

## G10 MACRO REGIME

Policy rates (FACT, from the supplied ForexFactory sidebar): AUD 4.60% · USD 4.00% · GBP 3.75% · NZD 2.75% · EUR 2.65% · CAD 2.25% · JPY <1.25% · CHF 0.00%. NOK and SEK were not shown.

Stored central-bank evidence (VERIFIED, FACT, retrieved 11 Oct 20:36 UTC) covers the Fed, ECB, BOE, BOJ and SNB only. There is no stored RBA, BOC or RBNZ evidence, so the rates above rest on the ForexFactory sidebar alone for those banks.

Macro Regime Snapshot (inflation, labour, policy pressure), Macro Regime Ranking, Institutional Read, FX Implication, Changes From Previous Week: NOT SOURCED.

**Price-derived currency strength (DERIVED, not a macro-regime ranking).** Source: `hipmarvinfx-macro-assembler` weekly row, created 11 Oct 20:36 UTC. It scores trend, momentum and volatility from price data. It covers 8 currencies; NOK and SEK are absent. The row's own buckets put USD as Constructive, the other seven as Neutral, and Strongest, Weakening and Weakest empty.

| Rank | Currency | Score | Trend | Momentum | Volatility |
|---|---|---|---|---|---|
| 1 | USD | 63.5 | 68.4 | +2.5 | 6.0 |
| 2 | GBP | 53.1 | 53.4 | +0.1 | 5.2 |
| 3 | CHF | 52.4 | 51.1 | +0.7 | 6.7 |
| 4 | AUD | 52.2 | 51.9 | -0.3 | 6.3 |
| 5 | JPY | 49.9 | 47.4 | -0.1 | 7.6 |
| 6 | CAD | 47.5 | 44.4 | -0.4 | 5.3 |
| 7 | NZD | 45.8 | 42.1 | -1.3 | 5.9 |
| 8 | EUR | 45.3 | 41.4 | -1.2 | 5.4 |

The price data this score was computed from has not been inspected, so its as-of time is unconfirmed. It is consistent in direction with the 20-day reference above (USD pairs high, USD-quote pairs low), but that is an observation, not a validation.

## HIGHER-TIMEFRAME TREND MAP

Source: stored `htf-engine` rows, as-of Fri 9 Oct 06:19 UTC (pre-close; the stored price data behind them contains in-progress bars). 4 of 30 subjects are engine-eligible (`qmrEligible: true`); the other 26 are NOT-ELIGIBLE. These are engine outputs, not analyst views. Engine status for all four is VERIFIED.

| Pair | Daily | 4H | 4H structural break | Daily structural break | Trend Alignment | Engine preferred direction | QMR Phase | Flow Regime | Liquidity State | 20D location (engine) |
|---|---|---|---|---|---|---|---|---|---|---|
| AUD/CHF | Bearish | Bearish | None | None | With-trend | Short | Quality | Uncertain | Untaken liquidity | 47.9% |
| AUD/USD | Bearish | Bearish | **Confirmed bullish** | None | With-trend | Short | Quality | Range (Medium) | Untaken liquidity | 31.7% |
| AUD/CAD | Bearish | Bearish | None | None | With-trend | Short | Quality | Uncertain | Untaken liquidity | 50.9% |
| XAG/USD | Bearish | Bearish | None | **Confirmed bearish** | With-trend | Short | Manipulation | Uncertain | Sequential liquidity consumption | 21.2% |

For all four: engine `eligibleDirection` is null and QM/QML is not applicable. "Preferred direction" is an engine field, not a trade idea. Per the template, a Quality or Manipulation phase means the setup is incomplete.

Observations on this table (not conclusions):
- AUD/USD shows a confirmed bullish 4H structural break while the 4H trend is bearish. The trend and break fields disagree, and the engine still lists it eligible.
- Three of the four engine-preferred shorts have AUD as the weak leg (AUD/CHF, AUD/USD, AUD/CAD). That is one directional view in three pair expressions, relevant to the Rule 5 correlation check.
- Engine labels use "Deep Discount" for low 20D readings (the engine labelled EUR/USD 8.7% and 15.8% that way). The template's band scheme calls everything below 20% "Discount". The naming differs between engine and template. The data is not affected.
- EUR/USD changed between engine runs. Stored 8 Oct (VERIFIED): bearish on both timeframes, `qmrEligible: true`, 8.7%. Stored 9 Oct (PENDING): 4H bullish against Daily bearish, not eligible, 15.8%.
- GBP/JPY, GBP/CAD and CAD/JPY are stored as PENDING and NOT-ELIGIBLE (4H and Daily in conflict, or 4H against Daily). An earlier Groq-generated report named them as eligible. The stored rows contradict that, so it is not used here.

## WEEKLY THESIS

NOT SOURCED (analyst).

## MACRO DRIVERS

Source: ForexFactory calendar view supplied by the owner (capture time not recorded). Times appear to be WAT. No actuals exist yet. Analysis fields (confirm/strengthen/weaken/break conditions) are NOT DRAFTED because they depend on the macro regime.

**Driver 1**
**Tag:** SCHEDULED
**Headline:** US CPI — Wednesday, Oct 14
**Subline:** Wed 14 Oct, 13:30 WAT — Core CPI m/m Forecast 0.2% (prior 0.3%); Core CPI y/y Forecast 2.5% (prior 2.4%); CPI m/m Forecast 0.6% (prior 0.4%); CPI y/y Forecast 3.6% (prior 3.4%) (per FF screenshot)
**Analysis:**
- Macro regime being tested: NOT SOURCED
- Confirms regime if: NOT SOURCED
- Strengthens regime if: NOT SOURCED
- Weakens regime if: NOT SOURCED
- Breaks / invalidates regime if: NOT SOURCED
- FX implication: NOT SOURCED

**Driver 2**
**Tag:** SCHEDULED
**Headline:** AUD Employment Change & Unemployment Rate — Thursday, Oct 15
**Subline:** Thu 15 Oct, 01:30 WAT — Employment Change Forecast 20.0K (prior 39.5K); Unemployment Rate Forecast 4.6% (prior 4.6%) (per FF screenshot)
**Analysis:**
- Macro regime being tested: NOT SOURCED
- Confirms regime if: NOT SOURCED
- Strengthens regime if: NOT SOURCED
- Weakens regime if: NOT SOURCED
- Breaks / invalidates regime if: NOT SOURCED
- FX implication: NOT SOURCED

**Driver 3**
**Tag:** SCHEDULED
**Headline:** GBP GDP m/m — Thursday, Oct 15
**Subline:** Thu 15 Oct, 07:00 WAT — Forecast -0.1% (prior 0.4%) (per FF screenshot)
**Analysis:**
- Macro regime being tested: NOT SOURCED
- Confirms regime if: NOT SOURCED
- Strengthens regime if: NOT SOURCED
- Weakens regime if: NOT SOURCED
- Breaks / invalidates regime if: NOT SOURCED
- FX implication: NOT SOURCED

**Driver 4**
**Tag:** SCHEDULED
**Headline:** US PPI & Retail Sales — Thursday, Oct 15
**Subline:** Thu 15 Oct, 13:30 WAT — Core PPI m/m Forecast 0.3% (prior 0.2%); PPI m/m Forecast 0.5% (prior 0.4%); Core Retail Sales m/m Forecast 0.5% (prior 1.4%); Retail Sales m/m Forecast 0.3% (prior 1.2%) (per FF screenshot)
**Analysis:**
- Macro regime being tested: NOT SOURCED
- Confirms regime if: NOT SOURCED
- Strengthens regime if: NOT SOURCED
- Weakens regime if: NOT SOURCED
- Breaks / invalidates regime if: NOT SOURCED
- FX implication: NOT SOURCED

Also on the calendar (no forecast or prior shown): Fri 16 Oct, GBP BOE Gov Bailey speaks 03:00 and USD Fed Chairman Warsh speaks 04:30. These go in the Daily Game Plan.

## TRADE PRIORITY LIST

No idea is written. The template requires entry, stop, TP1, TP2 and R:R, and none is sourced. The engine marks four pairs eligible but with `eligibleDirection` null and a Quality or Manipulation phase, so nothing is trade-ready on that evidence. Entries must not be invented. Daily Zone for any idea must be calculated at its entry price, per Rule 21, once entries exist; the 20-day reference in the Price Strip is not a substitute.

## SCENARIO MATRIX

NOT SOURCED. The header must use the exact FF event name (for example `## SCENARIO MATRIX — CPI m/m`).

## DAILY GAME PLAN

Forward catalysts only. All other per-day fields (liquidity pool, flow regime, confirmation, reassessment, discipline) are NOT SOURCED.

- **Mon 12 Oct:** no red-folder events in the ForexFactory view. The stored FinanceCalendar weekly row lists a TSX Thanksgiving item for this date (that source is not ForexFactory).
- **Tue 13 Oct:** no red-folder events in the ForexFactory view.
- **Wed 14 Oct:** US CPI at 13:30.
- **Thu 15 Oct:** AUD labour data 01:30; GBP GDP 07:00; US PPI and Retail Sales 13:30.
- **Fri 16 Oct:** BOE Gov Bailey 03:00; Fed Chairman Warsh 04:30.

## COT POSITIONING

Source: CFTC TFF futures-only, report date 2026-10-06 (VERIFIED). Net positions are in pair direction (JPY, CAD and CHF contracts inverted). Direction and Read columns are NOT DRAFTED.

| Pair | Net Position (Leveraged Funds) | Net Position (Asset Mgr/Institutional) | Direction (wk/wk change) | Read |
|------|------|------|------|------|
| EUR/USD | net -44,261 | net +189,881 | NOT DRAFTED | NOT DRAFTED |
| GBP/USD | net +12,432 | net -145,442 | NOT DRAFTED | NOT DRAFTED |
| USD/JPY | net +25,043 | net -67,795 | NOT DRAFTED | NOT DRAFTED |
| USD/CAD | net +79,625 | net +35,806 | NOT DRAFTED | NOT DRAFTED |
| USD/CHF | net +11,350 | net +37,379 | NOT DRAFTED | NOT DRAFTED |
| NZD/USD | net -787 | net -32,534 | NOT DRAFTED | NOT DRAFTED |
| AUD/USD | net +54,133 | net -101,428 | NOT DRAFTED | NOT DRAFTED |

## RESEARCH CYCLE / CARRYOVER

Previous week's review: unavailable (not read). No carryover is claimed.

## POSITION LEDGER LINK

No ideas published, so no ledger rows.

---

## Open evidence items

1. **Friday close — resolved to an approximation.** The stored Yahoo price rows end Fri 9 Oct 06:19 UTC with in-progress bars, so they are not used. Yahoo daily candles are stamped 23:00Z, which makes the `2026-10-08T23:00Z` bar the Friday 9 Oct session, not Thursday. That bar's close is unreliable (for EUR/USD about 10 pips from the last 4H close; two daily bars have open identical to close). The Price Strip instead rebuilds Friday from Yahoo 1H bars and cross-checks TwelveData 1H at the 20:00Z bar. Remaining uncertainty: the sources differ by up to 7.4 pips (USD/JPY), the last Yahoo bar is 20:00Z (not the 21:00Z close), XAU/USD has a single source, and DXY is not cross-checked.
2. **Stored price rows:** 121 rows, all VERIFIED, newest created 2026-10-09 06:19 UTC. VERIFIED does not mean the candle was closed. Rows with a null `source` are not protected by the table's `(type, source)` unique key, so duplicates exist (typically 4 per subject; EUR/USD has 5). Any reader must take the newest row per subject. The closed-bar fix (`keepFullFourHourBuckets`) exists only in an uncommitted branch (`fix/live-closed-bars`, 27 lines changed in `yahoo-fx.ts`) and is not on main; its tests were not run or read.
3. **Calendar:** FinanceCalendar event times are real UTC (a Canada Labour Force Survey row is stored as 12:30Z, which is 8:30am Eastern and 13:30 WAT). The research importer stores WAT as `+01:00`, so "13:30 WAT" becomes 12:30Z. Read from code, not yet tested on a live Week 42 import. FinanceCalendar carries no forecasts, actuals or currency fields. One mismatch: its AUD prior reads unemployment 4.5%, while ForexFactory shows previous 4.6%. This draft uses the ForexFactory values. FinanceCalendar lists no Bailey or Warsh events.
4. **Macro-assembler weekly row** (VERIFIED, created 11 Oct 20:36 UTC): `currencyStrength` was read (DERIVED, price-based, 8 currencies) and is shown in the G10 section. It is not a macro-regime ranking, so the regime sections stay NOT SOURCED. Its as-of time is unconfirmed.
5. **Central-bank evidence:** stored for Fed, ECB, BOE, BOJ and SNB only. None for RBA, BOC or RBNZ.
6. **COT evidence rows** carry a null `source` column; 7 VERIFIED and 8 INVALID rows exist. The 6 Oct report is the one shown. Consumers must select by report date.
7. **Calendar capture time:** the ForexFactory screenshot clock reads 7:11am, so record when it was captured.
8. **HTF map is pre-close** (stored 9 Oct 06:19 UTC). Not re-run against Friday's close.
9. **Weekly thesis, macro regime, scenarios, trade ideas, game-plan detail:** analyst content, not sourced.
10. **Not run:** the weekly cron after PR #19 (whether the model emits the claims block), and the research-log push. Nothing from this draft has been imported or pushed.
