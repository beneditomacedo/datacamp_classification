## ---------------------------
## Script name: sofisticated_nb_model.R
##
## Purpose of script: Build and test a sofisticated naive bayes model
##
## ---------------------------

locmodel <- naive_bayes(location ~ daytype + hourtype, data = locations)

# Predict Brett's location on a weekday afternoon
predict(locmodel, weekday_afternoon)

# Predict Brett's location on a weekday evening
predict(locmodel, weekday_evening)
