# LinkedIn Post Writer

<!-- 
  WHAT THIS DOES: Writes LinkedIn posts in your voice using proven frameworks,
  hook patterns, and formatting rules. Covers 7 post types, 12 hook formulas,
  5 CTA patterns, and a scoring rubric to ensure every draft meets a quality bar.
  
  HOW TO USE: Reference this file in your CLAUDE.md skills section. When you need
  a LinkedIn post, tell Claude: "Use the LinkedIn writer skill to draft a post
  about [topic]." Provide your past posts (10+ recommended) so Claude can
  calibrate to your voice. The more examples, the better the voice match.
-->

## Customize This Skill

This is a template, not a finished skill. Before using it for real work, customize it for your business.

When this skill is loaded for the first time, Claude should:
1. Ask the user about their specific context (industry, ICP, voice, typical topics)
2. Run the Voice Extraction Process below on the user's past posts
3. Update the Voice Profile section with the extracted patterns
4. Only then proceed to draft posts

To customize, tell Claude: "Read this skill and help me adapt it for my business. Interview me about what needs to change."

The frameworks below are proven starting points from running hundreds of B2B LinkedIn campaigns. They work 10x better once you plug in your voice, topics, and data.

## When to Use

- Drafting LinkedIn posts on any topic (frameworks, hot takes, milestones, tool reviews)
- Turning raw ideas, screenshots, or outlines into polished posts
- Repurposing long-form content (blog, podcast, case study) into LinkedIn format
- Reactive content for industry news, tool launches, or trending topics
- Building a weekly content calendar with varied post types
- Quality-checking drafts before publishing

---

## Before You Write

**Gather context from the user before drafting.** Ask for:

1. **What is the core idea?** A specific insight, result, experience, or opinion. Not "write about marketing." Something like "we tested 6 email finding tools and Findymail won by 40% on accuracy."
2. **Who reads this?** Job titles, seniority, industry. A post for founders reads differently than one for marketing managers.
3. **What is the goal?** Pick one: brand awareness, engagement (comments), lead generation, thought leadership, hiring.
4. **Do you have past posts to calibrate voice?** 10+ examples ideal. Even 3-5 help. Without voice examples, output will sound generic.
5. **Any data, stories, or proof points to include?** Screenshots, metrics, customer quotes, before/after numbers.
6. **Preferred post type?** (Framework, hot take, story, tool review, case study, giveaway, milestone - or "you pick")

Do not draft until you have answers to at least questions 1, 2, and 4. Without voice examples, the output will be mediocre.

---

## Voice Calibration

Generic LinkedIn content is obvious and gets ignored. Voice calibration is what separates a post that sounds like you from one that sounds like an AI wrote it.

### Voice Extraction Process

When given 10+ past posts, Claude should extract and document all of the following. This is not optional - do the full extraction before writing anything.

**Step 1: Sentence analysis**
- What is the average sentence length? Count words in 20 random sentences.
- Does the author use fragments? ("Built this. Shipped it. Worked.")
- How often do sentences start with "I" vs. other openers?

**Step 2: Opening patterns**
- How does the author typically open? (Bold claim? Question? Story moment? Stat?)
- List the 5 most common first-line structures from their posts.

**Step 3: Vocabulary fingerprint**
- Build a "language swap table" - words the author actually uses vs. words they never use.
- Note any signature phrases or repeated expressions.
- Flag any jargon patterns (do they name-drop tools? Use acronyms? Spell things out?)

| I Say This | Not This |
| --- | --- |
| [extracted from posts] | [common alternatives they avoid] |
| [extracted from posts] | [common alternatives they avoid] |

**Step 4: Structural habits**
- Do they use numbered lists? Bullet points? Neither?
- How do they transition between sections? (Line breaks only? Transition words?)
- What does their typical post structure look like? (Hook > context > list > CTA? Hook > story > lesson?)

**Step 5: Tone markers**
- Where do they fall on these spectrums?

```
[Arrogant] -------- [Confident] -------- [Humble]
                         ^

[Academic] -------- [Practical] -------- [Simplistic]
                         ^

[Safe] ------------ [Slightly edgy] ---- [Inflammatory]
                         ^

[Polished] -------- [Conversational] --- [Unfiltered]
                         ^
```

**Step 6: Emoji and formatting rules**
- How often do they use emojis? (Never? List markers only? Every paragraph?)
- Which specific emojis appear? (Pointer hands? Checkmarks? Fire? None?)
- Do they use bold text? How?

