Getting and Cleaning Data Assignment
====================================

This repository contains everything needed for the assignment, both the
data set, uncompressed as my script requires, the codebook with the code
to produce a table detailing all the variables from the result. A .txt
with the final product and the readme.

The resulting dataset is a tall one pairing activities and subjects
providing the means for each variable. It fulfill all the requisites for
being a clean data set by having each row correspond to a single
observation of the same type, each column is a variable, labeled in a
descriptive manner, being slighly modified versions of the ones that
came with the data set. I choose to not add that they are the means of
each variable each column name as that would make it less readable and
it is clearly stated both in the codeboook and the table in it that
describes all variables.

The code is pretty straightforward and it should work cleanly if the
data is uncompressed in the directory. The data should be read with

read.table(“tidyframe.txt”, header=TRUE)

Code description
----------------

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
