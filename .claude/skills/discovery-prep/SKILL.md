---
name: discovery-prep
description: |
  Use this skill when a specific meeting with a named person is on the calendar and nobody has done the homework - "I have a call in an hour", "who are these people", "build me a brief for tomorrow's call", "what do I ask them", "a new stakeholder joined the thread, what do I need to know", "prep me for the renewal", "what are they going to push back on", "we are re-engaging a stale deal, what changed at their company", "brief me before the demo". Reads the CRM record, the prior thread, public sources and recent signals, then produces a one-page brief a rep scans in five minutes: company and person snapshot, three pain hypotheses with the evidence behind each, an opener, the questions to ask, the objections to expect with responses, and the next step to propose. The brief is internal, and this skill never contacts the prospect. NOT scoring a list of accounts for fit, which is the icp-modeller skill and runs long before anybody books a meeting. NOT the outbound message that gets the meeting booked in the first place, which is outbound-copywriter.
---

# Discovery prep

## When this applies

One named person, one scheduled conversation, and fifteen minutes or less to get ready. It covers a first call, a follow-up where new stakeholders are joining, a demo, a negotiation, a renewal or expansion conversation, and the refresh before reaching back into a stale opportunity.

Maturity: the research layers, the call-type playbooks and the objection responses have been used in real sales conversations. The objection table is the part that improves fastest once you start adding your own, so treat the shipped rows as a starting library rather than the finished one.

## What it produces

One page, in this order, because that is the order a rep reads it in with four minutes to go:

- A 30-second version that stands alone if nothing else gets read.
- Company snapshot and person profile.
- Three pain hypotheses, each with the evidence behind it, clearly marked as hypotheses.
- An opener referencing something specific to them, and the bridge from rapport into discovery.
- The questions, grouped into discovery, qualification and closing.
- The objections to expect, with a response for each.
- The next step to propose, with who, what and when.

## Fill these in

- `{{CRM}}` - where prior activity, notes and deal history live
- `{{ENRICHMENT}}` - what supplies company and person data, and what a lookup costs
- `{{WHAT_WE_SELL}}` - one sentence, so pain hypotheses and value framing are tailored rather than generic
- `{{PROOF_POINTS}}` - the customer results that can be cited, and which names are cleared for use
- `{{PREP_BUDGET}}` - default minutes of prep for a standard call (default: 10) and for a high-value one (default: 30)

## First run: the customization interview

**Run this as a one-time setup step, outside any live engagement, and never mid-run.** It edits files, and editing a skill or its reference material while it is being used against real work is how a run half-follows two versions of its own instructions. Company-level answers belong in these files; anything specific to one account or one person belongs in `clients/<slug>/` or `company-wiki/`, not in a reference file every account's run reads.

Read before you ask. Pull three recent closed-won and closed-lost records from `{{CRM}}` and look at what actually appears in the notes, because that tells you which questions this team already asks well and which ones they never get to. Present that, then ask what the records cannot answer.

1. What do you sell, in one sentence a buyer would recognise?
2. Which proof points can be cited by name, and which have to stay anonymous?
3. What are the three objections you hear most, and what currently works against each?
4. Who are you usually compared against, and what is your honest differentiator against each?
5. What is your standard next step after a first call?
6. What is off limits to mention: a competitor's legal trouble, a customer under NDA, anything else.

Write the answers into `references/briefing-template.md` under objections and competitive positioning, and the placeholders into this file. The objection library is the part of this skill that compounds, so every new objection heard on a live call gets added with the response that worked.

## Reference routing

| File | What it contains | When to read it | What breaks if you skip it |
|---|---|---|---|
| `references/research-layers.md` | The four research layers with every data point, where it comes from and why it matters, plus the source quick reference | At step 2, while researching | You research the company and not the person, which is the most common way a brief still produces a generic call |
| `references/call-type-playbooks.md` | Five call types with the goal, the prep emphasis, the time structure, the key questions, what not to do, and the success measure | At step 1, before any research, because the call type decides which layers matter | You bring first-call prep to a negotiation and spend the meeting re-discovering things they already told you |
| `references/briefing-template.md` | The full one-page template, the objection table with responses, competitive positioning and the do-not-say list | At step 4, while assembling, and at step 5 before handing it over | The brief becomes research notes rather than something usable in the four minutes before a call |

## Step 1 - Identify the call type first

Everything downstream depends on this. A first call and a renewal need different research, different questions and a different structure, and the same prep given to both is wrong for at least one.

Ask, or infer from `{{CRM}}` and say what you inferred: first call, follow-up, demo, negotiation, or renewal and expansion. Then read the matching playbook.

## Step 2 - Research in layers, bounded by the time available

Four layers, each adding depth. Do not run all four by reflex.

- **10 minutes:** layers 1 and 2. Company and person.
- **30 minutes:** all four. Add competitive landscape and recent signals.

