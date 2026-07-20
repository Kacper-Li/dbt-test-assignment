# Retail Analytics Executive Presentation

## Slide 1 — Title
Retail analytics transformation and executive insights

- dbt + DuckDB workflow for a messy retail transaction extract
- From denormalized source data to decision-ready analytics

---

## Slide 2 — The business problem
Why this matters

- CEO needs answers on growth, performance, and profit
- The source data was messy, repeated, and inconsistent
- We needed a trustworthy analytical foundation

---

## Slide 3 — What we built
The solution architecture

- Raw extract → staging → intermediate → marts
- Staging cleans and flags issues
- Intermediate models normalize products, stores, and sales lines
- Marts answer executive questions

---

## Slide 4 — How the data was transformed
From wide extract to analytics-ready structure

- Preserved row-level sales detail
- Separated product and store attributes into reusable structures
- Calculated revenue, gross cost, and gross margin at the line level
- Surfaced quality issues instead of hiding them

---

## Slide 5 — Key modeling decisions
What we chose and why

- Used standard cost first, then landed cost, then unit cost for margin
- Treated transaction IDs as non-unique identifiers and flagged duplicates
- Preserved negative quantities as possible returns or adjustments
- Flagged missing product/store IDs and conflicting cost fields

---

## Slide 6 — Verified business metrics
Executive snapshot

- Total revenue: $46.16M
- Gross margin: $14.22M
- Gross margin rate: 44.6%
- 2022 revenue rose from $1.04M in January to $1.75M in December

---

## Slide 7 — Growth and performance insights
What the data says

- Revenue momentum strengthened in late 2022
- Strongest products by revenue: Computers, Dinnerware, Cookware, Candles
- Strongest stores by revenue: Los Angeles, New York City, San Diego, San Francisco

---

## Slide 8 — Profit opportunities and watchouts
Where to focus next

- Margin is positive overall, but cost definition sensitivity matters
- Conflicting costs and missing identifiers should be reviewed
- Product and store master quality should be improved for better reporting

---

## Slide 9 — Tradeoffs and next steps
What we would improve with more time

- Add a stronger product/store master reference
- Create a more formal semantic layer for business definitions
- Expand views by category, region, and profitability segment

---

## Slide 10 — Closing message
Why this matters

- The pipeline is transparent, explainable, and business-ready
- The analysis supports decisions rather than just reporting historical output
- This is a strong foundation for future growth and executive reporting
