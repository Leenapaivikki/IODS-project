# author: Leena Huiku
# date: 06122018  
# original data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# original data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt
# Clear memory
rm(list = ls())
# R packages required by this script is loaded.
library(dplyr)
library(tidyr)
library(ggplot2)
#Set the working directory
setwd("~/GitHub/IODS-project/data")
#Read the "BPRS" and "RATS" datas into R
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep  =" ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep  ='\t')
# Look at the (column) names of datasets
names(BPRS)
names(RATS)
# Look at the structure of datasets
str(BPRS)
str(RATS)
# Create summaries of the variables
summary(BPRS)
summary(RATS)
# Convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))
# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))
#Now, take a serious look at the new data sets and compare them with
#their wide form versions: check the variable names, view the data
#contents and structures, and create some brief summaries of the variables.
#Make sure that you understand the point of the long form data and the crucial
#difference between the wide and the long forms before proceeding the to Analysis exercise.
names(BPRSL)
names(RATSL)
# Look at the structure of datasets
str(BPRSL)
str(RATSL)
# Create summaries of the variables
summary(BPRSL)
summary(RATSL)

