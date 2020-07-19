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
# create locations dataset
locations <- raw_locations[c(4,6,7)]
# show locations
head(locations)
```

```
##   daytype hourtype location
## 1 weekday    night     home
## 2 weekday    night     home
## 3 weekday    night     home
## 4 weekday    night     home
## 5 weekday    night     home
## 6 weekday    night     home
```

```r
# create weekday_afternoon and weekday_evening dataframes
weekday_afternoon <- data.frame(daytype="weekday",hourtype="afternoon")
weekday_evening <- data.frame(daytype="weekday",hourtype="evening")
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

### Examine raw probabilities


```r
knitr::spin_child('examine_raw_prob.R')
```

```r
## Script name: examine_raw_prob.R
##
## Purpose of script: Examine raw probabilities of a naive
## bayes model
```

```r
# Examine the location prediction model
locmodel
```

```
## 
## ================================== Naive Bayes ================================== 
##  
##  Call: 
## naive_bayes.formula(formula = location ~ daytype, data = where9am)
## 
## --------------------------------------------------------------------------------- 
##  
## Laplace smoothing: 0
## 
## --------------------------------------------------------------------------------- 
##  
##  A priori probabilities: 
## 
## appointment      campus        home      office 
##  0.01098901  0.10989011  0.45054945  0.42857143 
## 
## --------------------------------------------------------------------------------- 
##  
##  Tables: 
## 
## --------------------------------------------------------------------------------- 
##  ::: daytype (Bernoulli) 
## --------------------------------------------------------------------------------- 
##          
## daytype   appointment    campus      home    office
##   weekday   1.0000000 1.0000000 0.3658537 1.0000000
##   weekend   0.0000000 0.0000000 0.6341463 0.0000000
## 
## ---------------------------------------------------------------------------------
```

```r
# Obtain the predicted probabilities for Thursday at 9am
predict(locmodel, thursday9am , type = "prob")
```

```
##      appointment    campus      home office
## [1,]  0.01538462 0.1538462 0.2307692    0.6
```

```r
# Obtain the predicted probabilities for Saturday at 9am
predict(locmodel, saturday9am, type="prob")
```

```
##       appointment       campus      home      office
## [1,] 3.838772e-05 0.0003838772 0.9980806 0.001497121
```

### Sofisticated naive bayes model


```r
knitr::spin_child('sofisticated_nb_model.R')
```

```r
## Script name: sofisticated_nb_model.R
##
## Purpose of script: Build and test a sofisticated naive bayes model
##
```

```r
locmodel <- naive_bayes(location ~ daytype + hourtype, data = locations)
```

```
## Warning: naive_bayes(): Feature daytype - zero probabilities are present.
## Consider Laplace smoothing.
```

```
## Warning: naive_bayes(): Feature hourtype - zero probabilities are present.
## Consider Laplace smoothing.
```

```r
# Predict Brett's location on a weekday afternoon
predict(locmodel, weekday_afternoon)
```

```
## [1] office
## Levels: appointment campus home office restaurant store theater
```

```r
# Predict Brett's location on a weekday evening
predict(locmodel, weekday_evening)
```

```
## [1] home
## Levels: appointment campus home office restaurant store theater
```
