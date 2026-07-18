# Raw data

Landing-zone CSV extracts. Treat as imperfect warehouse feeds: duplicates, nulls,
versioned dimensions, and more than one candidate source for unit cost.

| File | Description |
|------|-------------|
| `transactions.csv` | Sales lines + lineage (`source_system`, `ingested_at`) |
| `products.csv` | Product attributes (`pack_size`, effective dates) |
| `store_locations.csv` | Store attributes + opex (effective dates) |
| `regions.csv` | State → region (effective dates) |
| `product_unit_costs.csv` | Effective-dated unit costs by product (`cost_set`) |

## Notes

- `Transaction ID` is **not** unique in the extract.
- `quantity` may be negative (returns / adjustments).
- `pack_size` indicates units per pack/case — confirm whether `unit_cost` on a row is per unit or per pack before multiplying.
- Dimensions may have **overlapping** `effective_from` / `effective_to` ranges for the same key.
- Unit cost appears both on transactions and in `product_unit_costs.csv` with more than one `cost_set`.

## Stakeholder notes (unreconciled)

Choose deliberately and document:

- **Finance planning:** “Use `cost_set = standard` from the cost table for margin. Transaction costs are noisy.”
- **AP / Ops:** “`landed` in the cost table is what we actually paid. POS often restates costs after the fact.”
- **Sales ops:** “Never drop sales lines; prefer the latest `ingested_at` when IDs collide.”
- **FP&A:** “Store operating costs are annual.” / **Store Finance:** “They’re monthly.”

Do not edit these files. Clean and transform them in dbt models.
