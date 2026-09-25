# HipMarvin FX — Weekly Research File

## RESEARCH CYCLE
**Research Cycle Label:** Week 35 — Sep 20–26, 2026
**Week Start (ISO):** 2026-09-20
**Week End (ISO):** 2026-09-26
**Event Label:** AU Employment Beat / SNB Hold / BOE Bailey Speaks
**Impact Level:** Medium-High
**Thematic Focus:** AUD repositioning after a mixed employment print; SNB hold with a dovish-leaning tone shift on FX-intervention language; GBP tone-dependent on Bailey's speech today
**Overall Bias:** Mixed — no pair reached deterministic trade confirmation this week
**Status:** active
**Macro Thesis:**
Both of the week's hard-data catalysts have now released. AU Employment (Thu 24 Sep) beat forecast by roughly double (+39,500 vs +20,000), but the unemployment rate rose to 4.6% from 4.5% as participation surged to 67.1% — job quality was weak (full-time -6,300, all gains from part-time +45,800), and AUD was reported "little changed" on the release. This is a genuinely mixed print, not a clean bullish signal, despite the headline beat. SNB held at 0.00% exactly as forecast — a non-event on the rate itself — but eased its FX-intervention language, dropping prior "increased willingness to intervene" wording for standard phrasing, read by markets as a pivot toward inflation vigilance over currency defense; USD/CHF rose to ~0.827, its highest since late May. BOE Governor Bailey speaks today (Friday); no forecast exists for a speech, tone-dependent only. The RBA meets Monday 29 Sep with markets pricing ~95% odds of a hike to 4.6% — this falls just after this cycle's window but is the natural carryover catalyst into Week 36.

**Analyst:** Elijah Agom / MarvinX
**Published:** Friday, September 25, 2026, 10:56 WAT
**Import Status Note:** Rebuilt this cycle from verified sources after the original WEEK35_WEEKLY_RESEARCH.md was found to contain fabricated data (AU Employment actual/forecast and unemployment figures did not match real released data; COT JPY weekly change was incorrect). All figures below are sourced from live web search (real-time news/data providers) and the live `/api/engine-snapshot` HTF/QMR engine output pulled during this session. Sections without a verified source are marked NOT SOURCED rather than filled with placeholder or invented values — do not populate them without real data.

---

## HIGHER-TIMEFRAME TREND MAP

*(Source: live `/api/engine-snapshot` pull, 2026-09-25T07:12 UTC — real deterministic engine output, not manually estimated. NOTE: as of the current admin/page.tsx importer, HTF Trend / Trend Alignment / Structural Break / QMR Phase fields are only parsed when they appear inside a **Priority N** trade-idea block. This table has no import path into Supabase this week since no trade ideas were published — presentational/reference only until that gap is addressed.)*

| Pair | Daily Trend | 4H Trend | Trend Agreement | Classification |
|---|---|---|---|---|
| USDJPY | Bullish | Bullish | Agree | Directional (WITH-TREND, LONG) |
| EURUSD | Bearish | Bearish | Agree | Directional (WITH-TREND, SHORT) |
| USDCAD | Bullish | Bullish | Agree | Directional (WITH-TREND, LONG) |
| AUDUSD | Bearish | Bearish | Agree | Directional (WITH-TREND, SHORT) |
| NZDUSD | Bearish | Bearish | Agree | Directional (WITH-TREND, SHORT) |
| GBPUSD | Conflict | Bearish | Conflict | Transition-Conflict (NOT-ELIGIBLE) |
| USDCHF | Transition | Bullish | Conflict | Transition-Conflict (NOT-ELIGIBLE) |

**Rule 24 discipline applied:** GBPUSD and USDCHF are correctly excluded from directional trade consideration this week — Daily/4H disagree and no confirmed structural break exists to justify countertrend eligibility.

---

## MACRO DRIVERS

**Driver 1**
**Tag:** RELEASED
**Headline:** AU Employment Change & Unemployment Rate — Thursday, Sep 24
**Subline:** Thu 24 Sep, 1:30am UTC — Employment Change Actual +39,500 (Forecast +20,000, Prior -15,800) · Unemployment Rate Actual 4.6% (Forecast 4.5%, Prior 4.5%)
**Analysis:**
- Macro regime being tested: AUD labour-market strength
- Confirms regime if: both employment and unemployment improve together
- Strengthens regime if: employment beats and unemployment holds or falls
- Weakens regime if: employment beats but unemployment rises on weak job quality — this is what happened
- Breaks / invalidates regime if: employment misses and unemployment rises
- FX implication: Mixed, not clean-bullish. Full-time employment fell (-6,300); all gains were part-time (+45,800). Unemployment rose because participation (67.1%, up from 66.9%) outpaced hiring. Market reaction was reported as "AUD little changed." Treat this as a real but ambiguous data point, not a directional trigger on its own.

