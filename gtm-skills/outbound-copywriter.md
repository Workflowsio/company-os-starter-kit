# Outbound Copywriter

<!-- 
  WHAT THIS DOES: Writes high-converting cold emails using the SPARK framework,
  7 copy archetypes, 7 power patterns, Chris Voss persuasion techniques, and a
  full follow-up sequence engine. Includes subject line formulas, QA checklist,
  A/B testing protocol, and a self-improvement feedback loop.
  
  HOW TO USE: Reference this file in your CLAUDE.md skills section. When you need
  cold email copy, tell Claude: "Use the cold email writer skill to write copy for
  [campaign/segment]." Provide your value prop, target persona, proof points, and
  any past campaign data. Claude will select the right archetype and write the sequence.
-->

## Customize This Skill

This is a template, not a finished skill. The frameworks below are proven starting points from hundreds of campaigns, but they work 10x better once you plug in your specific voice, proof points, and data.

**First-time setup:** Tell Claude: "Read this skill and help me adapt it for my business. Interview me about what needs to change."

When this skill is loaded for the first time, Claude should run this interview:

### Customization Interview (Claude runs this)

Ask these questions in order. Wait for answers before proceeding. Update this file with the answers inline.

**Round 1 - Business Context**
1. What do you sell? (Product/service, one sentence)
2. Who is your ideal customer? (Title, company size, industry)
3. What is your strongest proof point? (Best customer result with numbers)
4. What problem do you solve that your buyer currently handles manually or poorly?
5. How do buyers typically find you today? (Referrals, inbound, outbound, events)

**Round 2 - Voice and Positioning**
6. Paste 2-3 emails you have sent that felt "right" in tone. (Claude will extract patterns)
7. What words or phrases should NEVER appear in your copy? (Add to the banned list below)
8. Are you positioned as premium, mid-market, or budget? This changes CTA framing.
9. What do competitors say in their outreach? (So you can say something different)

**Round 3 - Operational Context**
10. What tools do you use for sending? (Instantly, HeyReach, Outreach, Salesloft, etc.)
11. What CRM holds your prospect data? (HubSpot, Salesforce, Pipedrive, etc.)
12. Do you have intent data or signal sources? (Bombora, G2, Clay, LinkedIn Sales Nav)
13. What is your average deal size? (Affects aggressiveness and CTA type)
14. What is your current positive reply rate? (Sets the baseline to beat)

After collecting answers, Claude should:
- Update the Voice section with extracted patterns from the user's example emails
- Add company-specific banned words to the banned list
- Pre-fill proof points into the SPARK framework examples
- Adjust CTA aggressiveness based on deal size (high ACV = softer, low ACV = more direct)
- Save all changes to this file

---

## When to Use

- Writing cold email campaigns for a new segment or persona
- Rebuilding underperforming sequences or A/B testing new angles
- Monthly copy refresh for long-running campaigns
- Warming up a new domain/sender with initial sequences
- Translating inbound messaging into outbound angles

---

## Before You Write

**Step 0: Gather context from the user.** Before writing anything, collect:

**Required (do not write without these):**
1. **Target persona** - Job title, company size, industry, seniority level, and geography
2. **Value proposition** - What you sell and the specific outcome the buyer gets
3. **Proof points** - Customer results with numbers, logos you can name-drop, case studies
4. **Campaign trigger** - What signal prompted this campaign? (Hiring for a role, funding round, tech adoption, event attendance, job change, or no signal)

**Strongly recommended:**
5. **Past campaign data** - What angles worked, what flopped, reply rates by variant
6. **Competitor landscape** - What alternatives does the buyer already know about?
7. **Buyer's current state** - How do they solve this problem today? (Manual process, incumbent vendor, ignoring it)
8. **Tone reference** - Paste a message that matches the voice you want
9. **Disqualifiers** - Who should NOT get this email? (Wrong segment, existing customer, active deal)
10. **Sending infrastructure** - How many emails/day, how many senders, warm-up status

Generic input produces generic output. If the user skips questions 1-4, push back.

**Step 1: Pull campaign analytics.** If past campaigns exist, check reply rates per variant, classify recent replies (positive/negative/neutral), and start from your highest-performing angles. If you skip this, you are writing blind while real data sits unused.

