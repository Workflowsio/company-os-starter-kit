---
name: icp-modeller
description: |
  Use this skill when the answer to "who exactly are we targeting" is a sentence rather than a scored definition, and a list is about to be built from it - "define our ICP", "who should we be going after", "our list is too broad", "score these accounts", "why do our best customers keep coming from one segment", "we are expanding into a new vertical and I do not know what good looks like there", "rebuild the tiering, everything is Tier 1", "which accounts should the reps call first", "we have no customers yet, who do we target". Reads closed-won and churned records, call transcripts and campaign results by segment, then produces a tiered matrix: firmographic, psychographic and behavioral scoring with weights, tier thresholds, hard disqualifiers, per-tier campaign treatment, and a backtest against the customers you already have. Gates before any spend and never writes to the CRM without approval. NOT the pre-call brief on one named account, which is a different artifact for a different moment and is the discovery-prep skill. NOT the choice of channels, budget or motion, which is the gtm-strategist skill and starts once you know who you are targeting.
---

# ICP modeller

## When this applies

Somebody is about to build a list, run a campaign or brief a rep, and the targeting definition is a sentence rather than something you can score an account against. It also applies to refining targeting after three or more months of campaign data, entering a new segment, the quarterly review, and validating assumptions before spending anything on outbound.

Maturity: the three-dimension model and the tier treatments here come from real campaign work. The default weights are starting points and will be wrong for your business until the backtest in step 6 corrects them.

## What it produces

A single document, the ICP matrix, containing:

- Three scored dimensions with your weights, not the defaults.
- Tier 1, 2 and 3 definitions with the thresholds that separate them, plus a disqualified list.
- Hard disqualifiers that override the score.
- A per-tier campaign treatment: volume, research depth, personalization level, channels, contacts per account, sequence length.
- A backtest result: what percentage of existing customers land in Tier 1 or 2.
- A changelog, so every later change to the matrix carries the data that prompted it.

## Fill these in

- `{{CRM}}` - where closed-won, churned and deal data live
- `{{ENRICHMENT}}` - what supplies firmographic and technographic attributes
- `{{SIGNAL_SOURCES}}` - what detects buying signals, or an explicit "none yet"
- `{{APPROVAL_OWNER}}` - who approves a spend and who approves a write back to the CRM
- `{{REVIEW_CADENCE}}` - how often the matrix is revisited (default: every 90 days)

## First run: the customization interview

**Run this as a one-time setup step, outside any live engagement, and never mid-run.** It edits files, and editing a skill or its reference material while it is being used against real work is how a run half-follows two versions of its own instructions. Company-level answers belong in these files; anything specific to one account or one person belongs in `clients/<slug>/` or `company-wiki/`, not in a reference file every account's run reads.

Pull the data before you ask anything. Read closed-won and closed-lost from `{{CRM}}`, the churned accounts, reply rates by segment if campaigns have run, and the case studies on the website. Present what you found and ask for corrections rather than asking questions the data already answers.

Then ask, one at a time:

1. What do you sell, and what is the deal size range?
2. Name your five best customers, and say what makes each one good beyond the revenue.
3. Name your worst. Churned, unhappy, or the ones that took three times the effort. These carry more signal than the wins.
4. Have you done ICP work before? Anything existing gets built on rather than replaced.
5. Are you refining an existing segment or entering a new one?
6. Which channels reach these people today?

Write the answers into the matrix document, and write the placeholders into this file. If the answers to 2 and 3 are the same kind of company, say so out loud, because that usually means the fit criteria are not where the difference lives.

## Reference routing

| File | What it contains | When to read it | What breaks if you skip it |
|---|---|---|---|
| `references/scoring-model.md` | All three dimensions with attributes, data sources, scoring scales, how to set weights, and a full worked account walkthrough | While building the model, at steps 2 through 4 | The matrix becomes a list of adjectives nobody can score an account against |
| `references/tiers-and-output.md` | Tier thresholds, hard disqualifiers, the per-tier treatment matrix, and the deliverable template | At step 5, and whenever somebody asks what a tier actually means operationally | Tiers exist on paper and every account gets treated identically anyway |
| `references/validation.md` | The six validation methods with timing and pass marks, sample-size floors, and the calibration problems table with fixes | At step 6, and at every `{{REVIEW_CADENCE}}` review | A confident matrix built from assumptions, which is worse than no matrix because people act on it |