**Driver 2**
**Tag:** RELEASED
**Headline:** SNB Monetary Policy Assessment & Policy Rate — Thursday, Sep 24
**Subline:** Thu 24 Sep, 7:30am UTC — SNB Policy Rate Actual 0.00% (Forecast 0.00%, Prior 0.00%) — fifth consecutive hold
**Analysis:**
- Macro regime being tested: CHF policy stance / intervention posture
- Confirms regime if: rate held and intervention language unchanged
- Strengthens regime if: rate held and tone turns more hawkish/inflation-focused
- Weakens regime if: rate held but intervention language eases — this is what happened
- Breaks / invalidates regime if: rate cut, or intervention threat escalates
- FX implication: Inflation forecasts were raised across 2026–2028 (0.7% / 0.8% / 0.8%). SNB dropped its prior "increased willingness to intervene against franc strength" language for standard wording — read as a pivot toward inflation vigilance over currency defense. USD/CHF rose to ~0.827, highest since late May. This is a genuine, sourced tone shift, not a rate surprise.

**Driver 3**
**Tag:** SCHEDULED (today)
**Headline:** BOE Governor Bailey Speaks — Friday, Sep 25
**Subline:** Time not yet confirmed — speech only, no forecast or transcript available at time of writing
**Analysis:** Speech-only event, GBP directional impact is entirely tone-dependent. GBPUSD is already classified Transition-Conflict on the HTF Trend Map (Daily/4H disagree) — a hawkish or dovish tone from Bailey would need to produce a confirmed structural break before any GBP idea becomes eligible per Rule 26, not just a directional lean.

