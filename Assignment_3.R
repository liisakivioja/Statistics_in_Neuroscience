### 0.1 - Clear existing workspace objects rm(list = ls())
### 0.2 - Set working directory to where the data file is located & results should be saved
setwd("C:\\Users\\Liisa\\Documents\\Statistics in Neuroscience\\Script 3")

### 0.3 - Install packages 
install.packages("ggplot2", dependencies=TRUE)
install.packages("car",dependencies = TRUE)
install.packages("pastecs",dependencies = TRUE)
install.packages("psych",dependencies = TRUE) 
install.packages("gridExtra",dependencies = TRUE)
install.packages("DescTools",dependencies = TRUE)
install.packages("Hmisc", dependencies=TRUE)
install.packages("multcomp", dependencies=TRUE)
install.packages("haven", dependencies=TRUE)

### 0.4 - Load packages
library(ggplot2)
library(car)
library(pastecs)
library(psych)
library(grid)
library(gridExtra)
library(DescTools)
library(Hmisc)
library(multcomp)
library(haven)

rm(list = ls())

#open file
LD <- read.csv("learningdisabilityR1.csv", header=T)                         
#check data integrity
head(LD)
tail(LD)
dim(LD)
names(LD)
summary(LD)
psych::describe(LD)

#Let's subset the data
controlDat <- subset(LD, LD$group=="control")
RDDat <- subset(LD, LD$group=="RD")
ADDat <- subset(LD, LD$group=="AD")
RADDat <- subset(LD, LD$group=="RAD")

##QUESTION 1
psych::describe(ADDat)
psych::describe(RDDat)
psych::describe(RADDat)
psych::describe(controlDat)

#We first plot the data, making histograms for each group separately with a group-specific normal curve. 
hist.control <- ggplot(controlDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum controls", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(controlDat$trailnum, na.rm = TRUE), sd = sd(controlDat$trailnum, na.rm = 
                TRUE)), colour = "red", size = 1)    

hist.RD <- ggplot(RDDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum RD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RDDat$trailnum, na.rm = TRUE), sd = sd(RDDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)         

hist.AD <- ggplot(ADDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum AD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(ADDat$trailnum, na.rm = TRUE), sd = sd(ADDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)             

hist.RAD <- ggplot(RADDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum RAD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RADDat$trailnum, na.rm = TRUE), sd = sd(RADDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)

hist.all <- arrangeGrob(hist.control,hist.RD, hist.AD,hist.RAD,ncol=2,nrow=2)
grid.draw(hist.all) # interactive device
ggsave("hist_all_LD.pdf", hist.all) 

#Let's test for normality of the trailnum scores in the 4 groups
by(LD$trailnum, LD$group, shapiro.test)
#Let's test for homogeneity of the trailnum scores in the 4 groups
leveneTest(LD$trailnum,
           LD$group,center=mean)
###As there is a normality violation, therefore an outlier is present, let's find out what is is
boxplot <- boxplot(LD$trailnum ~ LD$group, xlab="Group", ylab="Trailnum Score")
boxplot$out
# 41, 55, 46

#Let's get rid of outliers
LD$trailnum <- ifelse(LD$trailnum==41, NA, LD$trailnum)
LD$trailnum <- ifelse(LD$trailnum==55, NA, LD$trailnum)
LD$trailnum <- ifelse(LD$trailnum==46, NA, LD$trailnum)

#Let's check that the outliers are gone
boxplot <- boxplot(LD$trailnum ~ LD$group, xlab="Group", ylab="Trailnum Score")

#We now plot the data again, making histograms for each group separately with a group-specific normal curve. 
hist.control <- ggplot(controlDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum controls", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(controlDat$trailnum, na.rm = TRUE), sd = sd(controlDat$trailnum, na.rm = 
                                                                                                   TRUE)), colour = "red", size = 1)    

hist.RD <- ggplot(RDDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum RD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RDDat$trailnum, na.rm = TRUE), sd = sd(RDDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)         

hist.AD <- ggplot(ADDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum AD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(ADDat$trailnum, na.rm = TRUE), sd = sd(ADDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)             

hist.RAD <- ggplot(RADDat, aes(trailnum)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnum RAD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RADDat$trailnum, na.rm = TRUE), sd = sd(RADDat$trailnum, na.rm = TRUE)), 
                colour = "red", size = 1)

hist.all <- arrangeGrob(hist.control,hist.RD, hist.AD,hist.RAD,ncol=2,nrow=2)
grid.draw(hist.all) # interactive device
ggsave("hist_all_LD.pdf", hist.all) 

#Let's test for normality again of the trailnum scores in the 4 groups
by(LD$trailnum, LD$group, shapiro.test)

