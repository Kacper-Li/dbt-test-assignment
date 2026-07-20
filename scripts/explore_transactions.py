import pandas as pd
from pathlib import Path

CSV_PATH = Path(__file__).resolve().parents[1] / "data" / "raw" / "consolidated_transactions_preview.csv"


def load_data(path: Path = CSV_PATH) -> pd.DataFrame:
    df = pd.read_csv(path)
    print(f"Loaded {len(df):,} rows and {len(df.columns)} columns")
    print("Columns:")
    for col in df.columns:
        print(f"- {col}")
    return df


def show_head(df: pd.DataFrame, n: int = 10) -> None:
    print(df.head(n).to_string(index=False))


def inspect_column(df: pd.DataFrame, column: str, top_n: int = 20) -> None:
    if column not in df.columns:
        raise KeyError(f"Column '{column}' not found. Available columns: {df.columns.tolist()}")
    print(f"\nTop {top_n} values for {column}:\n")
    print(df[column].value_counts(dropna=False).head(top_n).to_string())


def main() -> None:
    df = load_data()
    print("\nExample commands:")
    print("  df.head()")
    print("  df.columns")
    print("  df['quantity'].describe()")
    print("  df[df['quantity'] < 0].head()")
    print("  df.groupby('region_name').size().sort_values(ascending=False).head(10)")
    print("\nUse this script as a starting point and run your own pandas queries in the REPL.")


if __name__ == "__main__":
    main()
