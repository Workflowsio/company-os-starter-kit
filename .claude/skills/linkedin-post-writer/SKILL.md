---
name: linkedin-post-writer
description: |
  Use this skill when a post is going out on your own or a colleague's LinkedIn feed and it has to sound like the person rather than like a content team - "draft a post about this", "turn this into a LinkedIn post", "we shipped something, write the announcement", "make this sound like me", "here is a screenshot of the results, write it up", "repurpose the podcast into posts", "I have a hot take and no time", "score this draft before I publish", "why does everything I write sound like AI". Reads at least ten of the author's past posts to build a voice profile, picks one post format and one hook, and produces a draft plus a scored self-review against a weighted rubric with the failing dimensions named. It hands the draft to a human and never publishes. NOT cold outbound messages, connection requests or sequence copy sent to strangers, which is the outbound-copywriter skill. NOT deciding what to post about across a quarter, because this writes one post from an idea you already have.
---

# LinkedIn post writer

## When this applies

There is one idea and it needs to become one post in a specific person's voice: a framework, a result, a hot take, a tool teardown, a milestone, or a long-form piece being repurposed. It also applies to grading a draft somebody else wrote before it goes out.

Maturity: the formats, hooks and rubric here have been used on real B2B accounts. The voice half is the part that decides whether a post lands, and it is worthless until you feed it real past posts from the actual author.

## What it produces

- A voice profile for the author, written to `{{VOICE_PROFILE_PATH}}` so the next post does not rebuild it.
- One format and one hook, both chosen out loud, with three hook candidates shown and two discarded.
- A draft at the character target for that format.
- A weighted score out of 5 with every dimension named and every deduction explained.
- A publish handover: what a human should check, and what to do in the first hour after posting.

## Fill these in

- `{{AUTHOR}}` - whose voice this writes in, since a company page and a founder are different voices
- `{{AUDIENCE}}` - who is being written for, by title and seniority
- `{{POST_ARCHIVE}}` - where the author's past posts live, so the voice profile can be rebuilt
- `{{APPROVAL_OWNER}}` - who publishes, which is never this skill
- `{{SCORE_FLOOR}}` - the score below which a draft is not presented (default: 4.0)
- `{{VOICE_PROFILE_PATH}}` - where this author's profile is stored, one file per author. Default `company-wiki/marketing/voice-<author>.md` for your own team, `clients/<slug>/voice.md` for an account. **Never inside this skill:** see the note under the interview.

## First run: the customization interview

**Run this as a one-time setup step, outside any live engagement, and never mid-run.** It edits files, and editing a skill or its reference material while it is being used against real work is how a run half-follows two versions of its own instructions.

Read before you ask. Pull the author's last twenty posts from `{{POST_ARCHIVE}}`, run the voice extraction in `references/voice-extraction.md`, and present the extracted profile for correction. A profile you extracted and they corrected is far better than a profile they described from memory, because nobody describes their own writing accurately.

Then ask only what the posts cannot tell you, one question at a time.

1. Who are you writing for? Titles and seniority, not "B2B people".
2. What are the three or four topics you have standing authority on, and which ones are off limits?
3. What is the goal of a typical post: reach, comments, leads, hiring, or credibility with one specific group?
4. What are you not allowed to say in public? Numbers, client names, competitor names, anything under NDA.
5. Who else posts in this space and sounds nothing like you? Useful as a contrast, so the draft avoids drifting toward the house style of the category.

Write the answers back to `{{VOICE_PROFILE_PATH}}`: the extracted profile, and the prohibited list as this author's automatic violations. Then fill the placeholders above in this file. Say which files changed.

**Per-author content never goes into this skill's own reference files.** `references/voice-extraction.md` holds the extraction method and an empty template, and `references/scoring-rubric.md` holds the universal rubric. Both are read by every author who uses this skill. Write one author's profile into them and a team with three writers overwrites one profile with another, and one author's banned phrases become automatic violations for everybody. The method is universal, the profile is not, and the two live in different places.

## Reference routing

| File | What it contains | When to read it | What breaks if you skip it |
|---|---|---|---|
| `references/voice-extraction.md` | The seven-step extraction, the empty voice profile template, the quick-check before presenting. Method only, never one author's answers | Before the first draft for any new author, and again whenever the author says a draft does not sound like them | The post is competent and anonymous, which is the single most common failure of a written-by-agent post |
| `{{VOICE_PROFILE_PATH}}` | This author's filled profile and their prohibited list. One file per author, outside this skill | At step 1 of every run | You rebuild the profile from scratch each time, or you write in the last author's voice |
| `references/post-formats.md` | The seven formats with structure, example hook, when to use, character target, plus the formatting rules | While choosing a format and while laying the draft out | The draft is a wall of text with no shape, which loses the reader at the fold |
| `references/hooks-and-ctas.md` | Twelve hook formulas, the hook rules, five CTA types by goal, and the CTA anti-patterns | While writing the first line and the last line | The first line does not survive the fold, and the closer asks for nothing anyone would give |
| `references/scoring-rubric.md` | Weighted dimensions, level descriptions, the population prior, the ceiling rule, verdict bands, automatic violations | Before presenting any draft, as a separate pass | Scores drift upward every run until the gate stops separating good drafts from bad ones |

## Step 1 - Build or load the voice profile

If a profile exists at `{{VOICE_PROFILE_PATH}}`, load it and check it is still current. If it does not, build it now from at least ten past posts and write it there. Three to five is enough for a rough calibration and you should say so in the handover; fewer than three means voice cannot be scored, and the rubric handles that case explicitly.

Never write from a described voice. "Punchy and direct" describes half of LinkedIn.

