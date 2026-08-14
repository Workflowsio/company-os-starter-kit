# The three-dimension scoring model

Read while building the model. Data source columns name categories of tool rather than specific products, because the products change and this file will not.

---

## Dimension 1: Firmographic (who they are)

Observable, quantifiable, publicly available, and therefore the easiest to score at scale.

| Attribute | How to define it | Where the data comes from |
|---|---|---|
| **Industry or vertical** | Specific sub-industries, not broad categories. "HR tech SaaS" rather than "technology". | Closed-won records, contact databases, professional networks |
| **Headcount** | A range. Include department headcount where it matters, such as "20 to 50 in engineering". | Company pages, contact databases |
| **Revenue band** | Annual revenue or recurring revenue, as a range. | Funding databases, company filings, contact databases |
| **Geography** | Country, region or city. Note the timezone consequences for outreach. | CRM, contact databases, the company website |
| **Funding stage** | Bootstrapped, seed, Series A to C, public. | Funding databases, press |
| **Business model** | B2B, B2C, marketplace, SaaS, services. | Website, review-site profile |
| **Tech stack** | The tools that indicate fit, whether integration, competitor or adjacent. | Technographic tools, job postings |
| **Company age** | Years since founding. A three-year-old company and a fifteen-year-old company buy differently. | Funding databases, company pages |

### Scoring

```
FIRMOGRAPHIC SCORE = sum of:
  Industry match:      0 no match  / 5 adjacent      / 10 exact match     [weight: high]
  Headcount range:     0 outside   / 5 edge of range / 10 sweet spot      [weight: high]
  Revenue band:        0 outside   / 5 edge          / 10 sweet spot      [weight: medium]
  Geography:           0 excluded  / 5 secondary     / 10 primary market  [weight: medium]
  Funding stage:       0 wrong     / 5 acceptable    / 10 ideal           [weight: low-med]
  Tech stack signals:  0 / 3 adjacent / 5 competitor / 8 integration      [weight: medium]
  Business model:      0 wrong     / 10 match                             [weight: high]

MAXIMUM: 63
```

Replace the scales rather than accepting them. If geography does not matter because the product is fully remote, cap it at 5 or drop it. If you only integrate with one platform, make tech stack a 0 or 10 binary and say so. Every change gets a reason written beside it.

### Good against bad

**Good, because you could score an account against it:**
- Industry: B2B SaaS in HR tech, specifically talent acquisition and workforce management
- Headcount: 50 to 500, with five or more in sales
- Revenue: 5M to 75M recurring
- Geography: US and UK, English-speaking markets only
- Funding: Series A to C, raised in the last 24 months
- Tech stack: one of the two major CRMs, plus a marketing automation tool

**Bad, because it describes half the companies in the world:**
- Industry: technology companies
- Headcount: mid-market
- Revenue: growing companies
- Geography: global
- Funding: well funded
- Tech stack: modern

You cannot build a list from the second one, you cannot score an account against it, and you cannot tell a rep who to call.

---

## Dimension 2: Psychographic (why they buy)

The internal motivations and decision patterns. This is what separates an ICP from a firmographic filter, and it is the most predictive of the three.

| Attribute | How to define it | Where the data comes from |
|---|---|---|
| **Primary pain points** | The three to five problems you actually solve, in the buyer's words rather than yours | Customer interviews, call transcripts, review sites, support tickets |
| **Buying triggers** | The events that make the pain urgent, such as a new sales leader or board pressure on pipeline | Job postings, news alerts, funding events, interview patterns |
| **Decision structure** | Who decides, who influences, who blocks. A solo founder and a five-person committee are different products. | Call notes, contacts per deal in the CRM |
| **Budget availability** | Whether budget for this category already exists | Funding data, job postings naming your category, spend signals in the tech stack |
| **Urgency** | How fast they need to solve it | Trigger recency, competitive pressure, regulatory deadlines |
| **Sophistication** | Whether they have tried to solve this before, in-house or with a vendor | Tech stack history, competitor reviews, related job postings |

For each pain point, map five things: who feels it most by title, what event makes it urgent, what they do today without you, what inaction costs them, and how you specifically solve it.

### Scoring

```
PSYCHOGRAPHIC SCORE = sum of:
  Pain alignment:      0 no match / 5 adjacent pain  / 10 the exact pain you solve
  Active trigger:      0 none     / 5 weak signal    / 10 strong and recent
  Budget indicators:   0 none     / 5 likely         / 10 confirmed spend in category
  Urgency:             0 none     / 5 moderate       / 10 immediate
  Sophistication fit:  0 too basic or too advanced / 5 adjacent / 10 ideal

MAXIMUM: 50
```

