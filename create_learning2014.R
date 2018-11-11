#author: Leenapaivikki
#date: 08112018  
#This file contains the script of the Exercise 2 of IODS course.
# R package required by this script.
library(dplyr)
# Load the requested data file to a dataframe learning2014
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)
#Function dimension (dim) lists the content of the data: the number of the observations (rows) is 183 and the number of the variables (columns) is 60.
dim(learning2014)
#Function structure (str) extracts the first couple of entries from an object. other variables are numeric except the gender which is character type with 2 level. 
str(learning2014)
#All observations with zero points are filtered.
learning2014 <- filter(learning2014, Point > 0)
#A new dataframe is created. Columns that are not averaged are to be kept.
learning2014_v2 <- select(learning2014, one_of(c("Age", "Attitude", "Points", "gender")))
#All dataframe variable names are lowercased.
names(learning2014_v2) <- tolower(names(learning2014_v2))
#All questions that became part of the averaged variables are dedined.
#These definitions are copied from IODS material in DataCamp
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
#The averaged variables are added to the data frame
learning2014_v2$deep <- rowMeans(select(learning2014_v2, one_of(deep_questions)))
learning2014_v2$stra <- rowMeans(select(learning2014_v2, one_of(surface_questions)))
learning2014-v2$surf <- rowMeans(select(learning2014_v2, one_of(strategic_questions)))
#Download the output into a file
write.table(learning2014_v2, file = "learning2014.csv", sep = "\t", col.names = TRUE)

