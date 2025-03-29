**1** Our research question was: “Does the drug affect the protein levels in the cells?”. N=20 mice participated in this experiment, 10 in each condition: a baseline condition (0) in which n=10 mice did not receive a drug, and an experimental condition (1) in which n=10 mice received a drug. In each mouse, 100 cells were collected, and protein levels were measured in each cell, i.e., the observed sample size is 100 * 20 = 2000 cells. These data needed to be analysed using multi-level analysis because we deal with a nested dataset where all observations from the same cluster are part of the same experimental condition.

<img width="251" alt="Image" src="https://github.com/user-attachments/assets/3daca8c7-3775-41b3-84c7-6cf5a444222a" />

_**Figure 1.** Scatterplots depicting each mouse's protein levels per condition._

<img width="236" alt="Image" src="https://github.com/user-attachments/assets/d3b4eedf-b368-4e1c-817d-ef89b2a8a73d" />

_**Figure 2.**Figure 2. Histograms depicting protein level densities per condition._ 

Looking at the scatterplot in Figure 1 we see there is some variation of protein X levels within mice conditions and also some between mice conditions. We do expect the ICC to be low because the variation that we see in the total data set is not that different from the variation that we see in each cluster (i.e., in each mouse).

The ICC in the intercept-only model is calculated as: 0.34^2 / (0.34^2 + 1.90^2) = 0.032, which is low. However, the ICC is significant (chi(1)= 35.41, p< 0.0001), so we do need to conduct ML analysis on these data. We also note that when the number of observations taken from each cluster is high (like here: 100 per mouse), even small ICC’s can result in a much smaller effective sample size. The effective sample size is here estimated at

<img width="323" alt="Image" src="https://github.com/user-attachments/assets/19df7685-e46f-4b1c-bc58-047e6ff252dd" />

i.e., much higher than the observed sample size.

Including condition as predictor in the ML-model shows that the drug does not significantly affect protein levels (t(18)= 1.93, p= 0.069). The ICC in this model (i.e., what is not explained by condition) equals 0.31^2 /(0.31^2+ 1.9^2) = 0.025, so the change in ICC equals 0.032 - 0.025 = 0.0063, meaning that the experimental condition explains 0.63% of the variance between mice.

A regular t-test would have implied that the drug has a very significant decreasing effect on the protein levels (t(1959.5)= -3.61, p= 0.00031), i.e., a Type I error.