WITH t1 AS (
  --- gender
  SELECT lr.*, gender 
  FROM `physionet-data.mimic_core.patients` p
  RIGHT JOIN `emilyliu-chl7001h.extraction.cohort_with_lab_results` lr
  ON lr.subject_id = p.subject_id
)

, t2 AS (
  SELECT t1.*, ethnicity, marital_status, insurance, admission_type, admission_location
  FROM `physionet-data.mimic_core.admissions` adm
  RIGHT JOIN t1
  ON t1.subject_id = adm.subject_id AND t1.hadm_id = adm.hadm_id
)

, t3 AS (
  SELECT t2.*, ch.charlson_comorbidity_index
  FROM `physionet-data.mimic_derived.charlson` ch
  RIGHT JOIN t2 
  ON ch.subject_id = t2.subject_id AND ch.hadm_id = t2. hadm_id
)

, t4 AS ( 
  --- ICU type was defined as first care unit in the original paper
  SELECT t3.*, ic.first_careunit AS ICU_type
  FROM `physionet-data.mimic_icu.icustays` ic
  RIGHT JOIN t3
  ON ic.subject_id = t3.subject_id AND ic.hadm_id = t3.hadm_id AND ic.stay_id = t3.stay_id
)

SELECT * 
FROM t4
