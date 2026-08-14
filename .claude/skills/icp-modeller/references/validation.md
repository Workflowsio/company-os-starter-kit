# Validation and calibration

Read at step 6, and again at every scheduled review. A matrix is a living document, and the only thing that makes it trustworthy is having been checked against results that could have contradicted it.

---

## The six validation methods

| Method | When | What you check | What passing looks like |
|---|---|---|---|
| **Backtest** | At build time | Score your existing customers with the finished model | 80 percent or more land in Tier 1 or 2. Below 60 percent means the model is miscalibrated, and the weights are wrong rather than the customers |
| **Campaign A/B** | First two weeks | Send the same message to Tier 1 and to Tier 3, compare reply and meeting rates | Tier 1 replies at two to three times the Tier 3 rate. If it does not, the tiers are not separating real fit |
| **Sales feedback** | After 10 meetings | Ask the AE whether it felt like a real opportunity, tracked by tier | 70 percent or more of Tier 1 meetings are qualified opportunities. Below 50 percent means the psychographic scoring is off |
| **Conversion funnel** | After 30 days | Lead-to-meeting and meeting-to-deal by tier | Tier 1 converts to deals at twice the Tier 2 rate or better |
| **Churn analysis** | Quarterly | Which segments churned | A segment churning at twice the average comes out of Tier 1 and 2, or becomes a disqualifier |
| **Negative pattern review** | Monthly | What the worst deals have in common | New patterns become disqualifiers or scoring penalties, with the date attached |

The backtest is the one people skip and the one that catches the most. It costs an hour and it is the only check you can run before spending anything.

---

## Sample-size floors

- Minimum 50 outbound touches per tier before drawing any conclusion.
- Do not change the matrix on fewer than 20 replies per tier.
- Minor tweaks at week two to four, first real review at month two, full recalibration at quarter two.
- Log every change with the data that prompted it. A change with no data behind it is a preference, and preferences are how a scored model turns back into an opinion.

A number below these floors is not a weak signal, it is noise that happens to have a decimal point. State the sample size next to every result you report.

---

## Calibration problems

| Symptom | Likely cause | Fix |
|---|---|---|
| Everything scores Tier 1 | Firmographic criteria too broad | Tighten industry, headcount or revenue |
| Almost nothing scores Tier 1 | Criteria too narrow, or thresholds too demanding | Lower the thresholds, or relax one or two attributes rather than all of them |
| Tier 3 outperforms Tier 1 on reply rate | The wrong attributes carry the weight | Re-analyse closed-won and swap the weight priorities. Do not adjust the tier boundaries to hide it |
| High reply rate, low close rate | Firmographic fit is right and psychographic fit is wrong | Add pain and budget validation to the score |
| Plenty of meetings, and the AEs say they are not a fit | Behavioral signals are inflating scores for poor-fit accounts | Enforce a minimum firmographic score regardless of behavior |
| Tier 1 is 40 percent of the universe | The definition is a filter rather than a bullseye | Tighten until Tier 1 sits between 3 and 15 percent |
| Scores keep changing without anybody editing the model | Behavioral decay is doing its job | Nothing to fix. Report scores with the date they were computed |

---

## What to do when validation contradicts the model

Change the model. The failure mode here is not a bad matrix, it is a matrix that has been defended: somebody explains why the two best customers score badly instead of asking what the model is missing, and from then on the scores are decoration.

The best attribute in most mature matrices came from a contradiction like that. Every churned account missing an executive sponsor is not a footnote, it is a psychographic attribute worth ten points, and it only becomes one if somebody let the data win.
