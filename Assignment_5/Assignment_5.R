### 0.1 - Clear existing workspace objects 
rm(list = ls())
### 0.2 - Set working directory to where the data file is located & results should be saved (change to your own directory)
setwd("..")
### 0.3 – Install packages
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
install.packages("car",dependencies = TRUE)

### 0.4 - Load this week’s packages
library(ggplot2)
library(Hmisc)
library(ggm)
library(polycor)
library(psych)
library(gridExtra)
library(grid)
library(arules)
library(pracma)
library(pastecs)
library(QuantPsyc)
library(lmtest)
library(car)

brain <- read.csv("brain_iq.csv",header=T)

######### Question 1
# Select only the people with PID=1 to avoid dependency
sel<-brain[brain$pid==1,]
# Define "sex" as factor (note: this isn’t essential but regression results will now show the label associated with the regression coefficient)
sel$sex <- factor(sel$sex,levels=c(0,1), labels = c("female","male"))

head(sel)
tail(sel)
dim(sel)
names(sel)
summary(sel)
psych::describe(sel)

#Let's describe height per level of sex
by(sel$height, sel$sex, psych::describe)
#Let's describe ICV per level of sex
by(sel$intra, sel$sex, psych::describe)

##Let's create a scatterplot to visualize the data
scat.sex.intra <- ggplot(sel, aes(intra, sex)) +
  ggtitle("Scatterplot") + 
  geom_point(shape=21, size=3, fill="darkred",color="blue") + 
  labs(x="ICV", y="Sex") 

scat.sex.intra

#Let's run the simple regression with intra as DV and sex as IV
model1 <- lm(intra ~ sex, data=sel, na.action=na.exclude)
summary(model1)

#Let's run the regression model includingintra as DV, and both height and sex as IVs
model2 <- lm(intra ~ sex + height, data=sel, na.action=na.exclude)
summary(model2)

# Compare nested models to see which variable improves the base model
anova(model1, model2)

######### Question 2
rm(list = ls())

LD <- read.csv("learningdisabilityR1.csv", header=T)

head(LD)
tail(LD)
dim(LD)
names(LD)
summary(LD)
psych::describe(LD)

#######################################
# Histograms all involved variables

hist.digitF <- ggplot(LD, aes(digitF)) +
  ggtitle("Digit span F.")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=9) + 
  labs(x = "DigitF", y = "Density") +         
  stat_function(fun = dnorm, args = list(mean = mean(LD$digitF, na.rm = TRUE), sd = sd(LD$digitF, na.rm = TRUE)), colour = "red", size = 1)

hist.rakit <- ggplot(LD, aes(rakit)) +
  ggtitle("IQ scores")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=9) + 
  labs(x = "rakit", y = "Density") +         
  stat_function(fun = dnorm, args = list(mean = mean(LD$rakit, na.rm = TRUE), sd = sd(LD$rakit, na.rm = TRUE)), colour = "red", size = 1)

hist.age <- ggplot(LD, aes(age)) +
  ggtitle("Age")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=9) + 
  labs(x = "age", y = "Density") +         
  stat_function(fun = dnorm, args = list(mean = mean(LD$age, na.rm = TRUE), sd = sd(LD$age, na.rm = TRUE)), colour = "red", size = 1)

hist.digitB <- ggplot(LD, aes(digitB)) +
  ggtitle("Digit span B.")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=9) + 
  labs(x = "digitB", y = "Density") +         
  stat_function(fun = dnorm, args = list(mean = mean(LD$digitB, na.rm = TRUE), sd = sd(LD$digitB, na.rm = TRUE)), colour = "red", size = 1)

hist.all <- arrangeGrob(hist.digitF,hist.rakit,hist.age,hist.digitB,
                        ncol=4,nrow=1)
grid.draw(hist.all) # interactive device
ggsave("hist_all_LD.pdf", hist.all) # need to specify what to save explicitly

