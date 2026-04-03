# GTM Strategist

<!-- 
  WHAT THIS DOES: Helps you design, audit, or rebuild your go-to-market motion
  from scratch. Covers the modern B2B GTM stack, channel strategy, motion design,
  budget allocation, and the metrics that actually matter. Works for any B2B company
  at any stage.
  
  HOW TO USE: Reference this file in your CLAUDE.md skills section. Tell Claude:
  "Use the GTM strategist skill to [design our GTM motion / audit our current
  stack / plan our channel strategy]." Provide your ICP, current tools, budget,
  team size, and any existing performance data.
-->

## Customize This Skill

This is a template, not a finished skill. The frameworks below are proven starting points, but they work 10x better once you plug in your specific tools, data, and priorities.

**First-time setup:** Tell Claude: "Read this skill and help me adapt it for my business. Interview me about what needs to change."

### Customization Interview (Claude runs this)

Ask these questions in order. Update this file with the answers.

**Round 1 - Business Basics**
1. What do you sell and to whom? (Product/service, target market, typical deal size)
2. How many people are on your GTM team? (Just you, 2-3, dedicated team, 10+)
3. What is your current annual GTM budget? (Tools + ads + headcount)
4. What stage are you at? (Pre-revenue, early traction, scaling, established)

**Round 2 - Current State**
5. List every tool in your GTM stack right now. (CRM, email, enrichment, analytics, everything)
6. Which channel drives most of your pipeline today? (Outbound, inbound, referrals, events, product)
7. What is your current pipeline-to-close ratio? (Or best guess)
8. What is your biggest GTM bottleneck right now? (Not enough leads, low conversion, bad data, no process)

**Round 3 - Goals**
9. What does success look like in 90 days? (Pipeline target, meetings booked, revenue)
10. Are you trying to fix something broken or build something new?
11. What have you already tried that did not work?
12. Who makes the final call on GTM spend? (You, a board, a co-founder)

After collecting answers, Claude should:
- Fill in the "Current State" column in the audit checklist with the user's actual tools
- Flag which layers of the stack have gaps
- Pre-populate the budget section with real numbers
- Recommend which GTM motion fits their stage and resources
- Save all changes to this file

## When to Use

- Designing a GTM motion from scratch (new company, new product, new market)
- Auditing an existing GTM stack for gaps, redundancy, or misalignment
- Planning channel strategy (where to invest time and budget)
- Evaluating whether to go outbound-led, inbound-led, product-led, or partner-led
- Budget allocation across GTM channels and tools
- Diagnosing why pipeline is not converting despite high activity

---

## Before You Start

**Gather context from the user before designing or auditing.** Ask for:

1. **What do you sell and to whom?** (Product/service, target market, ACV range)
2. **What stage are you at?** (Pre-revenue, $0-500K ARR, $500K-2M, $2M+)
3. **What is your current GTM motion?** (Outbound, inbound, product-led, partner, or "we don't really have one")
4. **What tools are you using today?** (CRM, email sequencing, enrichment, analytics, anything)
5. **What is your GTM budget?** (Monthly spend on tools, ads, headcount dedicated to GTM)
6. **What is working and what is not?** (Best channel, worst channel, biggest bottleneck)
7. **Team size dedicated to GTM?** (Founder only, 1-2 people, dedicated team)
8. **What does success look like in 90 days?** (Pipeline target, meetings/month, revenue goal)

Do not recommend a stack or strategy without understanding their current state. A pre-revenue founder needs a completely different playbook than a $5M ARR company with 3 SDRs.

---

## The GTM Stack Framework

A modern B2B GTM stack has five layers. Each layer has a single job. If any layer is missing or broken, the whole system underperforms. The layers build on each other - you cannot fix a sequencing problem if the data layer is broken.

### Layer 1: Data Layer (Foundation)

**Job:** Build and maintain a clean, reliable database of accounts and contacts you can sell to.

This is the base of everything. Bad data means wasted effort in every layer above it. The data layer answers one question: "Who are we selling to and how do we reach them?"

**Core components:**
- **CRM** - Your single source of truth for all customer and prospect data. Every touchpoint, deal, and conversation lives here.
- **Contact database** - Where you source new prospects. This feeds your outbound and ABM motions.
- **Data hygiene** - Deduplication, bounce monitoring, job change detection, and regular cleanup. Data degrades at 2-3% per month if you do nothing.

