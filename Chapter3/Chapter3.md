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


```r
knitr::spin_child('roc_curves_auc.R')
```

```r
## Script name: roc_curves_auc.R
##
## Purpose of script: Calculating ROC curves and AUC
##
```

```r
# Load the pROC package
library(pROC)
```

```
## Type 'citation("pROC")' for a citation.
```

```
## 
## Attaching package: 'pROC'
```

```
## The following objects are masked from 'package:stats':
## 
##     cov, smooth, var
```

```r
# Create a ROC curve
ROC <- roc(donors$donated, donors$donation_prob)
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```r
# Plot the ROC curve
plot(ROC, col = "blue")
```

![](Chapter3_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

```r
# Calculate the area under the curve (AUC)
auc(ROC)
```

```
## Area under the curve: 0.5102
```

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


```r
knitr::spin_child('sofisticated_lr_model.R')
```

```r
## Script name: sofisticated_lr_model.R
##
## Purpose of script: Build and test a bit more sofisticated logistic model
##
```

```r
# Build a recency, frequency, and money (RFM) model
rfm_model <- glm(donated ~ money + recency * frequency, data = donors, family = "binomial")

# Summarize the RFM model to see how the parameters were coded
summary(rfm_model)
```

```
## 
## Call:
## glm(formula = donated ~ money + recency * frequency, family = "binomial", 
##     data = donors)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -0.3696  -0.3696  -0.2895  -0.2895   2.7924  
## 
## Coefficients:
##                                   Estimate Std. Error z value Pr(>|z|)    
## (Intercept)                       -3.01142    0.04279 -70.375   <2e-16 ***
## moneyMEDIUM                        0.36186    0.04300   8.415   <2e-16 ***
## recencyLAPSED                     -0.86677    0.41434  -2.092   0.0364 *  
## frequencyINFREQUENT               -0.50148    0.03107 -16.143   <2e-16 ***
## recencyLAPSED:frequencyINFREQUENT  1.01787    0.51713   1.968   0.0490 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 37330  on 93461  degrees of freedom
## Residual deviance: 36938  on 93457  degrees of freedom
## AIC: 36948
## 
## Number of Fisher Scoring iterations: 6
```

```r
# Compute predicted probabilities for the RFM model
rfm_prob <- predict(rfm_model, type="response")

# Plot the ROC curve and find AUC for the new model
library(pROC)
ROC <- roc(donors$donated,rfm_prob)
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```r
# Plot the ROC curve
plot(ROC, col = "red")
```

![](Chapter3_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

```r
# Calculate the area under the curve (AUC)
auc(ROC)
```

```
## Area under the curve: 0.5785
```

### Build a stepwise regression model


```r
knitr::spin_child('stepwise_regression_model.R')
```

```r
## Script name: stepwise_regression_model.R
##
## Purpose of script: Build a stepwise regression model
##
```

```r
# Specify a null model with no predictors
null_model <- glm(donated~1, data = donors, family = "binomial")

# Specify the full model using all of the potential predictors
full_model <- glm(donated ~ .,data = donors, family = "binomial")

# Use a forward stepwise algorithm to build a parsimonious model
step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward")
```

```
## Start:  AIC=37332.13
## donated ~ 1
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## + frequency          1    28502 37122
## + money              1    28621 37241
## + wealth_rating      1    28705 37326
## + has_children       1    28705 37326
## + age                1    28707 37328
## + imputed_age        1    28707 37328
## + wealth_levels      3    28704 37328
## + interest_veterans  1    28709 37330
## + donation_prob      1    28710 37330
## + donation_pred      1    28710 37330
## + catalog_shopper    1    28710 37330
## + pet_owner          1    28711 37331
## <none>                    28714 37332
## + interest_religion  1    28712 37333
## + recency            1    28713 37333
## + bad_address        1    28714 37334
## + veteran            1    28714 37334
## 
## Step:  AIC=37024.77
## donated ~ frequency
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## + money              1    28441 36966
## + wealth_rating      1    28493 37018
## + wealth_levels      3    28490 37019
## + has_children       1    28494 37019
## + donation_prob      1    28498 37023
## + interest_veterans  1    28498 37023
## + catalog_shopper    1    28499 37024
## + donation_pred      1    28499 37024
## + age                1    28499 37024
## + imputed_age        1    28499 37024
## + pet_owner          1    28499 37024
## <none>                    28502 37025
## + interest_religion  1    28501 37026
## + recency            1    28501 37026
## + bad_address        1    28502 37026
## + veteran            1    28502 37027
## 
## Step:  AIC=36949.71
## donated ~ frequency + money
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## + wealth_levels      3    28427 36942
## + wealth_rating      1    28431 36942
## + has_children       1    28432 36943
## + interest_veterans  1    28438 36948
## + donation_prob      1    28438 36949
## + catalog_shopper    1    28438 36949
## + donation_pred      1    28438 36949
## + age                1    28438 36949
## + imputed_age        1    28438 36949
## + pet_owner          1    28439 36949
## <none>                    28441 36950
## + interest_religion  1    28440 36951
## + recency            1    28440 36951
## + bad_address        1    28441 36951
## + veteran            1    28441 36952
## 
## Step:  AIC=36945.48
## donated ~ frequency + money + wealth_levels
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## + has_children       1    28416 36937
## + age                1    28424 36944
## + imputed_age        1    28424 36944
## + interest_veterans  1    28424 36945
## + donation_prob      1    28424 36945
## + catalog_shopper    1    28424 36945
## + donation_pred      1    28425 36945
## <none>                    28427 36945
## + pet_owner          1    28425 36946
## + interest_religion  1    28426 36947
## + recency            1    28426 36947
## + bad_address        1    28427 36947
## + veteran            1    28427 36947
## 
## Step:  AIC=36938.4
## donated ~ frequency + money + wealth_levels + has_children
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## + pet_owner          1    28413 36937
## + donation_prob      1    28413 36937
## + catalog_shopper    1    28413 36937
## + interest_veterans  1    28413 36937
## + donation_pred      1    28414 36938
## <none>                    28416 36938
## + interest_religion  1    28415 36939
## + age                1    28416 36940
## + imputed_age        1    28416 36940
## + recency            1    28416 36940
## + bad_address        1    28416 36940
## + veteran            1    28416 36940
## 
## Step:  AIC=36932.25
## donated ~ frequency + money + wealth_levels + has_children + 
##     pet_owner
```

```
## Warning in add1.glm(fit, scope$add, scale = scale, trace = trace, k = k, : using
## the 70916/93462 rows from a combined fit
```

```
##                     Df Deviance   AIC
## <none>                    28413 36932
## + donation_prob      1    28411 36932
## + interest_veterans  1    28411 36932
## + catalog_shopper    1    28412 36933
## + donation_pred      1    28412 36933
## + age                1    28412 36933
## + imputed_age        1    28412 36933
## + recency            1    28413 36934
## + interest_religion  1    28413 36934
## + bad_address        1    28413 36934
## + veteran            1    28413 36934
```

```r
# Estimate the stepwise donation probability
step_prob <- predict(step_model, type="response")

# Plot the ROC of the stepwise model
library(pROC)
ROC <- roc(donors$donated,step_prob)
```

```
## Setting levels: control = 0, case = 1
```

```
## Setting direction: controls < cases
```

```r
plot(ROC, col = "red")
```

![](Chapter3_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

```r
auc(ROC)
```

```
## Area under the curve: 0.5849
```

