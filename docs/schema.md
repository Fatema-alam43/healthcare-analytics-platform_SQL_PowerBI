# Database Schema

## patients
| Column | Type | Notes |
|---|---|---|
| patient_id | INTEGER (PK) | Surrogate key derived from name+age+gender+blood_type (source data had no real unique ID) |
| name | VARCHAR(200) | Title-cased during cleaning |
| age | INTEGER | |
| gender | VARCHAR(50) | |
| blood_type | VARCHAR(10) | |

## encounters
| Column | Type | Notes |
|---|---|---|
| encounter_id | INTEGER (PK) | |
| patient_id | INTEGER (FK → patients.patient_id) | |
| doctor | VARCHAR(100) | |
| hospital | VARCHAR(200) | Near-unique per row — see Limitations in README |
| insurance_provider | VARCHAR(200) | |
| billing_amount | DECIMAL(10,2) | 108 rows are negative — flagged via is_billing_invalid |
| is_billing_invalid | BOOLEAN | TRUE where billing_amount < 0 |
| room_number | INTEGER | |
| admission_type | VARCHAR(50) | Emergency / Elective / Urgent |
| date_of_admission | DATE | |
| discharge_date | DATE | |
| medication | VARCHAR(100) | |
| test_results | VARCHAR(100) | Normal / Abnormal / Inconclusive |

## Relationship
`patients` (1) → `encounters` (many), via `patient_id`.