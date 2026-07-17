# Analytics engineer challenge

Timed take-home for analytics engineer candidates. You will build a **dbt pipeline on DuckDB** to clean and join retail store data, then present insights in a short **PowerPoint** for a CEO audience.

**Start here:** [ASSIGNMENT.md](./ASSIGNMENT.md)

---

## Prerequisites

- [uv](https://docs.astral.sh/uv/) installed
- Python 3.12+ (uv will fetch it if needed)

## Setup (≈2 minutes)

```bash
# From the repo root
uv sync

# Confirm dbt + DuckDB adapter
uv run dbt --version

# Point dbt at the in-repo profiles.yml and verify the connection
export DBT_PROFILES_DIR="$(pwd)"
uv run dbt debug
```

Optional: add `export DBT_PROFILES_DIR="$(pwd)"` to your shell session, or prefix every dbt command with it.

## Useful commands

```bash
export DBT_PROFILES_DIR="$(pwd)"

# Parse / compile
uv run dbt parse
uv run dbt compile

# Explore a source without writing models yet
uv run dbt show --inline "select * from {{ source('raw', 'products') }}" --limit 5

# Build your project (after you add models)
uv run dbt build

# Query a model
uv run dbt show --select <model_name> --limit 20
```

DuckDB database file: `retail.duckdb` at the repo root (gitignored).

## Project layout

```text
ASSIGNMENT.md          # Candidate brief (requirements + scoring intent)
data/raw/              # Source CSVs — do not edit
models/staging/        # Put staging models here (_sources.yml provided)
models/intermediate/   # Joins / business logic
models/marts/          # Analytics-ready outputs
analyses/              # Optional ad-hoc SQL for Part B
profiles.yml           # Local DuckDB profile
dbt_project.yml
pyproject.toml         # uv / Python deps (dbt-duckdb)
```

## Stack

| Tool | Role |
|------|------|
| [uv](https://docs.astral.sh/uv/) | Package / environment manager |
| [dbt-core](https://docs.getdbt.com/) + [dbt-duckdb](https://github.com/duckdb/dbt-duckdb) | Transformation framework |
| [DuckDB](https://duckdb.org/) | Local analytical database |

## Verify the environment

```bash
./scripts/verify_env.sh
```

This checks that dependencies install, dbt can connect, and raw CSV sources are readable.

> Note: until you add models under `staging/`, `intermediate/`, and `marts/`, dbt may warn about unused configuration paths in `dbt_project.yml`. That is expected.
