#Trabalho Regressão Linear Múltipla ----

#OBS:Put more trust in your script than in your memory,
#    and don't save your workspace.

# Preparação dos dados a partir do BostonHousing ----


# 1.Carregando os dados ----

library(mlbench)
library(help = mlbench)

data("BostonHousing")
#View(BostonHousing)

hr <- BostonHousing 
str(hr)


# 2. Separe os dados para validação ----
#Separação simples (ingênua - não estratificada)

#Fixando a semente
set.seed(1)
corte = 0.80
train_index <- sample(1:nrow(hr),corte*nrow(hr))
hr_train <- hr[train_index,]
hr_test <- hr[-train_index,]

write.csv(BostonHousing,"../Dados/BostonHousing.csv", row.names = F)

write.csv(hr_train,"../Dados/BostonHousing_Trabalho.csv", row.names = F)
write.csv(hr_test ,"../Dados/BostonHousing_Test.csv", row.names = F)