**Step 2: Map the competitive frame.** Every prospect has a status quo. Name it. Your email competes against "do nothing" more often than it competes against another vendor. Write the email knowing what you are displacing.

---

## Framework

### The 3 Laws of Cold Email

These laws are non-negotiable. Every email must pass all three.

1. **Relevance > Cleverness** - A boring email about the right problem beats a clever email about nothing. The first line must prove you understand their world.

2. **One Job Per Email** - Step 1 earns the reply. Step 2 adds new value or gets feedback. Never combine jobs. Never ask for a meeting in Step 1.

3. **Earn the Reply, Don't Demand It** - Ask a question that confirms their situation before selling. "Are you seeing this too?" beats "Let's hop on a call." Low-friction questions get 3x the reply rate of meeting requests.

---

### The SPARK Framework

Every cold email follows this structural backbone. Each element has a specific job.

#### S - Subject Line
**Job:** Pattern interrupt. Get the open without misleading.

| Rule | Details |
|------|---------|
| Length | 3-5 words, always lowercase |
| Content | Reference their world, not yours |
| Never | Brackets, exclamation marks, emojis, "Re:", "Fwd:" |

**Good:**
- `{{company}} + [topic]`
- `quick question on [their process]`
- `idea for {{company}}`

**Bad:**
- `Exciting Opportunity for {{company}}!` (screams marketing)
- `Introduction - [Your Company]` (who cares about your company?)
- `Quick question` (overused, no specificity)

---

#### P - Personalized Opening
**Job:** Prove you did homework. Create an immediate "this person knows my world" feeling.

The opening must pass the **"Could I send this to 1,000 people?"** test. If yes, it is not personalized.

**Good examples:**
- "Saw {{company}} just opened a new office in Austin - congrats. That kind of expansion usually means [relevant pain]."
- "Noticed you're hiring 3 SDRs right now. When teams scale that fast, [problem] tends to show up around month two."
- "A VP Sales at another [industry] company told me last week that [specific pain]. Curious if you're seeing the same."

**Bad examples:**
- "I came across {{company}} and was impressed by your growth." (Says nothing specific)
- "As a fellow [industry] professional..." (Cringe. No one talks like this.)
- "I hope this email finds you well." (Instant delete.)
- "I noticed that your company is in the [industry] space." (You read their LinkedIn. So what?)

---

#### A - Agitate the Problem
**Job:** Name the specific pain. Use their language, not yours. Make them feel understood, not attacked.

The test: after reading this section, the prospect should think "that is exactly my situation" or "how did they know that?"

**Good examples:**
- "Most teams at your stage are running outbound manually - reps spending 2-3 hours a day on prospecting instead of selling. Pipeline looks thin even when the team is working hard."
- "The usual playbook is to hire more reps. But at $150K fully loaded per SDR, that math stops working around rep 4 or 5."

