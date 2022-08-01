import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
import scipy.stats as stats
import pylab
from tableone import TableOne, load_dataset

df = pd.read_csv("/Users/emily/Desktop/final_table", sep = ",")

# 1: Obese. 0: Normal Weights Group
df["bmi_dummy"]=np.where(df["bmi"] >= 30, 1,df["bmi"])
df["bmi_dummy"]=np.where((df["bmi_dummy"] >= 18.5) & (df["bmi_dummy"] < 23), 0, df["bmi_dummy"])

df1 = df.loc[(df["bmi_dummy"] == 1) | (df["bmi_dummy"] == 0)]
df1["bmi_dummy"] = df1["bmi_dummy"].astype(int)

# bmi exploratory analysis
plt.plot(df1["bmi"]) #outliers exist
stats.probplot(df1["bmi"][df1["bmi"]<100], dist="norm", plot=pylab)
pylab.show()

plt.hist(df1["bmi"][df1["bmi"] < 100])
df2 = df1.loc[df1["bmi"] <= 100] # filter out extreme values 

# filter the patients with lab results (at lease 3 days and at most 1 year) prior to first ICU admission
df2 = df2.loc[df2['baseline_lab_value'] == 1] 

# Create TableOne - results in the folder "tables" 
columns = ['anchor_age','gender', 'ethnicity', 'marital_status', 'insurance', 'charlson_comorbidity_index', 
'bmi', 'admission_type', 'admission_location', 'ICU_type', 'sapsii','sofa_score']
categorical = ['gender', 'ethnicity', 'marital_status', 'insurance', 'admission_type', 'admission_location', 'ICU_type']
groupby = 'bmi_dummy'
nonnormal = [ "bmi","sapsii","sofa_score"]

mytable = TableOne(df2, columns=columns, categorical=categorical,groupby=groupby, nonnormal=nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))




