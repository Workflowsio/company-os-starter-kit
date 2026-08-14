# The five layers and the 30-minute audit

Read at steps 1 and 2. Each layer has one job. They build on each other, so a broken layer makes every measurement above it unreadable.

---

## Layer 1: Data (foundation)

**Job:** maintain a clean, current database of accounts and contacts you can sell to. It answers one question: who are we selling to and how do we reach them.

Components: the CRM as the single source of truth, a contact database that feeds new prospects into it, and data hygiene covering deduplication, bounce monitoring, job change detection and regular cleanup. Contact data degrades a few percent every month on its own, so hygiene is a standing job rather than a project.

**Good:** the CRM is clean and current, bounce rate is under 3 percent, new records are deduplicated on import, nobody is keeping a private spreadsheet, and one named person owns data quality.

**Bad:** the CRM is a graveyard of stale records, the reps keep their own lists because they do not trust it, and you have 50,000 contacts and cannot say which 500 matter this week.

---

## Layer 2: Enrichment (intelligence)

**Job:** turn raw records into prioritized signals that say who to talk to and when. Raw contact data tells you who exists, and this layer tells you who is ready.

Components: signal detection (job postings, funding, leadership changes, tech changes, site visits, content engagement), scoring and prioritization, and research automation for personalization at a volume a person cannot reach by hand.

**Good:** the team knows which 50 accounts matter this week and why, signals are under 7 days old, scoring has been calibrated against actual closed-won data, and the reps trust the order enough to follow it.

**Bad:** every lead is treated identically, reps pick accounts by instinct or alphabetically, and there is intent data nobody has opened. A close variant: a scoring model set up 18 months ago and never recalibrated, which is worse than none because people still believe it.

---

## Layer 3: Sequencing (execution)

**Job:** reach the right people at the right time through the right channel with the right message.

Components: email sequencing with personalization and reply detection, social outreach at the connection and follow-up level, phone for the personas that still answer it, and ad platforms for retargeting and air cover.

**Good:** sequences are differentiated by tier rather than one-size-fits-all, reply rates are above 5 percent, channels are coordinated rather than run as separate silos, and the timing follows the signals from layer 2.

**Bad:** one generic sequence for everybody, email and social running as unconnected programmes, no testing, and a reply rate under 1 percent with volume increasing anyway. Watch for the seven-step sequence where steps 4 to 7 add nothing and exist to hit an activity target.

---

## Layer 4: CRM and pipeline

**Job:** track every deal from first touch to close, with a forecast that survives contact with the quarter. This is not storage, which is layer 1. This is deal progression.

Components: a pipeline whose stages match how you actually sell with clear entry and exit criteria, activity tracking that happens automatically rather than through rep data entry, and reporting on pipeline value, stage conversion, cycle length and win/loss reasons.

**Good:** every deal has a next step and a close date, pipeline review takes 15 minutes because the data is already there, forecasts land within 15 percent, and you can see which deals are stuck and why.

**Bad:** stages that mean nothing (interested in what?), reps updating deals the morning of the review, forecasts off by 40 percent, half the pipeline is zombie deals that should have been closed-lost months ago, and win/loss reasons are never recorded so nothing is learned from a loss.

---

## Layer 5: Analytics (learning)

**Job:** measure what works, kill what does not, and close the loop between activity and revenue.

Components: attribution (pick one model and start, rather than debating three), campaign performance by segment, persona and channel, and revenue metrics covering acquisition cost, lifetime value, payback and pipeline velocity.

**Good:** you can answer "which channel produces the most revenue per unit spent" in under a minute, the weekly metrics review leads to an actual change, and sales and marketing have agreed on the attribution model rather than each keeping their own.

**Bad:** no attribution, marketing claiming credit for everything, sales calling all leads junk, and nobody able to say which channel produced the last ten closed-won deals. Dashboards exist and nobody opens them.

---

## The 30-minute audit

Score each item yes or no. Any no is a gap.

**Data layer**
- [ ] The CRM is the single source of truth, and there are no shadow spreadsheets
- [ ] Contact bounce rate is under 5 percent
- [ ] Data is deduplicated and cleaned at least monthly
- [ ] The ICP is documented with firmographic and persona criteria

**Enrichment layer**
- [ ] At least one signal source is live: intent, job changes, funding or site visits
- [ ] Accounts are scored or tiered rather than treated equally
- [ ] Signals are acted on within 7 days of detection

**Sequencing layer**
- [ ] Multi-channel sequences are running, not email alone
- [ ] Sequences differ by persona rather than one for everybody
- [ ] Reply rate is above 2 percent
- [ ] Sending domains have full authentication in place
- [ ] Volume per inbox is inside safe limits

**Pipeline layer**
- [ ] Stages have clear entry and exit criteria
- [ ] Every active deal has a next step and a close date
- [ ] Activities are logged automatically
- [ ] Forecasts are reviewed weekly and land within 20 percent

**Analytics layer**
- [ ] You can name your best channel by revenue rather than by activity
- [ ] Acquisition cost and lifetime value are calculated and tracked
- [ ] The weekly metrics review leads to a change
- [ ] Win and loss reasons are recorded on every closed deal

### Scoring

| Score | Reading | What to do |
|---|---|---|
| 16 to 18 | Strong foundation | Optimize. The work is in the analytics layer |
| 10 to 15 | Real gaps, all fixable | Fix the lowest-scoring layer first and change nothing else that month |
| Under 10 | Foundational rebuild | Start at layer 1 and work up. Do not buy anything for layers 3 to 5 yet |

Report the score by layer rather than as a total. A 12 made of four full layers and one empty one is a completely different situation from a 12 spread evenly, and the total hides which one you have.