####################
# normality tests
stat.desc(LD$digitF, basic=F, norm=T)
stat.desc(LD$rakit, basic=F, norm=T)
stat.desc(LD$age, basic=F, norm=T)
stat.desc(LD$digitB, basic=F, norm=T)

#######################################
# Regression model

model1 <-lm(digitB ~ rakit + age, data=LD, na.action=na.exclude)
summary(model1)

model2 <-lm(digitB ~ rakit + age + digitF, data=LD, na.action=na.exclude)
summary(model2)

anova(model1, model2)

lm.beta(model2)
# Correlation matrix of the model parameters
cov2cor(vcov(model2))  

vif(model2)
mean(vif(model2))


#######################################
# Check assumptions model 2
#######################################

# Check linearity of X-Y association (for time's sake, just between digitF and digitB here but you should check this for all IVs)
scat.linear <- ggplot(LD,aes(digitF,digitB)) +
  ggtitle("Linearity of association digitF-digitB")+
  geom_point() + labs(x="DigitF scores", y="DigitB scores") +
  geom_smooth(method="lm", colour="Blue")
scat.linear # interactive device
ggsave("scat_linearity.pdf", scat.linear) # need to specify what to save explicitly


###########################################
# Residual plots - (check distribution of residuals)

# Save residuals and predicted values
LD$fitted <- model2$fitted.values     # predicted values
LD$resid <- model2$residuals           # raw residuals 
LD$stand.resid <- rstandard(model2)   # standardized residuals
head(LD)

# Stand residuals versus observed values digitF (heteroscedasticity)
scat.obs.resid <- ggplot(LD,aes(digitF,stand.resid)) +
  ggtitle("Heteroscedasticity")+
  geom_point() + labs(x="DigitF scores", y="Standardized residuals") +
  geom_smooth(method="lm", colour="Blue")

# Stand residuals versus ID (independence)
scat.resid.ID <- ggplot(LD,aes(ID,stand.resid)) +
  ggtitle("Independence")+
  geom_point() + labs(x="Person ID", y="Standardized residuals") +
  geom_smooth(method="lm", colour="Blue")

# Distr stand residuals
hist.resid <- ggplot(LD, aes(stand.resid)) +
  ggtitle("Distribution")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Residuals", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(LD$stand.resid, na.rm = TRUE), sd = sd(LD$stand.resid, na.rm = TRUE)), colour = "red", size = 1)

scat.all <- arrangeGrob(scat.obs.resid,scat.resid.ID,hist.resid,ncol=3,nrow=1)
grid.draw(scat.all) # interactive device
ggsave("scat_residuals.pdf", scat.all) # need to specify what to save explicitly

# Breusch-Pagan test for homoscedasticity
bptest(model2)

# Durbin-Watson test for autocorrelation
dwtest(model2,alternative ="two.sided")

# SW test for normality of residuals
stat.desc(LD$stand.resid,basic=F,norm=T)

# Check distribution of standardized residuals against normal distribution
aux3 <-as.vector(LD$stand.resid)
aux3
y1 <- c(aux3[aux3< -3.3], aux3[aux3>3.3])	  # > |3.3|
y2 <- c(aux3[aux3< -2.58], aux3[aux3>2.58])	# > |2.58|
y3 <- c(aux3[aux3< -1.96], aux3[aux3>1.96])	# > |1.96|
y1
y2
y3

######### Question 3
#Make new dataframe for output 
regr.stats <- as.data.frame(summary(model2)$coef)	#extract coefficient table
names(regr.stats)[4] <- "P"		#rename from "PR(<|t|)" for ease of use
regr.stats	
#Let's correct the p-values using Bonferroni adjustment
regr.stats$P_bonf <- p.adjust(regr.stats$P, method="bonferroni")
regr.stats
#Let's correct the p-values using fdr adjustment
regr.stats$P_fdr <- p.adjust(regr.stats$P, method="fdr")
regr.stats
