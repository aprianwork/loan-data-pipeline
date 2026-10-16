CREATE TABLE IF NOT EXISTS apridwh.mst_code_labels (
    column_name VARCHAR(50),
    code        SMALLINT,
    label       VARCHAR(100),
    PRIMARY KEY (column_name, code)
);

TRUNCATE apridwh.mst_code_labels;

INSERT INTO apridwh.mst_code_labels (column_name, code, label) VALUES
('checking_status',1,'no checking account'),
('checking_status',2,'< 0 DM'),
('checking_status',3,'0 <= ... < 200 DM'),
('checking_status',4,'>= 200 DM / salary for at least 1 year'),

('credit_history',0,'delay in paying off in the past'),
('credit_history',1,'critical account / other credits elsewhere'),
('credit_history',2,'no credits taken / all credits paid back duly'),
('credit_history',3,'existing credits paid back duly till now'),
('credit_history',4,'all credits at this bank paid back duly'),

('purpose',0,'others'),
('purpose',1,'car (new)'),
('purpose',2,'car (used)'),
('purpose',3,'furniture/equipment'),
('purpose',4,'radio/television'),
('purpose',5,'domestic appliances'),
('purpose',6,'repairs'),
('purpose',7,'education'),
('purpose',8,'vacation'),
('purpose',9,'retraining'),
('purpose',10,'business'),

('savings',1,'unknown / no savings account'),
('savings',2,'< 100 DM'),
('savings',3,'100 <= ... < 500 DM'),
('savings',4,'500 <= ... < 1000 DM'),
('savings',5,'>= 1000 DM'),

('employment_duration',1,'unemployed'),
('employment_duration',2,'< 1 yr'),
('employment_duration',3,'1 <= ... < 4 yrs'),
('employment_duration',4,'4 <= ... < 7 yrs'),
('employment_duration',5,'>= 7 yrs'),

('installment_rate',1,'>= 35'),
('installment_rate',2,'25 <= ... < 35'),
('installment_rate',3,'20 <= ... < 25'),
('installment_rate',4,'< 20'),

('personal_status_sex',1,'male : divorced/separated'),
('personal_status_sex',2,'female : non-single or male : single'),
('personal_status_sex',3,'male : married/widowed'),
('personal_status_sex',4,'female : single'),

('other_debtors',1,'none'),
('other_debtors',2,'co-applicant'),
('other_debtors',3,'guarantor'),

('residence_since',1,'< 1 yr'),
('residence_since',2,'1 <= ... < 4 yrs'),
('residence_since',3,'4 <= ... < 7 yrs'),
('residence_since',4,'>= 7 yrs'),

('property',1,'unknown / no property'),
('property',2,'car or other'),
('property',3,'building soc. savings agr. / life insurance'),
('property',4,'real estate'),

('other_installment',1,'bank'),
('other_installment',2,'stores'),
('other_installment',3,'none'),

('housing',1,'for free'),
('housing',2,'rent'),
('housing',3,'own'),

('existing_credits',1,'1'),
('existing_credits',2,'2-3'),
('existing_credits',3,'4-5'),
('existing_credits',4,'>= 6'),

('job',1,'unemployed / unskilled - non-resident'),
('job',2,'unskilled - resident'),
('job',3,'skilled employee / official'),
('job',4,'manager / self-empl. / highly qualif. employee'),

('people_liable',1,'3 or more'),
('people_liable',2,'0 to 2'),

('telephone',1,'no'),
('telephone',2,'yes (under customer name)'),

('foreign_worker',1,'yes'),
('foreign_worker',2,'no'),

('credit_risk',0,'bad'),
('credit_risk',1,'good');

CREATE OR REPLACE FUNCTION apridwh.get_label(p_col TEXT, p_code SMALLINT)
RETURNS TEXT
LANGUAGE sql STABLE AS $$
    SELECT label FROM apridwh.mst_code_labels
    WHERE column_name = p_col AND code = p_code
$$;

CREATE OR REPLACE VIEW apridwh.v_loan_applications AS
SELECT
    loan_id,
    apridwh.get_label('checking_status', checking_status)           AS checking_status,
    duration_months,
    apridwh.get_label('credit_history', credit_history)             AS credit_history,
    apridwh.get_label('purpose', purpose)                           AS purpose,
    credit_amount,
    apridwh.get_label('savings', savings)                           AS savings,
    apridwh.get_label('employment_duration', employment_duration)   AS employment_duration,
    apridwh.get_label('installment_rate', installment_rate)         AS installment_rate,
    apridwh.get_label('personal_status_sex', personal_status_sex)   AS personal_status_sex,
    apridwh.get_label('other_debtors', other_debtors)               AS other_debtors,
    apridwh.get_label('residence_since', residence_since)           AS residence_since,
    apridwh.get_label('property', property)                         AS property,
    age,
    apridwh.get_label('other_installment', other_installment)       AS other_installment,
    apridwh.get_label('housing', housing)                           AS housing,
    apridwh.get_label('existing_credits', existing_credits)         AS existing_credits,
    apridwh.get_label('job', job)                                   AS job,
    apridwh.get_label('people_liable', people_liable)               AS people_liable,
    apridwh.get_label('telephone', telephone)                       AS telephone,
    apridwh.get_label('foreign_worker', foreign_worker)             AS foreign_worker,
    apridwh.get_label('credit_risk', credit_risk)                   AS credit_risk
FROM apridwh.loan_applications;