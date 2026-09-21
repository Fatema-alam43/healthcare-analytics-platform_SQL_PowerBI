-- Null value check across key columns
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(name) AS null_names,
    COUNT(*) - COUNT(age) AS null_ages,
    COUNT(*) - COUNT(gender) AS null_genders
FROM patients;

-- Duplicate row check (already resolved during cleaning, kept here for reference)
-- Original raw data had 534 exact duplicate rows before cleaning

-- Invalid billing amounts
SELECT COUNT(*) AS invalid_billing_count
FROM encounters
WHERE is_billing_invalid = TRUE;

-- Referential integrity check: encounters with no matching patient
SELECT e.encounter_id, e.patient_id
FROM encounters e
LEFT JOIN patients p ON e.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- Invalid age check
SELECT COUNT(*) AS invalid_age_count
FROM patients
WHERE age < 0 OR age > 120;

-- Invalid dates: discharge before admission
SELECT COUNT(*) AS invalid_date_count
FROM encounters
WHERE discharge_date < date_of_admission;