## Step 1 - Gather source material, in priority order

Never build from assumptions. Every attribute in the finished matrix traces to at least one source, and any attribute that cannot is labelled a hypothesis rather than quietly promoted.

1. Closed-won deal data: revenue, sales cycle, deal size.
2. Customer interviews and satisfaction responses.
3. Sales call transcripts and win/loss notes.
4. Campaign performance by segment: reply rates, meeting rates.
5. Website analytics: who visits and what they read.
6. Competitor customer analysis from public reviews and case studies.

**If there are no customers yet**, take the cold-start branch below rather than pretending the data exists.

### Cold start: no customers

State plainly in the document that this matrix is a hypothesis, then build it from what is available.

- **Competitor customers.** Identify three to five direct competitors and find their customers through case studies, public review sites, testimonials and job postings that name the product. Those companies share your likely ICP.
- **Founder network.** The first ten customers almost always come from somebody's existing network, so build the initial ICP around companies the founder can actually reach.
- **Problem first.** Instead of starting from firmographics, start from the pain. Who feels it most, who has budget, who has already tried and failed with an alternative.
- **Label every attribute** as hypothesis or validated, run two to four weeks of outbound against the hypothesis, and promote a segment to validated only on its own results.
- **Review at 50 touches per segment.** Below 2 percent reply, deprioritize. Above 5 percent, double down and add firmographic detail.

Worked example: a founder building a meeting-notes product for sales teams has no customers. Competitor case studies point at B2B SaaS companies with 20 to 200 reps, Series A to C, on one of the two major CRMs. That becomes the hypothesis. The founder's own network is strongest in fintech, so fintech B2B SaaS at 20 to 200 reps becomes the hypothesis Tier 1, because reachability decides which hypothesis you can actually test first. After 100 emails, fintech replies at 8 percent and general SaaS at 2 percent, and fintech gets promoted to validated.

## Step 2 - Score the three dimensions

An ICP is not one profile. It is a scored matrix across three dimensions that each answer a different question.

- **Firmographic: who they are.** Observable and quantifiable, and the easiest to score at scale.
- **Psychographic: why they buy.** The pain, the trigger, the budget, the decision structure. Hardest to score, most predictive.
- **Behavioral: how they signal readiness.** Time-sensitive, and it decays fast.

Firmographics alone give you a list of companies that look right and may never buy. Psychographics tell you which of them feel the pain. Behavioral signals tell you which of those are ready this week. Scored together they separate "could buy one day" from "should be in a sequence now". Attributes, scales and worked arithmetic are in `references/scoring-model.md`.

If you only have time to get one dimension right, make it psychographic. A perfect firmographic match with no pain alignment never converts, and it is the failure that looks most like success in a pipeline review.

## Step 3 - Spend gate. Runs before any enrichment, pull or export.

- Present the exact search parameters, the estimated row count and the estimated cost, then wait for `{{APPROVAL_OWNER}}`.
- Free checks first, then cheap ones, then expensive ones, then the export. Never spend a credit on a row you are about to discard, and treat that ordering as fixed rather than a preference.
- Sample before the full pull. Take 100 to 500 rows, show the first 20, take the correction, then run the rest.
- Test quietly. Present the parameter set that worked rather than the four that did not, because a wall of failed attempts trains the reviewer to skim, and a reviewer who skims approves things unread.

## Step 4 - Set the weights from your own data

Default weights are a starting point and they are somebody else's answer. Look at closed-won: if industry predicts close rate more strongly than revenue band, weight it higher. If geography is irrelevant because the product is fully remote, drop it to near zero rather than leaving it at the default and pretending.

Write the reason for each weight next to it. A weight with no reason next to it gets copied forward for two years by people who assume somebody measured it.

## Step 5 - Assemble the tiers

