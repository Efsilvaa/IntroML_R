#Regressão Linear Múltipla Trabalho ----

#OBS:Put more trust in your script than in your memory,
#    and don't save your workspace.

# Projeto de ML em R Template Basico ----

# 1. Crie um projeto em R ----
# a) Crie e organize o diretórios
# b) Use esse script como base

# 2. Prepare o Problema ----
# a) Carregue os pacotes necessários ----
library(readr)
library(ggplot2)
#Pacote para mapear "missing values"
library(Amelia)
#Pacote para visualizar correlações
library(corrplot)


# b) Carregue os dados ----

##Importando os dados no R ----

housing <- read_csv("../Dados/BostonHousing_Trabalho.csv")

View(housing)
hr <- housing
str(hr)

# c) Separe os dados para a sua validação ----
#Separação simples (ingênua - não estratificada)

#Fixando a semente
set.seed(1)
corte = 0.80
train_index <- sample(1:nrow(hr),corte*nrow(hr))
hr_train <- hr[train_index,]
hr_test <- hr[-train_index,]


# 3. Visão Geral Preliminar dos Dados ----
# a) Estatísticas descritivas 
# b) Visualização dos dados 

# 4. Avaliação do Modelos/Algoritmos ----
# a) Defina as opções validar e testar seu modelo
# b) Métrica de avaliação do modelo

# 5. Refinamento do modelo ----

