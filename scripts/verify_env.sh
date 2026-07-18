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

echo "==> read raw consolidated source via dbt show"
uv run dbt show --inline "select count(*) as n from {{ source('raw', 'consolidated_transactions') }}"
uv run dbt show --inline "select * from {{ source('raw', 'consolidated_transactions') }}" --limit 3

echo
echo "Environment OK. Next: open ASSIGNMENT.md and start normalizing models."
