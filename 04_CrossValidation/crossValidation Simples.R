#Cross Validation

#Carregando LIBRARIES (Pacotes)
library(ggplot2)

#carregando os dados
#Usando Rdata ao inves do script
#source("CarregamentoDados/loadHousingSmall.R")
load("Dados_RData/housingSmall.Rdata")



#' Método Holdout

#Fixando a semente 
set.seed(1)
corte = 0.75
train_index <- sample(1:nrow(hr),corte*nrow(hr))
hr_train <- hr[train_index,]
hr_test <- hr[-train_index,]

hr_test


# Visualizando os dados
g <- ggplot(data = hr_train,aes(x = area,y = preco))
     #pontos de treinamento
g <- g +  geom_point(colour = "Blue",size = 3) +
     # Pontos de test
     geom_point(data = hr_test,
                aes(x = area,y = preco),
                colour = "red", size = 3) +
     #Labels 
     labs( title = "Preços de Venda de imóveis",
           y = "Preço (x R$1000,00)",
           x = "Área (x 100m2)" )
g


##Modelo inicial - Regressão Linear----
#' Regressao_Simples
hr_lm <- lm(data = hr_train, preco ~ area)

###Alternativa 2 (Usando ggplot e geom_abline() )

g1 <-  g + geom_abline(intercept = hr_lm$coef[1], slope = hr_lm$coef[2],
                color = "Blue", size = 1)

#Plotando segmentos
prev <- predict(hr_lm,hr_test)
prev
df <- hr_test
df["prev"] = prev

g1 + geom_segment(aes(x = area, y = prev,xend = area, yend = preco ),
                 color = "Red",
                 data = df)

mse <- mean((df$preco - df$prev)^2)
mse


#' Modelo Regressão Polinomial quadrática (Cross Validation)

## Regressão Polinomial quadrática----

hr_lm2 <- lm(data = hr_train, preco ~ area + I(area^2))

###Alternativa 2 (Usando ggplot e geom_abline() )

newx = data.frame(area = seq(min(hr_train$area),
                             max(hr_train$area),
                             #Número de pontos
                             length.out = 100))

newx$pred = predict(hr_lm2, newdata = newx)

g2 <-  g + geom_line(data=newx,aes(x = area, y = pred),
                       color = "Blue", size = 1)

#Plotando segmentos
df <- hr_test
df$prev =  predict(hr_lm2,hr_test)

g2 + geom_segment(aes(x = area, y = prev,xend = area, yend = preco ),
                 color = "Red",
                 data = df)

mse <- mean((df$preco - df$prev)^2)
mse


#' Modelo Regressão Polinomial (Cross Validation)

## Regressão Polinomial Overfitting ----

hr_lm3 <- lm(data = hr_train, preco ~ poly(area,17,raw=TRUE))

###Alternativa 2 (Usando ggplot )

newx = data.frame(area = seq(min(hr_train$area),
                             max(hr_train$area),
                             #Número de pontos
                             length.out = 100))

newx$pred = predict(hr_lm3, newdata = newx)

g3 <-  g + geom_line(data=newx,aes(x = area, y = pred),
                     color = "Blue", size = 1)

#Plotando segmentos
df <- hr_test
df$prev =  predict(hr_lm3,hr_test)

g3 + geom_segment(aes(x = area, y = prev,xend = area, yend = preco ),
                  color = "Red",
                  data = df)

mse <- mean((df$preco - df$prev)^2)
mse

