## ---------------------------
## Script name: recognize_road_sign.R
##
## Purpose of script: Recognize a road sign
##
## ---------------------------

# Create a vector of sign labels to use with kNN by extracting the column sign_type
# from signs.
sign_types <- signs$sign_type
# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)
