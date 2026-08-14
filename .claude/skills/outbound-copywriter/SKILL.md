---
name: outbound-copywriter
description: |
  Use this skill when a cold outbound sequence needs to be written or rewritten and the messages go to people who have never replied to you - "write the cold email sequence for this segment", "our reply rate has tanked, rewrite the copy", "we need a new angle for this campaign", "write the LinkedIn connection message and the follow-ups", "this campaign is dead, what do we say instead", "draft the breakup email", "make this sequence sound less like a template", "we just pulled a signal list, what do we send them". Reads the ICP definition, the proof points and any prior reply data, then produces a full sequence: subject lines, a four-step body sequence with one job per step, the archetype chosen and the reason, and a QA pass against a copy checklist. It drafts only. It never sends, and it never uploads to a sequencer without approval. NOT organic posts published to your own audience, which is a different reader and the linkedin-post-writer skill. NOT the diagnosis of an underperforming campaign whose cause is deliverability, list quality or channel choice, which is the gtm-strategist skill and has to be ruled out first, because no rewrite fixes a domain reputation problem.
---

# Outbound copywriter

## When this applies

A sequence is going to strangers who have no reason to reply, and the copy has to earn the first response on its own. That covers a new segment, a rebuild of something underperforming, a scheduled refresh of a long-running campaign, and the first sequences off a newly warmed domain. It also covers cold LinkedIn connection notes and their follow-ups, which are the same job in a shorter format.

Maturity: the frameworks here have been run against real campaigns and the thresholds are the ones we use. They are not tuned to your business until you run the interview below and write your own numbers into this file.

## What it produces

- One archetype selection with the reason it beat the other six.
- Ten subject lines, narrowed to two for the test.
- A four-step sequence, each step with one job, in plain text at 60 to 120 words per email.
- A completed QA checklist with every failed line named.
- A test plan: what varies between the two variants, and the sends per variant before anyone reads the result.
- A ledger entry per shipped variant, so the next rebuild starts from measured copy rather than taste.

## Fill these in

The interview writes these into this file on the first run. Until then they are placeholders and the skill will ask.

- `{{SEQUENCER}}` - where sequences are built and sent
- `{{CRM}}` - where prospect and reply data lives
- `{{APPROVAL_OWNER}}` - who approves copy before it reaches a sequencer, and who approves the send
- `{{SEND_FLOOR}}` - sends per variant before a verdict is allowed (default: 200)
- `{{LEDGER}}` - where scored variants are kept between campaigns

## First run: the customization interview

**Run this as a one-time setup step, outside any live engagement, and never mid-run.** It edits files, and editing a skill or its reference material while it is being used against real work is how a run half-follows two versions of its own instructions. Company-level answers belong in these files; anything specific to one account or one person belongs in `clients/<slug>/` or `company-wiki/`, not in a reference file every account's run reads.

Research first, then ask. Before the first question, read whatever already exists: past sequences in `{{SEQUENCER}}`, reply data in `{{CRM}}`, the ICP definition, the website, any case studies. Pre-fill every answer you can and present it for correction. Never ask for something you could have detected.

Then ask what is left, one question at a time, waiting for each answer.

**Business context**
1. What do you sell, in one sentence a buyer would recognise?
2. Who is the buyer? Title, company size, industry, seniority.
3. What is your strongest proof point, with the number in it?
4. What does the buyer do about this problem today, without you?

**Voice and position**
5. Paste two or three messages you have sent that felt right. Voice gets extracted from these rather than described.
6. What words must never appear in your copy? These go into the banned list in `references/copy-qa.md`.
7. Premium, mid-market or budget? This decides how hard the CTA can push.

**Operating context**
8. What sends the mail, what holds the data, and what is the current positive reply rate?
9. Average deal size, because a high-value deal takes a softer ask and a low-value one takes a direct one.

Then write the answers into the files: voice patterns and banned words into `references/copy-qa.md`, proof points into the SPARK examples in `references/spark-and-archetypes.md`, and the placeholders above into this file. Say which files you changed.

## Reference routing

