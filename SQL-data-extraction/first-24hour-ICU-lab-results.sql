WITH t1 AS ( 
  --- laboratory results table (SAPS-II: WBC, Sodium, Potassium, BUN, BIC. SOFA: Creatinine, Platelets)
  SELECT c.*, fdl.wbc_max AS wbc_icu, 
  fdl.sodium_min AS sodium_icu, fdl.potassium_max AS potassium_icu, 
  fdl.bun_max AS bun_icu, fdl.bicarbonate_min AS bicarbonate_icu, 
  fdl.creatinine_max AS creatinine_icu, 
  fdl.platelets_min AS platelets_icu
  FROM `physionet-data.mimic_derived.first_day_lab` fdl
  INNER JOIN `emilyliu-chl7001h.cohort1.cohort` c
  ON fdl.subject_id = c.subject_id AND fdl.stay_id = c.stay_id
)

, t2 AS (
  --- sapsii score
  SELECT t1.*, sap.sapsii
  FROM `physionet-data.mimic_derived.sapsii` sap
  INNER JOIN t1
  ON sap.subject_id = t1.subject_id AND sap.hadm_id = t1.hadm_id AND sap.stay_id = t1.stay_id
)

, t3 AS (
  --- sofa score
  SELECT t2.*, sofa.sofa_24hours
  FROM `physionet-data.mimic_derived.sofa` sofa
  INNER JOIN t2
  ON t2.stay_id = sofa.stay_id
)

SELECT *
FROM t3
