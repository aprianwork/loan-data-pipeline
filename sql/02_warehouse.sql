CREATE TABLE IF NOT EXISTS apridwh.loan_applications (
    loan_id               SERIAL PRIMARY KEY,
    checking_status       SMALLINT,  -- laufkont
    duration_months       SMALLINT,  -- laufzeit
    credit_history        SMALLINT,  -- moral
    purpose               SMALLINT,  -- verw
    credit_amount         INTEGER,   -- hoehe
    savings               SMALLINT,  -- sparkont
    employment_duration   SMALLINT,  -- beszeit
    installment_rate      SMALLINT,  -- rate
    personal_status_sex   SMALLINT,  -- famges
    other_debtors         SMALLINT,  -- buerge
    residence_since       SMALLINT,  -- wohnzeit
    property              SMALLINT,  -- verm
    age                   SMALLINT,  -- alter
    other_installment     SMALLINT,  -- weitkred
    housing               SMALLINT,  -- wohn
    existing_credits      SMALLINT,  -- bishkred
    job                   SMALLINT,  -- beruf
    people_liable         SMALLINT,  -- pers
    telephone             SMALLINT,  -- telef
    foreign_worker        SMALLINT,  -- gastarb
    credit_risk           SMALLINT   -- kredit
);

TRUNCATE apridwh.loan_applications RESTART IDENTITY;

INSERT INTO apridwh.loan_applications (
    checking_status, duration_months, credit_history, purpose, credit_amount,
    savings, employment_duration, installment_rate, personal_status_sex,
    other_debtors, residence_since, property, age, other_installment,
    housing, existing_credits, job, people_liable, telephone,
    foreign_worker, credit_risk
)
SELECT
    laufkont, laufzeit, moral, verw, hoehe,
    sparkont, beszeit, rate, famges,
    buerge, wohnzeit, verm, alter, weitkred,
    wohn, bishkred, beruf, pers, telef,
    gastarb, kredit
FROM apridwh_stg.german_credit_raw;