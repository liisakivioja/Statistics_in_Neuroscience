**1** In this experiment children’s (N = 34) vocabulary scores were rated on a scale of 1 to 10 by their teachers (N = 33, mean = 6.67, sd = 1.74) and their mothers (N = 33, mean = 7.33, sd = 1.49). After considering the data that was complete (N = 32, mean = 0.62, sd = 1.01), we proceeded with analysing the dataset. The null hypothesis would state that the mothers did not evaluate their offspring’s vocabulary more positively than teachers, whereas the alternative hypothesis would state that the subject’s mothers did in fact evaluate their offspring’s vocabulary more positively than the teachers. To test these hypotheses, we conducted a paired t-test and tested against an alpha of 0.05. First however, we needed to make sure that our data follows normal difference distribution. 
For this we plotted our data into a histogram and conducted formal normality tests. The normality test (W = 0.89, p = 0.00397) showed the differences to be significant, which was also the case when we looked at the data distribution within the histogram.				
To see whether the results converge, we conducted a paired t-test and a Wilcoxon test. The paired t-test was significant (t(31) = 3.5074, p = 0.001405). We also conducted a Wilcoxon-test (V = 51.5, p = 0.002879) and saw that the test was highly significant, meaning that the mothers did indeed give higher scores to their offspring. Looking at the effect size (r =  -0.5268513) we can conclude that there is a large effect size. Concluding, we can say that we reject the null hypothesis stating that the mother’s did not evaluate their offspring’s vocabulary more positively than the teachers, and accept the alternative hypothesis. 

<img width="241" alt="Image" src="https://github.com/user-attachments/assets/3eba96bc-4e64-49d2-af96-52aaabe699a9" />

_**Figure 1.** Histogram of the data’s distribution._

**2** Weight data were gathered on seven consecutive time points (T1 to T7) in three groups of inbred mice (genotypes aa: N=11, Aa: N=10, and AA: N=12). The aim of the study is to find out whether the mice gain weight over time, and whether this gain is equal across the three genotype groups (2-sided). We hypothesized that either the mice do not gain weight over time, or they gain weight and it is not equal across the three genotype groups.
At T1, data were not normally distributed in group AA (SW=0. 82869, p < 0. 02023), and on T2, data were not normally distributed in groups aa and AA (SW=0.88044, p < 0.02023, and SW=0.79028, p < 0.007279, respectively). However, as the other (3*7)-3=18 tests for non-normality were not significant, and the non-parametric Friedman ANOVA does not permit the study of group differences, a repeated measures ANOVA was preferred, which is reasonably robust against violations of normality. 

<img width="293" alt="Image" src="https://github.com/user-attachments/assets/d9254409-534f-4455-8ea8-b6d63c043723" />

_**Figure 2.** Plotted data to visualize interaction_

The means and SD for all three strains on all 7 time points are the following:

aaDat
item group1 vars  n   mean     sd
X11    1   wt.1    1 11 148.91  14.88
X12    2   wt.2    1 11 253.73  43.19
X13    3   wt.3    1 11 419.91  66.96
X14    4   wt.4    1 11 561.64  82.19
X15    5   wt.5    1 11 690.18  81.82
X16    6   wt.6    1 11 788.55  99.00
X17    7   wt.7    1 11 861.18 100.41

AaDat
    item group1 vars  n  mean    sd
X11    1   wt.1    1 10 176.2  9.19
X12    2   wt.2    1 10 320.0 25.76
X13    3   wt.3    1 10 504.2 39.38
X14    4   wt.4    1 10 641.1 71.01
X15    5   wt.5    1 10 745.4 49.41
X16    6   wt.6    1 10 790.9 51.42
X17    7   wt.7    1 10 869.2 56.41

AADat
    item group1 vars  n   mean     sd
