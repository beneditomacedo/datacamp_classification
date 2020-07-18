## ---------------------------
## Script name: normalize.R
##
## Purpose of script: Normalize data
##
## ---------------------------

# Define a min-max normalize() function
normalize <- function (x) {
  return ((x - min(x))/ (max(x) - min(x)))
}