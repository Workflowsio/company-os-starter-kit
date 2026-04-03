# ICP Modeller

<!-- 
  WHAT THIS DOES: Builds a tiered Ideal Customer Profile matrix using firmographic,
  psychographic, and behavioral dimensions. Outputs a scored Tier 1/2/3 targeting
  framework with campaign mapping.
  
  HOW TO USE: Reference this file in your CLAUDE.md skills section. When you need
  to define or refine your ICP, tell Claude: "Use the ICP modeller skill to create
  our ICP matrix for [product/segment]." Provide your CRM data, customer list, and
  any campaign history. Claude will walk through each step.
-->

## Customize This Skill

This is a template, not a finished skill. Before using it for real work, customize it for your business.

When this skill is loaded for the first time, Claude should:
1. Ask the user about their specific context (industry, ICP, tools, voice, processes)
2. Suggest specific edits to the frameworks and templates below
3. Update the skill file with the user's answers
4. Only then proceed to execute the skill

To customize, tell Claude: "Read this skill and help me adapt it for my business. Interview me about what needs to change."

The frameworks below are proven starting points from running hundreds of campaigns. But they work 10x better once you plug in your specific tools, voice, and data.

## When to Use

- Defining or formalizing your ICP for the first time
- Refining targeting after 3+ months of campaign data
- Expanding into a new market segment or vertical
- Quarterly ICP review (recommended cadence: every 90 days)
- Pre-revenue: validating your assumptions before spending on outbound

---

## Before You Start

**Gather context from the user before building the matrix.** Ask for:

1. **What do you sell?** (Product/service, key value prop, pricing/ACV range)
2. **Who are your best customers today?** (Company names, industries, sizes, what makes them great)
3. **Who are your worst customers?** (Churned, low NPS, bad fit. Equally important.)
4. **What data do you have?** (CRM export, customer list, campaign history, win/loss notes)
5. **Have you done ICP work before?** (Existing definitions, personas, or targeting criteria to build on)
6. **What channels are you using to reach them?** (Outbound email, LinkedIn, ads, inbound, events)
7. **Are you expanding into a new segment, or refining an existing one?**

Do not build from assumptions. If the user has no data at all, start with their best 5-10 customers and work backward. If they have zero customers, follow the Pre-Revenue Workflow below.

---

## Pre-Revenue Workflow

If the company has no customers yet, you cannot work backward from closed-won data. Use this approach instead.

**Step 1: Competitor customer analysis.** Identify 3-5 direct competitors. Find their customers through case studies, G2 reviews, LinkedIn testimonials, and job postings that mention the competitor's product. These companies share your likely ICP.

**Step 2: Founder network analysis.** Look at the founder's LinkedIn connections, previous roles, and industry experience. The first 10 customers almost always come from the founder's existing network. Build the ICP around companies the founder can actually reach.

**Step 3: Problem-first definition.** Instead of starting with firmographics, start with the pain point. Who feels this pain most acutely? Who has budget to solve it? Who has tried and failed with alternatives? Those answers define your initial ICP.

**Step 4: Hypothesis matrix.** Build a preliminary matrix (use the same framework below) but label every attribute as "hypothesis" or "validated." Run 2-4 weeks of outbound against the hypothesis. Track reply rates, meeting rates, and objections by segment. Promote high-performing segments to "validated."

**Step 5: Rapid iteration.** Review after 50 outbound touches per segment. If a segment shows <2% reply rate, deprioritize it. If a segment shows >5% reply rate, double down and add more firmographic detail.

**Pre-revenue example:**

A founder is building an AI meeting notetaker for sales teams. No customers yet. Competitor analysis of Gong, Chorus, and Fireflies shows their customers are B2B SaaS companies with 20-200 reps, Series A-C funding, using Salesforce or HubSpot CRM. That becomes the hypothesis ICP. The founder's network is strongest in fintech, so fintech B2B SaaS 20-200 reps becomes Tier 1 hypothesis. After 100 cold emails, fintech shows 8% reply rate while general SaaS shows 2%. Fintech gets promoted to validated Tier 1.

---

## Framework

### The ICP Matrix: Three Dimensions

An ICP is not a single profile. It is a scored, tiered matrix built across three dimensions. Each dimension contributes independently to the total score.

