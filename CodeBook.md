Getting and Cleaning Data Codebook
==================================

Source of the Data
------------------

The data set comes from the UCI Machine Learning Repository, using the
one provided in Human Activity Recognition Using Smartphones Data Set,
which comes from a set of experiments in which 30 volunteers aged
between 19 to 48 years performed 6 different activities wearing a
Samsung Galaxy SII smartphone. Using the data from its embedded
accelerometer and gyroscope, the data provides 3-axial linear
acceleration and 3-axial angular velocity at a constant rate of 50Hz,
which later received further transformations explained in the page of
the data set. The data set was also divided into test and training data
in a proportion of 3:7.

The provided citation for the data set is: Davide Anguita, Alessandro
Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain
Dataset for Human Activity Recognition Using Smartphones. 21th European
Symposium on Artificial Neural Networks, Computational Intelligence and
Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

Charasteristics of the data set prior to being transformed
----------------------------------------------------------

According to the website:

“For each record in the dataset it is provided: - Triaxial acceleration
from the accelerometer (total acceleration) and the estimated body
acceleration. - Triaxial Angular velocity from the gyroscope. - A
561-feature vector with time and frequency domain variables. - Its
activity label. - An identifier of the subject who carried out the
experiment.”

In particular, the data that will be used on this exercise comes divided
amongst the test and train labels, each of which has three .txt files,
in which one provides the Spatial Vectors data of each observation,
another the ID of the measured subject (1-30) and the last one, the
activity being measured. In addition, the labels of the activities and
the names of the Spatial Vectors columns come from separate .txt files
in the data set.

\#\#Transformations

The provided script transforms the data to achieve the required results
in a few steps.

First, it reads the uncompressed data set to retrieve the aforementioned
.txt files to create data sets that will join. First joining the spatial
vectors, IDs and activity labels of each set, and creating a variable,
called set, to identify if it comes from the train set or the test set.
This variable will go unused beyond this step but it is there if it
needs to be used for some other transformation.

Both sets are then joined using rbind() and then the column names are
retrieved from another .txt file, and together with the added columns,
are named as such in the new data frame.

Then, as required in the second step of the exercise, the script subsets
the variables related to standard deviation and mean, which are
understood as those that mention mean or std in their variable names but
not those that involve mean frequencies or angles. To do this, the
script uses the function grep, both to grab the columns in which the
proper strings appear, as well as to exclude those that show the strings
freq and angle. After this, using the function gsub, the labels of the
column “activity” are changed to more descriptive character strings
using the key provided in the data set. In addition, the other variable
names are cleaned slightly, keeping the axis of movement and the overall
abreviation of the variable but removing the brackets of some variables.

And then, the data is split according to subject, and, using a function
and lapply, then split among activity in each set and the mean of each
variable is calculated. Then using another function, the data is
rejoined into a broader data set in which each row corresponds to a
particular subject and activity and most of the columns provide the mean
of all the observations of that pair.

The end result is a tall data set that follows the principles of
tidyness in having each row correspond to an observation, each column to
a variable and the table only refers to the same type of data. The names
of the variable are also descriptive and the codebook provides an
account of each variable with this table.

