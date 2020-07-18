---
title: 'Datacamp - Supervised Learning in R: Classification'
output: 
  html_document:
    keep_md: true
---



## Chapter 1: k-Nearest Neighbors (kNN)

### Preparing datasets


```r
knitr::spin_child('prepare_datasets.R')
```

```r
## Script name: prepare_datasets.R
##
## Purpose of script: Prepare the datasets for datacamp course Supervised Learning in R:
## Classification, Chapter 1
##
```

```r
# loading training, test and example records
raw_signs <- read.csv("../data/knn_traffic_signs.csv")
# select only train rows
signs <- raw_signs[raw_signs$sample == "train",]
# remove id and sample columns
signs <- signs[-c(1,2)]
# select only test rows
test_signs <- raw_signs[raw_signs$sample == "test",]
# remove id and sample columns
test_signs <- test_signs[-c(1,2)]
# select only example row
next_sign <- raw_signs[raw_signs$sample == "example",]
# remove id, sample, sign_type columns
next_sign <- next_sign[-c(1:3)]
```

### Recognizing a road sign with kNN


```r
knitr::spin_child('recognize_road_sign.R')
```

```r
## Script name: recognize_road_sign.R
##
## Purpose of script: Recognize a road sign
##
```

```r
# Create a vector of sign labels to use with kNN by extracting the column sign_type
# from signs.
sign_types <- signs$sign_type
# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)
```

```
## [1] stop
## Levels: pedestrian speed stop
```

### Exploring the traffic sign dataset


```r
knitr::spin_child('explore_sign_dataset.R')
```

```r
## Script name: recognizing_road_sign.R
##
## Purpose of script: Recognizing a road sign
##
```

```r
# Load the 'class' package
library(class)
# Create a vector of sign labels to use with kNN by extracting the column sign_type
# from signs.
sign_types <- signs$sign_type
# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)
```

```
## [1] stop
## Levels: pedestrian speed stop
```

### Classifying a collection of road signs


```r
knitr::spin_child('classify_collection.R')
```

```r
## Script name: recognizing_road_sign.R
##
## Purpose of script: Recognizing a road sign
##
```

```r
# Use kNN to identify the test road signs
sign_types <- signs$sign_type
signs_pred <- knn(train = signs[-1], test = test_signs[-1], cl = sign_types)
# Create a confusion matrix of the predicted versus actual values
signs_actual <- test_signs$sign_type
table(signs_pred, signs_actual)
```

```
##             signs_actual
## signs_pred   pedestrian speed stop
##   pedestrian         19     2    0
##   speed               0    17    0
##   stop                0     2   19
```

```r
# Compute the accuracy
mean(signs_actual == signs_pred)
```

```
## [1] 0.9322034
```

### Testing other 'k' values


```r
knitr::spin_child('test_other_k.R')
```

```r
## Script name: testing_other_k.R
##
## Purpose of script: Testing other k values
##
```

```r
# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = signs[-1], 
           test = test_signs[-1], cl = sign_types)
mean(k_1 == signs_actual)
```

```
## [1] 0.9322034
```

```r
# Modify the above to set k = 7
k_7 <- knn(train = signs[-1], 
           test = test_signs[-1], cl = sign_types, k=7)
mean(k_7 == signs_actual)
```

```
## [1] 0.9491525
```

```r
# Set k = 15 and compare to the above
k_15 <- knn(train = signs[-1], 
            test = test_signs[-1], cl = sign_types, k=15)
mean(k_15 == signs_actual)
```

```
## [1] 0.8813559
```

### Seeing how the neighbors voted


```r
knitr::spin_child('see_probability.R')
```

```r
## Script name: see_probability.R
##
## Purpose of script: See probability of predictions
##
```

```r
# Use the prob parameter to get the proportion of votes for the winning class
sign_pred <- knn(train = signs[-1], 
                 test = test_signs[-1], cl = sign_types, k=7, prob=TRUE)

# Get the "prob" attribute from the predicted classes
sign_prob <- attr(sign_pred, "prob")

# Examine the first several predictions
head(sign_pred)
```

```
## [1] pedestrian pedestrian pedestrian stop       pedestrian pedestrian
## Levels: pedestrian speed stop
```

```r
# Examine the proportion of votes for the winning class
head(sign_prob)
```

```
## [1] 0.5714286 0.5714286 0.8571429 0.5714286 0.8571429 0.5714286
```

## Extra

### Normalize data


```r
knitr::spin_child('normalize.R')
```

```r
## Script name: normalize.R
##
## Purpose of script: Normalize data
##
```

```r
# Define a min-max normalize() function
normalize <- function (x) {
  return ((x - min(x))/ (max(x) - min(x)))
}
```

```r
knitr::spin_child('ex_normalize.R')
```

```r
## Script name: ex_normalize.R
##
## Purpose of script: Example of how to normalize data
##
```

```r
summary(signs$r1)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    3.00   46.75   85.50  100.87  152.75  234.00
```

```r
summary(normalize(signs$r1))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.1894  0.3571  0.4237  0.6483  1.0000
```
