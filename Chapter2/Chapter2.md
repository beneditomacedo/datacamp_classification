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

```r
# create thursday9am and saturday9am dataframes
thursday9am <- data.frame(daytype="weekday")
saturday9am <- data.frame(daytype="weekend")
```

### Computing probabilities


```r
knitr::spin_child('compute_prob.R')
```

```r
## Script name: compute_prob.R
##
## Purpose of script: compute probability
##
```

```r
# Compute P(A) 
p_A <- nrow(subset(where9am, location == "office")) / nrow(where9am)

# Compute P(B)
p_B <- nrow(subset(where9am, daytype == "weekday")) / nrow(where9am)

# Compute the observed P(A and B)
p_AB <- nrow(subset(where9am, location == "office" & daytype == "weekday")) / nrow(where9am)

# Compute P(A | B) and print its value
p_A_given_B <- (p_AB/p_B)
print(p_A_given_B)
```

```
## [1] 0.6
```

### Simple naive bayes model


```r
knitr::spin_child('simple_naive_bayes_model.R')
```

```r
## Script name: simple_naive_bayes_model.R
##
## Purpose of script: Build and test a simple naive bayes model
##
```

```r
# Load the naivebayes package
library(naivebayes)
```

```
## Warning: package 'naivebayes' was built under R version 4.0.2
```

```
## naivebayes 0.9.7 loaded
```

```r
# Build the location prediction model
locmodel <- naive_bayes(location ~ daytype, data = where9am)
```

```
## Warning: naive_bayes(): Feature daytype - zero probabilities are present.
## Consider Laplace smoothing.
```

```r
# Predict Thursday's 9am location
predict(locmodel, thursday9am)
```

```
## [1] office
## Levels: appointment campus home office
```

```r
# Predict Saturdays's 9am location
predict(locmodel, saturday9am)
```

```
## [1] home
## Levels: appointment campus home office
```