**Step 7: CTA patterns**
- How do they end posts? (Question? Statement? Comment trigger? Nothing?)
- Do they ever use "follow for more" style CTAs?

### Voice Profile Template

After extraction, fill in this profile. Keep it in the skill file so every future draft references it.

```
VOICE PROFILE: [Name]
- Avg sentence length: [X] words
- Fragment usage: [never / sometimes / frequently]
- Typical opener: [pattern]
- Emoji frequency: [never / list markers only / occasional / heavy]
- Tone: [confident/humble], [practical/academic], [edgy/safe], [conversational/polished]
- Signature phrases: [list]
- Never says: [list]
- Ends posts with: [pattern]
- Uses bold: [never / section headers / emphasis]
- Uses hashtags: [never / 3-5 at end / inline]
```

### Voice Quick-Check

Before presenting any draft, verify:
- Could this post have been written by anyone? If yes, it fails.
- Read the first 3 sentences aloud. Do they sound like the author's past posts?
- Check the language swap table. Are any "Not This" words in the draft?
- Is the emoji frequency correct?
- Does the ending match the author's typical pattern?

---

## Post Frameworks

Use one framework per post. Each framework below includes: structure, example hook, when to use it, and target length.

### 1. Hot Take

A contrarian opinion that challenges conventional wisdom. Designed to provoke engagement through disagreement and "yes, finally someone said it" reactions.

**Structure:**
```
[Bold, contrarian statement - 1 sentence, max 15 words]

[1-2 sentences of context. Why most people are wrong.]

[3-5 sentences building your argument. Use specifics, not generalities.
Name the tools, tactics, or beliefs you are pushing back on.]

[1-line closer that reinforces the take. No hedging.]

[CTA: polarizing question that forces a stance]
```

**Example hook:** "Your CRM is not a strategy. It is a spreadsheet with a login page."

**When to use:** Industry debates. Challenging popular tools, tactics, or beliefs. Reframing something everyone takes for granted. Works best when you have a strong opinion backed by experience, not just contrarianism for attention.

**Length:** 500-800 characters. Hot takes lose power when they ramble.

---

### 2. Framework Post

A step-by-step system or process. The core authority-builder. This is what positions you as someone who has done the work, not just thought about it.

**Structure:**
```
[Hook: result or bold claim about what this framework produces]

[1-2 lines of context: who this is for, why it matters]

[Numbered list: 5-9 steps or components]
  - Each item: clear title + 1-2 lines of detail
  - Be specific enough that someone could start executing

[1-line closer: the outcome of following the framework]

[CTA: "Comment [KEYWORD] for the full playbook" or a question]
```

**Example hook:** "Every outbound campaign we run follows the same 7 steps. Here is the framework."

**When to use:** Sharing processes, systems, playbooks, or mental models you actually use. Best when the framework is tested, not theoretical. Include real tool names, real numbers, real steps.

**Length:** 1,000-1,500 characters. Framework posts earn their length through density, not filler.

---

### 3. Story Post

A personal narrative that teaches through experience. Highest emotional engagement of any format.

**Structure:**
```
[Hook: the most interesting moment of the story, not the beginning.
Drop the reader into the middle of the action.]

[Set the scene: 2-3 sentences. Where, when, what was at stake.]

[The conflict or turning point: 3-5 sentences. What went wrong,
what changed, what you did not expect.]

[The lesson or outcome: 2-3 sentences. What you learned that
the reader can apply to their own situation.]

[CTA: question inviting shared experience]
```

**Example hook:** "I mass-applied for 300 jobs. Not a single reply. Then I sent one DM."

**When to use:** Founder journey moments, career pivots, failures, moments where you learned something the hard way. The story must serve the lesson. If the story is just "look at me," skip it.

**Length:** 800-1,200 characters. Long enough to build tension, short enough to hold attention.

---

### 4. Tool Review / Stack Breakdown

An authoritative review of tools you have actually used. Credibility comes from volume tested and honest verdicts.

**Structure:**
```
[Hook: number of tools tested + bold verdict or ranking]

[Brief context: why you tested these, what you were solving for]

[List: each tool with 1-2 line verdict. Be specific.
"Good UI" is useless. "Found 40% more emails than Tool B" is useful.]

[Summary: your actual recommendation, with caveats by use case]

[CTA: "Save this for your next stack review" or "What did I miss?"]
```

**Example hook:** "I tested 12 email finding tools over 90 days. Here is the honest ranking."

