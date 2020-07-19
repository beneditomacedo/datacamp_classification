## ---------------------------
## Script name: examine_raw_prob.R
##
## Purpose of script: Examine raw probabilities of a naive
## bayes model
## ---------------------------

# Examine the location prediction model
locmodel

# Obtain the predicted probabilities for Thursday at 9am
predict(locmodel, thursday9am , type = "prob")

# Obtain the predicted probabilities for Saturday at 9am
predict(locmodel, saturday9am, type="prob")
