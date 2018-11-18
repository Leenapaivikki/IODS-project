# author: Leenapaivikki
# date: 17112018  
# This file contains the script of the Exercise 3 of IODS course.
# Clear memory.
rm(list = ls())
# R package required by this script is loaded.
# Access the dplyr library
library(dplyr)
#Set the working directory
setwd("~/GitHub/IODS-project/data")
#Read both student-mat.csv and student-por.csv into R (from the data folder)
math <- as.data.frame(read.table('student-mat.csv',  sep=";", header=TRUE))
por <- as.data.frame(read.table('student-por.csv',  sep=";", header=TRUE))
#Explore the structure and dimensions of the data
glimpse(math)
glimpse(por)
# Join the two data sets using the variables as (student) identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# Join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix=c(".math",".por"))
#Explore the structure and dimensions of the data at the dataset
glimpse(math_por)
# Create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))
# The columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
# Glimpse at the new combined data
glimpse(alc)

# Take the average (of weekends and weekdays) alcohol consumption.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# create a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse the structure and dimensions of the new dataframe
glimpse(alc)

# Write the dataframe into a file
write.table(alc, file = "alc.csv", sep = "\t", col.names = TRUE)


