#Introduction on Statistical Learning in R 
library(ISLR)
#Carregando dados Auto

??Auto
data(Auto)
au <- Auto

###Verificando
colnames(au)
str(au)
head(au)

###Ajustando colunas
au$cylinders <- as.factor(au$cylinders)
au$name <- as.character(au$name)

str(au)
head(au)


save(au,file = "Dados_RData/AutoISLR.Rdata")