**Bad examples:**
- "Many companies struggle with sales efficiency." (Vague. Could be about anything.)
- "You must be frustrated with your current process." (Presumptuous. You don't know how they feel.)
- "In today's competitive landscape..." (Filler that says nothing.)

**Key rules:**
- Use the buyer's vocabulary, not yours. If they say "pipeline," don't say "revenue generation."
- Agitate the cost of inaction, not the problem itself. "What is this costing you per quarter?" hits harder than "This is a problem."
- Never agitate for more than 2-3 sentences. You are naming the pain, not lecturing.

---

#### R - Relevant Value
**Job:** One concrete outcome you deliver. Not features. Not a product tour. One result with a number.

**Good examples:**
- "We helped [similar company] add $2.1M in pipeline in 90 days without hiring a single new rep."
- "Three [industry] companies switched to us this quarter. Average result: 47% more qualified meetings from the same list size."

**Bad examples:**
- "Our platform helps you automate your outbound." (Feature, not outcome.)
- "We provide end-to-end sales solutions." (Meaningless.)
- "Companies like yours see great results with our tool." (No proof, no number, no specificity.)

**Rules:**
- One proof point per email. Not three. The prospect needs one compelling reason to reply, not a menu.
- Specific numbers always. "47%" beats "nearly 50%." "$2.1M" beats "millions."
- Name a real company if you can. "We helped Acme Corp" beats "We helped a company like yours."

---

#### K - Kick-off CTA
**Job:** Low-friction question that earns a reply. Not a calendar link. Not a meeting request.

The CTA should cost the prospect less than 10 seconds to respond to.

**Good examples:**
- "Are you seeing the same thing?" (Binary, easy to answer)
- "Would it be worth sharing how [similar company] solved this?" (Offers value, not a pitch)
- "Is this even on your radar for Q2?" (Gives them an easy out, which paradoxically increases replies)
- "Would it be a terrible idea to send over the playbook?" (No-oriented, per Chris Voss)

**Bad examples:**
- "Let's hop on a quick 15-minute call." (Too much commitment for a cold email)
- "Are you free Thursday at 2pm?" (Presumptuous and high-friction)
- "Would you be open to a brief demo?" (You haven't earned the right to demo yet)
- "Let me know your thoughts." (Not a question. No clear action.)

**CTA selection by email step:**
| Step | CTA Type | Example |
|------|----------|---------|
| Step 1 | Confirm the problem exists | "Seeing this too?" |
| Step 2 | Offer a specific deliverable | "Want me to send the comparison?" |
| Step 3 | Micro-commitment or new angle | "Would a 2-min video walkthrough be useful?" |
| Step 4 | Breakup with options | "1. Bad timing 2. Wrong person 3. Not interested" |

**Total email length:** 60-120 words. Absolute maximum: 150 words. Mobile-first. If you cannot read the full email on a phone screen without scrolling, it is too long.

---

### Subject Line Formulas

Write 10 subject lines before picking one. Your first idea is rarely your best.

| Formula | Example | When to Use |
|---------|---------|-------------|
| `[deliverable] for {{company}}` | `growth playbook for acme` | When you have something specific to offer |
| `{{company}} + [topic]` | `acme + outbound` | General opener, works for most campaigns |
| `quick [niche] question` | `quick hiring question` | When your opener is a genuine question |
| `[trigger event]` | `series b congrats` | Signal-based campaigns |
| `idea for {{company}}` | `idea for acme` | Creative Ideas archetype |
| `[peer company] mentioned you` | `drift mentioned you` | Referral or name-drop campaigns |
| `[metric] in [timeframe]` | `47% more pipeline in 90 days` | Strong proof point campaigns |
| `not another [category] pitch` | `not another crm pitch` | Self-aware pattern interrupt |
| `have you given up on [topic]?` | `have you given up on outbound?` | No-oriented (Chris Voss) |
| `[their problem] solved?` | `rep ramp time solved?` | Problem-aware audiences |

**Rules:**
- Always lowercase. No exceptions.
- 3-5 words maximum.
- No brackets, exclamation marks, emojis, or special characters.
- No "Re:" or "Fwd:" tricks. Prospects see through them and it destroys trust.
- No company name of YOUR company. The subject is about THEM.
- A/B test subject lines in pairs, never more than 2 variants at once.

---

### The 7 Power Patterns

Proven techniques from the highest-performing cold email campaigns. Layer them on top of SPARK.

#### 1. Question Opener (> Statement Opener)
Don't state a fact. Ask a question that creates a mental gap.

- **Bad:** "Looks like you carry a solid catalog."
- **Good:** "Are your current suppliers meeting 100% of your inventory needs?"
- **Why it works:** Questions force the prospect to self-assess before deciding to reply. Facts are easy to dismiss. A question creates an open loop the brain wants to close.

#### 2. Peer Story (> Generic Discovery)
Open with what a similar company told you, not "I found your company on [source]."

- **Bad:** "I came across {{companyName}} while researching companies in [industry]..."
- **Good:** "Just spoke to another [industry] VP in [region]. They wanted to scale outbound but told me rep ramp time was killing their unit economics."
- **Why it works:** Peer stories establish credibility, name the pain in real language (not your marketing language), and create FOMO. The prospect wonders "what are my peers doing that I'm not?"

#### 3. "Reason Why" Framing
Don't pitch. Explain why someone else came to you.

- **Bad:** "We have a new program for companies like yours."
- **Good:** "The reason they reached out is that most agencies charge per seat. We charge per meeting booked."
- **Why it works:** Flips the frame from "I'm selling" to "others are buying." The prospect's brain processes third-party validation differently than a direct pitch.

#### 4. Specific Numbers (> Ranges)
32% sounds measured. "30-40%" sounds like a guess.

- **Bad:** "The average gap has been 30-40%."
- **Good:** "The average gap has been 32%."
- **More examples:** "$847K" not "nearly $1M." "14 days" not "about two weeks." "23 companies" not "dozens of companies."
- **Why it works:** Specific numbers signal you actually ran the analysis. Ranges signal you are guessing. The more precise the number, the more credible it sounds.

#### 5. Scale Credibility
Drop a concrete scale number early. Let the fact do the credibility work.

- "We run outbound for 40+ B2B companies in this exact space."
- "Our system sends 2M+ emails per month across 200 domains."
- **Bad:** "We are a leading provider of sales automation." (Adjective-driven credibility never works.)
- **Why it works:** No adjectives needed. The number speaks. "Leading" is an opinion. "40+ companies" is a fact.

#### 6. Gap-Hinting CTA
Your CTA should imply the prospect might be missing something, without being condescending.

- **Bad:** "Worth a look?"
- **Good:** "Would you be open to seeing where the gaps are in your current setup?"
- **Also good:** "Want me to run a quick comparison against what [peer] is doing?"
- **Why it works:** "Gaps" and "comparison" framing implies there is something they have not addressed. Curiosity is stronger than interest.

#### 7. Risk Reduction Offers
Frame offers as risk reducers, not discounts or freebies.

- **Bad:** "We'll give you a free trial."
- **Good:** "If we ran a free teardown of your current sequences, would you want to see the results? No pitch attached."
- **Also good:** "We guarantee 30 qualified meetings in 90 days or you don't pay. That is the actual offer."
- **Why it works:** The offer is conditional on their engagement, not a giveaway. "Free trial" sounds desperate. "Free analysis with no pitch attached" sounds confident.

---

### Persuasion Layer (Chris Voss Techniques)

These are not theoretical. Each one has a specific place in the email sequence.

#### 1. Calibrated Questions
"What" and "how" questions force considered answers instead of reflexive "no."

- **In practice:** "What is your team's biggest bottleneck when ramping new reps?"
- **Where to use:** Step 1 CTA or Step 2 opener
- **Common mistake:** Asking "why" questions. "Why" makes people defensive. "What" and "how" make people think.

#### 2. Accusation Audit
Name the objection before they do. This defuses it and builds trust.

- **In practice:** "You probably get a dozen of these emails a week, so I will keep this to 3 sentences."
- **In practice:** "I know the last thing you need is another vendor promising the world."
- **Where to use:** Step 1 opener (especially for over-prospected personas like VPs at tech companies)
- **Common mistake:** Over-apologizing. One sentence is enough. Two or more sounds insecure.

#### 3. Loss Aversion
People fear losing what they have more than they desire gaining something new.

- **In practice:** "Most teams at your stage are losing 2-3 qualified deals per month to slow follow-up. They just don't see it in the CRM."
- **In practice:** "The 32% gap we keep seeing means you are probably leaving $400K+ on the table annually."
- **Where to use:** The Agitate section of SPARK
- **Common mistake:** Manufacturing fake urgency ("Act now!"). Real loss aversion uses real data.

#### 4. "That's Right" Moments
Describe their situation so accurately that they think "that's right" before they even realize they are agreeing.

- **In practice:** "You have got a strong product. Customers love it. But growth has been word-of-mouth and referrals, and you know that does not scale past a certain point."
- **Where to use:** The Personalized Opening or Agitate section
- **Common mistake:** Being too generic. "Your industry is competitive" does not trigger a "that's right." It triggers "so what."

#### 5. No-Oriented Questions
People feel safer saying "no" than "yes." Frame your ask so "no" moves the conversation forward.

- **In practice (subject):** `have you given up on outbound?`
- **In practice (CTA):** "Would it be a terrible idea to send over the teardown?"
- **In practice (CTA):** "Is this a bad time to bring this up?"
- **Where to use:** Subject lines and Step 3/4 CTAs
- **Common mistake:** Using negative framing that sounds passive-aggressive. "You probably don't care about pipeline" crosses the line.

---

### 7 Copy Archetypes

Each campaign uses ONE primary archetype. Selected based on the available signal data and your strongest value proposition.

| # | Name | Best For | Key Structure |
|---|------|----------|---------------|
| 1 | **The Observation** | Visible signal (hiring, funding, leadership change) | Signal you noticed -> what it implies -> what peers did -> "Seeing the same?" |
| 2 | **The Problem-Solution** | Well-understood pain with hard metrics | Name problem -> quantify cost -> how you solve it -> specific proof -> gap-hinting CTA |
| 3 | **The Referral Ceiling** | Founder-led companies growing via word-of-mouth | Acknowledge growth -> name the limitation -> contrast with predictable alternative -> offer playbook |
| 4 | **The Creative Ideas** | Prospects you can generate specific ideas for | "Spent time looking at {{company}}" -> 2-3 tailored ideas -> "Think any could work?" |
| 5 | **The Benchmark** | Data-driven buyers (VPs, Directors) | Industry data point -> how they likely compare -> what top performers do -> offer to run comparison |
| 6 | **The Case Study** | When you have a perfect-match customer story | One-line result -> what the customer's situation was before -> what changed -> "sound familiar?" |
| 7 | **The Whole Offer** | No signal available, value prop stands alone (fallback) | One-sentence credibility -> specific result with proof -> relevance bridge -> "Open to hearing more?" |

**Selection logic:**
- Timely signal (last 30 days)? -> **Observation**
- You have a case study for their exact segment? -> **Case Study**
- Data-driven buyer with benchmark data? -> **Benchmark**
- Founder-led or referral-driven growth? -> **Referral Ceiling**
- Can generate 2-3 specific ideas for their business? -> **Creative Ideas**
- Well-understood pain with hard metrics? -> **Problem-Solution**
- None of the above? -> **Whole Offer** (fallback, not first choice)

**Note:** The Creative Ideas archetype (Archetype 4) consistently outperforms everything else when the ideas are truly specific. It requires real research. That is why it works and why most teams skip it.

---

### Follow-Up Sequence (Full Templates)

Each follow-up has ONE job. Never "just bumping this." Every step adds new information or reframes.

#### Step 1 - The Opener (Day 0)
**Job:** Earn the reply. Prove relevance. Ask one question.

Use SPARK framework. Select one archetype. Keep it under 120 words.

```
Subject: {{company}} + [topic]

[Personalized opening - 1-2 lines referencing signal, peer, or observation]

[Agitate - 2-3 lines naming their specific pain in their language]

[Value - 1 specific proof point with a number]

[CTA - one low-friction question]

[First name]
```

#### Step 2 - The Value-Add (Day 3-4)
**Job:** Provide new value. Get a signal on interest.

Do NOT reference Step 1. Write this as if Step 1 never happened. New angle, new value.

```
Subject: (same thread)

[One-line context reset - new angle or new proof point]

[Binary question that is easy to answer]

P.S. [Social proof with a specific metric - this gets read even when the body is skimmed]
```

**Example:**
```
Subject: (same thread)

Put together a quick breakdown of how [peer company] restructured their outbound
last quarter. Went from 12 meetings/month to 41 without adding headcount.

Would a copy be useful, or is outbound already working well for you?

P.S. They were using the same stack you are (Clay + Instantly).
```

#### Step 3 - The Reframe (Day 7-10)
**Job:** Try a completely different angle. If Steps 1-2 were about the problem, Step 3 is about curiosity or a micro-commitment.

```
Subject: (same thread)

[Completely new angle - different pain, different proof, or a question]

[Micro-commitment CTA: 2-min video, one-page teardown, or a single data point]
```

**Example:**
```
Subject: (same thread)

One thing I keep hearing from [industry] VPs: the bottleneck is not lead volume, it is
reply quality. Teams are booking meetings with people who were never going to buy.

We built a 2-min video showing how to filter for buyer intent before the first email.
Worth watching, or is this not a priority right now?
```

#### Step 4 - The Breakup (Day 14-21)
**Job:** Give them a clean exit. Paradoxically, breakup emails convert at the highest rate (15-25% of total positive replies come from this step).

```
Subject: (same thread)

[Short, human, direct. No guilt trip.]

[Numbered options: 1. Not interested 2. Bad timing 3. Wrong person]

Either way, no hard feelings.

[First name]
```

**Example:**
```
Subject: (same thread)

Hey {{firstName}},

Not trying to be a pest. Figured I would check one last time.

1. You are all set - not something you need help with
2. Timing is off - circle back in a few months
3. Wrong person - point me to the right one?

No worries either way.

[Your name]
```

**Why numbered options work:** They lower the cognitive cost of replying. Instead of composing a response, the prospect just types "2." And "2" opens the door for a follow-up in 3 months.

#### Optional: Step 5 - The Long Game (Day 30-60)
**Job:** Re-engage with a genuinely new piece of value. Only send if you have something real (a new case study, a benchmark report, an industry insight).

Never send Step 5 if you are just rephrasing Steps 1-4. If you do not have new value, stop at Step 4.

---

### Anti-Patterns (What to NEVER Write)

| Bad Pattern | Why It Fails | Fix |
|-------------|-------------|-----|
| "Quick question..." | Overused. Everyone knows a pitch is coming. | Just ask the actual question. |
| "I noticed that..." | Fake personalization if followed by something generic. | Reference the actual insight without the preamble. |
| "Just following up" | Zero new value. Looks desperate. | Provide new information or a different angle. |
| "Would it make sense to..." | Wishy-washy and passive. | Be direct about the value exchange. |
| "I'd love to connect" | Too eager, no value offered. | State why connecting benefits THEM. |
| "As a [title], you probably..." | Reads like AI-generated copy. | Open with their situation, not their title. |
| "I hope this finds you well" | Template signal. Instant delete. | Skip pleasantries entirely. Start with value. |
| "We're an AI-powered platform that..." | Nobody cares about your architecture. | State the outcome, not the technology. |
| "Many companies like yours..." | If you cannot name the companies, you do not know enough. | Name a specific peer or say "A VP Sales at a [industry] company told me..." |
| "Reaching out because..." | Throat-clearing. Get to the point. | Delete and start with the next sentence. |
| "In today's competitive landscape..." | Filler that every AI writes. | Delete entirely. Say something specific. |
| "I'll be brief" | Then be brief. Don't announce it. | Delete and actually be brief. |
| "Let me know your thoughts" | Not a question. No clear action. No urgency. | Replace with a specific question with two possible answers. |
| "Can I get 15 minutes of your time?" | You have not earned 15 minutes yet. | Earn a reply first. Meetings come after mutual interest is established. |
| Mentioning your company name in the first line | They do not care about you yet. | First line should be about THEM. Your company can appear in the value section. |
| Multiple CTAs in one email | Confused prospects do not reply. | One CTA per email. Period. |

---

### Voice and Tone

Sound like a knowledgeable peer at a conference who spent 5 minutes on homework. Not a marketer. Not a robot. Not a desperate SDR.

**Rules:**
- Short sentences. 6-15 words each.
- Every sentence gets its own paragraph (in the email body).
- Contractions always ("you're" not "you are," "won't" not "will not").
- Plain text only. No bold, no italics, no HTML formatting.
- No links or bullet points in Step 1. Links trigger spam filters. Bullet points look like marketing.
- P.S. lines are allowed starting in Step 2. They are prime real estate for social proof.
- Read it aloud. If it sounds like marketing copy, rewrite it. If it sounds like something you would actually say to someone at a bar, ship it.

**Banned words (never use these in cold emails):**
leverage, utilize, streamline, comprehensive, robust, innovative, cutting-edge, game-changing, revolutionary, disruptive, synergy, best-in-class, world-class, next-generation, solution (say "system" or "approach"), excited to, passionate about, thrilled, reimagine, transform (say "change" or "fix"), empower, elevate, optimize (say "improve"), drive results (say what results), thought leader

---

### Copy QA Checklist

Run every email through this checklist before sending. Every item must pass.

**Structure:**
- [ ] Subject line is 3-5 words, all lowercase, no special characters
- [ ] Total word count is 60-120 (150 max for complex value props)
- [ ] First line is specific to the prospect or their peer group (not sendable to 1,000 people)
- [ ] Email has exactly one CTA, and it is a question
- [ ] CTA is NOT "book a call" or "grab 15 minutes" (in Steps 1-3)
- [ ] Every sentence gets its own paragraph

**Content quality:**
- [ ] Every sentence passes the "so what?" test (if a sentence does not earn its place, cut it)
- [ ] 3:1 ratio of prospect-focused language vs. self-focused (count the "you/your" vs. "we/our/I")
- [ ] At least 2 power patterns are applied
- [ ] The prospect would think "that is exactly my situation" after reading
- [ ] No banned words from the voice section
- [ ] No adjectives doing the work that numbers should do

**Technical:**
- [ ] All merge variables resolve ({{firstName}}, {{company}}, {{signal}})
- [ ] No broken variable syntax (no stray {{ or }})
- [ ] Mobile preview is clean (check on an actual phone or phone-width preview)
- [ ] No links in Step 1
- [ ] No images or HTML
- [ ] No spam trigger words (free, guarantee, act now, limited time, exclusive offer)

**Proof points:**
- [ ] Every metric cited is real and approved by the user
- [ ] Named companies have given permission to be referenced (or are public case studies)
- [ ] Numbers are specific, not ranges

---

### A/B Testing Protocol

Do not test randomly. Follow this hierarchy.

**What to test (in priority order):**
1. **Subject line** - Highest impact, easiest to test. Always start here.
2. **Opening line** - Personalized vs. peer story vs. question opener
3. **CTA type** - Gap-hinting vs. no-oriented vs. direct offer
4. **Archetype** - Problem-Solution vs. Observation vs. Creative Ideas
5. **Proof point** - Different customer story or metric
6. **Length** - 80 words vs. 120 words

**Testing rules:**
- Change ONE variable at a time. If you change the subject and the body, you learn nothing.
- Minimum 200 sends per variant before drawing conclusions.
- Run for at least 5 business days before judging.
- "Winner" = higher positive reply rate, not higher open rate. Opens are unreliable.
- Document every test result. Your future self needs this data.

---

### Performance Thresholds

| Metric | Strong | Acceptable | Kill and Rewrite |
|--------|--------|------------|------------------|
| Positive reply rate | > 3% | 1-3% | < 1% |
| Total reply rate | > 8% | 3-8% | < 3% |
| Open rate | > 60% | 40-60% | < 40% (infrastructure problem, not copy) |
| Bounce rate | < 2% | 2-3% | > 3% (list quality problem) |
| Unsubscribe rate | < 0.5% | 0.5-1% | > 1% (targeting or frequency problem) |

**Diagnostic logic:**
- Open rate low, reply rate low -> Deliverability problem. Check DNS, warm-up, and sending volume before rewriting copy.
- Open rate fine, reply rate low -> Copy problem. Rewrite using a different archetype.
- Open rate fine, reply rate fine, but all replies are negative -> Targeting problem. Your list is wrong, not your copy.
- High positive replies but no meetings booked -> Handoff problem. Your SDR follow-up is dropping the ball, not the email.

---

### Tips

- Copy that works for SMB founders rarely works for enterprise VPs. Always segment by company size AND persona seniority. A founder reads email on their phone at 6am. A VP has an EA filtering their inbox.
- The P.S. line is prime real estate for social proof. It gets read even when the body is skimmed. Always include one in Step 2+ with a specific metric.
- When a campaign underperforms, check deliverability BEFORE rewriting copy. Wasted rewrites are the #1 time sink in outbound.
- The "Creative Ideas" archetype consistently outperforms when the ideas are truly specific. It requires real research per account. That is why most teams skip it and why it works when they don't.
- For campaigns targeting the same persona across different products, reuse structure, never reuse content. Same skeleton, new flesh.
- Breakup emails (Step 4) convert at surprisingly high rates. Do not skip them. Do not half-write them. The numbered options format is the highest-converting breakup structure we have tested.
- Write your worst email first. Get the bad ideas out. Then rewrite. Your second draft is almost always better than agonizing over the first.
- If you find yourself writing more than 150 words, you are trying to say two things. Split it into two emails.
