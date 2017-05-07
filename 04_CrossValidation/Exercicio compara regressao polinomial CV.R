#Cross Validation CV k fold

#Carregando LIBRARIES (Pacotes)

##lib para gráficos
library(ggplot2)

##lib para ML + Cross validation
library(caret)

#carregando os dados
#Usando Rdata ao inves do script
#source("CarregamentoDados/loadHousingSmall.R")
load("Dados_RData/autoISLR.Rdata")

str(au)
head(au)

##Regressão: Prever mpg ~ horsepower

## Comparando os varios modelos de Regressão polinimial (1 a 8)

#Usando CARET ####

# define training control
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
N <- 8
modelos_list <- list()
for (i in (1:N)){
  m_formula <- paste("mpg ~ poly(horsepower,",i,")",sep="")
  
  model <- train(as.formula(m_formula), data = au, trControl=train_control, method="lm")
  
  modelos_list[[paste("lmPoly_",i,sep = "")]] <- model
}


resamps <- resamples(modelos_list)
resamps
summary(resamps)

	
# BOXPLOTS Comparando os resultados
bwplot(resamps,metric="RMSE")		# boxplot


#Fazendo o gráfico de linha manualmente
#Visualizando RMSE 
sr <-  summary(resamps)

#Capturando os dados de summary()
dfRMSE <- sr$statistics$RMSE

str(dfRMSE)
class(dfRMSE)
#convertendo em data frame para usar em ggplot
dfRMSE <- as.data.frame(dfRMSE)
str(dfRMSE)
#Acrescentando uma coluna para modelos
dfRMSE$i <- seq(1:8)
str(dfRMSE)

g <- ggplot(data = dfRMSE , aes(x = i))
g <- g +  geom_line(aes(y = Mean )) +
  labs( title = "Comparando Modelos",
        x = "Modelos de Regressão:  mpg ~ Poly(horsepower, i)" )
g + scale_x_continuous(breaks = seq(1:8))


##Existe uma grande chance ed que o modelo i=5
# esteja sendo superajustado.
# i= 2 é um modelo mais simples e 
# provavelmente atende aos requisitos


#Outro exemplo:
# resamps <- resamples(list(CART = rpartFit,
#                           CondInfTree = ctreeFit,
#                           MARS = earthFit))

#Para comparar vários modelos o ideal é que a partição seja 
# a mesma, usando a mesma seed antes das partições
# Ref:
# The Design and Analysis of Benchmark Experiments
# Torsten Hothorn, Friedrich Leisch, Achim Zeileis & Kurt Hornik
# Pages 675-699 | Published online: 01 Jan 2012


