# Raw data

CSV extracts provided for this challenge. Treat them as a warehouse landing zone:
values may be incomplete, duplicated, or versioned.

| File | Description |
|------|-------------|
| `transactions.csv` | Sales transaction lines (plus load metadata) |
| `products.csv` | Product catalog (may contain multiple versions per key) |
| `store_locations.csv` | Store attributes & demographics |
| `regions.csv` | State → region mapping |

## Column notes (transactions)

| Column | Notes |
|--------|--------|
| `Transaction ID` | Business key — **not guaranteed unique** in the extract |
| `load_batch` | Ingestion batch number (higher = later load) |
| `is_correction` | Upstream flag indicating a restated row |
| `quantity` | May be negative (returns / adjustments) |
| `unit_cost` | May be null |

## Guidance from stakeholders (unreconciled)

You may hear conflicting preferences from the business — **choose deliberately and document**:

- **Finance:** “For margin reporting, drop incomplete cost rows and always use the latest `load_batch`. Corrections supersede originals.”
- **Ops / Sales ops:** “Never drop sales lines. Prefer the original batch unless Finance has formally approved a correction. Allocate missing cost from product medians if needed.”
- **Finance (store P&L):** “Treat `Direct store operating costs` as a **monthly** fixed cost.”
- **FP&A:** “Those operating costs look **annual** in our budget files — allocate across months.”

Do not edit these files. Clean and transform them in dbt models.
