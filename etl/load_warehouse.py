import os
import psycopg2
from config import DB

SQL_FILE = "sql/02_warehouse.sql"

def load_warehouse():
    conn = psycopg2.connect(**DB)
    try:
        with conn, conn.cursor() as cur:
            with open(SQL_FILE, "r", encoding="utf-8") as f:
                cur.execute(f.read())

            cur.execute("SELECT COUNT(*) FROM apridwh_stg.german_credit_raw;")
            jumlah_staging = cur.fetchone()[0]
            cur.execute("SELECT COUNT(*) FROM apridwh.loan_applications;")
            jumlah_warehouse = cur.fetchone()[0]

            print("baris di staging :", jumlah_staging)
            print("baris di warehouse :", jumlah_warehouse)

            if jumlah_staging != jumlah_warehouse:
                raise ValueError("jumlah baris di staging dan warehouse beda, dibatalkan.")
            print("cek kualitas data : OK")
    finally:
            conn.close()

if __name__ == "__main__":
     load_warehouse()