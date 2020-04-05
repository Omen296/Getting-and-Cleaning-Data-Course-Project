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
