# author: Leenapaivikki
# date: 23112018  
# This file contains the script of the Exercise 4 (wrangling 5) of IODS course.
# The exercise in based on data from: United Nations Human Development Report 2015:
# Human Development Index (HDI; http://hdr.undp.org/en/composite/HDI
# Gender Inequality Index (GII; http://hdr.undp.org/en/composite/GII
# Clear memory.
rm(list = ls())
# R packages required by this script is loaded.
library(dplyr)
library(stringr)
#Set the working directory
setwd("~/GitHub/IODS-project/data")
#Read the "Human development" and "Gender inequality" datas into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
# Glimpse at the datasets: see the structure and dimensions of the data
glimpse(hd)
glimpse(gii)
#Create summaries of the variables
summary(hd)
summary(gii)
# Rename the variables with (shorter) descriptive names
names(hd)[1] <- 'hdi_r'
names(hd)[2] <- 'country'
names(hd)[3] <- 'hdi'
names(hd)[4] <- 'life_exp'
names(hd)[5] <- 'edu_exp'
names(hd)[6] <- 'edu_mean'
names(hd)[7] <- 'gni_cap'
names(hd)[8] <- 'gni_r_hdi_r'
# Rename the variables with (shorter) descriptive names
names(gii)[1] <- 'gii_r'
names(gii)[2] <- 'country'
names(gii)[3] <- 'gii'
names(gii)[4] <- 'mat_mor'
names(gii)[5] <- 'ado_birth'
names(gii)[6] <- 'parli_f'
names(gii)[7] <- 'edu2_f'
names(gii)[8] <- 'edu2_m'
names(gii)[9] <- 'labo_f'
names(gii)[10] <- 'labo_m'
# Mutate the "Gender inequality" data and create two new variables.
# The first new variable is a ratio of Female and Male populations with secondary education in each country. 
gii <- mutate(gii, edu2_f_m = edu2_f/edu2_m)
# The secon new variable is a ratio of labour force participation of females and males in each country
gii <- mutate(gii, labo_f_m = labo_f/labo_m)
# Join together the two datasets using the variable Country as the identifier. 
human <- inner_join(hd, gii, by = 'country')
# Write the joined dataframe into a file.
write.table(human, file = "human.csv", sep = "\t", col.names = TRUE)
glimpse(human)