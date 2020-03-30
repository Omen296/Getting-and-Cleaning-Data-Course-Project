

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt") #Loads X_test as a table, which contains all test observations.
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt") #Loads Y_test, which contains the activity of each observation
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt") #Loads the ID of the subject of each observation



X_train<-read.table("./UCI HAR Dataset/train/X_train.txt") #Loads X_test as a table, which contains all test observations.
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt") #Loads Y_test, which contains the activity of each observation
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt") #Loads the ID of the subject of each observation
  
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
  
features<-read.table("./UCI HAR Dataset/features.txt") #Reads the features table, which will serve as the colnames for the broader dataset

#Make features the column name of both train and test
#extract the things we want with the text recognizing function to get the columns with the means and std, and the ones for subjects and activities. 
#bind them with cbind and rbind

#Then we have to pick between a tall or a wide dataset, the tall one is sub+var as each observation while the wide is subject and each activity variable mean. I prefer wide.

?read.table