```
Dimension 1: Firmographic (WHO they are)
    +
Dimension 2: Psychographic (WHY they buy)
    +
Dimension 3: Behavioral (HOW they signal readiness)
    =
Tiered ICP Matrix (Tier 1 / Tier 2 / Tier 3 / Disqualified)
```

**Why three dimensions matter:** Firmographics alone give you a list of companies that look right but may never buy. Psychographics tell you which of those companies actually feel the pain you solve. Behavioral signals tell you which of those are ready to buy right now. Scoring all three together separates "could buy someday" from "should be in a sales sequence this week."

---

### Step 1: Gather Source Material

Collect: CRM closed-won data, sales call transcripts, customer interviews, campaign performance data, your website/case studies, and any previous ICP work.

**Source priority (most reliable first):**
1. Closed-won deal data from CRM (revenue, sales cycle, deal size)
2. Customer interviews and NPS survey responses
3. Sales call transcripts and win/loss notes
4. Campaign performance data (reply rates, meeting rates by segment)
5. Website analytics (who visits, what pages, conversion rates)
6. Competitor customer analysis (G2, case studies, LinkedIn)

**Critical:** Never build an ICP from assumptions alone. Every attribute must be grounded in at least one data source. If no data exists yet, use the Pre-Revenue Workflow above.

---

### Step 2: Define Firmographic Attributes

Firmographics describe the observable, quantifiable characteristics of target companies. These are the easiest to score at scale because the data is publicly available.

| Attribute | How to Define | Data Sources |
| --- | --- | --- |
| **Industry / Vertical** | List specific sub-industries, not broad categories. "HR Tech SaaS" not "Technology." | CRM closed-won, Apollo, Clay, LinkedIn Sales Navigator, ZoomInfo |
| **Company Size (Headcount)** | Define as a range. Include department-specific headcount when relevant (e.g., "20-50 in engineering"). | LinkedIn company page, Apollo, Clay, ZoomInfo, BuiltWith |
| **Revenue Range** | Annual revenue or ARR. Use ranges (e.g., $5M-$50M ARR). | PitchBook, Crunchbase, ZoomInfo, Apollo, annual reports |
| **Geography** | Country, region, or city. Note timezone implications for outreach. | CRM, Apollo, LinkedIn, company website |
| **Funding Stage** | Bootstrapped, Seed, Series A-C+, Public. | Crunchbase, PitchBook, TechCrunch, Clay enrichment |
| **Business Model** | B2B, B2C, B2B2C, Marketplace, SaaS, Services. | Company website, G2 profile, LinkedIn description |
| **Tech Stack** | Tools they use that indicate fit (e.g., "uses HubSpot CRM" or "runs on AWS"). | BuiltWith, Wappalyzer, HG Insights, Clay tech stack enrichment |
| **Company Age** | Years since founding. Startups (<3yr) vs. established (10+yr) behave differently. | Crunchbase, LinkedIn, company website |

#### Firmographic Scoring Model

Build a weighted scoring model. Weights should reflect which attributes most predict deal closure for YOUR business. Default weights below are starting points.

**How to set weights:** Look at your closed-won deals. If industry is the strongest predictor of close rate, weight it highest. If revenue range matters more than geography, weight accordingly. When in doubt, use the defaults below and adjust after 30 days of campaign data.

```
FIRMOGRAPHIC SCORE = SUM OF:
  Industry match:        0 (no match) / 5 (adjacent) / 10 (exact match)       [WEIGHT: HIGH]
  Headcount range:       0 (outside) / 5 (edge of range) / 10 (sweet spot)    [WEIGHT: HIGH]
  Revenue range:         0 (outside) / 5 (edge) / 10 (sweet spot)             [WEIGHT: MEDIUM]
  Geography:             0 (excluded) / 5 (secondary market) / 10 (primary)   [WEIGHT: MEDIUM]
  Funding stage:         0 (wrong stage) / 5 (acceptable) / 10 (ideal stage)  [WEIGHT: LOW-MED]
  Tech stack signals:    0 / 3 (adjacent) / 5 (competitor) / 8 (integration)  [WEIGHT: MEDIUM]
  Business model:        0 (wrong) / 10 (match)                               [WEIGHT: HIGH]

MAX FIRMOGRAPHIC SCORE: 63
```

