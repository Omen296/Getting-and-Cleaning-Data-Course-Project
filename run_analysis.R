X_test<-read.table("./UCI HAR Dataset/test/X_test.txt") #Loads X_test as a table, which contains all test observations.
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt") #Loads Y_test, which contains the activity of each observation
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt") #Loads the ID of the subject of each observation
test<-cbind(X_test, Y_test, subject_test) #Binds them
test$set<-"test" #Creates a variable that identifies the set from which they come

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt") #Loads X_test as a table, which contains all test observations.
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt") #Loads Y_test, which contains the activity of each observation
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt") #Loads the ID of the subject of each observation
train<-cbind(X_train, Y_train, subject_train) #Bind
train$set<-"train" #Creates a variable that identifies from where they come

complete<-rbind(test, train) #Binds both sets to create a complete version

features<-read.table("./UCI HAR Dataset/features.txt") #Reads the features table, which will serve as the colnames for the broader dataset
colnames<-tolower(as.vector(features[,2])) #Changes the matrix to a vector with the names in lowercase
names(complete)<-c(colnames, "activity", "subject", "set") #Names all the variables

subsetdata1<-complete[, c(grep("mean()|std()", colnames), 562:564)] #subsets the variables that have anything to do with deviation or means through the column names and also the ones that provide the ID, activity and set
subsetdata2<-subsetdata1[, -grep("freq|angle", names(subsetdata1))] #Removes the vairables that deal with meanfrequency and angle whichh are not pertinent to the exercise


#Tidy the dataset and go to item 5
#Then we have to pick between a tall or a wide dataset, the tall one is sub+var as each observation while the wide is subject and each activity variable mean. I prefer wide.
#Regarless, we can obtain that with table, or split or just use dplyr


?read.table