**When to use:** Software reviews, tech stack reveals, tool comparisons. Only write these if you have actually used the tools. "I read the landing page" does not count.

**Length:** 800-1,500 characters. Dense information. Every line should teach something.

---

### 5. Case Study / Results Post

Sharing real results with enough detail to be credible. The proof post that converts followers into leads.

**Structure:**
```
[Hook: the headline metric. One number, one result.]

[Context: who (anonymized if needed), what, timeframe.
"A B2B SaaS company with 50 employees" is fine.]

[The approach: 3-5 bullets on what you actually did.
Tool names, sequence details, targeting criteria.]

[Results: specific numbers. Before and after.
"Increased pipeline" is vague. "47 qualified meetings in 60 days" is real.]

[Takeaway: the one lesson that generalizes beyond this specific case]

[CTA: question about their experience with similar problems]
```

**Example hook:** "47 qualified meetings in 60 days. Zero cold calls. Here is the system."

**When to use:** Client wins (with permission), campaign results, business milestones. Every claim needs a number. If you cannot put a number on it, it is not a case study.

**Length:** 800-1,200 characters. Tight and metric-heavy.

---

### 6. Giveaway / Lead Magnet

Offering something free in exchange for engagement. High reach, moderate quality leads. The comment-trigger mechanic is the engine.

**Structure:**
```
[Hook: what you are giving away + why it is valuable.
Lead with the outcome, not the format.
"The system that booked 200 meetings" > "A PDF checklist"]

[2-3 lines on what is inside. Be specific.
"12 cold email templates with subject lines and reply rates" >
"A helpful resource about email"]

[Social proof: who else has used it, what results it produced.
"Used by 50+ B2B teams" or "This is the exact system we run internally."]

[CTA: "Comment [KEYWORD] and I will send it over"]
```

**Example hook:** "I am giving away our entire outbound playbook. The same one we use for clients paying $10k/month."

**When to use:** Playbooks, templates, checklists, recordings, swipe files. The giveaway must be genuinely useful. If it is a disguised sales pitch, people will notice and disengage.

**Length:** 500-800 characters. Short and punchy. The value is in the asset, not the post.

---

### 7. Milestone / Journey Post

Sharing a business or personal milestone with enough vulnerability and specifics to be relatable, not just bragging.

**Structure:**
```
[Hook: the milestone as a contrast or transformation.
Before/after is the strongest opener here.]

[Context: where you started. Be honest about the starting point.
The worse the "before," the better the story.]

[3-5 bullets on what actually happened. Key decisions,
turning points, things that did not work along the way.]

[What you would do differently or what surprised you]

[CTA: question inviting others to share their own milestone or journey]
```

**Example hook:** "No clients. No revenue. No team. That was 8 months ago. Here is what happened."

**When to use:** Revenue milestones, team growth, product launches, follower milestones. Only works if you share real details. "We grew a lot" is not a milestone post, it is a humble-brag.

**Length:** 800-1,200 characters.

---

## Hook Patterns

The hook is 80% of the battle. If nobody stops scrolling, the rest of the post does not matter. Every hook below includes a template, an example, and guidance on when it hits hardest.

### The 12 Hook Formulas

**1. Bold claim + number**
- Template: "[Specific number] + [specific result] + [timeframe]."
- Example: "We booked 320 meetings in October."
- Best for: Case studies, results posts. The number does the credibility work.

**2. Contrarian statement**
- Template: "[Common belief everyone holds] is [wrong/broken/overrated]."
- Example: "Your CRM is lying to you."
- Best for: Hot takes, industry commentary. Must be defensible, not just provocative.

**3. Story intro (start in the middle)**
- Template: "I [past tense verb] + [specific detail] + [time marker]."
- Example: "I mass-applied for 300 jobs. Not a single reply."
- Best for: Origin stories, founder journey moments, career pivots. Drop the reader into the action.

**4. News hook**
- Template: "[Company/platform] just [specific action]. Here is [what it means / why it matters]."
- Example: "Google just released their AI agent platform. Here is what changes."
- Best for: Reactive content, tool launches, industry shifts. Must be timely (post within 24-48 hours).

**5. System reveal**
- Template: "I am giving away [specific asset]. [For free / For $1 / No catch]."
- Example: "I am giving away our entire outbound system. For free."
- Best for: Giveaways, lead magnets, playbook drops. The more specific the asset, the better.

