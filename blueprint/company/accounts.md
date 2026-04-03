# Accounts

<!-- This file is for your most important accounts only. Not a full CRM export.
     Think: your top 10-20 accounts that Claude should know about by name.
     For everything else, connect your CRM via a connector or MCP so Claude
     can look up any account on demand. -->

## Key Accounts

List your most important customers or prospects here. These are the ones Claude should recognize by name without needing to search your CRM.

| Account | Status | What we do for them | Key contact | Notes |
|---------|--------|---------------------|-------------|-------|
| {{company}} | {{active/prospect/churned}} | {{your service or product}} | {{name, title}} | {{anything Claude should know}} |
| {{company}} | {{status}} | {{service}} | {{contact}} | {{notes}} |

## Connect Your CRM

For your full account list, connect your CRM so Claude can look up any account live:

**HubSpot:** Connect via claude.ai/settings/integrations (one-click)
**Salesforce:** Connect via claude.ai/settings/integrations (one-click)
**Other CRM:** Set up an MCP connection with your API key

Once connected, you can ask Claude:

```
Look up {{company name}} in our CRM. Pull their deal history,
last activity, and any open tasks.
```

No need to maintain a full account list in this file. Just keep your top accounts here for quick context, and let the CRM handle the rest.
