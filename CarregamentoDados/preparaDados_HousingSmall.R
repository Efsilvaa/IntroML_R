#Carregando dados small housing

##Carregando pacotes
library(readr)

##Importando os dados no R ----

housing <- read_delim("../Dados/housingSmall.csv", 
                      ";", escape_double = FALSE,
                      locale = locale(decimal_mark = ","),
                      trim_ws = TRUE)
hr <- housing

###Ajustando os nomes das colunas

###Verificando
colnames(hr)
colnames(hr)[2]

###alterando
colnames(hr)[2] = "area"
colnames(hr)[3] = "garagem"
colnames(hr)[4] = "quartos"
colnames(hr)[5] = "preco"

###Checando
colnames(hr)

head(hr)

save(hr,file = "Dados_RData/housingSmall.Rdata")