**6. Stat + implication**
- Template: "[Number]. [Number]. [Number]. [What it adds up to]."
- Example: "11.8k emails sent. 10.2% reply rate. 178 opportunities."
- Best for: Case studies, campaign breakdowns. Stacking 3+ numbers creates momentum.

**7. Before/after**
- Template: "[Bad starting state]. [Another bad detail]. That was [time period] ago."
- Example: "No revenue. No pipeline. No team. That was 7 months ago."
- Best for: Milestone posts, transformation stories. The contrast between before and after does the work.

**8. Direct question**
- Template: "How many [specific things] are actually [doing the thing they claim to do]?"
- Example: "How many tools in your stack are actually contributing to pipeline?"
- Best for: Thought leadership, challenging assumptions. The question must be uncomfortable, not easy.

**9. Admission of failure**
- Template: "This [specific thing] [failed/flopped/bombed]. Here is [what I learned / what I changed]."
- Example: "This campaign flopped. 2,000 emails. 3 replies. Here is what went wrong."
- Best for: Story posts, lessons learned. Only works if the failure is specific and the lesson is real.

**10. Pattern interrupt**
- Template: "Stop [thing everyone does]." or "[Unexpected 2-3 word statement]."
- Example: "Stop building funnels."
- Best for: Hot takes, contrarian content. The shorter, the better. Must be followed by a real argument.

**11. Curiosity gap**
- Template: "The [superlative] [thing] I ever [did] was [surprising detail]."
- Example: "The highest-converting email I ever sent was 19 words."
- Best for: Framework posts, case studies. The gap between what the reader expects and the detail you reveal creates the pull.

**12. Social proof stack**
- Template: "[Number] + [units]. [Number] + [units]. [One result]."
- Example: "200+ companies. 12 months. One playbook."
- Best for: Giveaways, credibility posts, framework intros. Compress a lot of proof into a small space.

### Hook Rules

- The first line must stand alone. It should stop someone mid-scroll even without the rest of the post.
- No emojis in hooks. Ever.
- No questions that can be answered with "no" and a scroll. ("Do you want to improve your marketing?" - scroll.)
- Specific beats vague. "320 meetings" beats "hundreds of meetings." "19 words" beats "a short email."
- The hook is a promise. The post must deliver on it. If your hook says "here is the system," there must be a system in the post.
- Write 3 hooks before picking one. Your first hook is almost never your best.

---

## Formatting Rules

LinkedIn's feed is narrow, especially on mobile. Dense paragraphs die. These rules are non-negotiable.

### Line Spacing
- **Line break between every 1-2 sentences.** This is the single most important formatting rule. No paragraph should be more than 2 sentences.
- Double line break (blank line) between sections: hook, body, list, closer, CTA.
- After writing, mentally preview on a phone screen. If any section looks like a wall, break it up.

### Numbered Lists
- Use number emojis or plain numbers for lists of 3+ items.
- Each item: number + title on one line, then 1-2 short bullet points underneath.
- Keep bullets to one line each. No sub-bullets. No nested lists.
- If a list has 7+ items, consider splitting into a carousel instead of a text post.

### Length Targets
| Post Type | Character Target | Notes |
| --- | --- | --- |
| Hot take | 500-800 | Short and sharp. Loses power if it rambles. |
| Framework | 1,000-1,500 | Earns length through density. |
| Story | 800-1,200 | Long enough for tension, short enough for attention. |
| Tool review | 800-1,500 | Dense information. Every line teaches. |
| Case study | 800-1,200 | Tight and metric-heavy. |
| Giveaway | 500-800 | The value is in the asset, not the post. |
| Milestone | 800-1,200 | Specifics, not filler. |

### Character Count Context
- LinkedIn shows ~210 characters before the "see more" fold on mobile.
- Your hook + first line of context must fit in that window.
- If the reader does not click "see more," the rest of the post does not exist.

### General Formatting Rules
- Use dashes (-) for bullet points. Arrows for emphasis or flow.
- Bold sparingly. Use bold for section headers in long posts or to highlight one key phrase per section. Not for emphasis within every sentence.
- No hashtags in the body of the post. If you must use them, put 3-5 at the very end, separated by a line break.
- Never tag someone just for reach. Only tag if they are directly referenced or will genuinely engage.
- No links in the post body. LinkedIn's algorithm suppresses posts with external links. If you must link, put it in the first comment.

---

## CTA Patterns

Every post should end with a reason for the reader to do something. Match the CTA to your goal.