**What good looks like:** CRM is clean and current. Contact data has <3% bounce rate. New records are deduplicated on import. No manual spreadsheet wrangling. One person owns data quality.

**What bad looks like:** CRM is a graveyard of stale records. Sales team keeps their own spreadsheets. Nobody trusts the data. You have 50,000 contacts but cannot tell which 500 matter right now. Duplicate records everywhere.

### Layer 2: Enrichment Layer (Intelligence)

**Job:** Turn raw contact data into prioritized, actionable signals that tell you WHO to talk to and WHEN.

Raw contact data is not enough. You need to know when a prospect is ready to buy, not just who they are. This layer sits between your data and your outbound execution - it decides what gets acted on.

**Core components:**
- **Signal detection** - Job postings, funding rounds, leadership changes, tech stack changes, website visits, content engagement. These are buying triggers, not just data points.
- **Scoring and prioritization** - Which accounts are showing buying signals right now? Score them. Rank them. Route the hottest ones to your best reps.
- **Research automation** - AI-powered company and prospect research that scales beyond what a human can do manually. Personalization at volume requires this.

**What good looks like:** Your team knows which 50 accounts to focus on this week, and why. Signals are fresh (<7 days old). Scoring is calibrated against actual closed-won data. Reps trust the prioritization enough to follow it.

**What bad looks like:** Every lead is treated the same. No signal tracking. Reps pick accounts based on gut feel or alphabetical order. You have intent data but nobody looks at it. Scoring exists but was set up 18 months ago and never recalibrated.

### Layer 3: Sequencing Layer (Execution)

**Job:** Reach the right people at the right time through the right channel with the right message.

This is where outbound emails, LinkedIn messages, phone calls, and ads get orchestrated. The sequencing layer turns your ICP and signal data into actual conversations.

**Core components:**
- **Email sequencing** - Automated multi-step email campaigns with personalization, A/B testing, and reply detection.
- **LinkedIn automation** - Connection requests, follow-up messages, and content engagement at scale.
- **Phone / voice** - Cold calls, warm calls, and voicemail drops. Still the highest-conversion channel for certain personas (especially C-suite and VP-level buyers).
- **Ad platforms** - Retargeting, ABM display ads, and LinkedIn ads for awareness and air cover.

**What good looks like:** Sequences are personalized per tier (not one-size-fits-all). Reply rates exceed 5%. Channels are coordinated (email + LinkedIn + phone, not email OR LinkedIn). Timing aligns with signal data from Layer 2.

**What bad looks like:** One generic sequence for every prospect. Email and LinkedIn run as separate silos. No A/B testing. Reply rate under 1% but volume keeps increasing. Sequences are 7+ steps of increasingly desperate follow-ups with no new value in each step.

### Layer 4: CRM Layer (Pipeline)

**Job:** Track every deal from first touch to closed-won with full visibility and accurate forecasting.

The CRM layer is not just about storing data (that is Layer 1). This layer is about pipeline management, deal progression, and revenue forecasting. It answers: "How healthy is our pipeline and what is going to close?"

**Core components:**
- **Deal pipeline** - Stages that reflect your actual sales process. Not generic stages you copied from a template. Each stage should have clear entry/exit criteria.
- **Activity tracking** - Every email, call, meeting, and note logged automatically. Reps should not be spending time on data entry.
- **Reporting and forecasting** - Pipeline value, stage conversion rates, average deal cycle, win/loss reasons. Updated in real-time, not manually assembled for a Monday meeting.

**What good looks like:** Every deal has a next step and a close date. Pipeline reviews take 15 minutes because the data is already there. Forecasts are within 15% of actuals. You can see which deals are stuck and why.

**What bad looks like:** Pipeline stages are meaningless ("Interested" - interested in what?). Reps update deals once a week before the pipeline review. Forecasts are off by 40%+. Half the pipeline is zombie deals that should have been closed-lost months ago. Win/loss reasons are never recorded.

### Layer 5: Analytics Layer (Learning)

**Job:** Measure what works, kill what does not, and close the feedback loop between activity and revenue.

Without analytics, you are guessing. The analytics layer connects your GTM activities to actual revenue outcomes and tells you where to double down or cut.

