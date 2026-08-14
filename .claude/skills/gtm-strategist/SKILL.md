---
name: gtm-strategist
description: |
  Use this skill when the question is which motion, which channels and which layer of the stack to fix first, rather than what to say to anybody - "audit our GTM stack", "we are spending on tools and getting nothing", "should we go outbound or inbound", "where do we put the next 5k", "pipeline is flat and nobody can tell me why", "what do we fix first", "do we hire a rep or buy a tool", "we have 14 tools and I think we are paying twice for the same thing", "we are launching in a new market, what is the motion". Reads the current tool list, channel results, budget and team size, then produces a layer-by-layer audit score, a named primary motion with the reasoning, a channel mix matched to deal size and team capacity, a budget split, and a fix-first order. It recommends and never purchases. NOT the definition of who to target, which is the icp-modeller skill and an input this one assumes you already have. NOT writing the messages once the motion is chosen, which is outbound-copywriter.
---

# GTM strategist

## When this applies

The problem is structural rather than verbal. A motion is being designed from scratch, an existing stack is being audited for gaps and overlap, budget is being allocated across channels, or pipeline is flat while activity is high and nobody can name which layer is broken.

Maturity: the five-layer model, the motion designs and the fix-first order come from real GTM builds. The budget bands and channel costs are the ranges we have seen and they will differ in your market. Treat them as a starting point you replace with your own numbers, and date any number you replace.

## What it produces

- A five-layer audit with a yes or no on each check and a score out of 18.
- One named primary motion, with the reasoning and the second motion to add later.
- A channel mix matched to deal size, buyer, universe size, team capacity and timeline.
- A budget split by stage, and guardrails on tool spend.
- A fix-first order, which is the part that actually changes what happens on Monday.
- A stated exclusion list: what this audit did not look at.

## Fill these in

- `{{STAGE}}` - pre-revenue, early traction, scaling, or established
- `{{DEAL_SIZE}}` - the average contract value, because it decides the whole channel mix
- `{{GTM_HEADCOUNT}}` - how many people are actually on this, including part-timers
- `{{BUDGET_OWNER}}` - who signs off on spend, which is who any recommendation is written for
- `{{CURRENT_STACK}}` - every tool in use today, including the ones nobody logs into

## First run: the customization interview

**Run this as a one-time setup step, outside any live engagement, and never mid-run.** It edits files, and editing a skill or its reference material while it is being used against real work is how a run half-follows two versions of its own instructions. Company-level answers belong in these files; anything specific to one account or one person belongs in `clients/<slug>/` or `company-wiki/`, not in a reference file every account's run reads.

Read before you ask. Pull the tool list from billing rather than from memory, because the tools nobody remembers are usually the finding. Pull channel results from the CRM and the sequencer. Present what you found, then ask what the data cannot tell you, one question at a time.

**Basics**
1. What do you sell and to whom, with the typical deal size?
2. How many people are on go-to-market, counting fractional and part-time honestly?
3. What is the current monthly spend across tools, ads and dedicated headcount?
4. What stage are you at?

**Current state**
5. Which channel produces most of your pipeline today?
6. What is the biggest bottleneck right now: not enough leads, low conversion, bad data, or no process?
7. What have you already tried that did not work? This one prevents recommending it again.

**Goals**
8. What does success look like in 90 days, as a number?
9. Are you fixing something broken or building something new?

Write the answers into the audit document, and the placeholders into this file. Never recommend a stack or a motion without the current state, because a pre-revenue founder and a company with three reps need different playbooks and the same advice given to both is wrong for at least one.

## Reference routing

