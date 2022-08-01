WITH t1 AS  --- age >= 16 table
(
SELECT icu.subject_id, icu.hadm_id, icu.stay_id, icu.intime AS icu_intime, icu.outtime AS icu_outtime, 
  adm.admittime AS admit_admittime, 
  age.anchor_age, age.admittime AS age_admittime

FROM `physionet-data.mimic_icu.icustays` icu
  INNER JOIN `physionet-data.mimic_core.admissions` adm
    ON icu.subject_id = adm.subject_id AND icu.hadm_id = adm.hadm_id
  INNER JOIN `physionet-data.mimic_derived.age` age
    ON icu.subject_id = age.subject_id AND icu.hadm_id = age.hadm_id

)
, t2 AS  --- first ICU admission table
(
SELECT *, 
RANK() OVER (PARTITION BY t1.subject_id ORDER BY t1.icu_intime) as first_icu_admission
FROM t1 
)
, t3 AS --- laboratory results table (SAPS-II: WBC, Sodium, Potassium, BUN, BIC. SOFA: Creatinine, Platelets)
(
SELECT DISTINCT subject_id, hadm_id, charttime AS lab_value_charttime, itemid, valuenum
FROM `physionet-data.mimic_hosp.labevents` le
WHERE itemid IN (51300,51301,50824,50983,50822,50971,51006, 50803,50882,50912,51081,51265)
)

, avg_valuenum AS 
(
SELECT subject_id, hadm_id, lab_value_charttime, itemid, AVG(valuenum) AS avg_value
FROM t3
GROUP BY subject_id, hadm_id, lab_value_charttime, itemid
)

, t4 AS --- combine
(
SELECT t2.*, a_value.lab_value_charttime, a_value.itemid, a_value.avg_value
FROM t2
LEFT JOIN avg_valuenum a_value
ON t2.subject_id = a_value.subject_id AND t2.hadm_id = a_value.hadm_id
)
, t5 AS --- filter age >= 16 and first_icu_admission
(
SELECT *,
CASE WHEN DATE_DIFF(icu_intime, lab_value_charttime, day) BETWEEN 3 AND 365 THEN 1 ELSE 0 END AS baseline_lab_value,
CASE WHEN DATE_DIFF(icu_intime, lab_value_charttime, day) BETWEEN -24 AND 0 THEN 1 ELSE 0 END AS lab_value_within_first_day_icu_adm
FROM t4
WHERE anchor_age >= 16 AND first_icu_admission = 1 
)
, t6 AS --- import height data
(
SELECT t5.*, h.charttime AS height_charttime, h.height,
FROM t5
INNER JOIN `physionet-data.mimic_derived.height` h
ON t5.subject_id = h.subject_id AND t5.stay_id = h.stay_id
)
, t7 AS --- height values measured 24 hours before and 24 hours after the first ICU admission
(
SELECT t6.*,
CASE WHEN DATE_DIFF(icu_intime, height_charttime, day) BETWEEN -24 AND 24 THEN 1 ELSE 0 END AS height_within_abs_24
FROM t6
)
, max_height as ---max height
(
SELECT DISTINCT subject_id, MAX(height) AS height_max
FROM t7
WHERE height_within_abs_24 = 1
GROUP BY subject_id
)
, t8 AS 
(
SELECT t7.*, m.height_max
FROM t7
INNER JOIN max_height m
ON t7.subject_id = m.subject_id
)
, t9 AS  --- import weight data; 
(
SELECT t8.*, wd.weight, wd.starttime AS weight_starttime
FROM t8
INNER JOIN `physionet-data.mimic_derived.weight_durations` wd
ON t8.stay_id = wd.stay_id
)
, avg_weight AS 
(
SELECT DISTINCT subject_id, AVG(weight) AS weight_avg
FROM t9
GROUP BY subject_id
)
, t10 AS 
(
SELECT t9.*, aw.weight_avg
FROM t9
INNER JOIN avg_weight aw
ON t9.subject_id = aw.subject_id
)

, t11 AS --- calculating bmi according to WHO
(
SELECT t10.*, weight_avg/(height_max*height_max/10000) as bmi
FROM t10
)

SELECT DISTINCT subject_id, hadm_id, stay_id, anchor_age, first_icu_admission, itemid, AVG(avg_value) AS lab_value, baseline_lab_value, lab_value_within_first_day_icu_adm, bmi
FROM t11
WHERE bmi IS NOT NULL --- AND baseline_lab_value = 1
GROUP BY subject_id, hadm_id, stay_id, anchor_age, first_icu_admission, itemid, baseline_lab_value, lab_value_within_first_day_icu_adm, bmi 