1. **Company.** What they do, size, stage, markets, recent news, tech stack, who is likely on the buying committee.
2. **Person.** Title and tenure, previous roles, what they post about, mutual connections, communication style, whether they are new in role.
3. **Competitive landscape.** What they already use in your category, who else they might be evaluating, whether they are considering building it themselves, and any contract timing you know about.
4. **Recent signals.** Leadership changes, funding, job postings, launches, events. The time-sensitive layer, and the one that produces the opener.

Time-box it. You do not need to know everything, you need to know enough to ask good questions, and over-preparation past the box is time taken from the next call's prep.

## Step 3 - Spend gate. Runs before any paid lookup.

- Free sources first: the CRM, the prior thread, the company website, public profiles, public news. Most briefs are complete before anything is spent.
- If a paid enrichment lookup is needed, name what is missing, what the lookup costs, and what it changes about the call. Then ask.
- Never run a bulk enrichment for a single meeting. One record, one lookup.

## Step 4 - Write three pain hypotheses, and label them

Each hypothesis carries the evidence behind it: the signal, the role, the stage, the thing you actually observed. A hypothesis with no evidence line is a guess wearing a label, and a rep who repeats it in the room sounds confident about something they invented.

Mark them as hypotheses in the brief itself. The job of the call is to validate or disprove them, and a rep who walks in certain about the pain talks past the answer.

## Step 5 - Assemble the page, then cut it

Fill `references/briefing-template.md`, then cut it down to one page. The 30-second version goes at the top and has to stand alone, because that is the part that gets read.

A briefing that could apply to any company in the segment is a wasted briefing. Before handing it over, check that at least three lines could only have been written about this specific account and this specific person. If not, the research was too shallow and one more pass on layers 2 and 4 will fix it.

## Step 6 - Handover gate. The brief is internal.

- **Never send anything to the prospect.** No email, no message, no calendar note, no confirmation. This skill produces an internal document and hands it to the rep.
- **Never invent a fact about a real person or company.** If something is unknown, write unknown. A confident wrong detail about their funding or their previous employer costs more credibility in the first two minutes than the whole brief buys.
- **Mark anything sensitive as context rather than material.** Layoffs, negative press and executive departures shape the headspace they arrive in and they are not to be raised in the call. Say so on the line where you write them.
- **Flag anything cleared elsewhere.** A named customer reference, a specific metric, a competitive claim. Say which ones are safe to say aloud and which need checking.
- **Say what you did not check.** If prep was time-boxed at 10 minutes and layers 3 and 4 were skipped, write that at the bottom. A skipped layer is not a clean layer, and a rep who thinks a brief is complete stops asking.

## What good looks like

A good brief is short and unmistakably about one account. The call type was established first, and it was a second call rather than a first, which changed the whole shape: the prep went into the competitive layer and the new stakeholder joining, rather than into re-researching the company. The last three CRM activities were read, so the brief opens by naming the two things the buyer already said, and none of the discovery questions repeat them. The person research found a post from nine days ago about exactly the problem being sold into, which became the opener, and it was quoted rather than paraphrased. Three pain hypotheses, each with an evidence line, and the second one marked weak because it rests only on headcount growth. Nothing was purchased, because the CRM and public sources already covered it. The objections section carried the two most likely, one taken from the shipped library and one added last month after a live call, with the response that worked written next to it. The next step was specific: a named person to bring in, by a named date. At the bottom, one line saying the competitive layer was not checked because prep was capped at ten minutes. Nothing was sent to anybody outside the company.

Mediocre looks like three pages of research notes with no 30-second version, a company snapshot copied from the website, no person research beyond a job title, ten generic discovery questions that would fit any account in the segment, a pain hypothesis with no evidence behind it stated as a fact, a competitor named with a differentiator nobody has verified, no next step, and a confident claim about their funding round that turns out to be a year old and gets corrected by the buyer in the first minute.

## Hard rules

- MUST establish the call type before researching anything, and say so when it was inferred rather than given.
- MUST read the last three activities in `{{CRM}}` before writing a single question.
- MUST time-box research to `{{PREP_BUDGET}}` and say which layers were skipped.
- MUST attach an evidence line to every pain hypothesis, and label all three as hypotheses.
- MUST fit the brief on one page, with a 30-second version at the top that stands alone.
- MUST include at least three lines that could only have been written about this account and this person.
- MUST name free sources first, and present cost and reason before any paid lookup.
- MUST state which proof points and named references are cleared to say aloud.
- NEVER contact the prospect. No email, message, invitation or confirmation. The brief is internal and goes to the rep.
- NEVER invent a fact about a real person or company. Write unknown, because unknown is recoverable and wrong is not.
- NEVER put layoffs, negative press or an executive departure in the brief without marking it as context that is not to be raised.
- NEVER name a competitor with a differentiator nobody has verified, and never write a line that trashes one by name.
- NEVER hand over a brief that would fit any other account in the same segment.
- NEVER pad the page. A rep with four minutes reads the top third, so anything below it has to earn its line.
