## ---------------------------
## Script name: prepare_datasets.R
##
## Purpose of script: Prepare the datasets for datacamp course Supervised Learning in R:
## Classification, Chapter 1
##
## ---------------------------

# loading training, test and example records
raw_signs <- read.csv("../data/knn_traffic_signs.csv")
# select only train rows
signs <- raw_signs[raw_signs$sample == "train",]
# remove id and sample columns
signs <- signs[-c(1,2)]
# select only test rows
test_signs <- raw_signs[raw_signs$sample == "test",]
# remove id and sample columns
test_signs <- test_signs[-c(1,2)]
# select only example row
next_sign <- raw_signs[raw_signs$sample == "example",]
# remove id, sample, sign_type columns
next_sign <- next_sign[-c(1:3)]
