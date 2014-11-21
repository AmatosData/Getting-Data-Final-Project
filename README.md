Getting-Data-Final-Project
==========================
This repo contains
- tidy dataset
- Script to create data set (run_analysis.r) = which performs the analysis and creates the tidy dataset
- CodeBook to guide the user through the steps to create the dataset and description of variables and study design.

Description:
- This analysis takes several text files of train and test data from Samsung Data and merge them into a single dataset. 
- Drop all the variables that are not mean or standard deviations. 
- Calculates the average(mean) of each variable per Activity(e.g Walking...) by observation
- Creates a tidy dataset and export it as a text file.


Analysis Steps:
1. Download the Samsung Data to your working directory
2. Set working directory in r script
3. Run the script (run_analysis.r)
4. Output = tidy dataset called "tidy.data.comp"


Gettin and Cleaning Data Course- Final project
