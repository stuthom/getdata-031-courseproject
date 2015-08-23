---
title: "CodeBook.md"
author: "Stuart Thom"
date: "23 August 2015"
output: html_document
---

# Getting and Cleaning Data - Course Project
The code in this repository has been written to fulfil the requirements of the Course Project in the Getting and Cleaning Data course from Johns Hopkins University and provided on Coursera as part of the Data Science Specialisation.  More information about the course can be found at https://www.coursera.org/course/getdata.

## Data source
The data used comes from a study conducted in Human Activity Recognition using Smartphones.  More information about the study can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The original source data used for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  This link is included in the main file run_analysis.R as a variable which can be changed to a new location if the original data source can no longer be found.

## Objectives
The assignment instructions are as follows.
>The purpose of this project is to demonstrate your ability to collect, work with, and clean >a data set. The goal is to prepare tidy data that can be used for later analysis. You will >be graded by your peers on a series of yes/no questions related to the project. You will be >required to submit: 1) a tidy data set as described below, 2) a link to a Github repository >with your script for performing the analysis, and 3) a code book that describes the >variables, the data, and any transformations or work that you performed to clean up the >data called CodeBook.md. You should also include a README.md in the repo with your scripts. >This repo explains how all of the scripts work and how they are connected.  
>
>One of the most exciting areas in all of data science right now is wearable computing - see >for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to >develop the most advanced algorithms to attract new users. The data linked to from the >course website represent data collected from the accelerometers from the Samsung Galaxy S >smartphone. A full description is available at the site where the data was obtained: 
>
>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
>
>Here are the data for the project: 
>
>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
>
>You should create one R script called run_analysis.R that does the following. 
>Merges the training and the test sets to create one data set.
>Extracts only the measurements on the mean and standard deviation for each measurement. 
>Uses descriptive activity names to name the activities in the data set
>Appropriately labels the data set with descriptive variable names. 
>From the data set in step 4, creates a second, independent tidy data set with the average >of each variable for each activity and each subject.
>
>Good luck!

## run_analysis.R
The file run_analysis.R is the file required for this assignment, and contains the code to download the source data and then manipulate the data into the required format.  The code performs the following activities:

1. Sets variables to make the code more readable, and loads required libraries into R.
2. Downloads the required source data. The data is in a zip file, so the code also unzips the zip file.
3. Reads some of the source data into vectors and data tables to be used within the code.
4. Reads in the measurements from both the *test* and *train* data sets, and merges these together into a single data set.
5. Extracts only measurements relating to mean and standard deviation from within the data set.
6. Adds the activity names to the measurements within the data set.
7. Improves the human readability of the variable names within the data set.
8. Creates a new data set, summarising the data by participant and activity and taking the mean of all measurements for that grouping.
9. Outputs the newly created data set to a file named *tidy_dataset.txt*.

## tidy_dataset.txt
This is the output file created by the script.