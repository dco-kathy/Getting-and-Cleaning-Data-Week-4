#Kathy Fontaine, May 4, 2020
#written in R version 3.6.3
#data was extracted from 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#on April 20, 2020.

#Use of this dataset in publications must be acknowledged by referencing the following publication:
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support 
#Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
#Spain. Dec 2012

#This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed 
#to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
#Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

#beginning of code
#sets my working directory, removes extraneous variables, and loads the tidyverse package
setwd("~/Desktop/Coursera/R Programming/Getting and Cleaning Data/UCI HAR Dataset")
rm(list = ls())
library(tidyverse)
library(stringr)

#reads in the features file to get the Sensor Measurements and Activity Names
columns <- read.table("features.txt", header = FALSE)
columns$V1 <- NULL
colnames(columns) <- "SensorMeasurements"
SensorMeasurements <- t(columns)
colnames(SensorMeasurements) <- SensorMeasurements[1 ,]
ActivityNames <- read.table("activity_labels.txt", header = FALSE, col.names = c("Activity Number", "Activity"))

#read subject files
SubjectTest <- read.table("test/subject_test.txt", header = FALSE, col.names = "ID")
SubjectTrain <- read.table("train/subject_train.txt", header = FALSE, col.names = "ID")

#read activity files
ActivityTest <- read.table("test/y_test.txt", header = FALSE, col.names = "ActivityNames")
ActivityTrain <- read.table("train/y_train.txt", header = FALSE, col.names = "ActivityNames")

#read feature files
FeatureTest <- read.table("test/X_test.txt", header = FALSE, col.names = c(SensorMeasurements))
FeatureTrain <- read.table("train/X_train.txt", header = FALSE, col.names = c(SensorMeasurements))

#combine all Test and Train files into one file
All_Test <- cbind(SubjectTest, ActivityTest, FeatureTest)
All_Train <- cbind(SubjectTrain, ActivityTrain, FeatureTrain)

#combine all files into one large data set
CombinedData <- merge(All_Test, All_Train, all = TRUE)

#extract the data for each column
newmean <- select(CombinedData, contains(".mean."))
newstd <- select(CombinedData, contains(".std"))
newID <- select(CombinedData, contains("ID"))
newActivity <- select(CombinedData, contains("ActivityNames"))

#renames the Activities so they make sense
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "1", "Walking")
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "2", "Walking Upstairs")
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "3", "Walking Downstairs")
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "4", "Sitting")
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "5", "Standing")
newActivity$ActivityNames = str_replace_all(newActivity$ActivityNames, "6", "Laying")

ExtractedData <- cbind(newID, newActivity, newmean, newstd)

#renames the Sensor Measurements so they make sense
names(ExtractedData) <- gsub("^t", "time", names(ExtractedData))
names(ExtractedData) <- gsub("BodyBody", "Body", names(ExtractedData))
names(ExtractedData) <- gsub("Acc", "Accelerometer", names(ExtractedData))
names(ExtractedData) <- gsub("Gyro", "Gyroscope", names(ExtractedData))
names(ExtractedData) <- gsub("Mag", "Magnitude", names(ExtractedData))
names(ExtractedData) <- gsub("^f", "frequency", names(ExtractedData))

#creates the mean data grouped by person (ID) and what they did (ActivityNames)
FinalResults <- aggregate(. ~ID + ActivityNames, ExtractedData, mean)
FinalResults <- FinalResults[order(FinalResults$ID, FinalResults$ActivityNames), ]

#save as a tidy data set
write.table(FinalResults, file = "tidydataset.txt", row.names = FALSE)

#end of code


