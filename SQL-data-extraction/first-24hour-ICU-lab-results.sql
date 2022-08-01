WITH t1 AS ( 
  --- laboratory results table (SAPS-II: WBC, Sodium, Potassium, BUN, BIC. SOFA: Creatinine, Platelets)
  SELECT c.*, fdl.wbc_max AS wbc_icu, 
  fdl.sodium_min AS sodium_icu, fdl.potassium_max AS potassium_icu, 
  fdl.bun_max AS bun_icu, fdl.bicarbonate_min AS bicarbonate_icu, 
  fdl.creatinine_max AS creatinine_icu, 
  fdl.platelets_min AS platelets_icu
  FROM `physionet-data.mimic_derived.first_day_lab` fdl
  INNER JOIN `emilyliu-chl7001h.cohort1.cohort` c --- tables from cohort extraction
  ON fdl.subject_id = c.subject_id AND fdl.stay_id = c.stay_id
)
SELECT *
FROM t1
