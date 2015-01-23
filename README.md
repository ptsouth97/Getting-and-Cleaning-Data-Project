Getting-and-Cleaning-Data-Project
=================================

Requires package stringr

How the code works:

Unzips the data in the working directory

Reads in test and train values then merge them

Labels the data columns with values from the 'features' file after cleaning them by converting to lowercase and removing punctuation

Matches only the columns that contain mean or std

Subsets the columns that contain both mean and std values

Reads, combines, and labels activity info

Reads and combines subject info

Combines activity and subject columns

Combines the activity/subject data frame with the subsetted values data frame

Initializes a data frame to hold the tidy data

Loops through each subject, each activity, and each column in order to id the subject, activity, and then take the average for each subset

Writes the tidy data to a .txt file

Reads the .txt file and presents it in more viewable format
