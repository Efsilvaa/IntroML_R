# Parameter Tuning - Cross Validation
# Problema de refressão utilizadndo KNN 
# KNN
# Two Class data
# Exemplo from Max Kuhn
# Prof. Eduardo F. Silva


#Carregando Library
library(ggplot2)

#Carregamento dos dados ----

#Produção inicial dos dados*************************
#library(AppliedPredictiveModeling)
# data(twoClassData)
# 
# pp <- predictors
# 
# pp$classes <- classes
# save(pp,file = "./Dados_RData/twoClassData.Rdata")
#***************************************************

load("./Dados_RData/twoClassData.Rdata")

#Analisando e visualizando os dados
head(pp)
str(pp)
summary(pp)


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

save(pp,file = "./Dados_RData/regressaoKNNcv_pp.Rdata")