**Core components:**
- **Attribution** - Which channels, campaigns, and touchpoints are creating pipeline and revenue? First-touch, last-touch, and multi-touch models all have a place. Pick one to start.
- **Campaign performance** - Reply rates, meeting rates, opportunity rates, and win rates by segment, persona, and channel.
- **Revenue metrics** - CAC, LTV, payback period, pipeline velocity, and net revenue retention.

**What good looks like:** You can answer "what is our best-performing channel by revenue per dollar spent?" in under 60 seconds. Weekly metrics reviews happen and lead to actual changes. Attribution model is agreed upon across sales and marketing.

**What bad looks like:** No attribution. Marketing claims credit for everything. Sales says all leads are junk. Nobody knows which channel produced the last 10 closed-won deals. You have dashboards nobody looks at. Data exists in 5 different tools and nobody reconciles it.

---

## Tool Selection by Category

For each layer, here are the tool categories you need and 3-5 options per category. No single vendor owns the whole stack. Pick tools that integrate well with each other.

### CRM
| Tool | Best For | Price Range |
| --- | --- | --- |
| HubSpot | SMB to mid-market. Free tier is strong. | Free - $1,600/mo |
| Salesforce | Enterprise and complex sales processes. | $25 - $300/user/mo |
| Pipedrive | Small teams that want simplicity. | $15 - $99/user/mo |
| Close | Inside sales teams. Built-in calling. | $49 - $139/user/mo |
| Attio | Modern teams that want flexibility. | $29 - $119/user/mo |

### Contact Data and Enrichment
| Tool | Best For | Price Range |
| --- | --- | --- |
| Apollo | All-in-one prospecting + enrichment. Large database. | Free - $99/user/mo |
| Clay | Waterfall enrichment + AI research. Most flexible. | $149 - $800/mo |
| ZoomInfo | Enterprise. Largest database. Highest price. | Custom ($$$$) |
| Cognism | European data. GDPR-compliant. Phone numbers. | Custom ($$$) |
| Lusha | Quick enrichment. Simple UI. Good for small teams. | Free - $79/user/mo |

### Email Sequencing
| Tool | Best For | Price Range |
| --- | --- | --- |
| Instantly | High-volume cold email. Multi-inbox rotation. | $30 - $77/mo |
| Smartlead | Similar to Instantly. Strong deliverability tools. | $39 - $94/mo |
| Outreach | Enterprise sales engagement. Multi-channel. | Custom ($$$) |
| Salesloft | Enterprise. Strong analytics and coaching. | Custom ($$$) |
| Lemlist | Mid-market. Good personalization features. | $39 - $129/mo |

### LinkedIn Automation
| Tool | Best For | Price Range |
| --- | --- | --- |
| HeyReach | Multi-account LinkedIn outreach. Team-friendly. | $79 - $499/mo |
| Expandi | Cloud-based. Smart sequences. | $99/mo |
| Dripify | Simple LinkedIn automation for small teams. | $39 - $79/mo |
| PhantomBuster | Scraping + automation. Flexible but technical. | $56 - $352/mo |

### Phone and Dialer
| Tool | Best For | Price Range |
| --- | --- | --- |
| Orum | AI-powered parallel dialer. High volume. | Custom ($$$) |
| Nooks | AI dialer + virtual salesfloor. Team coaching. | Custom ($$) |
| Aircall | Simple cloud phone for small teams. | $30 - $50/user/mo |
| Kixie | Power dialer with CRM integrations. | $35 - $95/user/mo |
| JustCall | International calling. Good for global teams. | $19 - $49/user/mo |

### Signal Detection and Intent
| Tool | Best For | Price Range |
| --- | --- | --- |
| Clay (signals) | Custom signal workflows. Most flexible. | Included in Clay plans |
| Bombora | Surge intent data. B2B topic-level intent. | Custom ($$$) |
| G2 Buyer Intent | In-market signals from G2 comparison activity. | Custom ($$) |
| RB2B | Website visitor identification (US-focused). | Free - $249/mo |
| Common Room | Community and product signals. PLG-friendly. | Free - Custom |

### Analytics and Attribution
| Tool | Best For | Price Range |
| --- | --- | --- |
| HubSpot Reporting | Native reporting if HubSpot is your CRM. | Included in Pro+ |
| Dreamdata | B2B revenue attribution. Multi-touch. | Free - Custom |
| Factors.ai | Account-level analytics and attribution. | $399 - Custom |
| Databox | Dashboard aggregation across multiple tools. | Free - $47/mo |
| Google Looker Studio | Custom dashboards. Free but requires setup. | Free |