#Let's check for homogeneity again
leveneTest(LD$trailnum,
           LD$group,center=mean)

#Let's perform the Welsch test
NRmodel2 <- oneway.test(trailnum ~ group, data=LD)
NRmodel2

#Let's perform the Bonferroni corrected pairwise post hoc test
LD$group <- factor(LD$group, levels = c("control","RD","AD","RAD"))
print(levels(as.factor(LD$group)))
pairwise.t.test(LD$trailnum, LD$group, p.adjust.method="bonferroni")

#Let's make qq-plots for our data for visualisation
qq.CD <- ggplot(controlDat, aes(sample=trailnum))+ggtitle("Control")+stat_qq() + stat_qq_line ()  
qq.RD <- ggplot(RDDat, aes(sample=trailnum))+ggtitle("RD")+stat_qq() + stat_qq_line ()
qq.AD <- ggplot(ADDat, aes(sample=trailnum))+ggtitle("AD")+stat_qq() + stat_qq_line ()
qq.RAD <- ggplot(RADDat, aes(sample=trailnum))+ggtitle("RAD")+stat_qq() + stat_qq_line ()

qq.all <- arrangeGrob(qq.CD,qq.RD, qq.AD,qq.RAD,ncol=2,nrow=2)
grid.draw(qq.all)

#Let's make error bar plots for data visualisation
err.Count <- ggplot(LD,aes(group,trailnum)) +  stat_summary(fun=mean,geom="point") +  stat_summary(fun=mean, geom="line", aes(group=1), colour= "Blue", linetype="dashed") +  stat_summary(fun.data=mean_cl_boot, geom="errorbar", width=.2) +  labs(x="Groups", y="Mean Trail Making task")
err.Count

##QUESTION 2
psych::describe(ADDat)
psych::describe(RDDat)
psych::describe(RADDat)
psych::describe(controlDat)

#We first plot the data, making histograms for each group separately with a group-specific normal curve. 
hist.control <- ggplot(controlDat, aes(trailnumlet)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnumlet controls", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(controlDat$trailnumlet, na.rm = TRUE), sd = sd(controlDat$trailnumlet, na.rm = 
                                                                                                   TRUE)), colour = "red", size = 1) 

hist.RD <- ggplot(RDDat, aes(trailnumlet)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnumlet RD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RDDat$trailnumlet, na.rm = TRUE), sd = sd(RDDat$trailnumlet, na.rm = TRUE)), 
                colour = "red", size = 1)         

hist.AD <- ggplot(ADDat, aes(trailnumlet)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnumlet AD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(ADDat$trailnumlet, na.rm = TRUE), sd = sd(ADDat$trailnumlet, na.rm = TRUE)), 
                colour = "red", size = 1)             

hist.RAD <- ggplot(RADDat, aes(trailnumlet)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=10) + 
  labs(x = "Trailnumlet RAD", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(RADDat$trailnumlet, na.rm = TRUE), sd = sd(RADDat$trailnumlet, na.rm = TRUE)), 
                colour = "red", size = 1)

hist.all <- arrangeGrob(hist.control,hist.RD, hist.AD,hist.RAD,ncol=2,nrow=2)
grid.draw(hist.all) 
ggsave("hist_all_LD.pdf", hist.all) 

#Let's test for normality of the trailnumlet scores in the 4 groups
by(LD$trailnumlet, LD$group, shapiro.test)
#Let's test for homogeneity of the trailnumlet scores in the 4 groups
leveneTest(LD$trailnumlet, LD$group, center=mean)

#Let's perform one-way ANOVA
new_model = aov(trailnumlet~group, data = LD, na.action = na.exclude)
summary(new_model)

#Let's perform the Bonferroni corrected pairwise post hoc test
LD$group <- factor(LD$group, levels = c("control","RD","AD","RAD"))
print(levels(as.factor(LD$group)))
pairwise.t.test(LD$trailnumlet, LD$group, p.adjust.method="bonferroni")

#Let's make qq-plots for our data for visualisation
qq.CD <- ggplot(controlDat, aes(sample=trailnumlet))+ggtitle("Control")+stat_qq() + stat_qq_line ()  
qq.RD <- ggplot(RDDat, aes(sample=trailnumlet))+ggtitle("RD")+stat_qq() + stat_qq_line ()
qq.AD <- ggplot(ADDat, aes(sample=trailnumlet))+ggtitle("AD")+stat_qq() + stat_qq_line ()
qq.RAD <- ggplot(RADDat, aes(sample=trailnumlet))+ggtitle("RAD")+stat_qq() + stat_qq_line ()

