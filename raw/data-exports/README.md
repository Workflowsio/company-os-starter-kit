# raw/data-exports

Machine output. CSV, JSON, spreadsheet dumps, report exports.

**The test:** a system produced it, not a person. CRM exports, campaign stats, billing reports, enrichment results, analytics pulls, query results.

Name files `YYYY-MM-DD-source-what.csv`, for example `2026-08-01-crm-open-pipeline.csv`. The source matters because the same numbers pulled from two systems rarely agree, and in six months the filename is the only record of which one you used.

**Not here:** a PDF report someone emailed you is a document, so `../documents/`. A vendor's public benchmark study is external material, so `../external-sources/`.

Check exports for personal data and credentials before committing them. This repo goes to everyone who clones it, and an export is the most common way a spreadsheet of contact details ends up in version control forever.
