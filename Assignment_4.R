### 0.3 – Install packages 
install.packages("ggplot2", dependencies=TRUE)
install.packages("car", dependencies=TRUE)
install.packages("pastecs", dependencies=TRUE)
install.packages("psych", dependencies=TRUE)
install.packages("grid", dependencies=TRUE)
install.packages("gridExtra", dependencies=TRUE)
install.packages("DescTools", dependencies=TRUE)
install.packages("Hmisc", dependencies=TRUE)
install.packages("reshape2", dependecies=TRUE)
install.packages("ez",dependencies = TRUE)
install.packages("multcomp",dependencies = TRUE)
install.packages("nlme",dependencies = TRUE)
install.packages("MASS",dependencies = TRUE)
install.packages("lme4",dependencies = TRUE)
install.packages("emmeans",dependencies = TRUE)
install.packages("afex",dependencies = TRUE)
install.packages("ggbeeswarm",dependencies = TRUE)

### 0.4 - Load packages
library(ggplot2)
library(car)
library(pastecs)
library(psych)
library(grid)
library(gridExtra)
library(DescTools)
library(Hmisc)
library(reshape2)
library(ez)
library(multcomp)
library(nlme)
library(MASS)
library(lme4)
library(emmeans)
library(afex)
library(ggbeeswarm)

lang <- read.csv("language.csv", header=T)

# Check data integrity
head(lang)
tail(lang)
dim(lang)
names(lang)
summary(lang)
psych::describe(lang)

###Question 1
lang$diff <- lang$mother - lang$teacher

