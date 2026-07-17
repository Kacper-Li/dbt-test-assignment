#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "==> uv sync"
uv sync

echo "==> dbt --version"
uv run dbt --version

export DBT_PROFILES_DIR="$ROOT"

echo "==> dbt debug"
uv run dbt debug

echo "==> dbt parse"
uv run dbt parse

echo "==> read raw sources via dbt show"
uv run dbt show --inline "select count(*) as n from {{ source('raw', 'transactions') }}"
uv run dbt show --inline "select count(*) as n from {{ source('raw', 'products') }}"
uv run dbt show --inline "select count(*) as n from {{ source('raw', 'store_locations') }}"
uv run dbt show --inline "select count(*) as n from {{ source('raw', 'regions') }}"

echo
echo "Environment OK. Next: open ASSIGNMENT.md and start building models."
