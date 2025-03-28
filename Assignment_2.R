### 0.1 - Clear existing workspace objects rm(list = ls())
### 0.2 - Set working directory to where the data file is located & results should be saved
setwd("Script 2")
### 0.3 - Install packages 
install.packages("ggplot2", dependencies=TRUE)
install.packages("Hmisc", dependencies=TRUE)
install.packages("ggm", dependecies=TRUE)
install.packages("polycor",dependencies = TRUE)
install.packages("psych",dependencies = TRUE) 
install.packages("gridExtra",dependencies = TRUE)
install.packages("arules",dependencies = TRUE)
install.packages("pracma",dependencies = TRUE)
install.packages("pastecs",dependencies = TRUE)
install.packages("QuantPsyc",dependencies = TRUE)
install.packages("lmtest",dependencies = TRUE)
install.packages("checkmate",dependencies = TRUE)
install.packages("car",dependencies = TRUE)
### 0.4 - Load this week’s packages
library(lmtest)
library(QuantPsyc)
library(pastecs)
library(pracma)
library(arules)
library(ggplot2)
library(grid)
library(ggm)
library(gridExtra)
library(polycor)
library(Hmisc)
library(psych)
library(checkmate)
library(car)

##QUESTION 1
brain <- read.csv("brainsizeMRI_iq.csv", header=T)
head(brain)
tail(brain)
dim(brain)
names(brain)
summary(brain)
psych::describe(brain)

#Find the sample size
describeBy(brain, group=brain$sex)

#Plot the data into a scatterplot
#Codition VIQ score
scat.mri.viq <- ggplot(brain, aes(viq.q, mri)) +
  ggtitle("Scatterplot") +
  geom_point() + labs(x="MRI", y="VIQ score") +
  geom_smooth(method="lm", colour="Pink")

scat.mri.viq  

#Codition PIQ score
scat.mri.piq <- ggplot(brain, aes(piq.q, mri)) +
  ggtitle("Scatterplot") +
  geom_point() + labs(x="MRI", y="PIQ score") +
  geom_smooth(method="lm", colour="Pink")

scat.mri.piq  

#Correlation test using the Spearman rank correlation p
cor.test(brain$mri, brain$viq.q, alternative = "two.sided", method = "spearman", conf.level = 0.95)
#	Spearman's rank correlation rho
#data:  brain$mri and brain$viq.q
#S = 6671.5, p-value = 0.01739
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#  rho 
#0.3741531 

#Correlation test using the Spearman rank correlation p
cor.test(brain$mri, brain$piq.q, alternative = "two.sided", method = "spearman", conf.level = 0.95)
#Spearman's rank correlation rho
#data:  brain$mri and brain$piq.q
#S = 6323.7, p-value = 0.009191
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.4067848

#Descriptive statistics
psych::describe(brain$mri)
psych::describe(brain$viq.q)
psych::describe(brain$piq.q)


##Question 2
#Clear the workspace
rm(list = ls())
#Select first siblings from the old dataset
brain <- read.csv("brain_iq.csv",header=T)
brain2 <- subset(brain, pid==1)

#Run a regression analysis between intra and height
regr1 <- lm(intra ~ height, data=brain2, na.action=na.exclude)
summary(regr1)

#Sample size
describeBy(brain2, group=brain2$sex)

#Descriptive statistics
psych::describe(brain2$intra)
psych::describe(brain2$height)

#generate a scatterplot
scat.intra.height <- ggplot(brain2, aes(height, intra)) +
  ggtitle("Scatterplot") +
  geom_point() + labs(x="Height", y="Intracranical volume") +
  geom_smooth(method="lm", colour="Pink")

scat.intra.height
