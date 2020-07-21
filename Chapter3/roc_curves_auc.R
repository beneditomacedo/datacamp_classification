## ---------------------------
## Script name: roc_curves_auc.R
##
## Purpose of script: Calculating ROC curves and AUC
##
## ---------------------------

# Load the pROC package
library(pROC)

# Create a ROC curve
ROC <- roc(donors$donated, donors$donation_prob)

# Plot the ROC curve
plot(ROC, col = "blue")

# Calculate the area under the curve (AUC)
auc(ROC)