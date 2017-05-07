#Cross Validation CV k fold

#Carregando LIBRARIES (Pacotes)

##lib para gráficos
library(ggplot2)

##lib para ML + Cross validation
library(caret)

##lib para melt()
library(reshape2)

#carregando os dados
#Usando Rdata ao inves do script
#source("CarregamentoDados/loadHousingSmall.R")
load("Dados_RData/housingSmall.Rdata")

#Usando CARET ####
# define training control
set.seed(100)
train_control <- trainControl(method="cv", number=10)

# train the model
model_CV <- train(preco~area, data=hr, trControl=train_control, method="lm")
# summarize results
# considerando agora somente RMSE
print(model_CV)


# Usando agora repeatedCV
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)

# train the model
model_CVR <- train(preco~area, data=hr, trControl=train_control, method="lm")
# summarize result
print(model_CVR)



## Comparando os varios modelos de Regressão polinimial (1 a 8)

#Loop em train usando as.formula()
#Usando CARET ####
class(model_CVR$results)
str(model_CVR$results)


# define "training control"
set.seed(200)
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)
# treinamento do modelo
modelos <- NULL
for (i in (1:8)){
  m_formula <- paste("preco ~ poly(area,",i,")",sep="")
  model <- train(as.formula(m_formula), data = hr, trControl=train_control, method="lm")
  
  modelos <- rbind(modelos,data.frame(i, model$results))
}

modelos
class(modelos)
str(modelos)

#Visualizando RMSE e RMSESD

#Rsquared não faz muito sentido com os dados novos
#pois ele foi concebido para informar a proporção
#explicada pelo modelo nos dados de "treinamento"
g <- ggplot(data = modelos,aes(x = i))
g <- g +  geom_line(aes(y=RMSE,colour = "RMSE")) 
g <- g + geom_line(aes(y=RMSESD, colour = "RMSESD")) +
     labs( title = "Comparando Modelos",
        x = "Modelos de Regressão Preço ~ Poly(area, x)" )
g + scale_x_continuous(breaks = seq(1:8))

#Melhorando a escala de Y
g + scale_y_continuous(limits = c(0,120))

#Vericicando com a escala de Y
g + scale_y_continuous(limits = c(0,75))




#Outra alternativa usando a função resample em caret
#Usando CARET ####

# define "training control"
set.seed(300)
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
N <- 6   # A partir de 6 inviável
modelos_list <- list()
for (i in (1:N)){
  m_formula <- paste("preco ~ poly(area,",i,")",sep="")
  
  model <- train(as.formula(m_formula), data = hr, trControl=train_control, method="lm")
  
  modelos_list[[paste("lmPoly_",i,sep = "")]] <- model
}


resamps <- resamples(modelos_list)
resamps
summary(resamps)
# BOXPLOTS COMPARING RESULTS
bwplot(resamps,metric="RMSE")		# boxplot


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


#Refazendo o gráfico manualmente

##Entendendo os resultados de resamples
resamps$values
resamps$values$`lmPoly_1~RMSE`
head(resamps$values)

## select variables v1, v2, v3
myvars <- c("Resample","lmPoly_1~RMSE","lmPoly_2~RMSE","lmPoly_3~RMSE")
newdata <- resamps$values[myvars]
str(newdata)

##Melt todas as colunas (2:...) identificadas pela primeira coluna 
dfm <- melt(newdata,id_var = ("Resample"))   #melt do pacote reshape2
head(dfm)

ggplot(dfm, aes(x = variable, y = value)) +
  geom_boxplot()