| File | What it contains | When to read it | What breaks if you skip it |
|---|---|---|---|
| `references/spark-and-archetypes.md` | The five SPARK elements with good and bad examples, ten subject line formulas, the seven archetypes and the selection tree | Before writing any first draft, and whenever the archetype choice is not obvious | The email becomes a generic five-paragraph pitch with no structural job per line |
| `references/persuasion-patterns.md` | Seven power patterns and the calibrated-question layer, each with the place in the sequence where it belongs | While drafting, once the archetype is chosen | The copy is structurally correct and reads flat, because nothing in it makes the reader stop and self-assess |
| `references/sequence-templates.md` | Steps 1 to 5 with the job of each, filled examples, and the rule for when step 5 should not exist | When writing anything past the opener | Follow-ups turn into "just bumping this", which is the fastest way to train a list to ignore you |
| `references/copy-qa.md` | The anti-pattern table, voice rules, banned words, the QA checklist, the A/B protocol, the performance thresholds and their diagnostics | Before presenting any draft, and again before any send | You ship copy nobody graded, then read the result as a copy verdict when the problem was somewhere else |

## Step 0 - Diagnose before you rewrite

If a campaign is already running and underperforming, the copy is not automatically the problem. Run this before writing a word, because a rewrite aimed at a deliverability problem burns a week and changes nothing.

- Open rate below 30 percent? Stop. This is deliverability rather than copy. Check authentication, warm-up state, sending volume per inbox and domain reputation, and hand it to whoever owns the infrastructure.
- Opens fine and total replies under 1 percent? This is a copy problem, so continue here.
- Replies fine and all of them negative? This is targeting. Better copy sent to the wrong people gets you more articulate rejections.
- Positive replies fine and no meetings booked? This is the handoff rather than the email. The sequence did its job.
- None of the above, or no data at all? Treat it as a copy problem and continue, and say plainly that you are doing so without evidence.

The tree branches on open rate first because that is the only failure here that makes every other number unreadable.

## Step 1 - Gather the inputs

Do not write without these four. If they are missing, ask for them, and say why generic input produces generic output.

1. **Target persona.** Title, company size, industry, seniority, geography.
2. **Value proposition.** What you sell and the specific outcome the buyer gets.
3. **Proof points.** Customer results with numbers, and whether each named company can be named publicly.
4. **Campaign trigger.** The signal that prompted this campaign, or an explicit "no signal".

Worth ten minutes each and strongly recommended: prior reply rates by variant, the competitive frame the buyer already holds, the disqualifiers who must not receive this, and the sending capacity you actually have.

Every prospect has a status quo, and your email competes with "do nothing" far more often than with another vendor. Name the status quo before you write, because the copy is displacing it.

## Step 2 - Pick one archetype

One primary archetype per campaign. Walk the tree in order and stop at the first match.

1. A timely signal from the last 30 days? Use **Observation**.
2. A case study from their exact segment? Use **Case Study**.
3. A data-driven buyer and a benchmark to show them? Use **Benchmark**.
4. Founder-led or referral-driven growth? Use **Referral Ceiling**.
5. Enough research to generate two or three ideas specific to their business? Use **Creative Ideas**.
6. A well-understood pain with hard numbers attached? Use **Problem-Solution**.
7. Nothing above matched? Use **Whole Offer**, the named fallback, and say in the handover that no signal was available.

The tree branches on signal recency first because a fresh signal beats a better-written email that has no reason to arrive today. Full structures for all seven are in `references/spark-and-archetypes.md`.

## Step 3 - Write the sequence

Three laws govern every email, and every draft is checked against all three.

1. **Relevance beats cleverness.** A plain email about the right problem beats a clever email about nothing. The first line has to prove you understand their world.
2. **One job per email.** Step 1 earns the reply, step 2 adds new value. Never combine jobs, and never ask for a meeting in step 1.
3. **Earn the reply rather than demanding it.** A question that confirms their situation outperforms a calendar link, because it costs the reader ten seconds instead of thirty minutes.

Write the body against SPARK, layer two power patterns on top, and keep every email between 60 and 120 words with 150 as the ceiling. Write ten subject lines before choosing one. Write the worst version of the email first so the bad ideas are out of the way before the draft that matters.

## Step 4 - Run the QA gate in a fresh context

Self-checking is not checking. The context that wrote the draft believes its own reasoning and grades it kindly, so the gate runs as a separate pass that never saw the drafting.

The gate reads `references/copy-qa.md`, returns ACCEPT or REJECT plus numbered violations, and never returns an edited draft. An evaluator allowed to fix things has quietly become the writer, and you have lost the only independent read you had.

Cap the loop at three rewrites. If violations survive round three, present the best round with the unresolved violations listed as open flags and hand it to `{{APPROVAL_OWNER}}`. Never silently ship a failing draft, and never loop past the cap.

## Step 5 - Send gate. Runs before anything reaches a real inbox. No exceptions.

