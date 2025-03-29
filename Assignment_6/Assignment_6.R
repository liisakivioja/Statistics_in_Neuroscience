### 0.1 - Clear existing workspace objects 
rm(list = ls())

### 0.2 - Set working directory to where the data file is located & results should be saved (change to your own directory)
setwd("C:\\Users\\Liisa\\Documents\\Statistics in Neuroscience\\Script 6")

### 0.3 - Install packages
install.packages("ggplot2", dependencies=TRUE)
install.packages("gridExtra",dependencies = TRUE)
install.packages("grid",dependencies = TRUE)
install.packages("gmodels",dependencies = TRUE)
install.packages("MASS",dependencies = TRUE)
install.packages("psych",dependencies = TRUE)
install.packages("nlme",dependencies = TRUE)
install.packages("reshape",dependencies = TRUE)

### 0.4 - Load this week's packages
library(ggplot2)
library(gridExtra)
library(grid)
library(gmodels)
library(MASS)
library(psych)
library(nlme)
library(reshape)

########################################################
########################################################
#  1. m u l t i l e v e l    a n a l y s i s  : TYPE I
########################################################
########################################################

MLex<-read.csv("MLexample.csv",header=T)

head(MLex)
tail(MLex)
dim(MLex)
names(MLex)
summary(MLex)
psych::describe(MLex)

# Define factors
MLex$mouseID <- factor(MLex$mouseID,levels=c(1:20), labels = c(1:20))
MLex$condition <- factor(MLex$condition,levels=c(0,1), labels = c("control","experimental"))

# Check order of the levels of the factor
print(levels(MLex$condition))


######################
# Scatterplot

scat.protein <- ggplot(MLex,aes(mouseID, protein, colour=condition)) +
  ggtitle("Scatterplot") +
  geom_point(shape=19, size=3) + labs(x="mouseID", y="Protein levels") 

scat.all <- arrangeGrob(scat.protein,ncol=1,nrow=1)
grid.draw(scat.all) # interactive device
ggsave("scat_protein.pdf", scat.all) # need to specify what to save explicitly

####################
# Create histograms

ConDat <-subset(MLex,MLex$condition=="control")
ExpDat <-subset(MLex,MLex$condition=="experimental")


hist.con <- ggplot(ConDat, aes(protein)) +
  ggtitle("Histogram Controls")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Protein Levels", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(ConDat$protein, na.rm = TRUE), sd = sd(ConDat$protein, na.rm = TRUE)), colour = "red", size = 1)

hist.exp <- ggplot(ExpDat, aes(protein)) +
  ggtitle("Histogram Experimental")+
  geom_histogram(aes(y=..density..), colour="black", fill="white",bins=7) + 
  labs(x = "Protein Levels", y = "Density")  +         
  stat_function(fun = dnorm, args = list(mean = mean(ExpDat$protein, na.rm = TRUE), sd = sd(ExpDat$protein, na.rm = TRUE)), colour = "red", size = 1)

hist.all <- arrangeGrob(hist.con,hist.exp,ncol=2,nrow=1)
grid.draw(hist.all) # interactive device
ggsave("hist_protein.pdf", hist.all) # need to specify what to save explicitly

############################
# Describe length by levels of genotype
by(MLex$protein, MLex$condition, psych::describe)


############################
# Normality per genotype group
by(MLex$protein, MLex$condition, shapiro.test)

####################################
# Intercept-only model

# Fixed intercept
IntOnly<-gls(protein ~ 1, data=MLex, method="ML")

summary(IntOnly)

# Random intercept
RandomIntOnly<-lme(protein ~ 1, data=MLex, random= ~1|mouseID, method="ML")

summary(RandomIntOnly)

# Compare fit
anova(IntOnly,RandomIntOnly)

# ICC - see practical 6 for what to fill In!

ICC = (0.3444504^2)/((0.3444504^2)+(1.90303^2))
ICC

###############################################
# Model including condition as predictor

# Random intercept and condition as predictor
Conditionmod<-lme(protein ~ condition, data=MLex, random= ~1|mouseID ,method="ML")

summary(Conditionmod)

# Compare fit
anova(RandomIntOnly,Conditionmod)

# ICC - see practical 6 for what to fill in!

ICC2= (0.3071943^2)/((0.3071943^2)+(1.90303^2))
ICC2
###############################################
# Regular t-test

ttestCond <-t.test(protein ~ condition, data=MLex, alternative="two.sided", var.equal=F, paired=F)
ttestCond

###############################################
# Calculate effective sample size

Ntot=2000
ICC=0.0317
n=100

neff=Ntot/(1+(n-1)*ICC)
neff

#The change in ICCs:
change = ICC - ICC2
change