---

## Channel Strategy

### Channel Selection Matrix

Not every channel works for every business. Match channels to your ICP, deal size, and team capacity.

| Channel | Best For | Typical CAC | Time to Results | Team Needed |
| --- | --- | --- | --- | --- |
| **Cold email** | SMB-Mid-market. High volume. Measurable. | $50-500/meeting | 2-4 weeks | 1 person can run it |
| **LinkedIn outbound** | Mid-market to Enterprise. Relationship-driven. | $100-800/meeting | 4-8 weeks | 1 person can run it |
| **Cold calling** | Enterprise. Complex sales. High ACV. | $200-1,000/meeting | Immediate | Dedicated SDR team |
| **Content / inbound** | All sizes. Best for long-term brand building. | $100-400/meeting (at scale) | 3-6 months to ramp | Writer + distribution |
| **Paid ads (LinkedIn)** | Enterprise ABM. Awareness + retargeting. | $300-2,000/meeting | 2-4 weeks | Budget + designer |
| **Paid ads (Google)** | High-intent search. Bottom-of-funnel. | $100-800/meeting | 1-2 weeks | Budget + landing pages |
| **Events / webinars** | Enterprise. Relationship building. | $500-2,000/meeting | 4-8 weeks per event | 2-3 people + speakers |
| **Partnerships** | All sizes. Multiplier on existing channels. | Variable | 2-6 months to activate | Dedicated partner manager |

### How to Choose Your Channels

Answer these five questions to narrow down where to invest:

1. **What is your ACV?**
   - Under $5K: Cold email is your primary. LinkedIn optional. Do not invest in events or enterprise ads.
   - $5K-$50K: Email + LinkedIn is the sweet spot. Add phone for deals over $20K. Content as a multiplier.
   - Over $50K: Multi-channel required. Email + LinkedIn + phone + ads + events. You need air cover.

2. **Where does your buyer spend time?**
   - Technical buyers (engineering, product): Content, communities, developer events. Cold email works if hyper-relevant.
   - Business buyers (sales, marketing, ops): LinkedIn, email, webinars. Most responsive to outbound.
   - C-suite: Phone, warm intros, events, LinkedIn thought leadership. Cold email alone rarely works.

3. **How many target accounts exist?**
   - Under 500 total addressable accounts: Go deep, not wide. ABM + phone + LinkedIn. Do not blast.
   - 500-5,000 accounts: Tiered approach. Top 50 get personal touch. Rest get automated sequences.
   - Over 5,000 accounts: Volume outbound makes sense. Email-first with LinkedIn layered on top tier.

4. **What is your team's capacity?**
   - Founder only: Pick ONE channel. Master it. Email is usually the fastest to prove.
   - 1-2 people: Primary + secondary channel. Automate everything possible.
   - Dedicated team (3+): Multi-channel orchestration becomes viable.

5. **What is your timeline?**
   - Need pipeline in 30 days: Cold email or cold calling. Nothing else is fast enough.
   - 90-day horizon: Email + LinkedIn + early content.
   - 6+ month build: Full multi-channel including content, SEO, and partnerships.

### Channel Combination Principles

1. **Start with one channel. Master it. Then add.** Spreading thin across 4 channels from day one is the fastest way to get zero results from all of them.
2. **Outbound + content is the strongest combination for early-stage B2B.** Outbound drives short-term pipeline. Content builds the brand that makes outbound convert better over time.
3. **Layer channels by deal size.** $5K ACV = email only. $20K ACV = email + LinkedIn. $50K+ ACV = email + LinkedIn + phone + ads.
4. **Coordinate channels, don't silo them.** A prospect who gets your email, sees your LinkedIn post, and gets a LinkedIn DM in the same week is 3x more likely to reply than one who only gets the email.

---

## GTM Motion Design

### Motion 1: Outbound-Led
**Best for:** B2B companies with a clear ICP, $5K+ ACV, and a product/service that solves a known problem.

```
ICP definition -> Account sourcing -> Signal enrichment -> 
Multi-channel sequences (email + LinkedIn + phone) -> Meeting booked -> 
Sales call -> Proposal -> Close
```

**Advantages:** Predictable. Scalable. Fast feedback loop. You control the volume.
**Risks:** Depends on data quality and copy. Can feel spammy if done poorly. Deliverability requires ongoing maintenance.
**When to add a second motion:** Once outbound is generating consistent pipeline (10+ meetings/month), layer in content to improve reply rates and shorten sales cycles.

