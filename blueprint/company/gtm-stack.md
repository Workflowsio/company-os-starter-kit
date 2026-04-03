# GTM Stack

<!-- Your tool ecosystem. Claude uses this to know which tools to reference
     and how data flows between them. -->

## Core Tools

| Tool | Category | What We Use It For | Connected via MCP? |
|------|----------|-------------------|-------------------|
| {{e.g., HubSpot}} | CRM | {{deal tracking, contact management}} | {{yes/no}} |
| {{e.g., Slack}} | Communication | {{team chat, client channels}} | {{yes/no}} |
| {{e.g., Notion}} | Knowledge | {{SOPs, meeting notes, content pipeline}} | {{yes/no}} |
| {{e.g., Instantly}} | Email outbound | {{cold email campaigns}} | {{yes/no}} |

## Data Flow

<!-- Describe how data moves between your tools. Even a simple text description helps. -->

```
{{source}} -> {{enrichment}} -> {{sequencing}} -> {{CRM}}

Example:
Apollo (contacts) -> Clay (enrichment) -> Instantly (email) -> HubSpot (CRM)
```

## What's Working

- {{tool/workflow that's performing well}}
- {{another thing that's working}}

## What's Broken or Missing

- {{gap in your stack}}
- {{tool you're evaluating}}
