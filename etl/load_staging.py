import os
import psycopg2
from config import DB

CSV_PATH = "data/german_credit_data.csv"

def load_staging():
    conn = psycopg2.connect(**DB)
    try:
        with conn, conn.cursor() as cur:
            cur.execute("TRUNCATE apridwh_stg.german_credit_raw;")
            with open(CSV_PATH, "r", encoding = "utf-8") as f:
                cur.copy_expert(
                    "COPY apridwh_stg.german_credit_raw from STDIN WITH (FORMAT csv, HEADER true)",
                    f,
                )
            cur.execute("SELECT COUNT(*) FROM apridwh_stg.german_credit_raw;")
            print("Baris di staging:", cur.fetchone()[0])
    finally:
        conn.close()

if __name__ == "__main__":
    load_staging()