### Motion 2: Inbound-Led
**Best for:** Companies with strong content, thought leadership, or a product with natural search demand.

```
Content creation -> SEO / LinkedIn / YouTube distribution -> 
Website visit -> Lead capture (demo request, resource download) -> 
Nurture sequence -> Sales call -> Close
```

**Advantages:** Higher-quality leads. Compounds over time. Builds brand moat.
**Risks:** Slow to start. Hard to attribute. Requires consistent output for months before payoff.
**When to add a second motion:** Once inbound generates steady leads but you need more volume or faster growth, add outbound to control the pace.

### Motion 3: Product-Led
**Best for:** SaaS with a free tier or trial. Low ACV, high volume. The product itself is the best sales pitch.

```
Free trial / freemium signup -> Activation -> Usage milestones -> 
In-app prompts + email nurture -> Self-serve upgrade or sales-assist -> Close
```

**Advantages:** Low CAC at scale. Users sell themselves. Data-rich (you see exactly how they use the product).
**Risks:** Requires product investment. Not viable for high-ACV services. Free users can drain resources without converting.
**When to add a second motion:** Once self-serve is working, add sales-assist for larger accounts (PQL-to-SQL handoff). Layer outbound for enterprise accounts that will not self-serve.

### Motion 4: Partner-Led
**Best for:** Companies whose product is part of a larger ecosystem, or where trust and warm intros drive deals.

```
Partner identification -> Co-marketing / co-selling agreement -> 
Joint content + events -> Warm introductions -> Sales call -> Close
```

**Advantages:** Builds on existing trust. Low CAC. High close rates on warm intros.
**Risks:** Slow. Hard to control. Depends on partner engagement. You cannot scale what you do not own.
**When to add a second motion:** Immediately. Partner-led should rarely be your only motion. Pair with outbound or content from day one.

### Choosing Your Primary Motion

| Factor | Outbound | Inbound | Product-Led | Partner |
| --- | --- | --- | --- | --- |
| Time to first revenue | 2-4 weeks | 3-6 months | 1-3 months | 3-6 months |
| ACV sweet spot | $5K-$500K | $1K-$100K | $0-$20K | $10K-$500K |
| Team size needed | 1-3 | 2-4 | 3-5 (eng + product) | 1-2 |
| Scalability ceiling | Moderate | High | Very high | Moderate |
| Data dependency | High | Low | Medium | Low |

**Most B2B companies should start outbound-led.** It is the fastest path to revenue and gives you direct feedback on messaging, ICP, and product-market fit. Layer in other motions as you grow. The exception: if you have a self-serve product with natural search demand, start product-led.

---

## Budget Allocation Framework

### The 70/20/10 Rule

- **70%** on your primary motion (the one that is working or most likely to work based on your ICP and stage)
- **20%** on your secondary motion (the one you are building toward)
- **10%** on experiments (new channels, new tools, new approaches)

Review this split quarterly. When an experiment in the 10% bucket starts producing results, promote it to the 20% bucket and shift something else down.

### Budget by Stage

| Stage | Monthly GTM Budget | Where It Goes |
| --- | --- | --- |
| **Pre-revenue** | $500-2,000 | ~70% tools (CRM + email sequencing + basic enrichment). ~20% LinkedIn Premium / content. ~10% testing a paid channel. Zero on headcount - founder does the selling. |
| **$0-$500K ARR** | $2,000-5,000 | ~50% tools (add signal detection, LinkedIn automation). ~30% first GTM hire (part-time or contractor). ~20% content + experiments. |
| **$500K-$2M ARR** | $5,000-15,000 | ~40% headcount (1-2 dedicated GTM people). ~30% tools (full stack). ~20% paid channels (LinkedIn ads, Google). ~10% events or partnerships. |
| **$2M-$10M ARR** | $15,000-50,000 | ~50% headcount (SDR team + marketing). ~25% tools. ~15% paid acquisition. ~10% events, sponsorships, partnerships. |

### Tool Budget Guardrails

- **Pre-revenue:** Do not spend more than $500/mo on tools. HubSpot Free + Apollo Free + Instantly ($30/mo) is a viable starter stack.
- **Under $1M ARR:** Total tool spend should be under $2,000/mo. If you are spending more, you are over-tooled.
- **$1M-$5M ARR:** Tool spend between $2,000-$5,000/mo is normal. Audit quarterly for overlap.
- **Over $5M ARR:** Tool spend will scale with headcount. Budget $200-$500 per GTM employee per month.

