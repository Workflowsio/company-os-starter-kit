# Tool categories

Read only once you know which layer needs fixing. Buying a tool for a healthy layer is the most expensive mistake this skill can make.

**No vendor names and no prices in this file, on purpose.** Both rot, and they rot in ways that cost more than they save.

Prices, tiers and packaging change every quarter, so a number written here is wrong within one. Send the buyer to the vendor's own pricing page and use the budget guardrails in `budget-and-metrics.md` for the ceiling.

Names rot differently. A named shortlist reads as a recommendation however it is captioned, it goes stale as vendors get acquired, repositioned or ruled out, and in a store your whole team reads it turns into the buying decision nobody made deliberately. There is also a legal edge: a comparison naming a competitor is a different kind of document from a category description, and one of ours had to be pulled for it. What survives is the shape of the requirement, which is the part that lets you evaluate a vendor that did not exist when this was written.

**So each category below gives you what the tool has to do, what to choose on, and the profiles worth shortlisting.** Fill the names in yourself, from your own market, and write the shortlist into `company-wiki/company/gtm-stack.md` where it is dated by the commit that put it there.

---

## CRM

**Has to do:** hold every account, contact, deal and activity as the single source of truth, with a pipeline whose stages you can define yourself.

**Choose on:** whether your team will actually use it, how much configuration it needs before it is useful, what it integrates with natively, and how painful the export is if you leave.

**Profiles worth shortlisting:** a mid-market suite with a usable free tier, where marketing and sales sit in one system. An enterprise platform for complex processes, where the configuration cost is the point rather than the problem. A small-team tool that is opinionated and fast to adopt. An inside-sales tool with calling built in. A newer tool that lets you shape the data model yourself, if your motion does not fit a standard object graph.

---

## Contact data and enrichment

**Has to do:** supply accurate firmographic, contact and technographic data at the coverage rate your market needs.

**Choose on:** coverage in your specific geography and segment rather than the global database size, email accuracy measured by your own bounce rate rather than by their claim, how credits are consumed, and whether it enriches in bulk or one record at a time.

**Profiles worth shortlisting:** a combined prospecting-and-enrichment database, where the search and the data come from one place. A waterfall tool that chains several providers and runs research per record, for when no single source has your coverage. A European-coverage provider with a compliance story, if your lists include the EU or the UK. A lightweight per-record tool for a small team that enriches by hand.

**Test before you commit.** Run 100 records through a trial and measure the match rate and the bounce rate yourself. Every vendor's published accuracy figure is measured on their own sample.

---

## Email sequencing

**Has to do:** send multi-step sequences from multiple inboxes, detect replies reliably, and give you deliverability controls rather than just a send button.

**Choose on:** inbox rotation and per-inbox limits, warm-up handling, reply detection accuracy, and whether the reporting separates positive replies from all replies. That last one decides whether you can run the thresholds in the outbound skill at all.

**Profiles worth shortlisting:** a high-volume cold email tool built around inbox rotation, warm-up and deliverability controls. An enterprise sales-engagement platform, where coaching, call recording and analytics sit on top of the sequencing and the seat price reflects it. The two are different products and the second one is usually the wrong tool for cold outbound at volume.

---

## Social outreach

**Has to do:** run connection requests and follow-ups across one or more accounts without triggering platform limits.

**Choose on:** whether it runs cloud-side or from a browser, how it handles account limits, whether multiple team accounts can be managed centrally, and how visible the automation is to the recipient.

**Profiles worth shortlisting:** a multi-account tool that manages a team's seats centrally, with per-account limits enforced for you. A cloud-side sequencer for one or two accounts. A simple single-user tool where the whole job is follow-ups. A general scraping-and-automation platform, if you need the extraction as well as the outreach and have the technical capacity to maintain it.

---

## Phone and dialer

**Has to do:** get a rep through enough conversations per hour to make calling economic, and log every one into the CRM without data entry.

**Choose on:** parallel dialing capability, local presence and number reputation, CRM logging depth, and call recording plus coaching if you are running a team.

**Profiles worth shortlisting:** a parallel dialer, for volume, where the maths only works above a certain call count per rep per day. A dialer with team coaching attached, if you are ramping people rather than only dialing. A power dialer with deep CRM logging, if the data entry is the thing killing you. An international provider, if your numbers need local presence outside one country.

---

## Signal detection and intent

**Has to do:** tell you which accounts changed state this week, early enough for the change to still be a reason to reach out.

**Choose on:** signal freshness, whether it identifies the company or only the topic, whether it pushes into your stack or waits to be checked, and false positive rate, because an intent feed nobody trusts is a feed nobody reads.

**Profiles worth shortlisting:** a workflow tool you assemble your own signals in, for signals nobody sells. A topic-level surge intent provider, which tells you a theme is hot at an account rather than who is looking. A review-site or comparison-activity feed, which is the closest thing to in-market. A website visitor identification tool, which is the highest-intent and lowest-volume feed you will get. A community and product-usage signal tool, if you have either.

---

## Analytics and attribution

**Has to do:** connect activity to revenue well enough that something gets cut and something gets doubled.

**Choose on:** whether it does account-level rather than lead-level attribution, how much engineering setup it needs, whether it reads your CRM as the source of truth, and whether sales and marketing will both accept its model. That last one is not a technical question and it decides everything.

**Profiles worth shortlisting:** your CRM's native reporting first, because it is already paid for and already holds the data. Then a multi-touch B2B attribution tool that models at the account level rather than the lead level. Then a dashboard aggregator, if the problem is that the numbers live in six tools rather than that they are wrong. A free dashboard builder is a real option where you have the setup capacity and no budget.

---

## Before you recommend any of these

Four questions, in writing, per tool:

1. Which manual process does this replace, and how many hours a week?
2. Which existing tool does it replace, or does total spend go up?
3. What has to be true in 90 days for this to have been worth it?
4. What is the exit cost: contract length, data export, and how long re-implementation takes?

A tool with no answer to question 3 never gets cancelled, because nobody agreed in advance what failure would look like. That is how a stack reaches fourteen tools with nobody able to name what four of them do.

Fewer than ten tools is a reasonable target for most teams. Above that, the overlap is usually real and usually in enrichment.
