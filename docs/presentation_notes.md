# Presentation notes for the dbt retail challenge

## Pipeline summary
- The raw extract is a single denormalized sales file.
- The staging layer cleans and standardizes the source while preserving row-level facts.
- The intermediate layer splits the data into product, store, and sales-line structures.
- The marts aggregate those layers into executive-friendly views for growth, profit, and quality review.

## Main cleaning decisions
- Transaction IDs are treated as non-unique and are preserved as cleaned identifiers rather than assumed unique keys.
- Missing product IDs and store IDs are flagged rather than silently dropped.
- Missing unit cost is treated as a data-quality issue and surfaced in the quality mart.
- The model uses a preferred margin cost from the staging layer: standard cost first, then landed cost, then unit cost.
- Negative quantities are preserved and flagged because they may represent returns or adjustments.
- Conflicting standard vs landed costs are flagged because they could materially affect margin.

## Business interpretation
- Revenue is defined as quantity multiplied by unit price.
- Gross cost is defined as quantity multiplied by the chosen margin cost.
- Gross margin is revenue minus gross cost.
- These metrics are intentionally simple so the logic is easy to explain and defend.

## Presentation guidance
- Start with the pipeline story: raw extract -> staging -> intermediate -> marts.
- Highlight that the data was normalized into a more usable shape without losing the original row-level detail.
- Emphasize that quality issues were surfaced rather than hidden.
- Use the marts to answer the CEO questions around growth, top performers, profit opportunity, and data quality.