### 5 CTA Types by Goal

**1. Comment trigger (Goal: reach + lead capture)**
- Pattern: "Comment [KEYWORD] and I will [send/DM/share] [specific thing]."
- Example: "Comment PLAYBOOK and I will send you the full system."
- When: Giveaways, frameworks, playbooks. Best for lead generation. Pair with an automation that actually delivers the asset.
- Why it works: Low friction. One word to type. Creates visible engagement that signals the algorithm.

**2. Save prompt (Goal: bookmarks + long-term visibility)**
- Pattern: "Save this for [specific future situation]."
- Example: "Save this for your next stack review."
- When: Tool reviews, checklists, reference posts. Bookmarks count as engagement and keep the post circulating.

**3. Polarizing question (Goal: comments + debate)**
- Pattern: "[Specific question that forces the reader to pick a side]?"
- Example: "Is cold email dead or are most people just bad at it?"
- When: Hot takes, industry commentary, news reactions. The question must have two clear sides. "What do you think about marketing?" generates nothing. "Should SDRs be replaced by AI agents?" generates debate.

**4. Shared experience (Goal: community + relatability)**
- Pattern: "Anyone else [been through this / seen this / dealt with this]?"
- Example: "Anyone else had a campaign that looked perfect on paper and completely bombed?"
- When: Story posts, failure posts, milestone posts. Works because it invites people to share their own version.

**5. Follow prompt (Goal: follower growth)**
- Pattern: "Follow [me / along] for [specific content category]."
- Example: "Follow for weekly breakdowns of what is actually working in B2B outbound."
- When: Posts that demonstrate clear expertise in a niche. Only use if the post itself proves you are worth following. Empty follow prompts are ignored.

### CTA Anti-Patterns
| Pattern | Why It Fails |
| --- | --- |
| "Agree? Thoughts?" | Lazy. No one feels compelled to respond to a vague prompt. |
| "Like and share if you found this helpful!" | Begging for engagement. Signals low confidence in the content. |
| "Link in comments" (without actually adding one) | Broken promise. Trains your audience to distrust you. |
| "Drop a comment below!" | Generic. Does not give the reader a reason or topic. |
| A question so broad nobody would answer it | "What do you think about B2B in 2026?" is too vague. Ask about something specific. |
| Double CTA | Asking for a comment AND a follow AND a share. Pick one. |

---

## Anti-Patterns (What to Never Write)

These are specific patterns that instantly make a post sound generic, performative, or AI-generated. Each entry explains exactly why it fails and what to do instead.

| Pattern | Why It Fails | Instead |
| --- | --- | --- |
| "I'm so humbled and grateful..." | Performative. Nobody believes it. Reads as a rehearsed acceptance speech. | Start with what happened, not how you feel about it. |
| "Excited to announce..." | Overused by every company page on LinkedIn. Readers scroll past on autopilot. | Lead with the thing itself: "We just shipped X" or "X is live." |
| "Here are 5 tips to improve your..." | Generic. Sounds like every blog post from 2019. | Replace "tips" with a specific framework. "5 tips" vs. "The 5-step system we use for every client." |
| "Let that sink in." | Condescending. Implies the reader is slow. | Cut it. If the point is strong, it does not need a cue to be impressive. |
| Starting with "So..." | Filler word. Weak opener. | Delete it. Start with the next word. |
| "I failed and that is okay" | Self-help tone. LinkedIn is not a therapy session. | Share the failure, but lead with the lesson or the system you built to prevent it. |
| Ending with a question nobody would answer | "What do you think about B2B marketing?" is too broad. Nobody will write a paragraph in your comments. | Ask a specific question: "What is the highest reply rate you have ever hit on a cold campaign?" |
| Walls of text with no line breaks | Instant scroll-past on mobile. Nobody reads paragraphs on a 4-inch screen. | Line break between every 1-2 sentences. No exceptions. |
| Humble-bragging disguised as a lesson | "I accidentally built a $2M company" is not relatable, it is annoying. | Own the win directly, or make the post about the system, not the number. |
| Achievement post with no takeaway | Nobody cares about your win unless they can learn something from it. | Every win post needs at least 3 specific bullets on how you got there. |
| Opening with "I" in 3+ consecutive posts | Signals self-absorption. Your audience follows you for value, not autobiography. | Alternate openers. Start with a question, a stat, a bold claim. |
| Overusing "game-changer" or "next level" | Marketing cliches. Triggers the same mental filter as "limited time offer." | Be specific about what changed and by how much. |
| Posting a screenshot with no context | A screenshot of a dashboard is meaningless without the story behind it. | Always add 3+ lines explaining what the reader is looking at and why it matters. |