### Good against bad

**Good:**
- Pain: "Our reps spend three hours a day on research before writing a single email. We need the research step automated so they can sell." Taken verbatim from four customer interviews.
- Trigger: a new sales leader in the last 90 days, hired to double pipeline, replacing somebody who missed targets.
- Decision: the sales leader decides, revenue operations influences, finance approves above a threshold. Committee of three, cycle of 21 to 45 days.
- Budget: already spending on a sequencer and a contact database, so category budget exists.
- Sophistication: built something internally, or used a competitor for six months and hit its limits.

**Bad:**
- Pain: "They need better sales tools"
- Trigger: "They're growing"
- Decision: "The decision maker"
- Budget: "They can afford it"

You cannot write a cold email around "they need better sales tools", and you cannot build a trigger campaign around "they're growing".

---

## Dimension 3: Behavioral (how they signal readiness)

The most time-sensitive dimension and the hardest to capture at scale.

```
TIER A SIGNALS, 10 points each, high intent:
  - Visited your pricing page
  - Downloaded a resource or attended your event
  - Actively evaluating competitors
  - Leadership change in a buying role inside 90 days

TIER B SIGNALS, 5 points each, moderate intent:
  - Hiring for roles your product supports
  - Funding round inside 6 months
  - Engaged with your content in a way that took effort, such as a comment
  - Attended a relevant industry event

TIER C SIGNALS, 3 points each, weak but real:
  - Adopted an adjacent technology
  - Headcount growing more than 20 percent year on year
  - Published content on a topic you address
  - Opened or clicked a previous outbound email
```

### Where each signal comes from

| Signal | Source category | Cadence |
|---|---|---|
| Pricing page visit | Website analytics with visitor identification | Real-time alerts on identified companies |
| Resource download | Marketing automation | Track by company domain rather than by person |
| Competitor evaluation | Third-party intent data | Weekly pull |
| Leadership change | Professional network alerts, job-change feeds | Daily or weekly |
| Hiring signals | Job boards, enrichment | Weekly, filtered to relevant titles |
| Funding round | Funding databases, press | Weekly |
| Content engagement | Platform analytics, website analytics | Track at company level, not just person level |
| Event attendance | Sponsor and attendee lists | Enrich within 48 hours of the event |
| Tech adoption | Technographic tools | Monthly refresh |
| Headcount growth | Company pages, enrichment | Quarterly comparison |
| Email engagement | Your sequencer | Real-time, fed into the score |

### Scoring and decay

```
BEHAVIORAL SCORE = sum of detected signals, each multiplied by its recency factor

  under 7 days:   1.5x
  7 to 30 days:   1.0x
  30 to 90 days:  0.5x
  over 90 days:   0.25x, and consider dropping it entirely

MAXIMUM: uncapped
```

A funding round from six months ago is not the signal a funding round from two weeks ago is. Uncapped is deliberate, because signal stacking is real, but it is also why a minimum firmographic score is required for Tier 1 regardless of behavior. Without that floor, an unqualified company that visited your pricing page twice outranks a perfect-fit account that has been quiet.

---

## Worked walkthrough

A hypothetical account: B2B SaaS, 120 employees, Series B, 15M recurring revenue, US-based, running a major CRM and a sequencer.

**Firmographic**
- Industry B2B SaaS, exact match: 10
- Headcount 120 against a 50 to 500 sweet spot: 10
- Revenue 15M against a 5M to 75M band: 10
- Geography US, primary market: 10
- Funding Series B, ideal stage: 10
- Tech stack, an integration target: 8
- Business model match: 10
- Raw sum 68, **capped at the 63 maximum**. Note the cap rather than carrying 68 forward, because an uncapped dimension quietly reweights the whole model.

**Psychographic**
- Pain exact: 10
- New sales leader six weeks ago, strong recent trigger: 10
- Confirmed category spend: 10
- Board mandate inside 90 days, immediate: 10
- Used a competitor for a year and hit its limits: 10
- Total: **50**

**Behavioral**
- Pricing page three days ago: 10 x 1.5 = 15
- Two content engagements this week: 3 x 1.5 = 4.5
- Headcount up 30 percent year on year: 3 x 1.0 = 3
- Total: **22.5**

**Total: 63 + 50 + 22.5 = 135.5. Tier 1.** This account gets individual research, personalized outreach across email, social and phone, and three to five contacts multi-threaded.

Note what made it Tier 1: the psychographic 50, not the behavioral 22.5. An account with the same behavior and a psychographic score of 15 is a Tier 2 at best, and treating it as Tier 1 is the most common way a good model produces bad meetings.