## Step 2 - Gather the idea

Do not draft until you have the first three of these.

1. **The core idea.** A specific insight, result, experience or opinion. Not a topic. "We tested six email finding tools and one won by 40 percent on accuracy" is an idea. "Write about outbound" is not.
2. **The reader.** Titles and seniority, because a post for founders reads differently from a post for marketing managers.
3. **The voice source.** Past posts, per step 1.
4. **The goal.** Exactly one of reach, comments, leads, credibility or hiring.
5. **The proof.** Screenshots, metrics, quotes, before and after numbers, if any exist.
6. **A format preference**, or an explicit "you pick".

If the idea is a topic rather than an insight, push back and ask what specifically happened. Every good post starts from something that occurred, and no good post starts from a subject line.

## Step 3 - Pick one format and one hook

One format per post. The tree runs on what you actually have, not on what would perform best in the abstract.

1. A real number and a real outcome? Use **Case Study**.
2. A repeatable process you have run more than once? Use **Framework**.
3. A defensible disagreement with something the category believes? Use **Hot Take**.
4. First-hand experience with several tools in one category? Use **Tool Review**.
5. Something that happened to you with a turn in it? Use **Story**.
6. An asset genuinely worth having? Use **Giveaway**, maximum one a month.
7. A before and after in your own business? Use **Milestone**.
8. None of these fit cleanly? The idea is not ready. Say so and ask one question that would make it ready, rather than writing a format-less post.

Then write three hooks and pick one, showing the two you discarded so the author can overrule you. The first line has to stand alone, because roughly 210 characters show before the fold and everything after that only exists if the first line earned the click.

## Step 4 - Draft it

Write to the character target for the format. Line break every one or two sentences. One idea per post, because posts that cover five topics perform worse than posts that go deep on one.

Then apply the voice profile as a filter rather than a style: check the swap table, the opener pattern, the emoji frequency and the closing pattern. A draft that is structurally perfect and sounds like nobody has failed.

## Step 5 - Score it as a separate pass

Run `references/scoring-rubric.md` as a fresh read that did not write the draft, together with the prohibited list in `{{VOICE_PROFILE_PATH}}`, which carries this author's automatic violations. The context that wrote it believes its own reasoning, and self-scoring drifts up every time.

Return the score, every dimension, and the specific line behind each deduction. Do not present anything below `{{SCORE_FLOOR}}`, and do not quietly round up to reach it. Cap the rewrite loop at three rounds. At the cap, present the best round with the unresolved violations listed as open flags and hand it to `{{APPROVAL_OWNER}}`.

## Step 6 - Publish gate. This skill never posts.

- **Hand the draft to `{{APPROVAL_OWNER}}`.** Publishing is a human action, including from any scheduling tool. There is no version of this where the agent posts.
- **Flag anything that needs clearance before it goes out.** A client name, a revenue figure, a competitor comparison, a screenshot with somebody else's data in it, a claim about a named third party. Name what needs clearing and from whom, rather than softening it silently.
- **Never invent a number.** If the draft needs a metric the author has not given you, leave a marked blank and say what is missing. A fabricated statistic in a public post is the one mistake here that cannot be walked back.
- **Say what the first hour needs.** Reply to comments quickly, because early conversation drives reach far more than the posting time does. Do not post and disappear.

## What good looks like

A good run does the boring half first. Twenty past posts came out of the archive before anything was written, the extracted profile said average sentence length 11 words, opens with a number in six posts out of twenty, never uses emojis outside list markers, and closes with a question about half the time. The author corrected one line of that profile and it got saved. The idea was a real one: a tool test with a 40 percent accuracy gap and a screenshot to back it. Format chosen as Tool Review over Case Study, because the reader learns something reusable rather than reading about somebody else's win. Three hooks were written and the two discards were shown, which is what let the author take the second one instead. The draft ran 1,180 characters against a 1,500 ceiling, one idea, line breaks every second sentence, no hashtags in the body. The rubric ran as a separate pass and returned 4.2 with the deduction named: one banned word in paragraph three, sitting on the swap table. It was fixed and the score was re-reported rather than assumed. The draft went to the author, who published it, and the one number in it was one the author had actually measured.

Mediocre looks like a post written from a topic rather than an incident, in a voice described as "confident and approachable" because nobody pulled the past posts. It opens with "Excited to share", carries three ideas, runs 2,400 characters in four paragraph blocks, ends with "Thoughts?", scores itself 4.6 in the same breath as writing itself, and contains one impressive statistic that nobody can source.

## Hard rules

- MUST build the voice profile from real past posts before drafting, and say so when fewer than ten were available.
- MUST start from a specific insight, result or incident, and push back when handed a topic.
- MUST pick exactly one format and one goal per post.
- MUST write three hooks and show the discards.
- MUST keep the first line standing alone, because everything after 210 characters is behind the fold.
- MUST score with a separate pass, report every dimension, and name the line behind each deduction.
- MUST cap the rewrite loop at three rounds and hand over the best attempt with open flags at the cap.
- MUST flag anything needing clearance: client names, revenue figures, competitor comparisons, third-party claims, other people's data in screenshots.
- NEVER publish, schedule or post. The draft goes to a human.
- NEVER invent a metric, a quote or a customer result. Leave a marked blank and name what is missing.
- NEVER present a draft below `{{SCORE_FLOOR}}`, and never round up to clear it.
- NEVER let the same context write and grade the draft.
- NEVER put more than one CTA in a post, and never ask for a comment, a follow and a share at once.
- NEVER use engagement bait with no substance behind it. A post that asks for a reaction it has not earned costs more reach on the next post than it gains on this one.
