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
subsetdata2<-subsetdata1[, -grep("freq|angle", names(subsetdata1))] #Removes the variables that deal with meanfrequency and angle which are not pertinent to the exercise
subsetdata2$activity<-gsub(1, "walking", subsetdata2$activity) #Changes activities to a more descriptive label
subsetdata2$activity<-gsub(2, "walking upstairs", subsetdata2$activity)
subsetdata2$activity<-gsub(3, "walking downstairs", subsetdata2$activity)
subsetdata2$activity<-gsub(4, "sitting", subsetdata2$activity)
subsetdata2$activity<-gsub(5, "standing", subsetdata2$activity)
subsetdata2$activity<-gsub(6, "laying", subsetdata2$activity)




splitdata<-split(subsetdata2, subsetdata2$subject)#Splits the data by subject for further transformation 
splitfunct<-function(x) {splitdata2<-split(x, x$activity) #A function to split the data by activity which...
                    as.data.frame(lapply(splitdata2, function(x) colMeans(x[,1:66])))} 
newvariables<-lapply(splitdata, splitfunct) #Will be used to split the data of each subject by activity
tidyup<-function(x) {meanframe<-data.frame() #And then a function to produce an overall data set
                     framefunc<-function(x) {
                        loopframe<-t(x)   #Sets the columns as rows, as that was an issue prior
                        meanframe<-rbind(meanframe, loopframe)}
tidylist<-lapply(newvariables, FUN = framefunc)
do.call(rbind, tidylist) #This is particularly important as it properly binds the data as a data frame
}
tidyframe<-tidyup(newvariables) #Runs the function
rownames(tidyframe)<-gsub("\\.", "/", rownames(tidyframe)) #This changes the dot as a backslash but it requires to set . as literal with \\ 
