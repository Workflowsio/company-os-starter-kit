# Voice extraction

Read before the first draft for any new author, and again whenever the author says a draft does not sound like them. Generic content is obvious and gets ignored, and voice is the only part of a post an agent cannot fake from a description.

Work from at least ten past posts. Do the full extraction before writing anything, because the steps you skip are the ones that show up in the draft.

---

## Step 1 - Sentence analysis

- Average sentence length. Count the words in twenty sentences chosen at random.
- Do they use fragments? "Built this. Shipped it. Worked." is a habit, not an accident.
- How often does a sentence start with "I" against another opener?

## Step 2 - Opening patterns

- How do they open: a bold claim, a question, a moment from a story, a statistic?
- List the five most common first-line structures from the sample.

## Step 3 - Vocabulary fingerprint

Build a swap table of words they actually use against words they never use. Note signature phrases and repeated expressions. Note the jargon habit: do they name tools, use acronyms, or spell everything out?

| They say this | Never this |
|---|---|
| [extracted from posts] | [the common alternative they avoid] |
| [extracted from posts] | [the common alternative they avoid] |

## Step 4 - Structural habits

- Numbered lists, bullets, or neither?
- How do they transition: line breaks only, or transition words?
- What is the typical shape? Hook, context, list, CTA? Hook, story, lesson?

## Step 5 - Tone markers

Place them on each spectrum from the sample rather than from what they say about themselves.

```
[Arrogant] -------- [Confident] -------- [Humble]
[Academic] -------- [Practical] -------- [Simplistic]
[Safe] ------------ [Slightly edgy] ---- [Inflammatory]
[Polished] -------- [Conversational] --- [Unfiltered]
```

## Step 6 - Emoji and formatting

- Frequency: never, list markers only, occasional, heavy?
- Which specific emojis appear?
- Do they use bold, and where?

## Step 7 - Closing patterns

- How do posts end: a question, a statement, a comment trigger, nothing?
- Do they ever use follow-for-more style closers?

---

## Voice profile template

Copy this into `{{VOICE_PROFILE_PATH}}`, one file per author, and fill it in there. It stays empty here.

This file is the method and every author's run reads it. A filled profile in here is one account's answers sitting in the universal layer: a team with three writers overwrites one profile with another, and the second author's prohibited list becomes an automatic violation for everybody. Universal method, per-author data, two locations.

```
VOICE PROFILE: [Name]           Extracted: [date]   Sample size: [n posts]
- Avg sentence length: [X] words
- Fragment usage: never / sometimes / frequently
- Typical opener: [pattern]
- Emoji frequency: never / list markers only / occasional / heavy
- Tone: [confident|humble], [practical|academic], [edgy|safe], [conversational|polished]
- Signature phrases: [list]
- Never says: [list]
- Ends posts with: [pattern]
- Uses bold: never / section headers / emphasis
- Uses hashtags: never / 3-5 at end / inline
```

Date the profile. A voice moves over a year, and an undated profile is a number nobody can reason about. Re-extract when the sample is more than six months old or when the author changes what they write about.

---

## Quick check before presenting

- Could this post have been written by anybody? If yes, it fails, regardless of how good it is.
- Read the first three sentences aloud. Do they sound like the sample?
- Check the swap table. Is anything from the right-hand column in the draft?
- Is the emoji frequency right?
- Does the closing match their pattern?

---

## When there are not enough posts

Three to five posts gives a rough calibration and you say so in the handover. Fewer than three means voice cannot be assessed at all: write the draft, state plainly that no voice calibration was possible, and score it under the missing-input rule in `scoring-rubric.md` rather than guessing a voice score. A guessed voice score is worse than an unscored one, because it looks comparable to a real one.