**Customizing weights:** Replace the default 0/5/10 scales with your own. If geography does not matter for your product (fully remote/digital), drop it to 0/0/5 max. If tech stack is a hard requirement (you only integrate with Salesforce), make it 0/0/10 binary.

#### Firmographic Examples: Good vs Bad

**Good firmographic definition (specific, testable):**
- Industry: B2B SaaS in HR Tech, specifically talent acquisition and workforce management platforms
- Headcount: 50-500 employees, with 5+ in sales or business development
- Revenue: $5M-$75M ARR
- Geography: US and UK, English-speaking markets only
- Funding: Series A through Series C, raised in last 24 months
- Tech stack: Uses Salesforce or HubSpot CRM, has a marketing automation tool (Marketo, HubSpot, Pardot)

**Bad firmographic definition (vague, untestable):**
- Industry: "Technology companies"
- Headcount: "Mid-market"
- Revenue: "Growing companies"
- Geography: "Global"
- Funding: "Well-funded"
- Tech stack: "Modern stack"

The bad example describes half the companies in the world. You cannot build a campaign list from it, you cannot score accounts against it, and you cannot tell your SDR team who to call.

---

### Step 3: Define Psychographic Attributes

Psychographics describe the internal motivations, pain points, and decision-making patterns. This is what separates a good ICP from a generic firmographic filter.

| Attribute | How to Define | Data Sources |
| --- | --- | --- |
| **Primary Pain Points** | The 3-5 specific problems you solve. Use the buyer's language, not yours. | Customer interviews, sales call transcripts, G2 reviews (yours and competitors), support tickets, NPS surveys |
| **Buying Triggers** | Events that make the pain urgent. "Just hired a VP Sales" or "Board pressure for pipeline." | LinkedIn job postings, news alerts, Crunchbase funding events, customer interview patterns |
| **Decision-Making Structure** | Who decides, who influences, who blocks. Solo founder vs. committee. | Sales call notes, CRM deal data (contacts per deal), org chart analysis |
| **Budget Availability** | Do they have budget allocated for this type of solution? | Funding data, job postings mentioning your category, tech stack spend signals |
| **Urgency Level** | How fast do they need to solve this? | Trigger recency, competitive pressure, regulatory deadlines, board/investor pressure |
| **Sophistication Level** | Have they tried to solve this before? DIY attempts vs. first-time buyers. | Tech stack history, G2 reviews of competitors, job postings for related roles |

**For each pain point, map:**
- Who feels it most (title, department, seniority)
- When it becomes urgent (what event triggers action)
- The current workaround (what they do today without your product)
- The cost of inaction (what happens if they do nothing)
- How you solve it (your specific differentiation)

#### Psychographic Scoring

```
PSYCHOGRAPHIC SCORE = SUM OF:
  Pain point alignment:   0 (no match) / 5 (adjacent pain) / 10 (exact pain you solve)
  Active buying trigger:  0 (none detected) / 5 (weak signal) / 10 (strong, recent trigger)
  Budget indicators:      0 (no budget) / 5 (likely has budget) / 10 (confirmed budget/spend)
  Urgency signals:        0 (none) / 5 (moderate) / 10 (immediate need)
  Sophistication match:   0 (too basic or too advanced) / 5 (adjacent) / 10 (ideal)

MAX PSYCHOGRAPHIC SCORE: 50
```

#### Psychographic Examples: Good vs Bad

**Good psychographic definition:**
- Pain: "Our SDRs spend 3 hours/day on manual research before writing a single email. We need to automate the research step so they can focus on selling." (Exact buyer language from 4 customer interviews.)
- Trigger: VP Sales hired in last 90 days, tasked with doubling pipeline. Previous VP was fired for missed targets.
- Decision: VP Sales decides, RevOps influences, CFO approves above $25K/year. Average buying committee is 3 people. Sales cycle is 21-45 days.
- Budget: Companies spending $50K+/year on sales tools already (visible through tech stack: Outreach + ZoomInfo + Salesforce = budget exists).
- Sophistication: Has tried building internal tools or used a competitor for 6+ months and hit limitations.

**Bad psychographic definition:**
- Pain: "They need better sales tools"
- Trigger: "They're growing"
- Decision: "The decision maker"
- Budget: "They can afford it"
- Sophistication: "They understand the space"

The bad example gives you nothing to work with. You cannot write a cold email around "they need better sales tools." You cannot build a trigger-based campaign around "they're growing."

