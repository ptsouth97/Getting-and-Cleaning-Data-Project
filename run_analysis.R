run_analysis<-function(){
  
  # unzip the data in the working directory
  unz_data <- unzip("getdata-projectfiles-UCI HAR Dataset.zip")
  
  # Read in test and train values then merge them
  x_test <- read.table(unz_data[15])
  x_train <- read.table(unz_data[27])
  x <- merge(x_test, x_train, all=TRUE)
  
  # label the data columns with values from the 'features' file after cleaning them
  features <- read.table(unz_data[2])
  col_labels <- make.names(features[,2])
  lowercase_labels <- tolower(col_labels)
  punctuation_removed_labels <- str_replace_all(lowercase_labels, "[[:punct:]]","")
  names(x)<-punctuation_removed_labels
  
  # find only the columns that contain mean or std
  mean <- grep("mean", names(x))
  std <- grep("std", names(x))
  both <- c(std,mean)
  both_ordered <- sort(both)
  
  # subset the columns that contain both mean and std values
  subset <- x[,both_ordered]
  
  # Read ,combine, and label activity info
  y_test <- read.table(unz_data[16])  
  y_train <- read.table(unz_data[28])  
  y <- rbind(y_test, y_train)
  names(y)<-paste("Activity")
  
  # Read and combine subject info
  subject_test <- read.table(unz_data[14])
  subject_train <- read.table(unz_data[26])
  subject <- rbind(subject_test, subject_train)
  names(subject)<-paste("Subject")
  
  # combine activity and subject columns...
  combo <- cbind(subject, y)
  
  # combine the activity/subject data frame with the subsetted values data frame
  tidy1 <- cbind(combo, subset)
  
  # initialize tidy2 data frame
  tidy2 <- data.frame(matrix(ncol = 88, nrow = 180))
  names(tidy2) <- names(tidy1)
  
  # loop through each subject
  for(i in 1:30){ 
      reg_exp <- paste("^", i, "$", sep = "")
      which_subject <- grep(reg_exp, subject[,1])
      subject_subset <- tidy1[which_subject,]
      
      # loop through each activity
      for(j in 1:6){
          reg_exp2 <- paste("^", j, "$", sep = "")
          which_activity <- grep(reg_exp2, subject_subset[,2])
          activity_subset <- subject_subset[which_activity,]
          
          # loop through each column and....
          for(k in 1:88){       
              # id the subject, and...
              if(k == 1){
                  tidy2[6*i-(6-j),k] <- i    
              }
              # id the activity, and...
              if(k == 2){
                  if(j==1){tidy2[6*i-(6-j),k] <- "walking"}
                  if(j==2){tidy2[6*i-(6-j),k] <- "walking_upstairs"}
                  if(j==3){tidy2[6*i-(6-j),k] <- "walking_downstairs"}
                  if(j==4){tidy2[6*i-(6-j),k] <- "sitting"}
                  if(j==5){tidy2[6*i-(6-j),k] <- "standing"}
                  if(j==6){tidy2[6*i-(6-j),k] <- "laying"}
              }
              # take the average for each subset
              else{
                  tidy2[6*i-(6-j),k] <- mean(activity_subset[,k])
              }
          }
      }
  }
  write.table(tidy2, "project_output.txt", row.name=FALSE)
  data <- read.table("project_output.txt", header = TRUE)
  View(data)
}  


  
  
  
  
