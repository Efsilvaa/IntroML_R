#Regress�o Linear M�ltipla ----

#OBS:Put more trust in your script than in your memory,
#    and don't save your workspace.

# Projeto de ML em R Template Basico ----

# 1. Crie um projeto em R ----
# a) Crie e organize o diret�rios
# b) Use esse script como base

# 2. Prepare o Problema ----
# a) Carregue os pacotes necess�rios ----
library(readr)
library(ggplot2)
#Pacote para mapear "missing values"
library(Amelia)
#Pacote para visualizar correla��es
library(corrplot)


# b) Carregue os dados ----

##Importando os dados no R ----

housing <- read_delim("../Dados/housingSmall.csv", 
                         ";", escape_double = FALSE,
                         locale = locale(decimal_mark = ","),
                         trim_ws = TRUE)
View(housing)
hr <- housing

##Preparando os dados ----

###Ajustando os nomes das colunas

###Verificando nomes
colnames(hr)
colnames(hr)[2]

###alterando nome
colnames(hr)[2] = "area"
colnames(hr)[3] = "garagem"
colnames(hr)[4] = "quartos"
colnames(hr)[5] = "preco"

###Checando nomes
colnames(hr)

#Obs: deixarei a coluna "Obs" para mostrar
#     como remover nas an�lises!
#     Mas a melhor solu��o seria elimin�-la 
#     j� na leitura dos dados.

# c) Separe os dados para valida��o ----
#Separa��o simples (ing�nua - n�o estratificada)

#Fixando a semente
set.seed(1)
corte = 0.80
train_index <- sample(1:nrow(hr),corte*nrow(hr))
hr_train <- hr[train_index,]
hr_test <- hr[-train_index,]


# 3. Vis�o Geral Preliminar dos Dados ----
# a) Estat�sticas descritivas 

head(hr_train)
summary(hr_train)

#Valores perdidos

#Exemplo usando coluna "Obs"
hr_train[1:3,"Obs"] = NA
missmap(hr_train, main = "Valores Perdidos vs Observados")

# b) Visualiza��o dos dados 

boxplot(preco ~ quartos, data = hr_train)
boxplot(preco ~ garagem, data = hr_train)

#Correla��o sem a primeira colula
hr_cor <- cor(hr_train[,-1])

corrplot(hr_cor, method = "circle")
corrplot(hr_cor, method = "number",type = "upper")
#Pesquise tamb�m o pacote ggcorplot

pairs(hr_train[,-1])

# 4. Avalia��o do Modelos/Algoritmos ----
# a) Defina as op��es validar e testar seu modelo
#    (ex. cross validation - Ser� abordado mais adiante)

# b) M�trica de avalia��o do modelo
#    (R2 e RMSE)

# c) Selecione um conjunto de modelos/algoritmos de ML 
#    - Usaremos aqui s� a regress�o
hr_lm <- lm(preco ~ ., hr_train[,-1])

summary(hr_lm)

#Analisar as predi��es
hr_pred <- predict(hr_lm, hr_train[,-1])

mse <- mean((hr_train$preco - hr_pred)^2)
mse
sqrt(mse)

#ou para calcular o se (Desvio dos res�duos)
#que aparece no summary()
#dividir por n - p - 1 (11 - 3 - 1) 
sqrt(sum((hr_train$preco - hr_pred)^2)/7)


# 5. Refinamento do modelo ----
#centrando e normalizando os dados (Exceto a vari�vel resposta)

hr_transf <- scale(hr_train[,2:4],center = TRUE, scale = TRUE)

summary(hr_transf)

#scale transforma em matrix
class(hr_transf)
hr_transf <- as.data.frame(hr_transf)
class(hr_transf)

for (i in 1:3)  print(sd(hr_transf[,i]))


#Inserindo preco nos dados transformados
head(hr_transf)
hr_transf[,"preco"] = hr_train[,"preco"]
head(hr_transf)


#Testando comparando v�rios modelos 

hr_modelo1 <- summary(lm(preco ~ ., hr_transf))

resumo <- c(hr_modelo1$adj.r.squared,hr_modelo1$sigma) 
names(resumo) <- c("R^2 ajustado", "se")

hr_modelo2 <- summary(lm(preco ~ quartos + garagem, hr_transf))
resumo <- rbind(resumo,c(hr_modelo2$adj.r.squared,hr_modelo2$sigma)) 

hr_modelo3 <- summary(lm(preco ~ quartos + area, hr_transf))
resumo <- rbind(resumo,c(hr_modelo3$adj.r.squared,hr_modelo3$sigma)) 

hr_modelo4 <- summary(lm(preco ~ quartos + garagem + I(area^2), hr_transf))
resumo <- rbind(resumo,c(hr_modelo4$adj.r.squared,hr_modelo4$sigma)) 

hr_modelo5 <- summary(lm(preco ~ area + quartos + garagem + I(area^2), hr_transf))
resumo <- rbind(resumo,c(hr_modelo5$adj.r.squared,hr_modelo5$sigma)) 
resumo

#O "preco ~ area + quartos + garagem + I(area^2)" parece se o melhor at� aqui!
hr_modelo5