---

### Step 4: Define Behavioral Attributes

Behavioral attributes capture what a company or its people are actively doing that signals readiness to buy. These are the most time-sensitive signals and the hardest to capture at scale.

#### Behavioral Signal Tiers

```
TIER A SIGNALS (10 points each - high intent):
  - Visited your pricing page
  - Downloaded a resource or attended your webinar
  - Currently evaluating competitors (G2 comparison, demo requests)
  - Leadership change in buying role (new CRO/VP/CMO < 90 days)

TIER B SIGNALS (5 points each - moderate intent):
  - Hiring for roles your product supports
  - Recent funding round (< 6 months)
  - Engaged with your LinkedIn content (commented, not just liked)
  - Attended a relevant industry event

TIER C SIGNALS (3 points each - weak but relevant):
  - Adopted adjacent technology
  - Company headcount growing > 20% YoY
  - Published content on topics you address
  - Opened/clicked a previous outbound email
```

#### Where to Detect Each Signal

| Signal | Data Source | How to Monitor |
| --- | --- | --- |
| Pricing page visit | Your website analytics (GA4, HubSpot, Clearbit Reveal) | Set up real-time alerts for identified companies |
| Resource download | Marketing automation (HubSpot, Marketo, Pardot) | Track by company domain, not just individual |
| Competitor evaluation | G2 buyer intent, Bombora, TrustRadius | Weekly intent data pulls |
| Leadership change | LinkedIn Sales Navigator alerts, Apollo job change alerts | Daily or weekly automated scans |
| Hiring signals | LinkedIn job postings, Indeed, Clay enrichment | Weekly scrapes filtered by relevant job titles |
| Funding round | Crunchbase alerts, PitchBook, TechCrunch | Weekly funding round monitoring |
| Content engagement | LinkedIn analytics, website analytics | Track company-level, not just contact-level |
| Event attendance | Event sponsor lists, attendee lists (when available) | Post-event enrichment within 48 hours |
| Tech adoption | BuiltWith alerts, HG Insights, Clay | Monthly tech stack refresh |
| Headcount growth | LinkedIn, Apollo, Clay enrichment | Quarterly comparison |
| Content publishing | LinkedIn company page, company blog | Monthly scan of target accounts |
| Email engagement | Your email platform (Instantly, Outreach, HubSpot) | Real-time tracking, feed into scoring |

#### Behavioral Scoring

```
BEHAVIORAL SCORE = SUM OF ALL DETECTED SIGNALS (after recency multiplier)

Signal recency multiplier:
  < 7 days old:   1.5x
  7-30 days old:  1.0x
  30-90 days old: 0.5x
  > 90 days old:  0.25x (consider dropping)

MAX BEHAVIORAL SCORE: Uncapped (more signals = higher score)
```

---

### Step 5: Combine Into Tiered ICP Matrix

```
TOTAL ICP SCORE = Firmographic Score + Psychographic Score + Behavioral Score

Tier assignment:
  Tier 1 (Bullseye):    Firmographic >= 40 AND Psychographic >= 30 AND Total >= 80
  Tier 2 (Strong Fit):  Firmographic >= 25 AND Psychographic >= 20 AND Total >= 50
  Tier 3 (Good Fit):    Firmographic >= 15 AND Total >= 30
  Disqualified:         Firmographic < 15 OR Total < 30 OR hard disqualifier triggered
```

**Hard disqualifiers** (override score, instant DQ):
- Direct competitor
- Existing customer (route to expansion/upsell, not outbound)
- Excluded industry (regulated, restricted, or poor-fit verticals)
- Excluded geography (cannot serve, legal restrictions)
- Below minimum company size threshold
- Known bad-fit pattern (e.g., companies that churned within 90 days in the past)

#### Tier Treatment Matrix