| File | What it contains | When to read it | What breaks if you skip it |
|---|---|---|---|
| `references/stack-layers.md` | The five layers with the job, components, what good and bad look like, plus the 30-minute audit checklist and its scoring bands | At steps 1 and 2, before any recommendation | You recommend a tool for a layer that is not the broken one, which is the most expensive mistake in this skill |
| `references/motions-and-channels.md` | Four motions with their flows, risks and second-motion timing, the motion comparison, the channel matrix and the five channel questions | At steps 3 and 4 | The motion gets picked by preference rather than by deal size and team capacity, and the channel mix gets spread across four channels at once |
| `references/budget-and-metrics.md` | The 70/20/10 split, budget by stage, tool guardrails, leading and lagging metrics with thresholds, acquisition-cost benchmarks and the pipeline velocity formula | At step 5, and whenever somebody asks whether a number is good | The plan has no numbers attached, so nothing can be judged and nothing gets cut |
| `references/tool-categories.md` | What each category has to do, the selection criteria, example tools per category, and the questions to ask a vendor | Only once the layer that needs fixing is known | You buy tools to fix a strategy problem, which is the single most common failure in this whole skill |

## Step 1 - Audit the five layers

A modern GTM stack has five layers, each with one job, and they build on each other. You cannot fix a sequencing problem while the data layer is broken, and money spent on the wrong layer produces nothing visible.

1. **Data.** A clean, current database of accounts and contacts you can actually reach.
2. **Enrichment.** Turning raw records into prioritized signals that say who to talk to and when.
3. **Sequencing.** Reaching the right people through the right channel with the right message.
4. **CRM and pipeline.** Tracking every deal from first touch to close with a forecast that holds.
5. **Analytics.** Connecting activity to revenue, so something gets killed and something gets doubled.

Run the 18-check audit in `references/stack-layers.md` and score it honestly. Any "no" is a gap, and the lowest-scoring layer is where the work goes.

## Step 2 - Name the bottleneck before recommending anything

Do not skip to a recommendation. Walk this in order and stop at the first yes, because each item makes every measurement below it unreadable.

1. Are emails bouncing above 5 percent, or landing in spam? This is data quality and deliverability. Nothing else matters until it is fixed.
2. Is the ICP undocumented, or too broad to build a list from? This is targeting, and it is the icp-modeller skill rather than this one. Hand it over.
3. Are you reaching the right people with the wrong message? This is messaging, and it is the outbound-copywriter skill.
4. Are meetings happening and deals dying in the pipeline? This is pipeline management.
5. Is the engine running and nobody knows which part works? This is analytics and attribution.
6. None of the above? The motion itself is wrong, and step 3 is the work.

The order runs from the failure that corrupts the most downstream data to the one that corrupts the least. A company paying for intent data while its email lands in spam is solving item 5 while item 1 is on fire.

## Step 3 - Choose one primary motion

Four motions: outbound-led, inbound-led, product-led, partner-led. Full designs, risks and the timing for a second motion are in `references/motions-and-channels.md`.

Most B2B companies should start outbound-led, because it is the fastest route to revenue and it gives direct feedback on messaging, targeting and whether the product fits at all. The exception is a self-serve product with real search demand, which should start product-led. Partner-led should almost never be the only motion, because you cannot scale what you do not control.

Name the motion, say why, and name the second motion and the condition that triggers adding it. A motion with no trigger for the next one turns into the only motion by default.

## Step 4 - Match channels to reality

Five questions decide the mix: deal size, where the buyer actually spends time, how many target accounts exist, what the team can staff, and how fast pipeline is needed. The matrix and the answers are in `references/motions-and-channels.md`.

Four principles hold across every mix. Start with one channel and master it, because four channels from day one produces zero results from all four. Outbound plus content is the strongest early pairing, since outbound drives pipeline now and content makes outbound convert better later. Layer channels by deal size rather than by ambition. Coordinate rather than silo, because somebody who gets your email, sees your post and gets a message in the same week responds at a far higher rate than somebody who only gets the email.

## Step 5 - Spend gate. Runs before any purchase, contract or paid launch.

