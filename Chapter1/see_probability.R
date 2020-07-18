## ---------------------------
## Script name: see_probability.R
##
## Purpose of script: See probability of predictions
##
## ---------------------------

# Use the prob parameter to get the proportion of votes for the winning class
sign_pred <- knn(train = signs[-1], 
                 test = test_signs[-1], cl = sign_types, k=7, prob=TRUE)

# Get the "prob" attribute from the predicted classes
sign_prob <- attr(sign_pred, "prob")

# Examine the first several predictions
head(sign_pred)

# Examine the proportion of votes for the winning class
head(sign_prob)