| Attribute | Tier 1 (Bullseye) | Tier 2 (Strong Fit) | Tier 3 (Good Fit) | Disqualified |
| --- | --- | --- | --- | --- |
| **Volume** | 50-200 accounts | 200-500 accounts | 500-2,000 accounts | Do not contact |
| **Research depth** | Individual account research | Segment-level research | Minimal research | N/A |
| **Personalization** | Hyper-personalized (account-specific pain points, recent news, mutual connections) | Signal-based (trigger-specific, segment-level pain) | Bucket personalization (segment-level, template-driven) | N/A |
| **Channels** | Email + LinkedIn + Phone + Direct mail (for top 50) | Email + LinkedIn | Email only | N/A |
| **Contacts per account** | 3-5 (multi-thread the deal) | 2-3 | 1-2 | N/A |
| **Follow-up cadence** | 4-step sequence + manual LinkedIn touches + phone attempts | 4-step automated sequence | 3-step automated sequence | Suppress from all lists |
| **Expected reply rate** | 8-15% | 4-8% | 1-4% | N/A |
| **Sales involvement** | AE-led, SDR supports | SDR-led, AE joins at meeting stage | Fully automated, SDR reviews replies only | N/A |

#### Scoring Example (Walkthrough)

**Company: Acme Corp** (hypothetical B2B SaaS, 120 employees, Series B, $15M ARR, US-based, uses Salesforce + Outreach)

Firmographic scoring:
- Industry: B2B SaaS = exact match = 10
- Headcount: 120, sweet spot is 50-500 = 10
- Revenue: $15M, sweet spot is $5M-$75M = 10
- Geography: US = primary market = 10
- Funding: Series B = ideal stage = 10
- Tech stack: Salesforce (integration target) = 8
- Business model: B2B SaaS = match = 10
- **Firmographic total: 68** (capped at 63, but shows strong fit across all dimensions)

Psychographic scoring:
- Pain: "SDRs doing too much manual research" = exact pain = 10
- Trigger: New VP Sales hired 6 weeks ago = strong recent trigger = 10
- Budget: Spends on Outreach + ZoomInfo = confirmed spend = 10
- Urgency: VP Sales has 90-day mandate from board = immediate = 10
- Sophistication: Used a competitor for 1 year, hit limitations = ideal = 10
- **Psychographic total: 50**

Behavioral scoring:
- Visited pricing page 3 days ago = 10 x 1.5 = 15
- VP Sales liked 2 LinkedIn posts this week = 3 x 1.5 = 4.5
- Headcount grew 30% YoY = 3 x 1.0 = 3
- **Behavioral total: 22.5**

**Total: 63 + 50 + 22.5 = 135.5. Tier 1 (Bullseye).** This account gets individual research, hyper-personalized outreach across email + LinkedIn + phone, with 3-5 contacts multi-threaded.

---

### Step 6: Validate and Iterate

An ICP matrix is a living document. Never treat it as finished. Validate with real data and refine based on results.

#### Validation Methods

| Method | Timing | What to Check | What "Good" Looks Like |
| --- | --- | --- | --- |
| **Backtesting** | At build time | Score your existing customers. 80%+ should land in Tier 1 or 2. | If <60% of closed-won customers score as Tier 1/2, your scoring is miscalibrated. Adjust weights. |
| **Campaign A/B test** | First 2 weeks | Run the same message to Tier 1 vs Tier 3 accounts. Compare reply and meeting rates. | Tier 1 reply rate should be 2-3x higher than Tier 3. If not, the tiers are not differentiating real fit. |
| **Sales feedback** | After 10 meetings | Ask the AE: "Did this feel like a real opportunity?" Track by tier. | 70%+ of Tier 1 meetings should be qualified opportunities. <50% means psychographic scoring is off. |
| **Conversion funnel** | After 30 days | Track lead-to-meeting and meeting-to-deal conversion by tier. | Tier 1 should convert to deals at 2x+ the rate of Tier 2. |
| **Churn analysis** | Quarterly | Which customer segments churned? | If a segment churns at >2x the average, remove it from Tier 1/2 or add it as a disqualifier. |
| **Negative pattern review** | Monthly | What do your worst deals have in common? | Add negative patterns as hard disqualifiers or scoring penalties. |

#### Validation Benchmarks

- **Minimum sample size:** 50 outbound touches per tier before drawing conclusions
- **Statistical confidence:** Do not change the matrix based on fewer than 20 replies per tier
- **Review cadence:** Minor tweaks at week 2-4, first major review at month 2, full recalibration at quarter 2
- **Documentation:** Log every change to the matrix with the data that prompted it. Keep a changelog.

#### Common Calibration Problems

