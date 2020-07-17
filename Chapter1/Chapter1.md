---
title: 'Datacamp - Supervised Learning in R: Classification'
output: 
  html_document:
    keep_md: true
---



## Chapter 1: k-Nearest Neighbors (kNN)


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

# Recognizing a road sign with kNN


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

# Exploring the traffic sign dataset


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

# Classifying a collection of road signs


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

