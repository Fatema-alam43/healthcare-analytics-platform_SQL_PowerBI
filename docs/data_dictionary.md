# Data Dictionary

## patients table

| Column | Description |
|---|---|
| patient_id | Surrogate integer identifier, derived from name+age+gender+blood_type |
| name | Patient full name, title-cased |
| age | Patient age in years at time of record |
| gender | Male / Female |
| blood_type | One of 8 standard blood types (A+, A-, B+, B-, AB+, AB-, O+, O-) |

## encounters table

| Column | Description |
|---|---|
| encounter_id | Unique identifier for a single hospital encounter/admission |
| patient_id | Foreign key linking to patients.patient_id |
| doctor | Attending doctor's name |
| hospital | Hospital/facility name |
| insurance_provider | Patient's insurance provider for this encounter |
| billing_amount | Total billed amount for the encounter, in dollars |
| is_billing_invalid | TRUE if billing_amount is negative |
| room_number | Assigned room number |
| admission_type | Emergency, Elective, or Urgent |
| date_of_admission | Date the patient was admitted |
| discharge_date | Date the patient was discharged |
| medication | Medication prescribed during the encounter |
| test_results | Normal, Abnormal, or Inconclusive |