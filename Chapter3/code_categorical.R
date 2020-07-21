## ---------------------------
## Script name: code_categorical.R
##
## Purpose of script: Coding categorical features
##
## ---------------------------

# Convert the wealth rating to a factor
donors$wealth_levels <- factor(donors$wealth_rating, levels = c(0,1,2,3), 
                               labels = c("Unknown","Low","Medium","High"))

# Use relevel() to change reference category
donors$wealth_levels <- relevel(donors$wealth_levels, ref = "Medium")

# Build the donation model
donation_model <- glm(donated ~ wealth_levels, data = donors, family = "binomial")

# See how our factor coding impacts the model
summary(donation_model)
