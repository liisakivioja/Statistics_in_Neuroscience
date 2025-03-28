install.packages("psych",dependencies = TRUE)
install.packages("ggplot2", dependencies=TRUE)
install.packages("gmodels", dependencies=TRUE)
library(psych)
library(ggplot2)
library(gmodels)

# Clear existing workspace objects if necessary
rm(list = ls())

##Question 1
dat <- read.csv("exercise.csv")
head(dat)
tail(dat)
dim(dat)
names(dat)

dat$anxiety[dat$tstatus==1]
dat$anxiety[dat$tstatus==2]

describe(dat$anxiety)
#   vars  n  mean   sd median trimmed  mad min max range skew kurtosis   se
#X1    1 30 33.67 6.13     33   33.29 4.45  24  47    23 0.49    -0.64 1.12

describeBy(dat$anxiety, group=dat$tstatus)
# Descriptive statistics by group 
#group: 1
#vars  n  mean   sd median trimmed   mad min max range skew kurtosis   se
#X1    1 15 34.87 7.52     35   34.77 10.38  24  47    23 0.09    -1.37 1.94
#------------------------------------------------------------ 
#  group: 2
#vars  n  mean   sd median trimmed  mad min max range skew kurtosis  se
#X1    1 15 32.47 4.27     31   32.23 4.45  26  42    16 0.72    -0.18 1.1

#Write a function to calculate SE of skew and kurtosis
skewKurtSE = function(x){
  n = length(na.omit(x))
  skew = describe(x)$skew
  kurt = describe(x)$kurtosis
  skew_se = sqrt((6*n*(n-1))/((n-2)*(n+1)*(n+3)))
  kurt_se = sqrt((4*(n^2-1)*skew_se^2)/((n-3)*(n+5)))
  return(data.frame(Skew = skew, Skew_SE = skew_se, Kurtosis = kurt, Kurtosis_SE = kurt_se))
}

#Assign to variables
se_con1 <- skewKurtSE(dat$anxiety[dat$tstatus==1])
se_con2 <- skewKurtSE(dat$anxiety[dat$tstatus==2])

se_con1
#        Skew   Skew_SE  Kurtosis Kurtosis_SE
#1 0.09260205 0.5801194 -1.367763    1.120897
se_con2

#       Skew   Skew_SE   Kurtosis Kurtosis_SE
#1 0.7185343 0.5801194 -0.1761763    1.120897

#skewness for cond_1
z_1 = 0.09260205/0.5801194
z_1 #[1] 0.1596258

#skewness for cond_2
z_2 = 0.7185343/0.5801194
z_2 #[1] 1.238597

#kurtosis for cond_1
z_3 = -1.367763/1.120897
z_3 #[1] -1.22024

#kurtosis for cond_2
z_4 = -0.1761763/1.120897
z_4 #[1] -0.1571744

#Visualise data
table(dat$tstatus, dat$anxiety)

#Condition 1
ks.test(x=dat$anxiety[dat$tstatus==1], y="pnorm", mean=mean(dat$anxiety[dat$tstatus==1]), sd=sd(dat$anxiety[dat$tstatus==1]))
shapiro.test(dat$anxiety[dat$tstatus==1])
 
#One-sample Kolmogorov-Smirnov test
#data:  dat$anger[dat$tstatus == 1]
#D = 0.24661, p-value = 9.459e-13
#alternative hypothesis: two-sided
 
#Shapiro-Wilk normality test
#data:  dat$anger[dat$tstatus == 1]
#W = 0.89513, p-value = 0.5132
 
#Condition 2
ks.test(x=dat$anxiety[dat$tstatus==2], y="pnorm", mean=mean(dat$anxiety[dat$tstatus==1]), sd=sd(dat$anxiety[dat$tstatus==1]))
shapiro.test(dat$anxiety[dat$tstatus==2])

#One-sample Kolmogorov-Smirnov test
#data:  dat$anger[dat$tstatus == 2]
#D = 0.3514, p-value = 0.04923
#alternative hypothesis: two-sided

#Shapiro-Wilk normality test
#data:  dat$anger[dat$tstatus == 2]
#W = 0.9243, p-value = 0.224

#Visualise data
hist(dat$anxiety[dat$tstatus==1], xlab="Training")+
hist(dat$anxiety[dat$tstatus==2], xlab="No Training")

##Question 3
#Recreate data
genos <- data.frame( Group = c( rep("Case",100), rep("Control",100)), Genotype = c( rep("BB",46), rep("Bb",34), rep("bb",20),   rep("BB",60), rep("Bb",30), rep("bb",10) ), stringsAsFactors = T)

describe(genos)
#vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
#Group*       1 200 1.50 0.50    1.5    1.50 0.74   1   2     1  0.00    -2.01 0.04
#Genotype*    2 200 2.38 0.73    3.0    2.48 0.00   1   3     2 -0.72    -0.83 0.05

table(genos$Group)
#   Case Control 
#100     100 

table(genos$Genotype)
#bb  Bb  BB 
#30  64 106 

prop.table(table(genos$Group,genos$Genotype), margin = 1)
#bb   Bb   BB
#Case    0.20 0.34 0.46
#Control 0.10 0.30 0.60

#Perform chi2 test
chisq.test(table(genos$Group,genos$Genotype))
#Pearson's Chi-squared test
#data:  table(genos$Group, genos$Genotype)
#X-squared = 5.4324, df = 2, p-value = 0.06613

#Visualize data
ggplot(genos,aes(Group)) + geom_bar(position="dodge",aes(fill=Genotype)) + 
  scale_fill_manual(values=c("lightskyblue","lightskyblue2","lightskyblue3")) + 
  theme_minimal() + 
  ggtitle("Relationship between the disease and the genotype") + 
  ylab("Frequency")
