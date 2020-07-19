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
# create thursday9am and saturday9am dataframes
thursday9am <- data.frame(daytype="weekday")
saturday9am <- data.frame(daytype="weekend")
# create locations dataset
locations <- raw_locations[c(4,6,7)]
# show locations
head(locations)
# create weekday_afternoon and weekday_evening dataframes
weekday_afternoon <- data.frame(daytype="weekday",hourtype="afternoon")
weekday_evening <- data.frame(daytype="weekday",hourtype="evening")
# create weekend_afternoon dataframe
weekend_afternoon <- data.frame(daytype="weekend",hourtype="afternoon")

