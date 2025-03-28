**1** In this experimental study, the relation between either verbal IQ or performance IQ with the MRI of the subjects were measured in a general population. The subjects (N = 40, from which N = 38 were used) were either male (N = 20, from which N = 18 were used) or female (N = 20). 
Two variables, verbal IQ and performance IQ, were generated to represent the quartile rankings of the respective subscales of the Wechsler’s Adult Intelligence Scale (WAIS). We are interested in finding out whether there is a relation between MRI (the measure of brain volume) (mean = 908755, sd = 72282.05) and either the measured verbal IQ (mean = 2.6, sd = 1.03) or performance IQ (mean = 2.58, sd = 1.2). For this we performed calculations to examine the correlations between these variables, using the appropriate correlation coefficient which in this case was Spearman’s rank correlation p due to working with ordinal values (the IQ scales). The null hypothesis for these tests was that the correlation between MRI and these variables is not there and there is no relation. The two-sided alternative hypothesis was that there is a correlation between MRI and these variables. We tested against an alpha level of 0.05. 
The correlation tests results show that the correlation between the MRI and verbal IQ of the subjects is relatively low, but it is present (S = 6671.5, rho = 0.3741531) and the p value is significant (p = 0.01739), suggesting to reject the null hypothesis. Similarly, the results show that the correlation between the MRI and performance IQ of the subjects is relatively low (S = 6323.7, rho = 0.4067848) and the p value is significant (p = 0.009191), suggesting to reject the null hypothesis. Finally, the data was plotted into a scatterplot. Concluding, the significant p values suggest that there is a correlation present between MRI and the verbal and performance IQ’s of the subjects, but regarding our data it seems relatively low. 

<img width="626" alt="Image" src="https://github.com/user-attachments/assets/6b36f4bd-0453-46e2-838e-6f6998264bbe" />

_**Figure 1.** Two scatterplots to visualize the correlation between MRI and verbal IQ score (on the left), and between MRI and performance IQ score (on the right) of the subject’s._

**2** Anthropometric measures of height and intracranial volume (ICV) were collected in N=40 individuals (singletons selected from twin pairs), in order to test the research question of “Can the subject’s height be used to predict their intracranial volume?”. In this sample, the mean of ICV was 103.61 cm3 (SD= 10.33) and the mean of height was 1.77 meters (SD= 0.1).The F-statistic was significant (F(1, 38) = 6.309, p = 0.01638), meaning that the regression model including height provides a significantly better prediction of the dependent variable than a model that would only be based on the mean of the dependent variable. 
This is supported by the finding that the regression coefficient for height (i.e., the slope) was significant (β1 = 37.18, t(38) = 2.512, p = 0.0164, respectively), though the non-significant coefficient for the intercept (β0 = 37.76, t(38) = 1.438, p = 0.1586) indicated that the mean ICV for when height=0 did not differ significantly from zero. 
The regression formula was thus: ICVi = 37.76 + 37.18*heighti + 14.8. 
Height explained 0.1424 of the variance in intracranial volume. The adjusted R2 (0.1198) did not deviate much from this value, meaning that the present regression equation would generalize nicely to other samples taken from the same population. We can conclude from these results that the height (independent variable) can be used to better predict the intracranial volume (dependent variable).

<img width="344" alt="Image" src="https://github.com/user-attachments/assets/828c92bd-9c03-4a1c-a71a-7a67cd5dafe4" />

_**Figure 2.** A scatterplot to visualize the regression between subject’s height and their ICV._

**3** The regression assumptions:

- Linearity: check scatterplot for gross deviation

- Normal residuals: check histogram of residuals; infer from normality of dependent variable

- Independent observations: no repeated/nested data; check similarity of residuals between subjects

- Homoscedasticity: check distribution of residuals across independent variable, should be roughly similar across the range

To check for the linearity assumption in this regression analysis, we used the scatterplot plotted for height and ICV. There, we also checked for outliers which could have stood out. In the scatterplot, the relation seems linear and there are not outstanding outliers. 

To check for the normality, we looked at the generated histograms, and the formal normality tests (the Shapiro-Wilk test-statistic (normtest.W) and the p values (normtest.p)). Visually looking, we see that the histograms for both variables follow a normal distribution, since the curve that is symmetrical on both sides of the mean is present. When we look at the normality tests, we see that the corresponding p values (intra p = 0.98, height p = 0.14) and W values (intra W = 0.99, height W = 0.96) are non-significant, confirming our observations about the data following normal distribution. 

To check for the independent observations, we aim to see whether there are any unusual patterns that would indicate non-independence within the residuals. For this we looked at the plotted residuals, wherein the Family ID was plotted against the residuals. There, we do not see any obvious unusual patterns. We also looked at the Durbin-Watson test for independent residuals, where we saw that the test was non-significant (p = 0.80), suggesting no significant deviation from independence. Finally, when checking for normality of the residuals, we see that the SW normality test gives us non-significant values (SW = 0.97, p = 0.58). To see whether there are residual values outside the |3.3|, |2.58|, |1.96| boundaries, we looked at another test. Upon conducting that, we observed that there are four values that are > 1.96 boundary; this makes up 10% of 40 (the sample size). 

To check for the homoscedasticity, we plotted the residuals against the predictor variable to show whether the variance of the residuals is indeed consistent across all levels of the predictor. This would show the consistency of the data, which we do see here as there are no apparent differences in the spread of scores which appear systematic across the levels of the independent variable. The Breusch-Pagan test which also tests for homoscedasticity appears also to be non-significant (BP = 0.09, p = 0.76). 
