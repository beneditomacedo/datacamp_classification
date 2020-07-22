---
title: 'Datacamp - Supervised Learning in R: Classification'
output: 
  html_document:
    keep_md: true
---



## Chapter 4: Classification trees

### Preparing datasets


```r
knitr::spin_child('prepare_datasets.R')
```

```r
## Script name: prepare_datasets.R
##
## Purpose of script: Prepare the datasets for datacamp course Supervised Learning in R:
## Classification, Chapter 3
##
```

```r
# load donors dataset
donors <- read.csv("../data/donors.csv")
# show where9am
head(donors)
```

```
##   donated veteran bad_address age has_children wealth_rating interest_veterans
## 1       0       0           0  60            0             0                 0
## 2       0       0           0  46            1             3                 0
## 3       0       0           0  NA            0             1                 0
## 4       0       0           0  70            0             2                 0
## 5       0       0           0  78            1             1                 0
## 6       0       0           0  NA            0             0                 0
##   interest_religion pet_owner catalog_shopper recency  frequency  money
## 1                 0         0               0 CURRENT   FREQUENT MEDIUM
## 2                 0         0               0 CURRENT   FREQUENT   HIGH
## 3                 0         0               0 CURRENT   FREQUENT MEDIUM
## 4                 0         0               0 CURRENT   FREQUENT MEDIUM
## 5                 1         0               1 CURRENT   FREQUENT MEDIUM
## 6                 0         0               0 CURRENT INFREQUENT MEDIUM
```