---

## Scoring Rubric

Score every draft before presenting. Do not present anything below 4.0 out of 5.

| Criterion | Weight | 5 (Ship it) | 3 (Needs work) | 1 (Rewrite) |
| --- | --- | --- | --- | --- |
| **Hook strength** | 25% | Stops the scroll. Specific number or bold claim. Earns the "see more" click. | Decent but vague. Could be sharper or more specific. | Generic, boring, or starts with "I'm excited." Easy to skip. |
| **Voice match** | 25% | Sounds exactly like the author's past posts. Passes the language swap table check. No AI giveaway words. | Close but has some off-brand phrasing. 1-2 words from the "Not This" column. | Could be anyone. No personality. Reads like a ChatGPT default. |
| **Substance** | 20% | Teaches something specific and actionable. Reader can do something differently after reading. | Has value but stays surface-level. "Good advice" without specifics. | Platitudes and generalities. Nothing the reader did not already know. |
| **Structure** | 15% | Clean formatting. Right length for the post type. Line breaks in the right places. Easy to scan on mobile. | Minor formatting issues. A section that is too dense, or slightly over/under target length. | Wall of text. No visual hierarchy. Would be scrolled past on a phone. |
| **CTA quality** | 15% | Natural CTA matched to post type and goal. Easy to act on. One CTA, not three. | Decent but generic. "What do you think?" without specificity. | Missing entirely, or forced/desperate ("LIKE SHARE FOLLOW"). |

### Scoring Example

When presenting a draft, show the score like this:

```
Hook: 5/5 - Specific number, stops the scroll
Voice: 4/5 - Strong match, but "utilize" in paragraph 3 is off-brand
Substance: 5/5 - Actionable framework with real tool names
Structure: 4/5 - Slightly over length target for this post type
CTA: 5/5 - Clean comment trigger, matched to giveaway format

Overall: 4.6/5 - Ready to ship after swapping "utilize" for "use"
```

---

## Content Calendar Planning

If you are posting consistently (which you should be), plan a week at a time. Here is a mix framework.

### Weekly Post Mix (3 posts/week)

| Day | Post Type | Purpose |
| --- | --- | --- |
| Monday/Tuesday | Framework or Case Study | Authority builder. Start the week with substance. |
| Wednesday/Thursday | Hot Take or Tool Review | Engagement driver. Mid-week debate and saves. |
| Friday | Story, Milestone, or Giveaway | Community builder. End the week on a personal or generous note. |

### Content Mix Rules
- Never post the same framework two weeks in a row.
- Alternate between "I" posts (personal stories, milestones) and "you" posts (frameworks, tools, how-tos).
- One giveaway per month maximum. More than that trains your audience to expect free things, not value.
- Reactive content (news hooks) can replace any scheduled post when the timing is right. Freshness matters more than planning.

### Batch Writing Workflow
1. Pick 3 topics for the week.
2. Write 3 hooks for each topic (9 total).
3. Pick the best hook for each topic.
4. Draft all 3 posts in one session.
5. Score each draft. Rewrite anything below 4.0.
6. Schedule or post.

---

## Tips for Better Posts

- **Start from something specific.** A data point, a screenshot, a customer conversation, a tool you just tested. Never start from "write a LinkedIn post about X."
- **One idea per post.** Posts that try to cover five topics perform worse than posts that go deep on one.
- **Read it aloud.** If any sentence sounds like marketing copy, rewrite it until it sounds like something you would say to a peer over coffee.
- **Track what works.** Keep a running log of your posts with engagement data (impressions, likes, comments, reposts). After 20+ posts, patterns emerge. Double down on what performs.
- **Repurpose aggressively.** A single long-form piece (podcast, blog, presentation) can produce 5-10 LinkedIn posts by pulling out individual insights.
- **Engagement in the first 60 minutes drives reach.** Reply to every comment quickly. Ask follow-up questions. The algorithm rewards conversations, not just reactions.
- **Post timing matters less than consistency.** Tuesday-Thursday 8-10am in your audience's timezone is conventional wisdom, but a great post at 3pm will outperform a mediocre post at 9am. Focus on quality and frequency.
- **Never post and ghost.** If you are not going to be around to reply to comments for at least an hour, delay the post.
