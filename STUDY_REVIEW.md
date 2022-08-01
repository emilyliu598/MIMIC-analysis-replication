# Study Review

Review the chosen study as if you were an academic reviewer.


## Study information

### Title

Severity of Illness Scores May Misclassify Critically Ill Obese Patients.

**DOI**: 10.1097/CCM.0000000000002868



### Objective(s) of the study

* Compared deviation from baseline of pertinent ICU laboratory test results between obese and normal weight patients, adjusted for the severity of illness.
* Assessed the effect on hospital mortality of any statistically significant deviations found comparing the obese and normal weight groups.



### Dataset(s) used

**Dataset name and version**: Medical Information Mart for Intensive Care (MIMIC-III) database

**DOI**: 10.1038/sdata.2016.35

**Citation**: Johnson, A. E. W. et al. MIMIC-III, a freely accessible critical care database. Sci. Data 3:160035 doi: 10.1038/sdata.2016.35 (2016).


**Other relevant information**:
The use of the MIMIC-III database has been approved by Institutional Review Boards of Beth Israel Deaconess Medical Center (2001-P-001699/14) and MIT (No. 0403000206). 

---

## Summarize the paper

In this paper, the authors first tried to compare the deviation of laboratory results, specifically SAPS-II score and SOFA score, from baseline to ICU admission between the normal weights and the obese group. The statistically significant deviations are used to assess hospital mortality. In result, deviations in WBC, log(BUN), and log(creatine) are statistically higher in the obese group. At least one variable is statistically significant in predicting mortality.


### Strength(s) of the work

  * Explanation of objectives, methods, and results are clear.  
  * The diagram is well-presented, and easy to follow. 
  * Data processing are transparent; Some information are provided.
  * Have strong evidence of challenging the SAPS-II and SOFA score in predicting mortality between normal weight and obese patients.

### Weakness(es) of the work


* MIMIC-III database is not cited. The DOI is not provided.
* Some data are not provided, such as the comorbidity data, although codes to extract data are provided. 
* The logistic regression analysis could be more specific, although it is not for the primary objective. 


### Anticipated reproducibility challenges

Describe areas of the paper which appear to lack sufficient detail.
* Some of the information or table are not provided, such as the comorbidity index.
* The smoking table in MIMIC-III is not appeared in MIMIC-IV database. 

---

## Data extraction

### Variables

List out the covariates and exposures extracted for the study, e.g. admission source.

The followings are the covariates.
 * Age
 * Gender
 * Ethnicity
 * Marital status
 * Insurance coverage
 * Comorbidity index
 * BMI
 * Smoking status
 * Admission type
 * Source of admission
 * ICU admission type
 * Primary International Classification of Disease version 9 diagnosis (Sepsis, including pneumonia, Cardiovascular disease, Other respiratory condition, Neurological condition, and other)
 * Procedures in the first 24 hours of ICU admission (Mechanical ventilation, Vasopressors, Renal replacement therapy)
 * Severity of illness (SAPS-II and SOFA score)

The exposure variable is the deviation of laboratory results from the baseline to first ICU admission. 




### Outcome(s)

List the outcome(s) used in the study, e.g. 28-day mortality.

* The primary outcome was the deviation in laboratory results between that measured at baseline and during ICU admission.
  * The laboratory results include SAPS-II and SOFA laboratory parameters. They are 
    * WBC
    * Sodium
    * Potassium
    * BUN
    * BIC
    * creatinine
    * platelets


### Inclusion/Exclusion criteria

Describe the inclusion criteria for the study. Since inclusion/exclusion criteria are interchangeable, decide on the most clear presentation of the study methodology, e.g. "the study included all adults, and excluded patients admitted to CSRU."

The study, 
* included all first ICU admission of patients 16 years and older and excluded data from subsequent admissions if patients were admitted to ICU mroe than once.
* included data that have available documentation of height and weight, as well laboratory test results at baseline and at ICU admission, and excluded patients without height, weights or laboratory results before hospital admission. 
* included patients whose BMI are between 18.5 and 24.9, and greater and equal to 30; exluded patients whose BMI < 18.5 and BMI between 25 and 30.

### Outlier handling

N/A

### Missing data handling

Observations that contain missing laboratory values are exluded. Information about the number of missing laboratory values is provided in detail in Supplemental Table 1 (Supplemental Digital Content 1, http://links.lww.com/CCM/D72).



---

## Results

### Population summary

Provide information about the original study's population: sample size, average mortality, etc. Typically the data is presented in the first table (i.e. Table 1). Select a parsimonious set of descriptors which you will compare your reproduction against. At the very least include the sample size and a summary measure of the outcome(s).

* The sample size of the normal weight group is 769 and of the obese group is 1258. 
* The median baseline BMI for the normal weight group is 23.1 and for the obese group is 34.3. 
* The median SAPS-II for the normal weight group is 35 and for the obese group is 32. 
* The median SOFA score for the normal weight group is 4 and for the obese group is also 4.

### Analysis method

Methods for comparisons in values between the normal weights group and the obese group:
* For continuous variables,
  * quantile-quantile normal plots were used to assess the appropriateness of assuming normality.
  * if normality holds, they were summarized using the mean and SD. 
    * Mean values were compared using two-sample t tests.
  * if normality assumption violates, they were summarized with the median and inter-quanrtile range. 
    * Median values were assessed using the Mann-Whitney test. 

* For categorical variables, 
  * tests for association between categorical variables and BMI status were assessed using a chi-sqaure test.

The differences in deviation of laboratory results from baseline to ICU admission between both groups were compared using multivariable linear regression, adjusted for all covariates. 
* Fit a full model.
* Applied stepwise backward elimination retaining BMI status. 
* For variables violating the modeling assumptions of linear regression models, the logarithm (base 10) of the baseline and the ICU laboratory results were calculated and the regression analysis performed on the log transformed values.

The effect on hospital mortality of any statistically significant deviations found comparing the obese and normal weight groups using logistic regression. 
* A null model was fit composed of SAPS-II, SOFA, age, and the statistically significant ICU values of the laboratory tests. 
* compared with the full model by using a likelihood ratio test.

### Power calculations (if present)

N/A.

### Evaluation measures

Statistical tests:
* two-sample t-test
* Likelihood ratio test
* Mann-Whitney test
* Chi-square test


Evaluation measures:
* p-values
* Confidence intervals


### Sensitivity Analyses

N/A.
