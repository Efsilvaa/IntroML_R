set.seed(300)
indxTrain <- createDataPartition(y = Smarket$Direction,p = 0.75,list = FALSE)
training <- Smarket[indxTrain,]
testing <- Smarket[-indxTrain,]

#Checking distibution in origanl data and partitioned data
prop.table(table(training$Direction)) * 100
## 
##  Down    Up 
## 48.19 51.81
prop.table(table(testing$Direction)) * 100
## 
##  Down    Up 
## 48.08 51.92
prop.table(table(Smarket$Direction)) * 100
## 
##  Down    Up 
## 48.16 51.84
creteDataParition function creates sample very effortlessly. We don't need to write complex function like previous example

Training and train control
set.seed(400)
ctrl <- trainControl(method="repeatedcv",repeats = 3) #,classProbs=TRUE,summaryFunction = twoClassSummary)
knnFit <- train(Direction ~ ., data = training, method = "knn", trControl = ctrl, preProcess = c("center","scale"), tuneLength = 20)

#Output of kNN fit
knnFit
## k-Nearest Neighbors 
## 
## 938 samples
##   8 predictors
##   2 classes: 'Down', 'Up' 
## 
## Pre-processing: centered, scaled 
## Resampling: Cross-Validated (10 fold, repeated 3 times) 
## 
## Summary of sample sizes: 844, 844, 844, 845, 844, 845, ... 
## 
## Resampling results across tuning parameters:
## 
##   k   Accuracy  Kappa  Accuracy SD  Kappa SD
##   5   0.9       0.7    0.04         0.07    
##   7   0.9       0.8    0.04         0.08    
##   9   0.9       0.8    0.04         0.08    
##   10  0.9       0.8    0.03         0.07    
##   10  0.9       0.8    0.03         0.07    
##   20  0.9       0.8    0.03         0.06    
##   20  0.9       0.8    0.03         0.07    
##   20  0.9       0.8    0.04         0.08    
##   20  0.9       0.8    0.03         0.07    
##   20  0.9       0.8    0.03         0.07    
##   20  0.9       0.8    0.03         0.06    
##   30  0.9       0.8    0.03         0.06    
##   30  0.9       0.8    0.03         0.07    
##   30  0.9       0.8    0.03         0.07    
##   30  0.9       0.8    0.03         0.07    
##   40  0.9       0.8    0.03         0.07    
##   40  0.9       0.8    0.03         0.06    
##   40  0.9       0.8    0.03         0.06    
##   40  0.9       0.8    0.03         0.06    
##   40  0.9       0.8    0.03         0.05    
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was k = 23.
#Plotting yields Number of Neighbours Vs accuracy (based on repeated cross validation)
plot(knnFit)
plot of chunk unnamed-chunk-3

knnPredict <- predict(knnFit,newdata = testing )
#Get the confusion matrix to see accuracy value and other parameter values
confusionMatrix(knnPredict, testing$Direction )
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down  Up
##       Down  123   8
##       Up     27 154
##                                         
##                Accuracy : 0.888         
##                  95% CI : (0.847, 0.921)
##     No Information Rate : 0.519         
##     P-Value [Acc > NIR] : < 2e-16       
##                                         
##                   Kappa : 0.774         
##  Mcnemar's Test P-Value : 0.00235       
##                                         
##             Sensitivity : 0.820         
##             Specificity : 0.951         
##          Pos Pred Value : 0.939         
##          Neg Pred Value : 0.851         
##              Prevalence : 0.481         
##          Detection Rate : 0.394         
##    Detection Prevalence : 0.420         
##       Balanced Accuracy : 0.885         
##                                         
##        'Positive' Class : Down          
## 
mean(knnPredict == testing$Direction)
## [1] 0.8878
#Now verifying 2 class summary function

ctrl <- trainControl(method="repeatedcv",repeats = 3,classProbs=TRUE,summaryFunction = twoClassSummary)
knnFit <- train(Direction ~ ., data = training, method = "knn", trControl = ctrl, preProcess = c("center","scale"), tuneLength = 20)
## Loading required package: pROC
## Type 'citation("pROC")' for a citation.
## 
## Attaching package: 'pROC'
## 
## The following objects are masked from 'package:stats':
## 
##     cov, smooth, var
## Warning: The metric "Accuracy" was not in the result set. ROC will be used
## instead.
#Output of kNN fit
knnFit
## k-Nearest Neighbors 
## 
## 938 samples
##   8 predictors
##   2 classes: 'Down', 'Up' 
## 
## Pre-processing: centered, scaled 
## Resampling: Cross-Validated (10 fold, repeated 3 times) 
## 
## Summary of sample sizes: 844, 844, 845, 843, 844, 844, ... 
## 
## Resampling results across tuning parameters:
## 
##   k   ROC  Sens  Spec  ROC SD  Sens SD  Spec SD
##   5   0.9  0.8   0.9   0.03    0.07     0.05   
##   7   1    0.8   0.9   0.02    0.06     0.05   
##   9   1    0.8   0.9   0.02    0.07     0.05   
##   10  1    0.8   0.9   0.02    0.07     0.05   
##   10  1    0.8   0.9   0.02    0.07     0.05   
##   20  1    0.9   0.9   0.02    0.06     0.04   
##   20  1    0.9   0.9   0.02    0.06     0.04   
##   20  1    0.9   0.9   0.02    0.07     0.03   
##   20  1    0.9   0.9   0.01    0.06     0.03   
##   20  1    0.9   0.9   0.01    0.06     0.03   
##   20  1    0.9   0.9   0.01    0.07     0.03   
##   30  1    0.9   0.9   0.01    0.06     0.03   
##   30  1    0.8   0.9   0.01    0.07     0.03   
##   30  1    0.8   0.9   0.01    0.06     0.03   
##   30  1    0.8   0.9   0.01    0.07     0.03   
##   40  1    0.8   0.9   0.01    0.06     0.03   
##   40  1    0.8   0.9   0.01    0.06     0.03   
##   40  1    0.8   0.9   0.01    0.06     0.02   
##   40  1    0.8   0.9   0.01    0.06     0.02   
##   40  1    0.8   0.9   0.01    0.06     0.03   
## 
## ROC was used to select the optimal model using  the largest value.
## The final value used for the model was k = 43.
#Plotting yields Number of Neighbours Vs accuracy (based on repeated cross validation)
plot(knnFit, print.thres = 0.5, type="S")
plot of chunk unnamed-chunk-3

#Checking distibution in origanl data and partitioned data
prop.table(table(pp$classes)) * 100

g <- ggplot(data = pp, aes(x = PredictorA, y = PredictorB))

g + geom_point(aes(shape = classes, color = classes), size = 2)

#Adicionar coluna y = contínuo dif from factor
set.seed(100)
n = length(pp)
rA = rnorm(n, mean = 1)
rB = rnorm(n, mean = 2)
rC = runif(n)
pp$valor = pp$PredictorA*rA + pp$PredictorB*rB + ifelse(pp$classes == "Class1", 1, 2)*rC

save(pp,file = )

