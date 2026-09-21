-- Schema: two normalized tables, patients (parent) and encounters (child)
-- patient_id is a derived surrogate key (source data had no unique patient identifier)
-- encounters.patient_id has a foreign key constraint to patients.patient_id

CREATE TABLE IF NOT EXISTS patients (
    patient_id INTEGER PRIMARY KEY,
    name VARCHAR(200),
    age INTEGER,
    gender VARCHAR(50),
    blood_type VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS encounters (
    encounter_id INTEGER PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(patient_id),
    doctor VARCHAR(100),
    hospital VARCHAR(200),
    insurance_provider VARCHAR(200),
    billing_amount DECIMAL(10,2),
    is_billing_invalid BOOLEAN,
    room_number INTEGER,
    admission_type VARCHAR(50),
    date_of_admission DATE,
    discharge_date DATE,
    medication VARCHAR(100),
    test_results VARCHAR(100)
);