## ---------------------------
## Script name: recognizing_road_sign.R
##
## Purpose of script: Recognizing a road sign
##
## ---------------------------
# Load the 'class' package
library(class)
# Create a vector of sign labels to use with kNN by extracting the column sign_type
# from signs.
sign_types <- signs$sign_type
# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)