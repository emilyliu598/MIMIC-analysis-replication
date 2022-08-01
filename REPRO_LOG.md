# Conclusion for reproduction

The following is a logbook/ultimate conclusion for a reproduction of a published scientific study. Feel free to add/remove sections as you find them useful.

## Title

Severity of Illness Scores May Misclassify Critically Ill Obese Patients.

DOI: 10.1097/CCM.0000000000002868

## Known differences

Specify changes to the data processing and/or methodology which are known to you. For each difference, describe: (1) the original study approach, (2) the reproduction approach, (3) the justification for the change. If possible, classify the differences as major (could impact the result of the study) or minor (unlikely to change the result of the study).

- Comorbidity index
  - Orginal approach: Elixhauser index
  - Reproduction approach: Charlson index
  - Only the Charlson comorbidity index is available in MIMIC-IV. 


## Unknown differences

Specify changes to the data processing and/or methodology which *may* have occurred, but you are unable to confirm due to ambiguity in the original material studied. For each difference, describe (1) the most specific reference to the approach in the original study, if possible, and (2) the approach taken in the reproduction.

- Weights and Heights
  - Orginal approach: MIMIC-III chartevents
  - Reproduction approach: MIMIC_IV derived tables for weights and heights
  
- BMI
  - I exclude patients whose BMI values greater than 100.
  - Not sure how the original paper dealt with the extreme values.




## Comparison of results

A table of the evaluation measures comparing the results in the original study and the reproduction. Also include the final size of the cohort, proportion of individuals excluded, and other important summary measures for the study.

Evaluation measure | Original Study | Reproduction
---|---|---
$\Delta$ Sodium | p = 0.003 | p = 0.322
BIC | p = 0.73 | p = 0.024
$\Delta$ BIC | p = 0.8 | p = <0.001


## Conclusion(s) regarding reproducibility

Highlight specific challenges faced during the reproduction attempt which could be improved upon in the future.

- Some wordings in the paper were ambiguous and make the reproduction more difficult. 
  - When the authors mentioned baseline labortory results prior to hospital admission in the introduction section, they actually meant the values 3 days before to 1 year prior to ICU admission.
- Samples were different from MIMIC-III to MIMIC-IV; cannot make sure replicating the same sample. 
  - Results would have slight different.
-  The paper didn't mention anything about outliers. Not sure how to deal with them. 
   -  For example, I excluded those patients whose BMI values greater than 100.