- **This skill recommends. It does not buy, sign up, start a trial, or launch paid spend.** Every recommendation goes to `{{BUDGET_OWNER}}` as a proposal.
- **Every tool recommendation answers one question in writing: which manual process does this replace, and what is the return.** If that cannot be answered, the recommendation does not get made.
- **Present the total monthly cost, the annual commitment if there is one, and what has to be true in 90 days for it to have been worth it.** A tool with no success condition never gets cancelled.
- **Name what gets cut.** A stack recommendation that only adds is a budget increase wearing the clothes of a strategy.
- **Prove the motion by hand before automating it.** Tools do not fix a bad strategy, and the fastest way to spend a couple of thousand a month with no pipeline is to buy the stack before proving anything.

## Step 6 - Write the fix-first order

Deliver the order, not the list. Five gaps ranked is useful and five gaps listed is a to-do nobody starts.

1. Deliverability and data quality
2. Targeting and the ICP
3. Messaging and sequences
4. Pipeline management
5. Analytics and attribution

Then close with the exclusion list: what this audit did not cover. Say plainly if you did not look at the product, at pricing, at the customer success motion or at the paid channels, because an omission reads as an oversight and produces the same question every week, while a stated exclusion reads as a decision.

## What good looks like

A good audit starts in the billing export rather than in the interview, and the first finding usually arrives before the first question: two tools doing enrichment, one of them last logged into in March. The bottleneck walk stopped at item one, because bounce rate was 7 percent, which meant the reply rate everybody had been arguing about for a month was not a copy number at all. The audit came back 11 of 18 with the data layer scoring 1 of 4, and the recommendation was to fix the data layer and change nothing else that month, which is a smaller recommendation than the one that was asked for and the right one. The motion was named outbound-led with content second, with a stated trigger of ten meetings a month before content starts, and the reasoning was the deal size and a team of two rather than a preference. The channel mix was two channels, not four. Every tool recommendation named the manual process it replaced, and two named the tool it replaced, so the net spend went up by less than the list suggested. The 90-day success condition was written down for each one. Nothing was purchased by the agent. The report closed with what was not examined: pricing, onboarding and the customer success motion, all named as out of scope rather than left silent.

Mediocre looks like a stack recommendation delivered without a bounce rate ever having been checked, listing eleven tools across five layers with no mention of what gets cut and no success condition attached to any of them. It names four channels because the company might as well run all of them, calls the motion multi-channel, which is not a motion, and gives a fix-first list in the order the layers happen to be numbered. It quotes prices from a vendor page, which are wrong within a quarter. It has no exclusion list, so three weeks later somebody asks why the audit said nothing about pricing.

## Hard rules

- MUST pull the tool list from billing and the channel results from the systems, before the interview rather than during it.
- MUST run the bottleneck walk in order and stop at the first yes, before recommending anything.
- MUST hand targeting work to icp-modeller and copy work to outbound-copywriter rather than absorbing them here.
- MUST name exactly one primary motion, with the reasoning and the trigger condition for adding the second.
- MUST answer, in writing, which manual process each recommended tool replaces and what the return is.
- MUST state the total cost, the commitment, and the 90-day condition that would prove the spend was right.
- MUST name what gets cut alongside anything that gets added.
- MUST deliver the fixes as a ranked order rather than a list.
- MUST close with an exclusion list naming what the audit did not examine.
- NEVER purchase, subscribe, start a trial, or launch paid spend. Recommendations go to `{{BUDGET_OWNER}}`.
- NEVER recommend a tool for a layer that is not the bottleneck.
- NEVER recommend automating a motion nobody has proven by hand.
- NEVER copy a competitor's stack. Their deal size, their targeting and their stage are not yours.
- NEVER quote a vendor price as fact. Prices change upstream and this file will not, so send them to the pricing page and give them the budget guardrail instead.
- NEVER recommend hiring reps before founder-led or operator-led selling has worked. If the person closest to the product cannot sell it, a new hire cannot either.