| Symptom | Likely Cause | Fix |
| --- | --- | --- |
| All accounts score Tier 1 | Firmographic criteria too broad | Tighten industry, headcount, or revenue ranges |
| Almost no accounts score Tier 1 | Criteria too narrow or weights too demanding | Lower thresholds or relax 1-2 attributes |
| Tier 3 outperforms Tier 1 in reply rate | Wrong attributes weighted high | Re-analyze closed-won data, swap weight priorities |
| High reply rate but low close rate | Firmographic fit is right, psychographic fit is wrong | Add pain point and budget validation to scoring |
| High meetings but "not a fit" feedback from AEs | Behavioral signals inflating scores for poor-fit accounts | Require minimum firmographic score regardless of behavioral signals |

---

## Output Template

When the ICP matrix is complete, produce a document in this format. This is the deliverable.

```markdown
# ICP Matrix: [Company Name] - [Product/Segment]
**Created:** [Date]  |  **Last Updated:** [Date]  |  **Status:** [Hypothesis / Validated]
**Review cadence:** Every 90 days  |  **Next review:** [Date]

## 1. Product Context
- **What we sell:** [1-2 sentences]
- **Key value prop:** [The core promise in buyer language]
- **ACV range:** [e.g., $15K-$50K/year]
- **Sales cycle:** [e.g., 21-45 days]

## 2. Tier 1 (Bullseye) - [X] accounts
**Firmographic profile:**
- Industry: [specific]
- Headcount: [range]
- Revenue: [range]
- Geography: [specific]
- Funding: [stage]
- Tech stack: [required tools]

**Psychographic profile:**
- Primary pain: [in buyer's words]
- Buying trigger: [specific event]
- Decision maker: [title]
- Budget signal: [how you know they can pay]
- Sophistication: [what they have tried before]

**Behavioral signals to monitor:**
- [Signal 1 + data source]
- [Signal 2 + data source]
- [Signal 3 + data source]

**Campaign treatment:**
- Channels: [e.g., Email + LinkedIn + Phone]
- Personalization: [level and approach]
- Contacts per account: [number]
- Sequence: [length and type]

## 3. Tier 2 (Strong Fit) - [X] accounts
[Same structure as Tier 1]

## 4. Tier 3 (Good Fit) - [X] accounts
[Same structure as Tier 1]

## 5. Disqualified Segments
- [Segment 1]: [reason]
- [Segment 2]: [reason]
- [Segment 3]: [reason]

## 6. Hard Disqualifiers
- [Rule 1]
- [Rule 2]
- [Rule 3]

## 7. Scoring Model
[Paste the full scoring tables from above with your customized weights]

## 8. Validation Plan
- **Backtest result:** [X% of existing customers scored Tier 1/2]
- **A/B test plan:** [What you will test in the first 2 weeks]
- **Review triggers:** [What data points would cause an early review]

## 9. Changelog
| Date | Change | Data That Prompted It |
| --- | --- | --- |
| [Date] | Initial build | [Source] |
```

---

## Tips

- Start every ICP matrix by analyzing your best 10 customers. What do they have in common? That pattern IS the Tier 1 definition. Work backward from proven buyers, not forward from assumptions.
- Psychographic attributes are harder to score at scale but are the most predictive dimension. A perfect firmographic match with no pain point alignment will never convert. If you only have time to get one dimension right, make it psychographics.
- Behavioral signals decay fast. A funding round from 6 months ago is not the same signal as one from 2 weeks ago. Always apply recency multipliers.
- If Tier 1 is more than 15% of your total addressable market, the definition is too broad. If it is less than 3%, it is too narrow for sustainable campaign volume.
- Tech stack signals are underrated. A company using a direct competitor has proven budget, proven need, and proven buying behavior. That is a Tier A behavioral signal even without other data.
- This matrix feeds directly into your persona-builder and cold-email-writer skills. Build the matrix first, then build personas, then write copy.
- For companies with fewer than 20 customers, supplement CRM data with competitor customer analysis. Find who buys from competing products. Those companies share your ICP.
- The ICP is not a marketing exercise. It is an operational tool. If your SDR team cannot use it to build a list in 15 minutes, it is too abstract. If your AE cannot use it to qualify a deal in the first 5 minutes of a call, it is missing psychographic detail.
- Update the matrix when you lose a deal you expected to win. Those losses contain more ICP signal than your wins.
- Never let the ICP become a document that lives in a drawer. Pin it in Slack, reference it in pipeline reviews, and use it as the entry point for every campaign brief.
