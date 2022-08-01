# Reproduction template

The goal of this template is to guide documentation of a reproduction of a study in an electronic health record database. Reproductions are assumed to be retrospective observational studies.

This template is based on material from the OSF, as well as from Brandt et al., 2013.


---

## Title of the study

**Study titie**: Severity of Illness Scores May Misclassify Critically Ill Obese Patients.

**DOI**: 10.1097/CCM.0000000000002868

---

## Dataset(s) used

The database in the reproduced paper is Medical Information Mart for Intensive Care (MIMIC-III). 

The use of the MIMIC-III database has been approved by Institutional Review Boards of Beth Israel Deaconess Medical Center (2001-P-001699/14) and MIT (No. 0403000206). 

However, we use the MIMIC-IV database, the updated version, to replicate our data extraction and analysis. In the later step, we can compare our results to the ones in the paper.


**MIMIC-III information can be found here**:

DOI: 10.1038/sdata.2016.35

Citation: Johnson, A. E. W. et al. MIMIC-III, a freely accessible critical care database. Sci. Data 3:160035 doi: 10.1038/sdata.2016.35 (2016).

**MIMIC-IV information can be found here**:

DOI: 10.13026/a3wn-hq05

Citation: Johnson, A., Bulgarelli, L., Pollard, T., Horng, S., Celi, L. A., & Mark, R. (2020). MIMIC-IV (version 0.4). PhysioNet. 

---


## Data extraction

### Inclusion/Exclusion criteria

Inclusion criteria:
* first ICU admission of patients 16 years and older. 
* have available documentation of height and weight, as well laboratory test results at baseline and at ICU admission. 
(define baseline laboratory values as the mean laboratory result of all readings available between 3 days before to 1 year prior to ICU admission.)
(define the ICU values as the most abnormal laboratory result in the first 24 hours of ICU admission.)
* include normal group that is defined as patients whose BMI is between 18.5 and 24.9 and include the obese group that is defined as patients whose BMI is greater and equal to 30. 

Exclusion criteria:
* exclude patients under 16 years old. (Will use the age data: anchor_age.)
* exclude data from subsequent admissions if patients were admitted to ICU mroe than once. (Will use the mimic_icu.icustays table: intime.)
* exclude patients without height or weights. (Will use the height and weights tables under mimic_derived section.)
* exclude patients without laboratory results before hospital admission. (Will use the sapsii and the sofa tables.)
* exclude patients whose BMI < 18.5 and BMI between 25 and 30. (Will use the weights table to calculate BMI.)

We also use figure 1 in the paper - the consort diagram - as a reference to exlude cand extract cohort.




### Variables


Variable name | Description | Timing | Aggregation | Source | Notes
--- | --- | --- | --- | --- | ---
Age | Patient's age | First ICU admission |  | age | 
Gender | Patient's biological sex | Any time |  | patients |
Ethnicity, Marital Status, Insurance | Patient's demographic characteristics | First ICU admission |  | admission
Comorbidity Index | Elixhauser index | First 24 hours of ICU admission |  |  | We do not have the derived Elixhauser index, instead we can use the Charlson Index 
BMI | Patient's BMI according to the standard of WHO | 24 hours before and 24 hours after the ICU admission | Average | weight_durations, height | Calculation of BMI using height and weight is required; missing values are excluded
Smoking Status | Whether patient smoke | Any time | | | Natural Language Processing using MIMIC-III noteevents table; might not be feasible to be included
Admission Type | the urgency of the admission | First ICU admission |  | admission 
Source of Admission | the location of the patient prior to arriving at the hospital | First ICU admission |  | admission 
ICU admission type | the patient's care unit | First ICU admission | First | icustays 
SAPS-II | Severity of illness score | First 24 hours of ICU admission | | sapsii | Unsure if there are multiple scores for a same patient
SOFA | Severity of illness score | First 24 hours of ICU admission |  | sofa | Unsure if there are multiple scores for a same patient


### Outcome(s)

The outcome is the deviation in laboratory results between that measured at baseline and during ICU admission. 

[$\Delta$(ICU-baseline)]

* The laboratory results include SAPS-II and SOFA laboratory parameters. They are 
  * WBC
  * Sodium
  * Potassium
  * BUN
  * BIC
  * creatinine
  * platelets
* We can find these values in labevents table.

