## ---------------------------
## Script name: build_lr_model.R
##
## Purpose of script: Build a simple logistic regression model
##
## ---------------------------

# Examine the dataset to identify potential independent variables
str(donors)

# Explore the dependent variable
table(donors$donated)

# Build the donation model
donation_model <- glm(donated ~ bad_address + interest_religion + interest_veterans, 
                      data = donors, family = "binomial")

# Summarize the model results
summary(donation_model)