- **This skill never sends.** It drafts, it grades, it hands over. Sending is a human action taken in `{{SEQUENCER}}` by `{{APPROVAL_OWNER}}`.
- **Show the rendered copy before approval, not the mechanics.** Approval to build a campaign is not approval to send one. A broadcast in our own history had genuine authorisation to be built and triggered, was tested only for whether it fired, and reached 31 external destinations before anyone had read what it actually said. Every one had to be deleted by hand.
- **Stage the rollout.** Send to a handful of real addresses first, read the replies, correct the copy, delete the tests, then release the rest. Never open the full list on the first pass.
- **Keep conditional logic out of the send step.** Compute the decision into a separate inspectable field so the send condition is one boolean a human can read at a glance.
- **Present cost before any spend.** If a step consumes enrichment or verification credits, show the exact parameters, the estimated volume and the estimated cost, then wait for `{{APPROVAL_OWNER}}`. Free checks first, then cheap, then expensive, then the export, and never spend on a row you are about to discard.

## Step 6 - Score it, and write to the ledger

A variant gets no verdict before `{{SEND_FLOOR}}` sends and five business days. Opens are noise, and an open-rate win is not a win.

| Metric | Strong | Acceptable | Kill and rewrite |
|---|---|---|---|
| Positive reply rate | above 3% | 1 to 3% | below 1% |
| Total reply rate | above 8% | 3 to 8% | below 3% |
| Bounce rate | below 2% | 2 to 3% | above 3%, which is a list problem rather than a copy problem |

Write every shipped variant into `{{LEDGER}}` with its campaign id, archetype, segment, full copy, numbers, the date scored, and one line on why you think it worked. Field data outranks taste, and it especially outranks a team favourite. Move a dead variant into a retired section with its reason attached rather than deleting it, because the next person needs to know it was already tried.

Promote a pattern into this file only once it has shown up in three independent campaigns. One good result is a prior worth checking, not a law.

## What good looks like

A good run starts by proving the copy is the problem. The campaign that prompted the rebuild had a 22 percent open rate, so nothing was written that day and the warm-up got fixed first; the rewrite came a week later against readable numbers. The archetype was chosen out loud, Observation over Case Study, because the funding signal was eleven days old and the case study came from an adjacent segment rather than the same one. Ten subject lines existed before one was picked, and the two that went into the test differed in exactly one thing. The first line named a status quo the buyer would recognise instead of complimenting their growth. The proof point was one number, cleared for public use, and it appeared once rather than three times. The QA pass ran as a separate read and came back with four numbered violations including a banned word and a second CTA hiding in the P.S., all fixed by round two. Nothing was sent by the agent. A staged batch went to a handful of live addresses, two replies came back saying the pain was real but the timing was wrong, the timing line was rewritten, the tests were deleted, and only then did the rest go out. Three weeks later the variant was scored at 240 sends and written into the ledger with its numbers, alongside the losing variant and the reason it lost.

Mediocre looks like a rewrite ordered on the day the reply rate dropped, with no check on deliverability first. It has three CTAs in the opener, a proof point stated as "significant results", a first line that could go to a thousand people unchanged, and an archetype nobody chose because the draft is really all seven blended together. It was reviewed by the context that wrote it, tested with four things different between the variants, called at 40 sends on open rate, and released to the full list in one pass because the copy looked fine in the preview pane.

## Hard rules

- MUST run the Step 0 diagnosis before rewriting any campaign that is already running.
- MUST have the persona, the value proposition, the proof points and the trigger before writing, and push back when they are missing.
- MUST pick exactly one archetype per campaign and state why it beat the others.
- MUST keep one job per email, one CTA per email, and 60 to 120 words per email.
- MUST run the QA gate as a separate pass that returns a verdict plus numbered violations, never an edited draft.
- MUST cap the rewrite loop at three rounds, and hand the best attempt over with its open flags at the cap.
- MUST show rendered copy and get approval before anything reaches a sequencer, then stage the rollout.
- MUST present exact parameters, volume and cost before any step that spends credits.
- NEVER send an email, activate a campaign, or upload a list. This skill drafts and hands over.
- NEVER treat approval to build as approval to send.
- NEVER claim a metric that is not real and cleared, and never name a customer who has not agreed to be named.
- NEVER call a variant on open rate, or on fewer than `{{SEND_FLOOR}}` sends.
- NEVER change more than one element between two test variants.
- NEVER delete a losing variant from the ledger. It keeps its reason so nobody runs it again.
- NEVER write "just following up". If there is no new value, there is no step.