The resulting table provides the name of each variable, both types of
variable, which in all cases discounting the subject/activity variable
is the mean of an spatial vector and the minimum and maximum values of
each, discouting the one used for identification.

    tidydata<-read.table("tidyframe.txt", header=TRUE)
    Type<-sapply(tidydata[2,], class)
    Type<-gsub("factor", "ID", Type)
    Type<-gsub("numeric", "Mean", Type)
    Unit<-sapply(tidydata[2,], class)
    Unit<-gsub("factor", "ID", Unit)
    Unit<-gsub("numeric", "Spatial Vector", Unit)
    Minimum<-c("Does not apply", sapply(tidydata[,2:67], min))
    Maximum<-c("Does not apply", sapply(tidydata[,2:67], max))
    Variables<-colnames(tidydata)
    newframe<-data.frame(Variables, Type, Unit, Minimum, Maximum, row.names = NULL)
    print(newframe)

    ##                    Variables Type           Unit             Minimum
    ## 1           subject.activity   ID             ID      Does not apply
    ## 2            tbodyacc.mean.x Mean Spatial Vector       0.22159824394
    ## 3            tbodyacc.mean.y Mean Spatial Vector    -0.0405139534294
    ## 4            tbodyacc.mean.z Mean Spatial Vector  -0.152513899520833
    ## 5             tbodyacc.std.x Mean Spatial Vector  -0.996068635384615
    ## 6             tbodyacc.std.y Mean Spatial Vector  -0.990240946666667
    ## 7             tbodyacc.std.z Mean Spatial Vector  -0.987658662307692
    ## 8         tgravityacc.mean.x Mean Spatial Vector  -0.680043155060241
    ## 9         tgravityacc.mean.y Mean Spatial Vector  -0.479894842941176
    ## 10        tgravityacc.mean.z Mean Spatial Vector   -0.49508872037037
    ## 11         tgravityacc.std.x Mean Spatial Vector  -0.996764227384615
    ## 12         tgravityacc.std.y Mean Spatial Vector   -0.99424764884058
    ## 13         tgravityacc.std.z Mean Spatial Vector  -0.990957249538462
    ## 14       tbodyaccjerk.mean.x Mean Spatial Vector  0.0426880986186441
    ## 15       tbodyaccjerk.mean.y Mean Spatial Vector -0.0386872111282051
    ## 16       tbodyaccjerk.mean.z Mean Spatial Vector -0.0674583919268293
    ## 17        tbodyaccjerk.std.x Mean Spatial Vector  -0.994604542264151
    ## 18        tbodyaccjerk.std.y Mean Spatial Vector  -0.989513565652174
    ## 19        tbodyaccjerk.std.z Mean Spatial Vector  -0.993288313333333
    ## 20          tbodygyro.mean.x Mean Spatial Vector  -0.205775427307692
    ## 21          tbodygyro.mean.y Mean Spatial Vector  -0.204205356087805
    ## 22          tbodygyro.mean.z Mean Spatial Vector -0.0724546025804878
    ## 23           tbodygyro.std.x Mean Spatial Vector  -0.994276591304348
    ## 24           tbodygyro.std.y Mean Spatial Vector  -0.994210471914894
    ## 25           tbodygyro.std.z Mean Spatial Vector  -0.985538363333333
    ## 26      tbodygyrojerk.mean.x Mean Spatial Vector  -0.157212539189362
    ## 27      tbodygyrojerk.mean.y Mean Spatial Vector -0.0768089915604167
    ## 28      tbodygyrojerk.mean.z Mean Spatial Vector -0.0924998531372549
    ## 29       tbodygyrojerk.std.x Mean Spatial Vector   -0.99654254057971
    ## 30       tbodygyrojerk.std.y Mean Spatial Vector  -0.997081575652174
    ## 31       tbodygyrojerk.std.z Mean Spatial Vector  -0.995380794637681
    ## 32          tbodyaccmag.mean Mean Spatial Vector  -0.986493196666667
    ## 33           tbodyaccmag.std Mean Spatial Vector  -0.986464542615385
    ## 34       tgravityaccmag.mean Mean Spatial Vector  -0.986493196666667
    ## 35        tgravityaccmag.std Mean Spatial Vector  -0.986464542615385
    ## 36      tbodyaccjerkmag.mean Mean Spatial Vector   -0.99281471515625
    ## 37       tbodyaccjerkmag.std Mean Spatial Vector  -0.994646916811594
    ## 38         tbodygyromag.mean Mean Spatial Vector  -0.980740846769231
    ## 39          tbodygyromag.std Mean Spatial Vector  -0.981372675614035
    ## 40     tbodygyrojerkmag.mean Mean Spatial Vector  -0.997322526811594
    ## 41      tbodygyrojerkmag.std Mean Spatial Vector  -0.997666071594203
    ## 42           fbodyacc.mean.x Mean Spatial Vector  -0.995249932641509
    ## 43           fbodyacc.mean.y Mean Spatial Vector  -0.989034304057971
    ## 44           fbodyacc.mean.z Mean Spatial Vector  -0.989473926666667
    ## 45            fbodyacc.std.x Mean Spatial Vector  -0.996604570307692
    ## 46            fbodyacc.std.y Mean Spatial Vector  -0.990680395362319
    ## 47            fbodyacc.std.z Mean Spatial Vector  -0.987224804307692
    ## 48       fbodyaccjerk.mean.x Mean Spatial Vector  -0.994630797358491
    ## 49       fbodyaccjerk.mean.y Mean Spatial Vector  -0.989398823913043
    ## 50       fbodyaccjerk.mean.z Mean Spatial Vector  -0.992018447826087
    ## 51        fbodyaccjerk.std.x Mean Spatial Vector  -0.995073759245283
    ## 52        fbodyaccjerk.std.y Mean Spatial Vector  -0.990468082753623
    ## 53        fbodyaccjerk.std.z Mean Spatial Vector  -0.993107759855072
    ## 54          fbodygyro.mean.x Mean Spatial Vector   -0.99312260884058
    ## 55          fbodygyro.mean.y Mean Spatial Vector  -0.994025488297872
    ## 56          fbodygyro.mean.z Mean Spatial Vector        -0.985957788
    ## 57           fbodygyro.std.x Mean Spatial Vector  -0.994652185217391
    ## 58           fbodygyro.std.y Mean Spatial Vector  -0.994353086595745
    ## 59           fbodygyro.std.z Mean Spatial Vector  -0.986725274871795
    ## 60          fbodyaccmag.mean Mean Spatial Vector  -0.986800645362319
    ## 61           fbodyaccmag.std Mean Spatial Vector  -0.987648484461539
    ## 62  fbodybodyaccjerkmag.mean Mean Spatial Vector  -0.993998275797101
    ## 63   fbodybodyaccjerkmag.std Mean Spatial Vector  -0.994366667681159
    ## 64     fbodybodygyromag.mean Mean Spatial Vector  -0.986535242105263
    ## 65      fbodybodygyromag.std Mean Spatial Vector  -0.981468841692308
    ## 66 fbodybodygyrojerkmag.mean Mean Spatial Vector  -0.997617389275362
    ## 67  fbodybodygyrojerkmag.std Mean Spatial Vector   -0.99758523057971
    ##                 Maximum
    ## 1        Does not apply
    ## 2          0.3014610196
    ## 3  -0.00130828765170213
    ## 4        -0.07537846886
    ## 5     0.626917070512821
    ## 6     0.616937015333333
    ## 7     0.609017879074074
    ## 8           0.974508732
    ## 9     0.956593814210526
    ## 10         0.9578730416
    ## 11   -0.829554947808219
    ## 12   -0.643578361424658
    ## 13   -0.610161166287671
    ## 14    0.130193043809524
    ## 15       0.056818586275
    ## 16   0.0380533591627451
    ## 17    0.544273037307692
    ## 18    0.355306716915385
    ## 19   0.0310157077775926
    ## 20     0.19270447595122
    ## 21   0.0274707556666667
    ## 22    0.179102058245614
    ## 23    0.267657219333333
    ## 24    0.476518714444444
    ## 25    0.564875818162963
    ## 26  -0.0220916265065217
    ## 27  -0.0132022768074468
    ## 28 -0.00694066389361702
    ## 29    0.179148649684615
    ## 30    0.295945926186441
    ## 31    0.193206498960417
    ## 32    0.644604325128205
    ## 33    0.428405922622222
    ## 34    0.644604325128205
    ## 35    0.428405922622222
    ## 36    0.434490400974359
    ## 37    0.450612065720513
    ## 38    0.418004608615385
    ## 39    0.299975979851852
    ## 40   0.0875816618205128
    ## 41    0.250173204117966
    ## 42    0.537012022051282
    ## 43    0.524187686888889
    ## 44    0.280735952206667
    ## 45    0.658506543333333
    ## 46          0.560191344
    ## 47    0.687124163703704
    ## 48    0.474317256051282
    ## 49    0.276716853307692
    ## 50    0.157775692377778
    ## 51    0.476803887476923
    ## 52    0.349771285415897
    ## 53 -0.00623647528983051
    ## 54    0.474962448333333
    ## 55    0.328817010088889
    ## 56    0.492414379822222
    ## 57    0.196613286661538
    ## 58    0.646233637037037
    ## 59    0.522454216314815
    ## 60    0.586637550769231
    ## 61    0.178684580868889
    ## 62    0.538404846128205
    ## 63    0.316346415348718
    ## 64    0.203979764835897
    ## 65    0.236659662496296
    ## 66    0.146618569064407
    ## 67    0.287834616098305