---

## Common GTM Anti-Patterns

| Anti-Pattern | Why It Fails | Fix |
| --- | --- | --- |
| **Buying every tool before proving the motion** | Tools don't fix bad strategy. You will spend $2K/mo on software with zero pipeline. | Prove the motion manually first. Automate what works. |
| **Skipping ICP definition** | Sending to "everyone who might buy" means irrelevant messaging and wasted budget. | Build your ICP matrix before writing a single email or post. |
| **Copying a competitor's GTM stack** | Their ICP, ACV, and stage are different from yours. What works for them may not work for you. | Start from your own data. Use competitor stacks as inspiration, not blueprints. |
| **Hiring SDRs before founder-led sales works** | If the founder cannot sell it, an SDR cannot either. You are hiring someone to fail. | Founders close the first 10-20 deals. Then document the playbook. Then hire. |
| **Measuring activity instead of outcomes** | 10,000 emails sent means nothing if zero convert. High activity with low results usually means targeting or messaging is off. | Track metrics that tie to revenue, not vanity numbers. |
| **Running outbound without deliverability setup** | Emails land in spam. Open rates crater. You blame the copy when the infrastructure was the problem. | Warm up domains for 2-3 weeks before sending. Monitor sender reputation weekly. Set up SPF, DKIM, and DMARC on every sending domain. |
| **No feedback loop between sales and marketing** | Marketing generates leads that sales says are junk. Sales closes deals marketing never hears about. Both sides blame the other. | Weekly pipeline review with both teams. Shared metrics. Shared accountability. |
| **Sending the same sequence to every prospect** | A VP of Engineering and a VP of Marketing have completely different pain points. One sequence for both means neither resonates. | Build persona-specific sequences. At minimum: different copy per job function and seniority level. |
| **Scaling volume before fixing conversion** | Sending 5,000 emails/week with a 0.5% reply rate does not become 10,000 emails/week with a 1% reply rate. It becomes 10,000 emails/week with a 0.3% reply rate because you burned through your best prospects first. | Get reply rates above 3% on a small list before scaling volume. |
| **Ignoring domain and sender reputation** | You launch 10 new domains, blast 500 emails per inbox on day one, and wonder why everything lands in spam within a week. | Max 30-50 emails per inbox per day. Warm up for 2-3 weeks. Rotate domains. Monitor blacklists. |
| **Treating outbound as marketing's problem** | Sales says "give me more leads." Marketing blasts more emails. Nobody owns the end-to-end pipeline from first touch to close. | One person (or team) owns the full outbound pipeline. Not just "top of funnel." |

---

## Metrics That Matter

### Leading Indicators (Track Weekly)

These tell you if your GTM engine is healthy right now. If these go red, pipeline will dry up in 4-8 weeks.

| Metric | Good | Acceptable | Investigate |
| --- | --- | --- | --- |
| Emails sent (outbound) | 2,000+/week | 500-2,000 | <500 (volume too low to learn) |
| Open rate | >50% | 30-50% | <30% (deliverability issue, not a copy issue) |
| Reply rate | >5% | 2-5% | <2% (copy, targeting, or list quality) |
| Positive reply rate | >2% | 1-2% | <1% (messaging does not resonate) |
| LinkedIn connection rate | >30% | 15-30% | <15% (profile or targeting issue) |
| LinkedIn reply rate | >15% | 8-15% | <8% (message quality or timing) |
| Meetings booked/week | Depends on target | Trending up | Flat or declining for 3+ weeks |
| Meeting show rate | >80% | 60-80% | <60% (qualification or confirmation process) |
| Email bounce rate | <2% | 2-5% | >5% (data quality - stop sending, clean list) |

### Lagging Indicators (Track Monthly/Quarterly)

These tell you if your GTM motion is actually producing revenue. Leading indicators can look great while lagging indicators deteriorate if qualification is poor.