qq.all <- arrangeGrob(qq.CD,qq.RD, qq.AD,qq.RAD,ncol=2,nrow=2)
grid.draw(qq.all)

#Let's make error bar plots for data visualisation
err.Count <- ggplot(LD,aes(group,trailnumlet)) +  stat_summary(fun=mean,geom="point") +  stat_summary(fun=mean, geom="line", aes(group=1), colour= "Blue", linetype="dashed") +  stat_summary(fun.data=mean_cl_boot, geom="errorbar", width=.2) +  labs(x="Groups", y="Mean Trail Making task")
err.Count

#QUESTION 3
rm(list = ls())

#Open file
IQgene <- read.csv("IQgene.csv", header=T)                         

#Check data integrity
head(IQgene)
tail(IQgene)
dim(IQgene)
names(IQgene)
summary(IQgene)
psych::describe(IQgene)

#Let's define group as a factor
IQgene$group <- factor(IQgene$group,levels=c(1:3), labels = c("aa","Aa","AA"))

#Check order levels
print(levels(IQgene$group))

# Subset the data
aaDat<-subset(IQgene, IQgene$group=="aa")
AaDat<-subset(IQgene, IQgene$group=="Aa")
AADat<-subset(IQgene, IQgene$group=="AA")

# Histograms of the data in the 3 groups separately
hist.aa <- ggplot(aaDat, aes(IQ)) +  ggtitle("aa") +  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) +   labs(x = "IQ scores aa", y = "Density")  +           stat_function(fun = dnorm, args = list(mean = mean(aaDat$IQ, na.rm = TRUE), sd = sd(aaDat$IQ, na.rm = TRUE)), colour = "red", size = 1)
hist.Aa <- ggplot(AaDat, aes(IQ)) +  ggtitle("Aa") +  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) +   labs(x = "IQ scores Aa", y = "Density")  +           stat_function(fun = dnorm, args = list(mean = mean(AaDat$IQ, na.rm = TRUE), sd = sd(AaDat$IQ, na.rm = TRUE)), colour = "red", size = 1)
hist.AA <- ggplot(AADat, aes(IQ)) +  ggtitle("AA") +  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) +   labs(x = "IQ scores AA", y = "Density")  +           stat_function(fun = dnorm, args = list(mean = mean(AADat$IQ, na.rm = TRUE), sd = sd(AADat$IQ, na.rm = TRUE)), colour = "red", size = 1)
hist.all <- arrangeGrob(hist.aa,hist.Aa, hist.AA,ncol=3,nrow=1)
grid.draw(hist.all) # interactive device
ggsave("hist_IQgene.pdf", hist.all) # need to specify what to save explicitely

#QQ-plots to of the data in the 3 groups separately
qq.aa <- ggplot(aaDat, aes(sample=IQ))+ggtitle("aa")+stat_qq() + stat_qq_line ()     
qq.Aa <- ggplot(AaDat, aes(sample=IQ))+ggtitle("Aa")+stat_qq() + stat_qq_line ()     
qq.AA <- ggplot(AADat, aes(sample=IQ))+ggtitle("AA")+stat_qq() + stat_qq_line ()     

qq.all <- arrangeGrob(qq.aa,qq.Aa, qq.AA,ncol=3,nrow=1)
grid.draw(qq.all) # interactive device
ggsave("qq_IQgene.pdf", qq.all) # need to specify what to save explicitely

#Let's test for normality
by(IQgene$IQ,IQgene$group,shapiro.test)

#Let's describe the statistics per group
describeBy(aaDat$IQ)
describeBy(AaDat$IQ)
describeBy(AADat$IQ)

# Levene test
leveneTest(IQgene$IQ,IQgene$group,center=mean)
# Error-bar plot
err.Count <- ggplot(IQgene,aes(group,IQ)) +  stat_summary(fun=mean,geom="point") +  stat_summary(fun=mean, geom="line", aes(group=1), colour= "Blue", linetype="dashed") +   stat_summary(fun.data=mean_cl_boot, geom="errorbar", width=.2) +  labs(x="Groups", y="Mean IQ scores")
err.Count

### planned contrasts
print(levels(IQgene$group))
#We want the order to be in 'decreasing order'
IQgene$group <- factor(IQgene$group,levels(IQgene$group)[c(3,2,1)])
print(levels(IQgene$group))
#Let's define default R contrast
contrast1 <- c(-2,1,1)
contrast2 <- c(0,-1,1)
contrasts(IQgene$group) <-cbind(contrast1,contrast2)

IQgene$group
IQmodel <- aov(IQ ~ group, data=IQgene, na.action=na.exclude)
summary(IQmodel)
#Get contrast results
summary.lm(IQmodel)
