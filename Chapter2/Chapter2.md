---
title: 'Datacamp - Supervised Learning in R: Classification'
output: 
  html_document:
    keep_md: true
---



## Chapter 2: Naive Bayes

### Preparing datasets


```r
knitr::spin_child('prepare_datasets.R')
```

```r
## Script name: prepare_datasets.R
##
## Purpose of script: Prepare the datasets for datacamp course Supervised Learning in R:
## Classification, Chapter 2
##
```

```r
# load training, test and example records
raw_locations <- read.csv("../data/locations.csv")
# load where9am dataset
where9am <- subset(raw_locations, hour==9)
# maintain only needed columns
where9am <- where9am[c(4,7)]
# show where9am
head(where9am)
```

```
##     daytype location
## 10  weekday   office
## 34  weekday   office
## 58  weekday   office
## 82  weekend     home
## 106 weekend     home
## 130 weekday   campus
```
