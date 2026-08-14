<!-- WORKED EXAMPLE. Copy this folder as clients/<your-slug>/ or delete it.
     The split it demonstrates is explained in clients/guide.md. -->

<!-- MACHINE-OWNED FILE. Do not hand-edit.
     Writer:  scripts/sync-accounts.sh  (you write this, the kit does not ship it)
     Source:  CRM account record 4419-EXAMPLE
     Cadence: nightly, create-once. An existing file is never overwritten.
     Content last changed: 2026-08-10

     Because the sync creates this file and then leaves it alone, a hand edit
     here is never corrected either. It becomes a second version of the truth
     that nothing repairs. Fix the record in the CRM instead, and put anything
     you write yourself in operating-state.md beside this file.

     No sync yet? Delete this banner and treat the file as an ordinary human
     doc. A file claiming a writer that does not exist gets skipped by people
     and refused by tooling. -->

# Example Client Co

| Field | Value |
|---|---|
| Slug | `EXAMPLE-CLIENT` |
| Domain | example-client.com |
| CRM record | 4419-EXAMPLE |
| Status | Customer, active |
| Services | Outbound program, ABM pilot |
| Account owner | ops@yourcompany.com |
| Contract start | 2026-03-01 |
| Renewal | 2027-03-01, 12 month term |
| Billing | Monthly, invoiced on the 1st |

## Contacts

| Name | Title | Email | Role |
|---|---|---|---|
| J. Okafor | VP Revenue | j.okafor@example-client.com | Economic buyer |
| M. Lindqvist | Head of Demand Gen | m.lindqvist@example-client.com | Day to day contact |
| S. Bauer | RevOps Manager | s.bauer@example-client.com | Systems access |

## Connected systems

| System | Instance | Credential |
|---|---|---|
| CRM | example-client production | `EXAMPLE_CLIENT_CRM_TOKEN` |
| Email sequencer | example-client workspace | `EXAMPLE_CLIENT_SEQUENCER_KEY` |
| Shared channel | #example-client | n/a |

Credentials appear here as variable names only. The values live in your secrets manager and never in this repo.

## Recent activity

| Date | Event | Source |
|---|---|---|
| 2026-08-08 | Renewal opportunity created | CRM |
| 2026-07-22 | Quarterly business review completed | CRM |
| 2026-06-30 | ABM pilot added to contract | CRM |

Everything above is synced. Everything a human knows about this account is in `operating-state.md`.
