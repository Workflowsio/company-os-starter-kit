# Copy QA, voice, testing and thresholds

Read before presenting any draft, and again before any send. The QA pass runs as a separate context that did not write the draft. It returns ACCEPT or REJECT plus numbered violations, never an edited draft.

---

## Anti-patterns

| Pattern | Why it fails | Fix |
|---|---|---|
| "Quick question..." | Overused, and everybody knows a pitch is next | Ask the actual question |
| "I noticed that..." | Fake personalization when what follows is generic | State the insight without the preamble |
| "Just following up" | Zero new value, and it reads as desperate | Add new information or a different angle, or delete the step |
| "Would it make sense to..." | Wishy-washy and passive | Be direct about the value exchange |
| "I'd love to connect" | Eager, and offers nothing | Say why connecting benefits them |
| "As a [title], you probably..." | Reads as machine-written | Open with their situation rather than their job title |
| "I hope this finds you well" | Template signal, instant delete | Skip pleasantries and start with the substance |
| "We're an AI-powered platform that..." | Nobody buys architecture | State the outcome |
| "Many companies like yours..." | If you cannot name them, you do not know enough | Name a peer, or attribute it: "a VP Sales at a [industry] company told me..." |
| "Reaching out because..." | Throat-clearing | Delete it and start at the next sentence |
| "In today's competitive landscape..." | Filler that every generator produces | Delete entirely |
| "I'll be brief" | Then be brief | Delete and be brief |
| "Let me know your thoughts" | Not a question, no action | Replace with a specific question that has two possible answers |
| "Can I get 15 minutes of your time?" | You have not earned 15 minutes | Earn the reply first |
| Your company name in the first line | They do not care about you yet | First line is about them, your company appears in the value section |
| Two CTAs in one email | A confused reader does not reply | One CTA per email |

---

## Voice

Sound like a knowledgeable peer at a conference who spent five minutes on homework, rather than a marketer, a machine or a desperate rep.

- Sentences of 6 to 15 words.
- Every sentence gets its own paragraph in the email body.
- Contractions always.
- Plain text only, with no bold, no italics and no HTML.
- No links and no bullet points in step 1. Links push you toward the spam folder and bullets read as marketing.
- A P.S. is allowed from step 2 onwards.
- Read it aloud. If it sounds like marketing copy, rewrite it. If it sounds like something you would say to somebody at a bar, ship it.

**Banned words.** Add your own during the interview and never remove one without a reason written next to the deletion.

leverage, utilize, streamline, comprehensive, robust, innovative, cutting-edge, game-changing, revolutionary, disruptive, synergy, best-in-class, world-class, next-generation, solution (say system or approach), excited to, passionate about, thrilled, reimagine, transform (say change or fix), empower, elevate, optimize (say improve), drive results (say which results), thought leader

---

## QA checklist

Every item must pass. A skipped item is not a passing item, so report what you did not check.

**Structure**
- [ ] Subject line is three to five words, lowercase, no special characters
- [ ] Word count is 60 to 120, with 150 the absolute maximum
- [ ] First line is specific to this prospect or their peer group, and would not survive being sent to a thousand people
- [ ] Exactly one CTA, and it is a question
- [ ] The CTA is not "book a call" or "grab 15 minutes" in steps 1 to 3
- [ ] Every sentence has its own paragraph

**Content**
- [ ] Every sentence passes the "so what" test
- [ ] Roughly three times as much you-and-your language as we-and-our language
- [ ] At least two power patterns are applied, and no more than three
- [ ] The reader would think "that is exactly my situation"
- [ ] No banned words
- [ ] No adjective doing work a number should be doing

**Technical**
- [ ] Every merge variable resolves, with no stray braces
- [ ] Mobile preview is clean
- [ ] No links, images or HTML in step 1
- [ ] No spam trigger words (free, guarantee, act now, limited time, exclusive offer)

**Proof**
- [ ] Every metric cited is real and approved
- [ ] Every named company has agreed to be named, or is already a public case study
- [ ] Numbers are specific rather than ranges

---

## A/B testing protocol

Test in this order, because the earlier items move more and cost less to change.

1. Subject line
2. Opening line: personalized against peer story against question opener
3. CTA type: gap-hinting against no-oriented against direct offer
4. Archetype
5. Proof point
6. Length

Rules: change one variable at a time, because changing the subject and the body teaches you nothing. Minimum 200 sends per variant. Run at least five business days. The winner is the one with the higher positive reply rate, never the higher open rate. Write down every result, including the losses.

---

## Performance thresholds

| Metric | Strong | Acceptable | Kill and rewrite |
|---|---|---|---|
| Positive reply rate | above 3% | 1 to 3% | below 1% |
| Total reply rate | above 8% | 3 to 8% | below 3% |
| Open rate | above 60% | 40 to 60% | below 40%, which is infrastructure rather than copy |
| Bounce rate | below 2% | 2 to 3% | above 3%, which is list quality |
| Unsubscribe rate | below 0.5% | 0.5 to 1% | above 1%, which is targeting or frequency |

**Diagnostics.** Low opens and low replies means deliverability, so check authentication, warm-up and volume before rewriting anything. Fine opens and low replies means copy, so rewrite with a different archetype. Fine replies that are all negative means the list is wrong rather than the copy. Good positive replies with no meetings booked means the handoff after the reply is dropping them, and the sequence is not the problem.

These thresholds are ours. Replace them with your own once you have enough sends of your own to be honest about it, and put the date next to the number when you do.
