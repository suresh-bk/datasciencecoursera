# Course 3 - Getting and Cleaning Data Project
This document describes step by step what the R code in the file Run_Analysis.R

1. The R code is written with the assumption that the zip file is downloaded to the working directory and hence the file paths are maintained

## Step 1 - Reading the training and testing data sets

Step 1.1. Read the training and test data sets X_*.txt, Y_*.txt and subject_*.txt and merge them using column bind function cbind

Step 1.2. Merge the training and test data sets using row bind function rbind

## Step 2 - Setting the column titles and extracting only mean and standard deviation columns

Step 2.1. Read the features text file that has the column titles for the readings
Step 2.2. Tidy the values by remvoing the speacial characters and converting all to lower case for convenience
Step 2.3. Create a character vector from the features data frame and append to it the column titles for activity and subject
Step 2.4. Set the column names to the combined training and test data set which is referred to as alldata
Step 2.5. Extract only those columns that have the mean and standard deviation readings and the activity and subject columns

## Step 3 - Set activity id to activity label
Step 3.1. Read the  activity label file
Step 3.2. By comparing the activity id in alldata and activity label replace activity id with activity name in alldata data set

## Step 4 - Computing the means
Step 4.1. Compute the mean of all columns in the data set grouped by activty and subject

## Step 5 - Tidying the data and writing to a file
Step 5.1. Using the gather function collapse the data set into 4 columns - activity, subject, variable and mean
Step 5.2. Write the output of 5.1 into a file. End of function



