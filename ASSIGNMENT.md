# Analytics Engineer take-home challenge

**Timebox:** 2 hours  
**AI-assisted coding is expected and encouraged** (Cursor, Copilot, ChatGPT, etc.).  
**What we evaluate:** how you structure a dbt project, clean messy source data, model for analytics, and turn numbers into decisions — not how much you type by hand.

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

Raw extracts live in `data/raw/` (CSV files derived from an Excel workbook). A dbt + DuckDB project skeleton is already set up for you — see `README.md` for environment setup.

---

## What to build

### Part A — dbt pipeline (primary focus)

Build a dbt pipeline on DuckDB that **cleans, joins, and models** the raw data into analytics-ready tables.

Minimum expectations:

1. **Staging models** for each source (`transactions`, `products`, `store_locations`, `regions`)
   - Rename columns to clean snake_case
   - Cast types appropriately
   - Document and handle data-quality issues you find (do not silently drop them without explanation)
2. **Joined / intermediate models** that combine transactions with product, store, and region attributes
3. **Mart models** that a BI tool or analyst could query to answer the CEO questions (you choose grain and metrics — justify briefly)
4. **Tests** on key assumptions (e.g. uniqueness, not-null, accepted values, referential integrity)
5. A project that runs successfully with:

```bash
uv run dbt build
```

Suggested (not mandatory) layout:

```text
models/
  staging/        # 1:1 with sources, light cleaning
  intermediate/   # joins / business logic building blocks
  marts/          # facts / dims or wide analytics tables
```

Sources are already declared in `models/staging/_sources.yml` and point at the CSVs via DuckDB `read_csv_auto`. A sample staging model (`stg_products`) is included as a pattern to follow.

### Part B — Insights for the CEO (secondary)

Using your marts (via `dbt show`, SQL in `analyses/`, a notebook, Excel, or similar), produce a **short PowerPoint presentation** (`.pptx`) that answers the five questions above.

Guidance:

- Aim for roughly **5–10 slides** — enough to tell a clear story, not a full board pack
- Lead with insights and recommended actions; charts/tables should support the narrative
- Prioritise **correct figures, clear recommendations, and conciseness** over polish
- Mock anything you would build with more time and call it out on a slide
- Be ready to present this deck in the debrief discussion

---

## Principles

- Analysis is a means to an end — what should the business *do*?
- Assume the audience knows the business but not this dataset (CEO / sales leader)
- Prefer correct figures over impressive-looking wrong ones
- State assumptions (especially around cost / profit definitions)
- If you would pull extra data in the real world, say what and why
- Open-ended on purpose: go beyond the five questions if you find something valuable

---

## Hints (optional — use if stuck)

The raw extract is **intentionally messy**. Cleaning choices change the numbers — document yours and, where material, show sensitivity.

Things worth checking early:

- More than one place unit cost may live (transactions vs cost reference files)
- `pack_size` and whether costs are per unit or per pack/case
- Duplicate keys and overlapping effective dates on dimensions
- Lineage fields (`source_system`, `ingested_at`) vs economic event dates
- Negative quantities; null keys/costs/dates
- How you define revenue, gross profit, and contribution after store operating costs

See also stakeholder notes in `data/raw/README.md` — they do not all agree.

Transaction volume is intentionally capped vs a real retailer.

---

## Deliverables checklist

Submit (or push) before the debrief:

- [ ] dbt models + YAML (sources already provided; extend as needed)
- [ ] `uv run dbt build` succeeds
- [ ] PowerPoint presentation (`.pptx`) addressing the CEO questions
- [ ] Assumptions / trade-offs / next steps covered in the deck (or a short accompanying note)

Be ready to walk through your modeling choices and one or two insights in a short discussion.

---

## Out of scope

- Production deployment, CI, or cloud warehouses
- Perfect visual design
- Replacing the provided package manager / database stack (`uv` + `dbt-duckdb`)

You may add Python packages with `uv add` if needed for analysis, but the transformation layer should live in dbt SQL.
