# Tiers, disqualifiers and the deliverable

Read at step 5. A tier that does not change what happens to the account is a label rather than a tier.

---

## Tier assignment

```
TOTAL = firmographic + psychographic + behavioral

Tier 1 (bullseye):   firmographic >= 40 AND psychographic >= 30 AND total >= 80
Tier 2 (strong fit): firmographic >= 25 AND psychographic >= 20 AND total >= 50
Tier 3 (good fit):   firmographic >= 15 AND total >= 30
Disqualified:        firmographic < 15 OR total < 30 OR a hard disqualifier fired
```

The compound conditions matter more than the totals. A high total built entirely out of behavioral signals is an account that looked interested once, and the firmographic and psychographic floors are what stop it being called a bullseye.

Tune the thresholds against your own volume. If Tier 1 comes out at more than 15 percent of your addressable universe the definition is too broad, and below 3 percent it will not sustain campaign volume.

---

## Hard disqualifiers

These override the score entirely, however well an account scores.

- Direct competitor
- Existing customer, which routes to expansion rather than outbound
- Excluded industry, whether regulated, restricted or repeatedly poor fit
- Excluded geography, whether you cannot serve it or are not allowed to
- Below the minimum company size you can support profitably
- A known bad-fit pattern, such as a segment that has churned inside 90 days more than once

Write the reason next to each one. A disqualifier list with no reasons gets relaxed by the first person who needs more volume this month.

---

## Tier treatment matrix

| Attribute | Tier 1 | Tier 2 | Tier 3 | Disqualified |
|---|---|---|---|---|
| **Volume** | 50 to 200 accounts | 200 to 500 | 500 to 2,000 | Do not contact |
| **Research depth** | Individual account research | Segment-level | Minimal | n/a |
| **Personalization** | Account-specific: their pains, their recent news, mutual connections | Signal-based: trigger-specific, segment pain | Bucket: segment-level, template-driven | n/a |
| **Channels** | Email, social, phone, and direct mail for the top slice | Email and social | Email only | n/a |
| **Contacts per account** | 3 to 5, multi-threaded | 2 to 3 | 1 to 2 | n/a |
| **Cadence** | Four-step sequence plus manual touches and phone attempts | Four-step automated | Three-step automated | Suppressed from every list |
| **Expected reply rate** | 8 to 15% | 4 to 8% | 1 to 4% | n/a |
| **Sales involvement** | Account executive leads, rep supports | Rep leads, AE joins at meeting stage | Automated, rep reviews replies only | n/a |

The expected reply rates are the calibration check as much as the target. If Tier 3 is replying at the Tier 1 rate, the tiers are not separating fit, and the model needs the weights re-examined rather than the copy rewritten.

---

## The deliverable

```markdown
# ICP matrix: [company] - [product or segment]
**Created:** [date]  |  **Last updated:** [date]  |  **Status:** hypothesis / validated
**Review cadence:** every 90 days  |  **Next review:** [date]

## 1. Product context
- What we sell: [one or two sentences]
- Key value: [the core promise, in buyer language]
- Deal size range: [range]
- Sales cycle: [range]

## 2. Tier 1 (bullseye) - [X] accounts
**Firmographic:** industry, headcount, revenue, geography, funding, required tech
**Psychographic:** primary pain in their words, trigger, decision maker, budget signal, sophistication
**Behavioral signals monitored:** [signal + where it comes from], three or more
**Campaign treatment:** channels, personalization level, contacts per account, sequence

## 3. Tier 2 (strong fit) - [X] accounts
[same structure]

## 4. Tier 3 (good fit) - [X] accounts
[same structure]

## 5. Disqualified segments
- [segment]: [reason]

## 6. Hard disqualifiers
- [rule]: [reason]

## 7. Scoring model
[the three dimension tables with your weights and the reason beside each weight]

## 8. Validation plan
- Backtest result: [X percent of existing customers scored Tier 1 or 2]
- A/B plan: [what runs in the first two weeks]
- Early review triggers: [what would cause a review before the scheduled one]

## 9. Changelog
| Date | Change | The data that prompted it |
|---|---|---|
| [date] | Initial build | [source] |
```

The changelog is the part people drop, and it is the part that makes the matrix survivable. Without it, six months later nobody can say why headcount starts at 50, so somebody changes it on instinct and nobody can tell whether the results moved because of the change or because of the quarter.
