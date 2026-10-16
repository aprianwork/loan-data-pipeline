CREATE SCHEMA IF NOT EXISTS apridwh_stg;
CREATE SCHEMA IF NOT EXISTS apridwh;

CREATE TABLE IF NOT EXISTS apridwh_stg.german_credit_raw (
    laufkont  SMALLINT,
    laufzeit  SMALLINT,
    moral     SMALLINT,
    verw      SMALLINT,
    hoehe     INTEGER,
    sparkont  SMALLINT,
    beszeit   SMALLINT,
    rate      SMALLINT,
    famges    SMALLINT,
    buerge    SMALLINT,
    wohnzeit  SMALLINT,
    verm      SMALLINT,
    alter     SMALLINT,
    weitkred  SMALLINT,
    wohn      SMALLINT,
    bishkred  SMALLINT,
    beruf     SMALLINT,
    pers      SMALLINT,
    telef     SMALLINT,
    gastarb   SMALLINT,
    kredit    SMALLINT
);