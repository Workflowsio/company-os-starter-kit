# GTM Stack

<!-- Your tool ecosystem. Claude uses this to know which tools to reference
     and how data flows between them. -->

## Core Tools

| Tool | Category | What We Use It For | Connected via MCP? |
|------|----------|-------------------|-------------------|
| {{your CRM}} | CRM | {{deal tracking, contact management}} | {{yes/no}} |
| {{your team chat}} | Communication | {{team chat, client channels}} | {{yes/no}} |
| {{your knowledge tool}} | Knowledge | {{SOPs, meeting notes, content pipeline}} | {{yes/no}} |
| {{your email sequencer}} | Email outbound | {{cold email campaigns}} | {{yes/no}} |

## Data Flow

<!-- Describe how data moves between your tools. Even a simple text description helps. -->

```
{{source}} -> {{enrichment}} -> {{sequencing}} -> {{CRM}}

Name the actual tool in each slot, and name what each one is authoritative for.
Two tools claiming the same answer is the most expensive ambiguity in a stack, so
the arrow is less important than which end of it wins a disagreement.
```

## What's Working

- {{tool/workflow that's performing well}}
- {{another thing that's working}}

## What's Broken or Missing

- {{gap in your stack}}
- {{tool you're evaluating}}
