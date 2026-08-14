# Scoring rubric

Read before presenting any draft, as a pass that did not write the draft. Return the weighted score, every dimension, and the specific line behind every deduction.

---

## The five dimensions

Weights sum to 1.00. Score each dimension 1 to 5 using the level descriptions rather than a general impression.

| Dimension | Weight | 5 (ship it) | 3 (needs work) | 1 (rewrite) |
|---|---|---|---|---|
| **Hook strength** | 0.25 | Stops the scroll on its own. A specific number or a defensible claim. Fits before the fold and earns the expand. | Reasonable but vague. Could be sharper or more specific. Would probably not survive a busy feed. | Generic or self-congratulatory. Opens with "Excited to share". Nothing in it makes anybody stop. |
| **Voice match** | 0.25 | Indistinguishable from the author's past posts. Passes the swap table. No machine-writing tells. | Close, with one or two off-brand phrasings from the right-hand column of the swap table. | Could have been written by anybody. No personality, default cadence, no signature phrase anywhere. |
| **Substance** | 0.20 | Teaches something specific. The reader can do something differently tomorrow. | Real value, kept at the surface. Good advice with no specifics behind it. | Platitudes. Nothing the reader did not already know. |
| **Structure** | 0.15 | Clean formatting, right length for the format, line breaks in the right places, scans on a phone. | Minor issues. One dense section, or slightly over or under target. | A wall of text with no hierarchy. Scrolled past on a phone without being read. |
| **CTA quality** | 0.15 | One CTA, matched to the format and the goal, easy to act on. | Present but generic. "What do you think?" with no specificity. | Missing, or three CTAs, or desperate. |

---

## The population prior

**Most first drafts land between 2.5 and 3.5.** If you are scoring 4 or above across most dimensions, you are grading generously rather than reading closely. Re-read the level descriptions and score again.

This is here because a scorer with no stated prior drifts upward every run until the gate stops separating anything, and a rubric that always says ship is a rubric nobody needs.

---

## The ceiling rule

**If hook strength is 2 or below AND substance is 2 or below, the post cannot score above 3.0, regardless of the other three dimensions.**

A post nobody stops for, that teaches nothing when they do, is not rescued by clean formatting and a good closing line.

**Worked example.** A draft opens with "Excited to share our new framework for outbound", then lists four steps everybody already runs, in the author's exact voice, at 1,100 characters with perfect line breaks and one clean comment trigger.

Naive scoring: hook 2, voice 5, substance 2, structure 5, CTA 5.

Weighted: (2 x 0.25) + (5 x 0.25) + (2 x 0.20) + (5 x 0.15) + (5 x 0.15) = 0.50 + 1.25 + 0.40 + 0.75 + 0.75 = **3.65**.

The ceiling rule caps it at **3.0**, which is REWRITE rather than REVISE. That gap of 0.65 is the whole point: three quarters of the weight in this rubric can be earned by a post that does not deserve to be published, so the two dimensions that decide whether it deserves to be published get a veto.

---

## Missing inputs

When fewer than three past posts were available, voice cannot be scored. Do not guess it, because a guessed voice score looks identical to a real one and quietly corrupts every comparison afterwards.

Redistribute its 0.25 so the totals stay comparable: hook becomes 0.35, substance 0.28, structure 0.19, CTA 0.18, which still sums to 1.00. Label the result `voice-unscored` in the handover and say how many posts were available.

---

## Verdict bands

| Score | Verdict | What happens |
|---|---|---|
| 4.0 and above | SHIP | Present to the author with the score and the dimensions |
| 3.0 to 3.9 | REVISE | Rewrite the named dimensions and re-score, up to the cap |
| Below 3.0 | REWRITE | Start from a new hook or a new format, not from an edit |

**Any automatic violation caps the verdict at REVISE regardless of the score.** A 4.4 with an unsourced statistic in it is not a 4.4.

Cap the loop at three rewrite rounds. At the cap, present the best round with the unresolved violations listed as open flags and hand it to a human. Never silently ship a failing draft, and never loop past the cap.

---

## Automatic violations

Each of these caps the verdict at REVISE and has to be named explicitly in the report.

| Violation | Why it fails | Instead |
|---|---|---|
| A number, quote or result nobody supplied | Unsourceable claims in public are the one mistake that cannot be walked back | Leave a marked blank and name what is missing |
| A client, competitor or third party named without clearance | It is somebody else's decision to be named, not yours | Flag it for clearance and say from whom |
| "I'm so humbled and grateful" | Performative, and nobody believes it | Start with what happened rather than how you feel about it |
| "Excited to announce" | Every company page opens this way, and readers scroll past on reflex | Lead with the thing: "We shipped X" |
| "Here are 5 tips to..." | Reads like a 2019 blog post | Name the actual system: "the five-step system we run for every client" |
| "Let that sink in" | Condescending | Cut it. A strong point does not need a cue |
| Opening with "So..." | Filler and a weak opener | Delete it and start at the next word |
| "I failed and that's okay" | Self-help tone | Share the failure and lead with what you changed |
| A closing question nobody would answer | Too broad to reply to | Ask something specific enough to have an answer |
| A wall of text with no line breaks | Scrolled past on mobile before it is read | Line break every one or two sentences |
| Humble-bragging dressed as a lesson | Annoying rather than relatable | Own the win directly, or make the post about the system |
| An achievement with no takeaway | Nobody cares about the win unless they can use it | Three specific bullets on how it happened |
| "Game-changer", "next level" | Category cliches, filtered out on sight | Say what changed and by how much |
| A screenshot with no context | A dashboard means nothing on its own | Three lines on what the reader is looking at and why |
| More than one CTA | Comment, follow and share means none of them | Pick one |

The table above is universal: every one of these fails for every author, and it lives here because this is the list the gate reads.

**Per-author additions do not go in this table.** What one author is not allowed to say in public belongs in their own profile at `{{VOICE_PROFILE_PATH}}`, and the gate reads that file alongside this one. Written in here instead, a second author's restrictions become automatic violations for the whole team, and every account's run inherits one account's NDA. Company-wide prohibitions, the ones that are true whoever is writing, belong in `company-wiki/marketing/voice.md` and get read the same way.