| Metric | Good | Acceptable | Investigate |
| --- | --- | --- | --- |
| Customer Acquisition Cost (CAC) | Varies by ACV (see below) | Trending stable | Increasing for 2+ quarters |
| LTV:CAC Ratio | >3:1 | 2:1 - 3:1 | <2:1 (unit economics broken) |
| Payback period | <12 months | 12-18 months | >18 months (cash flow risk) |
| Pipeline velocity | Increasing QoQ | Stable | Declining (see formula below) |
| Win rate (opp to close) | >25% | 15-25% | <15% (qualification or sales process issue) |
| Sales cycle length | Stable or decreasing | Stable | Increasing (deal complexity or competitive pressure) |
| Net revenue retention | >110% | 100-110% | <100% (churn exceeds expansion) |

**CAC benchmarks by ACV:**
- ACV under $5K: CAC should be under $1,000 (ideally under $500)
- ACV $5K-$25K: CAC should be under $5,000
- ACV $25K-$100K: CAC should be under $15,000
- ACV over $100K: CAC up to $30,000 can work if LTV supports it

**Pipeline velocity formula:**

```
Pipeline Velocity = (# of Qualified Opps x Average Deal Size x Win Rate) / Average Sales Cycle (days)
```

Example: 40 opps x $25,000 x 20% win rate / 60 days = $3,333/day in expected revenue. Track this number monthly. If it is declining, figure out which variable is deteriorating.

---

## 30-Minute GTM Audit Checklist

Use this to quickly assess any B2B company's GTM health. Score each item Yes/No. Any "No" is a gap to fix.

### Data Layer
- [ ] CRM is the single source of truth (not spreadsheets)
- [ ] Contact bounce rate is under 5%
- [ ] Data is deduplicated and cleaned at least monthly
- [ ] ICP is documented with firmographic + persona criteria

### Enrichment Layer
- [ ] At least one signal source is active (intent, job changes, funding, website visits)
- [ ] Accounts are scored or tiered (not all treated equally)
- [ ] Signal data is acted on within 7 days of detection

### Sequencing Layer
- [ ] Multi-channel sequences are running (not just email)
- [ ] Sequences are persona-specific (not one-size-fits-all)
- [ ] Reply rate is above 2%
- [ ] Sending domains have proper authentication (SPF, DKIM, DMARC)
- [ ] Email volume is within safe limits per inbox (<50/day)

### CRM / Pipeline Layer
- [ ] Pipeline stages have clear entry/exit criteria
- [ ] Every active deal has a next step and close date
- [ ] Activities are logged automatically (not manually)
- [ ] Forecasts are reviewed weekly and within 20% of actuals

### Analytics Layer
- [ ] You can identify your best channel by revenue (not just activity)
- [ ] CAC and LTV are calculated and tracked
- [ ] Weekly metrics review happens and leads to action
- [ ] Win/loss reasons are recorded for every closed deal

### Scoring
- **16-18 Yes:** Strong foundation. Focus on optimization.
- **10-15 Yes:** Gaps exist but fixable. Prioritize the lowest-scoring layer.
- **Under 10 Yes:** Foundational rebuild needed. Start with Layer 1 (data) and work up.

---

## What to Fix First (Priority Framework)

When the audit reveals multiple gaps, fix them in this order:

1. **Deliverability and data quality** - If emails are bouncing or landing in spam, nothing else matters. Fix this first.
2. **ICP and targeting** - If you are reaching the wrong people, better copy and more channels will not help.
3. **Messaging and sequences** - Once you are reaching the right people reliably, optimize what you say to them.
4. **Pipeline management** - Once meetings are happening, make sure deals do not die in the pipeline.
5. **Analytics and attribution** - Once the engine is running, measure and optimize.

Do not skip ahead. A company spending $5K/mo on intent data while their emails land in spam is solving the wrong problem.

---

## Tips

- The best GTM strategy is the simplest one that works. Start with one ICP, one channel, one message. Get that working, then expand.
- Every tool purchase should answer: "What manual process does this replace, and what is the ROI?" If you cannot answer that, do not buy it.
- Outbound is the fastest path to revenue for most B2B companies. Inbound is the best long-term investment. Run both, but know which is your engine today.
- Your GTM stack should have fewer than 10 tools. If you have more, you are probably paying for overlap.
- Review your entire stack quarterly. Kill tools with low usage. Consolidate where possible. Tool sprawl is a hidden cost that compounds.
- The gap between "we have a CRM" and "our CRM is clean and useful" is where most companies lose. Data hygiene is not glamorous but it is the foundation.
- Founder-led sales is not a phase to skip. It is the phase where you learn what your GTM motion should be.
