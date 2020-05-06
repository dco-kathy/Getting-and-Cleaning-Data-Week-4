This file explains the code in run_analysis.R.  All related code and files are at 

The code was written in R version 3.6.3
Data was extracted from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on April 20, 2020.

The following information appears with this data set:
"Use of this dataset in publications must be acknowledged by referencing the following publication:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support 
Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012."   
More detailed information is contained in the code book.

run_analysis.R takes the above file and does the following:
1. reads in all text files
2. collects and combines training, test, activity, and subject data into 4 larger files
3. combines all into one large file
4. extracts measurements on the mean and standard deviation
5. changes the column headings and activity values so they are readable
6. creates a tidy data set with the average of each variable for each activity and each subject, in subject order.

The code book for this project is in the file Week4_Project_CodeBook.md

Original files used for this project after unzipping the above are:
activity_labels.txt
features.txt
features_info.txt
README.txt

and additional files within the 'test' and 'train' folders.