Combine into Tier 1, 2, 3 and disqualified, then attach the treatment each tier actually receives. A tier that does not change what happens to the account is a label rather than a tier. Thresholds, disqualifiers and the treatment matrix are in `references/tiers-and-output.md`.

Hard disqualifiers override the score entirely. Direct competitors, existing customers, excluded industries or geographies, anything below your minimum size, and any pattern you have already watched churn.

## Step 6 - Backtest, then validate against results

Score your existing customers with the finished model. **80 percent or more should land in Tier 1 or 2.** Below 60 percent means the model is miscalibrated, and the honest response is to fix the weights rather than to explain why your best customers score badly.

Then validate against live results using `references/validation.md`: an A/B of the same message to Tier 1 against Tier 3, rep feedback after ten meetings, funnel conversion by tier at 30 days, and a churn review each quarter. Nothing below 50 outbound touches per tier and 20 replies per tier is a result, it is a mood.

## Step 7 - Write-back gate. Runs before any bulk change to the CRM.

- Tier fields written back across thousands of records are hard to unpick, and they change what reps do the next morning.
- Show the count by tier, the exact field being written, and 20 sample records with their scores, then wait for `{{APPROVAL_OWNER}}`.
- Write to a new field rather than overwriting an existing one on the first run, so the old values survive a bad calibration.
- This skill proposes the write. A human runs it.

## What good looks like

A good run reads the data before it asks anything. The five best customers came out of the CRM with their deal sizes and cycles attached, and so did the four that churned, which is where the sharpest attribute came from: every churned account had bought without a named executive sponsor, so sponsor presence became a psychographic attribute worth 10 rather than a note in a doc. Weights came from closed-won rather than from the defaults in the reference, and each one has its reason written beside it, including the one set to zero because the product ships everywhere and geography does not predict anything. The pull was sampled at 200 rows and the first 20 were shown before anybody spent a credit on the rest, which caught a country filter matching on office addresses rather than headquarters. The backtest put 84 percent of existing customers in Tier 1 or 2, and the two that scored badly were both from a segment the company had already decided to stop selling to, which is a healthy miss rather than a broken model. Tier 1 came out at 6 percent of the addressable universe, and the treatment matrix says what Tier 1 actually gets: individual research, four channels, three contacts per account. The CRM write went out to a new field with 20 samples shown first, and it was a human who ran it. The changelog has one entry, dated, with the source next to it.

Mediocre looks like a matrix built in an afternoon from what everybody already believed, using the default weights unchanged. Every attribute is a range wide enough to include half the market, and there is no disqualifier list because nobody wanted to rule anything out. It was never backtested, so nobody knows that only a third of existing customers would score as Tier 1. It has no changelog, so six months later nobody remembers why headcount starts at 50. Its tiers exist in the document and every account gets the same three-step sequence anyway, and the first anyone hears about the calibration is a rep saying the Tier 1 list feels random.

## Hard rules

- MUST ground every attribute in at least one named data source, and label anything ungrounded as a hypothesis.
- MUST take the cold-start branch, and say the matrix is a hypothesis, when there are no customers to work backward from.
- MUST score all three dimensions. A firmographic filter alone is a list, not an ICP.
- MUST set weights from closed-won data and write the reason beside each weight.
- MUST present parameters, volume and cost before any enrichment or export, and sample before the full pull.
- MUST show the first 20 rows and take the correction before running the rest.
- MUST backtest against existing customers and report the percentage landing in Tier 1 or 2, including when it is bad.
- MUST attach an operational treatment to every tier, covering volume, research depth, channels and contacts per account.
- MUST log every change to the matrix with the data that prompted it and the date.
- NEVER write tier fields to the CRM without showing counts and samples and getting approval, and never overwrite an existing field on the first run.
- NEVER let behavioral signals alone lift an account into Tier 1. A minimum firmographic score is required regardless of how hot the signal is.
- NEVER call a tier verdict on fewer than 50 touches and 20 replies.
- NEVER leave a decayed signal in the score. Apply the recency multiplier, and drop anything past 90 days.
- NEVER present a matrix without its disqualifier list. The accounts you rule out are half the definition.
