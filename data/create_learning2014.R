# author: Leenapaivikki
# date: 08112018  
# This file contains the R script of the Exercise 2 of IODS course.
# Clear memory.
rm(list = ls())
# R package required by this script is loaded.
# Access the dplyr library
library(dplyr)
# The requested data file to a DF learning2014 is loaded.
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)
# Dimension (dim) lists the content of the data:
#the number of the observations (rows) is 183 and
#the number of the variables (columns) is 60.
dim(learning2014)
#Structure (str) extracts the first couple of
#entries from an object. Other variables are numeric 
#except the gender which is character
#type with 2 levels. 
str(learning2014)
#All observations with zero points are filtered.
learning2014 <- filter(learning2014, Points > 0)
#A new dataframe is created.
learning2014v2 <- select(learning2014, one_of(c("gender", "Age", "Attitude", "Points")))
# Convert all analysis DF variable names to lowercase:
names(learning2014v2) <- tolower(names(learning2014v2))

#All questions that became part of the averaged variables are dedined.
#These definitions are copied from IODS material in DataCamp
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

#The averaged variables are added to the data frame
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014v2$deep <- rowMeans(deep_columns)
stra_columns <- select(learning2014, one_of(strategic_questions))
learning2014v2$stra <- rowMeans(stra_columns)
surf_columns <- select(learning2014, one_of(surface_questions))
learning2014v2$surf <- rowMeans(surf_columns)

#Download the output into a file
write.table(learning2014v2, file = "learning2014.csv", sep = "\t", col.names = TRUE)
# Read the file back in and show its structure to demonstrate the process.
learning2014v2 <- as.data.frame(read.table('learning2014.csv',  sep="\t", header=TRUE))
# The structure of the newly created dataframe learning2014v2 is shown.
str(learning2014v2)
# The first then rows are shown of the newly created dataframe learning2014v2.
head(learning2014v2, n = 10)



