# Loan Data Pipeline

Pipeline ETL end-to-end yang memuat data pinjaman German Credit ke data warehouse PostgreSQL, memakai Python dan Docker.

## Alur Data

```
CSV  ->  apridwh_stg (staging)  ->  apridwh (warehouse)  ->  v_loan_applications (view)
```

| Layer | Objek | Fungsi |
|---|---|---|
| Staging | `apridwh_stg.german_credit_raw` | Salinan mentah CSV, nama kolom tidak diubah |
| Warehouse | `apridwh.loan_applications` | Nama kolom dirapikan, ada kolom `loan_id` |
| Master | `apridwh.mst_code_labels` | Tabel master: kode angka menjadi label |
| View | `apridwh.v_loan_applications` | Data warehouse dengan kode sudah jadi label |

## Teknologi

Python, PostgreSQL 16, Docker Compose, psycopg2, pandas

## Cara Menjalankan

1. Salin `.env.example` menjadi `.env`, lalu isi nilainya.
2. Jalankan database: `docker compose up -d`
3. Install library: `pip install -r requirements.txt`
4. Jalankan pipeline: `python etl/run_pipeline.py`

## Keputusan Desain

- **Staging dulu, baru warehouse:** data mentah tetap utuh, jadi transformasi bisa diulang tanpa memuat ulang file sumber.
- **Aman dijalankan berulang:** setiap langkah mengosongkan tabel sebelum mengisi, jadi data tidak dobel.
- **Pengecekan kualitas data:** jumlah baris warehouse dibandingkan dengan staging, dan proses dibatalkan (rollback) kalau beda.
- **Tabel master untuk label:** arti kode disimpan di `mst_code_labels`, bukan ditulis langsung di query, jadi mudah dirawat.
- **Pengaturan lewat `.env`:** password tidak ditulis di kode dan tidak ikut ke GitHub.

## Data

Dataset German Credit: 1.000 pengajuan pinjaman, 21 kolom, target `credit_risk` (700 good, 300 bad).