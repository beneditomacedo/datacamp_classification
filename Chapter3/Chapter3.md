---
title: 'Datacamp - Supervised Learning in R: Classification'
output: 
  html_document:
    keep_md: true
---



## Chapter 3: Logistic Regression

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

### Build a simple logistic regression model


```r
knitr::spin_child('simple_lr_model.R')
```

```r
## Script name: build_lr_model.R
##
## Purpose of script: Build a simple logistic regression model
##
```

```r
# Examine the dataset to identify potential independent variables
str(donors)
```

```
## 'data.frame':	93462 obs. of  13 variables:
##  $ donated          : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ veteran          : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ bad_address      : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ age              : int  60 46 NA 70 78 NA 38 NA NA 65 ...
##  $ has_children     : int  0 1 0 0 1 0 1 0 0 0 ...
##  $ wealth_rating    : int  0 3 1 2 1 0 2 3 1 0 ...
##  $ interest_veterans: int  0 0 0 0 0 0 0 0 0 0 ...
##  $ interest_religion: int  0 0 0 0 1 0 0 0 0 0 ...
##  $ pet_owner        : int  0 0 0 0 0 0 1 0 0 0 ...
##  $ catalog_shopper  : int  0 0 0 0 1 0 0 0 0 0 ...
##  $ recency          : chr  "CURRENT" "CURRENT" "CURRENT" "CURRENT" ...
##  $ frequency        : chr  "FREQUENT" "FREQUENT" "FREQUENT" "FREQUENT" ...
##  $ money            : chr  "MEDIUM" "HIGH" "MEDIUM" "MEDIUM" ...
```

```r
# Explore the dependent variable
table(donors$donated)
```

```
## 
##     0     1 
## 88751  4711
```

```r
# Build the donation model
donation_model <- glm(donated ~ bad_address + interest_religion + interest_veterans, 
                      data = donors, family = "binomial")

# Summarize the model results
summary(donation_model)
```

```
## 
## Call:
## glm(formula = donated ~ bad_address + interest_religion + interest_veterans, 
##     family = "binomial", data = donors)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -0.3480  -0.3192  -0.3192  -0.3192   2.5678  
## 
## Coefficients:
##                   Estimate Std. Error  z value Pr(>|z|)    
## (Intercept)       -2.95139    0.01652 -178.664   <2e-16 ***
## bad_address       -0.30780    0.14348   -2.145   0.0319 *  
## interest_religion  0.06724    0.05069    1.327   0.1847    
## interest_veterans  0.11009    0.04676    2.354   0.0186 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 37330  on 93461  degrees of freedom
## Residual deviance: 37316  on 93458  degrees of freedom
## AIC: 37324
## 
## Number of Fisher Scoring iterations: 5
```

### Making binary prediction


```r
knitr::spin_child('make_binary_prediction.R')
```

```r
## Script name: make_binary_prediction.R
##
## Purpose of script: Make a binary prediction
##
```

```r
# Estimate the donation probability
donors$donation_prob <- predict(donation_model, type = "response")

# Find the donation probability of the average prospect
mean(donors$donated)
```

```
## [1] 0.05040551
```

```r
# Predict a donation if probability of donation is greater than average (0.0504)
donors$donation_pred <- ifelse(donors$donation_prob > 0.0504, 1, 0)

# Calculate the model's accuracy
mean(donors$donation_pred == donors$donated)
```

```
## [1] 0.794815
```

### Calculating ROC Curves and AUC

TODO - fix pROC install

### Coding categorical features


```r
knitr::spin_child('code_categorical.R')
```

```r
## Script name: code_categorical.R
##
## Purpose of script: Coding categorical features
##
```

```r
# Convert the wealth rating to a factor
donors$wealth_levels <- factor(donors$wealth_rating, levels = c(0,1,2,3), 
                               labels = c("Unknown","Low","Medium","High"))

# Use relevel() to change reference category
donors$wealth_levels <- relevel(donors$wealth_levels, ref = "Medium")

# Build the donation model
donation_model <- glm(donated ~ wealth_levels, data = donors, family = "binomial")

# See how our factor coding impacts the model
summary(donation_model)
```

```
## 
## Call:
## glm(formula = donated ~ wealth_levels, family = "binomial", data = donors)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -0.3320  -0.3243  -0.3175  -0.3175   2.4582  
## 
## Coefficients:
##                      Estimate Std. Error z value Pr(>|z|)    
## (Intercept)          -2.91894    0.03614 -80.772   <2e-16 ***
## wealth_levelsUnknown -0.04373    0.04243  -1.031    0.303    
## wealth_levelsLow     -0.05245    0.05332  -0.984    0.325    
## wealth_levelsHigh     0.04804    0.04768   1.008    0.314    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 37330  on 93461  degrees of freedom
## Residual deviance: 37323  on 93458  degrees of freedom
## AIC: 37331
## 
## Number of Fisher Scoring iterations: 5
```

### Handling missing data


```r
knitr::spin_child('missing_data.R')
```

```r
## Script name: missing_data.R
##
## Purpose of script: Handling missing data
##
```

```r
# Find the average age among non-missing values
summary(donors$age)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00   48.00   62.00   61.65   75.00   98.00   22546
```

```r
# Impute missing age values with the mean age
donors$imputed_age <- ifelse(is.na(donors$age), round(mean(donors$age,na.rm=TRUE),2),donors$age)

# Create missing value indicator for age
donors$missing_age <- ifelse(is.na(donors$age),1,0)
```

### Build a bit sofisticated logistic regression model

TODO - fix pROC install
