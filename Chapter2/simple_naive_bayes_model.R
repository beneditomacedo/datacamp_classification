## ---------------------------
## Script name: simple_naive_bayes_model.R
##
## Purpose of script: Build and test a simple naive bayes model
##
## ---------------------------

# Load the naivebayes package
library(naivebayes)

# Build the location prediction model
locmodel <- naive_bayes(location ~ daytype, data = where9am)

# Predict Thursday's 9am location
predict(locmodel, thursday9am)

# Predict Saturdays's 9am location
predict(locmodel, saturday9am)