X11    1   wt.1    1 12 201.92  22.92
X12    2   wt.2    1 12 373.08  40.70
X13    3   wt.3    1 12 548.75  51.79
X14    4   wt.4    1 12 690.42  97.00
X15    5   wt.5    1 12 812.25 127.37
X16    6   wt.6    1 12 873.33 122.84
X17    7   wt.7    1 12 944.42 113.41

 Mauchley’s test was significant (W= 0.0041913, p=4.307e-22), meaning that the sphericity assumption was violated. We therefore used the Greenhouse-Geisser corrected results. 
The within subjects effect for time was significant (F(6,180)=895.19, p < 0.001, partial η2=0.92), but the interaction between time and group was not (F(12,180)=1.6530, ns, partial η2=0.042), meaning that weight increased over time, but the increase was equal for the three groups. 
Repeated contrasts showed that between every time point, the gain in weight was significant (T1 vs T2: t(30)=-29.166,p<0.0001,r= 0.9828; T2vsT3: t(30)=-30.710,p<0.0001,r= 0.9845; T3 vs T4: t(30)=-14.076,p<0.0001,r= 0.9319; T4 vs T5: t(30)=-14.036,p<0.0001,r= 0.9316; T5 vs T6: t(30)=-11.157,p<0.0001,r= 0.8977; T6 vs T7: t(30)=-7.806,p<0.0001,r= 0.8186. 
The main effect for group was significant (F(2,30)=8.99, p < 0.001, partial η2=0.27), meaning that the three strains did differ in overall weight across the 7 time points, albeit not in weight gain. We therefore conclude that the alternative hypothesis did indeed hold true as the weight increased over time and varied across the three strains. 

**3** In this study, subject’s (N=24) diastolic blood pressure (DBP) was measured in four conditions: condition 1: sitting still on a chair (mean = 67.29, sd = 13.93), condition 2: running for 1 minute on a treadmill (mean = 78.06, sd = 13.80), condition 3: running for 5 minutes on a tread mill (mean = 81.9, sd = 20.04), condition 4: running for 15 minutes on a treadmill (mean = 100, sd = 41.03). We were interested in whether DBP changes across the four described test conditions. The null hypothesis would state that the mean DBP does not differ across the four test conditions, whereas the alternative hypothesis would state that the mean DBP differs across the four test conditions, making this a two-sided test. We tested against an alpha of 0.05 in here. 
For this we first plotted the data of the mean DBP against all the four conditions, wherein we can visually already see that the measured DBP seems to vary across the four conditions. 

<img width="281" alt="Image" src="https://github.com/user-attachments/assets/3d590071-7984-42b7-9d2c-5fc1af191186" />

_**Figure 3.** Data visualizing the trend of mean DBP_

Next, we plotted the data into histograms per condition to check for normality to check the assumptions. Then we checked for the normality assumption formally by checking descriptive statistics of the scores in each condition. We saw that only the condition 2 was normal (p = 0.5021), whereas the other conditions (condition 1 p = 0.0047, condition 3 p = 0.030, condition 4 p = 0.0015) were significant, therefore not following the normal distribution. 
Next, we checked the Mauchly test, which was significant (W= 0.077, p= 9.7237e-11), meaning that the sphericity assumption was violated. Because of this, we ran a Friedman’s ANOVA which helps us answer the question whether the manipulation across four conditions significantly influence DBP. The measured DBP scores did change significantly over time (X^2(3) = 32.46, p = 4.19e-07). 
Because of this, we had to conduct a post hoc test – a paired non-parametric Wilcoxon signed rank test. This contrast showed that between conditions 1 & 2, and 3 & 4, the increase in DBP was significant (DBP.1 vs DBP2: V = 19.5,p<0.001,r= -0.7327638; DBP.2 vs DBP.3: V = 135.5, ns,r= -0.08167466; DBP.3 vs DBP.4: V =23, p<0.001,r= -0.7379136. Concluding, we can reject the null hypothesis and accept the alternative hypothesis stating that the DBP does indeed differ between the four conditions, but not so much in conditions 2 and 3.

<img width="344" alt="Image" src="https://github.com/user-attachments/assets/3cedba9f-a781-490c-a411-07c724bfa79a" />

_**Figure 4.** Histograms showing the distribution of sample population_
