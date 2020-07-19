## ---------------------------
## Script name: laplace_correction.R
##
## Purpose of script: Build and test a naive bayes model with laplace correction
##
## ---------------------------

# Observe the predicted probabilities for a weekend afternoon
predict(locmodel, weekend_afternoon, type="prob")

# Build a new model using the Laplace correction
locmodel2 <- naive_bayes(location ~ daytype + hourtype, data = locations, laplace=1)

# Observe the new predicted probabilities for a weekend afternoon
predict(locmodel2, weekend_afternoon, type="prob")