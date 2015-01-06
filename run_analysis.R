##get data from the internet

##THIS FUNCTION DOES NOT WORK PROPERLY YET...NOT HANDLING THE ZIP FILE CORRECTLY
download<-function(){

  if (!file.exists("project")){  # if data directory exists. true nothing happens
    dir.create("project")        # if false, creates directory
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = "./project/dataset.zip")  
  }
    
  unz_data <- unzip("./project/dataset.zip")
  head(unz_data)
  
}