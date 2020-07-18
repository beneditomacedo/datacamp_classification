## ---------------------------
## Script name: testing_other_k.R
##
## Purpose of script: Testing other k values
##
## ---------------------------

# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = signs[-1], 
           test = test_signs[-1], cl = sign_types)
mean(k_1 == signs_actual)

# Modify the above to set k = 7
k_7 <- knn(train = signs[-1], 
           test = test_signs[-1], cl = sign_types, k=7)
mean(k_7 == signs_actual)

# Set k = 15 and compare to the above
k_15 <- knn(train = signs[-1], 
            test = test_signs[-1], cl = sign_types, k=15)
mean(k_15 == signs_actual)

