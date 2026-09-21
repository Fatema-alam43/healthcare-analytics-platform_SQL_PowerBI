# Data Profiling Report

Profiling was performed in Python (pandas) before any table was created, to understand data quality issues before deciding how to handle them.

## Summary of Findings

| Check | Result | Decision |
|---|---|---|
| Total raw rows | 55,500 | — |
| Missing values (all columns) | 0 | No imputation needed |
| Exact duplicate rows | 534 | Dropped |
| Negative Billing Amount | 108 rows | Flagged via `is_billing_invalid`, not dropped |
| Invalid Age (<0 or >120) | 0 | No action needed |
| Invalid dates (discharge before admission) | 0 | No action needed |
| Name casing | Inconsistent | Normalized with title casing |
| Unique patient identifier | None present | Surrogate `patient_id` derived from name+age+gender+blood_type |

## Reasoning

**Negative billing amounts were flagged, not deleted.** A negative value could represent a legitimate refund or credit rather than an error. Deleting these rows without domain context risked silently distorting any billing-related analysis, so a boolean flag was added instead, letting downstream analysis include or exclude them explicitly.

**No unique patient identifier existed in the source data.** A surrogate key was derived from the combination of name, age, gender, and blood type. This is a known limitation — 22 rows share an identical combination of these four fields with more than one encounter, meaning either a genuine repeat patient or a coincidental match. The dataset provides no way to distinguish between these cases.

**Rows after cleaning:** 54,966 (534 duplicates removed from 55,500 raw rows).
**Unique patients identified:** 54,944.