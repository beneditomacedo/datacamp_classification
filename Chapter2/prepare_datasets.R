## ---------------------------
## Script name: prepare_datasets.R
##
## Purpose of script: Prepare the datasets for datacamp course Supervised Learning in R:
## Classification, Chapter 2
##
## ---------------------------

# load training, test and example records
raw_locations <- read.csv("../data/locations.csv")
# load where9am dataset
where9am <- subset(raw_locations, hour==9)
# maintain only needed columns
where9am <- where9am[c(4,7)]
# show where9am
head(where9am)
