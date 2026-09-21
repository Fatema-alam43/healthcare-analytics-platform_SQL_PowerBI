--Basic sanity check — JOIN patients encounter
SELECT p.name, p.age, p.gender, e.hospital, e.admission_type, e.billing_amount
FROM patients p
JOIN encounters e ON p.patient_id = e.patient_id
LIMIT 10;

--Patient demographics by gender
SELECT gender, COUNT(*) AS patient_count, ROUND(AVG(age), 1) AS avg_age
FROM patients
GROUP BY gender;

--Disease/condition-style breakdown — top test results by admission type (JOIN + GROUP BY)
SELECT e.admission_type, e.test_results, COUNT(*) AS total
FROM encounters e
GROUP BY e.admission_type, e.test_results
ORDER BY total DESC; 

--Monthly admission trend (date functions)
SELECT DATE_TRUNC('month', date_of_admission) AS month, COUNT(*) AS admissions
FROM encounters
GROUP BY 1
ORDER BY 1;

--CTE example — average billing per hospital, only hospitals with 50+ encounters
WITH hospital_stats AS (
    SELECT hospital, COUNT(*) AS total_encounters, ROUND(AVG(billing_amount), 2) AS avg_billing
    FROM encounters
    GROUP BY hospital
)
SELECT * FROM hospital_stats
WHERE total_encounters >= 3
ORDER BY avg_billing DESC
LIMIT 20;

--Window function — running total of monthly admissions
SELECT 
    DATE_TRUNC('month', date_of_admission) AS month,
    COUNT(*) AS monthly_admissions,
    SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('month', date_of_admission)) AS running_total
FROM encounters
GROUP BY 1
ORDER BY 1;

--Data quality query — for "Data Quality" dashboard page
SELECT 
    COUNT(*) AS total_encounters,
    COUNT(*) FILTER (WHERE is_billing_invalid) AS invalid_billing_count,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_billing_invalid) / COUNT(*), 2) AS pct_invalid_billing
FROM encounters;