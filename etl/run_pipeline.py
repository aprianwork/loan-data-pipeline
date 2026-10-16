import psycopg2

from config import DB
from load_staging import load_staging
from load_warehouse import load_warehouse


def run_sql_file(path):
    conn = psycopg2.connect(**DB)
    try:
        with conn, conn.cursor() as cur:
            with open(path, "r", encoding="utf-8") as f:
                cur.execute(f.read())
    finally:
        conn.close()


def main():
    print("[1/3] Load CSV ke staging")
    load_staging()

    print("[2/3] staging ke warehouse")
    load_warehouse()

    print("[3/3] Master label dan view")
    run_sql_file("sql/03_labels.sql")
    print("Master label dan view : OK")

    print("Pipeline selesai")
    

if __name__ == "__main__":
    main()