**Driver 4**
**Tag:** NOT SOURCED
**Headline:** RBA Rate Decision — Monday, Sep 29 (falls after this cycle's window)
**Subline:** Markets reportedly pricing ~95% odds of a hike to 4.6% per general market reporting; exact CME/OIS-style pricing source not independently verified this session
**Analysis:** Carryover catalyst into Week 36, not this cycle. Flagged here for continuity given AUD's mixed data week; do not treat the "~95%" figure as independently confirmed without re-sourcing at Week 36 build time.

---

## TRADE PRIORITY LIST

**No pair reached deterministic trade-construction eligibility this week.** Per Rule 25/26 discipline: a setup is not published with invented numbers to fill a gap. Live `/api/engine-snapshot` output (2026-09-25T07:12 UTC) was audited pair-by-pair; every pair's `tradeConstruction.status` returned `INELIGIBLE` with all price fields null. Classification below reflects the actual gate each pair is blocked at — this is real engine output, not a placeholder table.

**NEAR CONFIRMATION** (QMR phase MANIPULATION reached — one gate from eligible):
- **EURUSD** — SHORT bias, Daily+4H bearish, WITH-TREND. Daily structural break UNCONFIRMED (displacement check failed: body ratio 0.77x vs 1.5x threshold required). Blocked at: reaction confirmation — no directional flow, no confirmed break, no accepted/rejected liquidity yet.
- **USDJPY** — LONG bias, Daily+4H bullish, WITH-TREND. Daily structural break CONFIRMED-BULLISH (real, displacement-qualified, 1.89x ratio). Liquidity swept + accepted. Blocked at: reaction confirmation — supporting evidence only, no qualifying reaction yet. Dealing range flagged INVALIDATED-BULLISH; would need re-validation even after reaction confirms.

**WATCH** (QMR phase QUALITY — directional bias established, no liquidity interaction yet):
- **AUDUSD** — SHORT bias, Daily structural break CONFIRMED-BEARISH (5.26x displacement ratio). Blocked at: manipulation/liquidity sweep has not occurred yet. Dealing range flagged INVALIDATED-BEARISH.
- **USDCAD** — LONG bias, Daily structural break CONFIRMED-BULLISH (3.14x ratio). Same blocker: liquidity untaken.
- **NZDUSD** — SHORT bias, Daily structural break CONFIRMED-BEARISH (3.09x ratio, HIGH confidence both timeframes). Same blocker: liquidity untaken.

**INELIGIBLE** (trend alignment gate failed — no direction established):
- **GBPUSD** — Daily/4H conflict, no confirmed break to justify countertrend eligibility.
- **USDCHF** — Daily/4H conflict, no confirmed break to justify countertrend eligibility.

**Recommendation:** publish this week without a forced trade idea. EURUSD and USDJPY are the pairs to re-check first for Week 36 — both are one reaction-confirmation event from real deterministic entry/stop/target numbers.

---

## SCENARIO MATRIX — AU Employment Change

**Branch 1 — Beat confirmed, but quality-weak — resolved:** Employment printed +39,500 vs +20,000 forecast, but unemployment rose to 4.6% on a participation surge and weak full-time composition. Market reaction: AUD little changed. Verdict: Mixed — do not auto-classify as "Confirmed/bullish" from keyword overlap alone; the headline beat and the underlying deterioration point in different directions.
**Trade implication:** No AUD idea is justified from this data point alone. AUDUSD's SHORT bias on the HTF Trend Map is driven by real technical structure (confirmed Daily bearish break), not by this employment print — the two should not be conflated in the write-up.

## SCENARIO MATRIX — SNB Policy Rate

**Branch 1 — Hold confirmed, intervention language eased — resolved:** Rate held exactly as forecast (non-event on the number). Inflation forecasts raised; FX-intervention wording softened. Verdict: Confirmed for the "hold as expected" scenario; the intervention-language shift is the more actionable secondary signal, not encoded in a simple beat/miss framework.
**Trade implication:** USD/CHF technicals (HTF Trend Map: Daily Transition / 4H Bullish, currently NOT-ELIGIBLE) should be watched for a resolving break given this tone shift, but no eligible setup exists yet.

## SCENARIO MATRIX — BOE Bailey Speech

**Branch 1 — Hawkish/resilient tone (30% probability, speech not yet occurred):** GBP-positive lean. Action: watch for GBPUSD's Daily/4H conflict to resolve toward agreement, with a confirmed structural break, before treating as tradeable.
**Branch 2 — Dovish/soft tone (70% probability, speech not yet occurred):** GBP-negative lean, would align with the existing 4H bearish read. Action: same — requires a confirmed break, not just directional tone, per Rule 26.

---

## COT POSITIONING

*(Source: CFTC Traders in Financial Futures, reporting week 8–15 Sept 2026, published ~18 Sept — most recent report available as of this cycle. Only figures actually verified via search are included; other pairs are marked NOT SOURCED rather than estimated.)*

| Pair | Metric | Value | Read |
|---|---|---|---|
| JPY | Net long, leveraged funds | 120.4K contracts (14-month high) | +109.6K week-over-week — the standout positioning move of the period, part of a two-week 216K-contract buying spree |
| USD (aggregate, 8 IMM currencies) | Gross long | $5.9B | Collapsed 70% week-over-week — lowest in 15 months; confirms a broad dollar-soft positioning backdrop |
| EUR | Net short, leveraged funds | — | Short-covering of 15.6K contracts (~$2.3B) this period; still net short but reducing |
| CAD | Net short, leveraged funds | — | Short-covering of 33K contracts (~$2.4B) this period |
| AUD | — | NOT SOURCED | Not independently verified this session — do not populate without re-sourcing |
| GBP | — | NOT SOURCED | Not independently verified this session — do not populate without re-sourcing |
| CHF | — | NOT SOURCED | Not independently verified this session — do not populate without re-sourcing |

**Read:** The clearest, best-sourced signal this period is the JPY reversal and the broad USD long unwind — both real and substantial. AUD/GBP/CHF-specific COT figures should be pulled fresh before publish rather than carried over from the earlier (fabricated) file.

---

## DAILY GAME PLAN

**Monday/Tuesday:** No scheduled high-impact events. Use this window to re-check EURUSD and USDJPY for reaction confirmation — both are one gate from deterministic eligibility. No new entries until the engine snapshot shows a status upgrade from MANIPULATION to CONFIRMED-CONTINUATION/REVERSAL.
**Wednesday:** Mid-week reassessment. If AUDUSD, USDCAD, or NZDUSD show a liquidity sweep (QMR advancing from QUALITY to MANIPULATION), re-run the snapshot and re-audit trade construction for that pair specifically.
**Thursday:** No scheduled high-impact events this cycle. Reassess all WATCH-tier pairs against fresh engine output.
**Friday:** Bailey speaks — no new entries in the window around the speech. If GBPUSD's Daily/4H conflict resolves with a confirmed structural break following the speech, that would be the first legitimate trigger for a GBP idea this cycle; absent that, GBPUSD remains INELIGIBLE regardless of speech tone.

**Standing discipline:** No pair reached READY status this week. This is a legitimate outcome, not a gap to be filled artificially — the v7 no-trade condition applies where the deterministic gates are not satisfied.

---

## WEEK CLOSE REVIEW — CARRYOVER NOTE

No trade ideas were opened this cycle; Position Ledger has no new entries to carry forward. EURUSD and USDJPY are the two pairs closest to deterministic confirmation heading into Week 36 and should be the first re-check on that cycle's build. The RBA decision (Mon 29 Sep, falls just outside this window) is the natural AUD-relevant carryover catalyst for Week 36.

---
**Sources:** Live web search (real-time financial news/data, 25 Sept 2026) for AU Employment, SNB decision, and COT figures · Live `/api/engine-snapshot` pull (2026-09-25T07:12 UTC) for all HTF/QMR/trade-construction data · No position ledger carryover — no ideas opened this cycle.