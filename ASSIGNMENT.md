# Analytics Engineer take-home challenge

**Timebox:** 2 hours  
**AI-assisted coding is expected and encouraged** (Cursor, Copilot, ChatGPT, etc.).  
**What we evaluate:** how you **normalize** messy source data in dbt, make sound modeling/cost decisions, explain your pipeline choices, and turn numbers into decisions — not how much you type by hand.

---

## Context

You are supporting a US department store that sells consumer discretionary products (cookware, photo frames, table lamps, etc.).

The CEO wants to monitor sales performance and help the team make data-driven decisions. The overarching objective is **profitable long-term growth**.

They care especially about:

1. How are sales changing over time? Are we achieving growth?
2. Which are our top performing products, stores, and regions?
3. What have been the drivers of growth in 2022?
4. What could the business do to grow profit?
5. Are there any issues that require further investigation?

You receive a **single denormalized extract**: `data/raw/consolidated_transactions.csv`.  
A dbt + DuckDB project skeleton is already set up — see `README.md` for environment setup.

---

## What to build

### Part A — dbt pipeline (primary focus)

The landing file is wide and messy on purpose. Your job is to **normalize** it into analytics-ready models.

Minimum expectations:

1. **Staging** from `consolidated_transactions`
   - Rename to snake_case, cast types
   - Document and handle data-quality issues (do not silently drop without explanation)
2. **Normalize** into dimension + fact style models (names flexible), at least:
   - A **product** dimension (unique product key)
   - A **store** dimension (unique store key, with region)
   - A **sales fact** at a clear, documented grain
3. **Marts** that can answer the CEO questions (build from your normalized models — not by re-aggregating the raw file ad hoc for the deck)
4. **Tests** on primary keys and relationships
5. `uv run dbt build` succeeds

Suggested layout:

```text
models/
  staging/        # light cleaning of the consolidated extract
  intermediate/   # normalization / business logic
  marts/          # dims + facts (or equivalent)
```

A sample staging model is included as a pattern. Sources are declared in `models/staging/_sources.yml`.

### Part B — Presentation (secondary)

Produce a **short PowerPoint** (`.pptx`) you will walk through in the debrief. The deck must cover **both**:

1. **Your data transformation pipeline** — what you built and why  
2. **Insights for the CEO** — answers to the five questions above (using your marts)

#### Pipeline section (required)

Include enough slides that a technical interviewer can follow your approach, for example:

- High-level DAG / model layers (staging → intermediate → marts)
- How you normalized the denormalized extract (keys, grains, dims vs fact)
- Major cleaning / modeling decisions (duplicates, cost columns, `pack_size`, conflicting attributes, returns, orphans, etc.)
- What you rejected and why (alternate rules you considered)
- Assumptions, trade-offs, and what you would do with more time

#### Insights section (required)

- Aim for the whole deck to be roughly **8–12 slides** total (pipeline + insights)
- Lead insights with recommendations; charts/tables should support the narrative
- Prioritise **correct figures, clear recommendations, and conciseness** over polish
- State cost / profit definitions and any sensitivity to alternate choices

Be ready to present both the pipeline and the business findings in the debrief.
---

## Principles

- Analysis is a means to an end — what should the business *do*?
- Assume the audience knows the business but not this dataset
- Prefer correct figures over impressive-looking wrong ones
- Cleaning / cost choices change the answer — document yours
- Open-ended on purpose: go beyond the five questions if valuable

---

## Hints (optional — use if stuck)

- The extract repeats product/store/region attributes on every row — they are not always consistent
- There is more than one cost-related column — choose deliberately for margin
- Check `pack_size` before multiplying costs
- `Transaction ID` is not unique; lineage fields (`source_system`, `ingested_at`) may conflict with economic dates
- Negative quantities and unknown product/store keys appear
- Stakeholder notes in `data/raw/README.md` do not all agree

Transaction volume is intentionally capped vs a real retailer.

---

## Deliverables checklist

- [ ] Normalized dbt models (dims + fact) + YAML/tests
- [ ] `uv run dbt build` succeeds
- [ ] PowerPoint that presents **(1)** the transformation pipeline — what you did and why, and **(2)** CEO insights from your marts
- [ ] Assumptions / trade-offs / alternatives considered called out in the deck

---

## Out of scope

- Production deployment, CI, or cloud warehouses
- Perfect visual design
- Replacing `uv` + `dbt-duckdb`

You may `uv add` packages for analysis; transformation should live in dbt SQL.
