# Laboratory Results at Baseline

# SAPS-II: WBC, Sodium, Potassium, BUN, BIC. SOFA: Creatinine, Platelets
# itemid: 
# WBC: 51300, 51301
# Sodium: 50824, 50983
# Potassium: 50822, 50971
# BUN: 51006
# BIC: 50803, 50882
# Creatinine: 50912, 51081
# Platelets: 51265
  
columns =["lab_value"]
groupby = 'bmi_dummy'
nonnormal = ["lab_value"]

# WBC
df_wbc = df2.loc[(df2["itemid"] == 51300) | (df2["itemid"] == 51301)]
mytable = TableOne(df_wbc, columns=columns, groupby=groupby, nonnormal=nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))

#Sodium
df_sodium = df2.loc[(df2["itemid"] == 50824) | (df2["itemid"] == 50983)]
mytable = TableOne(df_sodium, columns=columns, groupby=groupby, nonnormal=nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Potassium
df_potassium = df2.loc[(df2["itemid"] == 50822) | (df2["itemid"] == 50971)]
mytable = TableOne(df_potassium, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# BUN
df_BUN = df2.loc[(df2["itemid"] == 51006)]
mytable = TableOne(df_BUN, columns=columns, groupby=groupby, nonnormal = nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))

#BIC
df_BIC = df2.loc[(df2["itemid"] == 50803)|(df2["itemid"] == 50882)]
mytable = TableOne(df_BIC, columns=columns, groupby=groupby, nonnormal = nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Creatinine
df_creatinine = df2.loc[(df2["itemid"] == 50912)|(df2["itemid"] == 51081)]
mytable = TableOne(df_creatinine, columns=columns, groupby=groupby, nonnormal = nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Platelets
df_platelets = df2.loc[(df2["itemid"] == 51265)]
mytable = TableOne(df_platelets, columns=columns, groupby=groupby, nonnormal = nonnormal, pval=True)
print(mytable.tabulate(tablefmt="github"))


# Deviation of Laboratory Results from Baseline to ICU

# WBC
df_wbc["wbc_deviation"] = df_wbc["wbc_icu"] - df_wbc["lab_value"]
columns =["wbc_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_wbc, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Sodium 
df_sodium["sodium_deviation"] = df_sodium["sodium_icu"] - df_sodium["lab_value"]
columns =["sodium_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_sodium, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Potassium
df_potassium["potassium_deviation"] = df_potassium["potassium_icu"] - df_potassium["lab_value"]
columns =["potassium_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_potassium, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# BUN
df_BUN["bun_deviation"] = df_BUN["bun_icu"] - df_BUN["lab_value"]
columns =["bun_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_BUN, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

#BIC
df_BIC["bic_deviation"] = df_BIC["bicarbonate_icu"] - df_BIC["lab_value"]
columns =["bic_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_BIC, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Creatinine
df_creatinine["creatinine_deviation"] = df_creatinine["creatinine_icu"] - df_creatinine["lab_value"]
columns =["creatinine_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_creatinine, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))

# Platelets
df_platelets["platelets_deviation"] = df_platelets["platelets_icu"] - df_platelets["lab_value"]
columns =["platelets_deviation"]
groupby = 'bmi_dummy'
mytable = TableOne(df_platelets, columns=columns, groupby=groupby, pval=True)
print(mytable.tabulate(tablefmt="github"))
