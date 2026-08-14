<!-- WORKED EXAMPLE, hand-written. Nothing syncs into this file.
     This is the human half of the split described in clients/guide.md. -->

# Example Client Co: operating state

**Read this before doing anything on this account, and trust it.** It is the account's working memory and it replaces session memory for anything that has to survive a context clear. Do not re-audit the account to reconstruct what is already written here.

**Update it before you finish an operational change, not afterwards.** Last updated 2026-08-12 by ops@yourcompany.com.

## Where things stand

Outbound program has been live since April on two segments, mid-market operations and enterprise revenue leadership. Mid-market is carrying the program and enterprise is not, which is the open question going into renewal in March. The ABM pilot added in June covers 40 accounts and has not produced a meeting yet, which is expected at this stage and has been said out loud to the buyer.

The day to day contact is Demand Gen, not RevOps. Route systems questions to RevOps and everything else to Demand Gen, or you get a two-day delay.

## Live commitments

| What | Owner | Due | State |
|---|---|---|---|
| Enterprise segment rewrite, three variants | us | 2026-08-22 | In progress, first variant drafted |
| ABM account list refresh, +25 accounts | client | 2026-08-19 | Waiting on their list |
| QBR deck for the September review | us | 2026-09-05 | Not started |

## Decisions and why

- **2026-07-22** Dropped the third segment (finance titles) after two months at under one reply per hundred. Buyer agreed in the QBR. Do not reopen without new data.
- **2026-06-30** Added the ABM pilot as a paid add-on rather than a trial, because the previous free pilot on another account produced no internal ownership on the client side.
- **2026-05-14** Sends go out from their domain, not ours. Their security team requires it. This constrains volume and it is not negotiable.

## Known broken

- Sequencer webhook into their CRM has been dropping reply events since 2026-08-05. Reported to RevOps, no fix date. Reply counts in their dashboard are low by roughly a fifth until it is fixed, so quote our numbers rather than theirs.
- ~~Shared drive access missing for two of our engineers~~ resolved 2026-08-07.

Struck lines stay. Deleting one loses the fact that it was checked.

## Do not

- Do not send to their parent company domain. Different legal entity, not in scope, they have asked twice.
- Do not add contacts from the ABM list into the running outbound sequences. The two programs are measured separately and mixing them destroys the comparison.