hist.diff <- ggplot(lang, aes(diff)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Difference scores", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(lang$diff, na.rm = TRUE), sd = sd(lang$diff, na.rm = TRUE)), colour = "red", size = 1)

hist.diff
ggsave("hist_diff.pdf", hist.diff) # need to specify what to save explicitly

stat.desc(lang$diff,basic=F,norm=T)

psych::describe(lang$diff)

ttestDiff <- t.test(lang$mother, lang$teacher, data=LD, alternative="two.sided", paired=T)
ttestDiff

#As the data is not normal, we do a Wilcoxon test
wilcoxDiff <- wilcox.test(lang$teacher, lang$mother, paired=T)  
wilcoxDiff #V = 51.5, p-value = 0.002879

#Let's calculate the ES r for the W test
rFromWilcox <- function(wilcoxModel, N) {
  z <- qnorm(wilcoxModel$p.value / 2)
  r <- z / sqrt(N)
  cat(wilcoxModel$data.name, "Effect Size, r = ", r)
}
rFromWilcox(wilcoxDiff,32)

###Question 2
miceDat<-read.csv("miceDat_long.csv",header=T)

head(miceDat)
tail(miceDat)
dim(miceDat)
names(miceDat)
summary(miceDat)
psych::describe(miceDat)

# Define group as factor
#    the levels correspond to the 3 genotype groups
miceDat$group <- factor(miceDat$group,levels=c(1:3), labels = c("aa","Aa","AA"))

psych::describe(aaDat)
psych::describe(AaDat)
psych::describe(AADat)

# Check order levels
# Note that R by default orders levels of a factor alphabetically
print(levels(as.factor(miceDat$group)))

# Descriptive statistics for each group in each condition
by(miceDat$weight, list(miceDat$time,miceDat$group), stat.desc,basic=F)

##########################################
# Plot the data to see the interaction
line.mice <- ggplot(miceDat, aes(time, weight, colour=group)) +
  stat_summary(fun=mean, geom="point", size=3) +
  stat_summary(fun=mean, geom="line", aes(group=group), linetype="solid", size=1.5) +
  stat_summary(fun.data=mean_cl_boot, geom="errorbar", width=.2) +
  labs(x="Weeks", y="Mean weight")

line.mice

grid.draw(line.mice) # interactive device
ggsave("linegraph_mice.pdf", line.mice) # need to specify what to save explicitly

##########################
# Normality

aaDat <-subset(miceDat, miceDat$group=="aa")
AaDat <-subset(miceDat, miceDat$group=="Aa")
AADat <-subset(miceDat, miceDat$group=="AA")

by(aaDat$weight,aaDat$time,shapiro.test)
by(AaDat$weight,AaDat$time,shapiro.test)
by(AADat$weight,AADat$time,shapiro.test)

##########################
# Means per group per week

describeBy(aaDat$ weight,list(aaDat$time), mat=TRUE,digits=2)  [,1:6]

describeBy(AaDat$ weight,list(AaDat$time), mat=TRUE,digits=2)  [,1:6]

describeBy(AADat$ weight,list(AADat$time), mat=TRUE,digits=2)  [,1:6]

##########################
# Specify the model
micemod <-aov_ez("ID", "weight", miceDat, 
                 between = c("group"), within = c("time"), 
                 anova_table=list(correction = "GG", es = "es"), print.formula=T, 
                 type=c("3"), check_contrasts=T, return = c("afex_aov"))

summary(micemod)
anova(micemod)

# Get the marginal means of the 4 conditions
emm <- emmeans(micemod, ~ time)
emm
### Repeated contrasts (note: not orthogonal!)
contrastR1 <- c(1,-1,0,0,0,0,0)
contrastR2 <- c(0,1,-1,0,0,0,0)
contrastR3 <- c(0,0,1,-1,0,0,0)
contrastR4 <- c(0,0,0,1,-1,0,0)
contrastR5 <- c(0,0,0,0,1,-1,0)
contrastR6 <- c(0,0,0,0,0,1,-1)
conRepeated <- cbind(contrastR1,contrastR2,contrastR3,
                     contrastR4,contrastR5,contrastR6)

contrast(
  emm, 
  list(conRepeated))

###############################
# Effect sizes contrasts
rcontrast<-function(t, df) {
  r <- sqrt(t^2 / (t^2 + df))
  print(paste("r = ", r))  
}

rcontrast(-29.166, 30)
rcontrast(-30.710, 30)
rcontrast(-14.076, 30)
rcontrast(-14.036, 30)
rcontrast(-11.157, 30)
rcontrast(-7.806, 30)

###Question 3
### Read In the data
DBPDat<-read.csv("DBP_repeated.csv",dec = ",",header=T)

head(DBPDat)
describe(DBPDat)
psych::describe(DBPDat)

# Convert wide-format data to long format
DBPDat2 <- melt(DBPDat,id = c("PPID","sex"),measured =c("DBP.1","DBP2.2","DBP.3","DBP.4"))

head(DBPDat2)

# Sort data so that you get a good idea of what the data look like now
DBPDat3 <- DBPDat2[order(DBPDat2$PPID),]

head(DBPDat3)

# change name column 3 for convenience
colnames(DBPDat3)[3]<- c("condition")
colnames(DBPDat3)[4]<- c("score")

##########################################
# Plot trend

trend.DBP <- ggplot(DBPDat3,aes(condition, score)) +
  stat_summary(fun=mean,geom="point") +
  stat_summary(fun=mean, geom="line", aes(group=1), colour= "Blue", linetype="dashed") +
  stat_summary(fun.data=mean_cl_boot, geom="errorbar", width=.2) +
  labs(x="Conditions", y="Mean DBP")

grid.draw(trend.DBP) # interactive device
ggsave("line_DBP.pdf", trend.DBP) # need to specify what to save explicitly

###########################
# HISTOGRAMS
hist.DBP1 <- ggplot(DBPDat, aes(DBP.1)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Diastolic blood pressure 1", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(DBPDat$DBP.1, na.rm = TRUE), sd = sd(DBPDat$DBP.1, na.rm = TRUE)), colour = "red", size = 1)

hist.DBP2 <- ggplot(DBPDat, aes(DBP.2)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Diastolic blood pressure 2", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(DBPDat$DBP.2, na.rm = TRUE), sd = sd(DBPDat$DBP.2, na.rm = TRUE)), colour = "red", size = 1)

hist.DBP3 <- ggplot(DBPDat, aes(DBP.3)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Diastolic blood pressure 3", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(DBPDat$DBP.3, na.rm = TRUE), sd = sd(DBPDat$DBP.3, na.rm = TRUE)), colour = "red", size = 1)

hist.DBP4 <- ggplot(DBPDat, aes(DBP.4)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Diastolic blood pressure 4", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(DBPDat$DBP.4, na.rm = TRUE), sd = sd(DBPDat$DBP.4, na.rm = TRUE)), colour = "red", size = 1)

hist.all <- arrangeGrob(hist.DBP1,hist.DBP2,hist.DBP3,hist.DBP4,ncol=2,nrow=2)
grid.draw(hist.all) # interactive device
ggsave("hist_all_SBP.pdf", hist.all) # need to specify what to save explicitly

########################################
# --- LONG FORMAT - normality in numbers 

by(DBPDat3$score,DBPDat3$condition,shapiro.test)

##########################
# Check Mauchly test
DBPmod <-aov_ez("PPID", "score", DBPDat3, between = NULL, within = c("condition"), 
                anova_table=list(correction = "GG", es = "pes"), print.formula=T, 
                type=c("3"), check_contrasts=T,
                return = c("afex_aov"))

summary(DBPmod)

##########################
# Run Friedman's ANOVA
# Delete columns "PPID" and "sex" from the wide-format file as these variables are not used in the model
DBPDat4 <- DBPDat[,c(-1,-2)]
head(DBPDat4)

# Exclude missing values
DBPDat5<-na.omit(DBPDat4)

friedman.test(as.matrix(DBPDat5))
###############################################
# Non-parametric posthoc: the Wilcoxon test

wilcoxDiff1 <- wilcox.test(DBPDat4$DBP.1, DBPDat4$DBP.2, paired=T)  
wilcoxDiff1

wilcoxDiff2 <- wilcox.test(DBPDat4$DBP.2, DBPDat4$DBP.3, paired=T)  
wilcoxDiff2

wilcoxDiff3 <- wilcox.test(DBPDat4$DBP.3, DBPDat4$DBP.4, paired=T)  
wilcoxDiff3


rFromWilcox<-function(wilcoxModel, N) {
  z <- qnorm(wilcoxModel$p.value/2)
  r <- z/ sqrt(N)
  cat(wilcoxModel$data.name, "Effect Size, r = ", r)
}

rFromWilcox(wilcoxDiff1, 24)
rFromWilcox(wilcoxDiff2, 24)
rFromWilcox(wilcoxDiff3, 24)
