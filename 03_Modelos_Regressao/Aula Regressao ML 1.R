#Regress�o Linear

##Preparando os dados ----

###Importando os dados no R ----

library(readr)

##Importando os dados no R ----

housing <- read_delim("../Dados/housingSmall.csv", 
                      ";", escape_double = FALSE,
                      locale = locale(decimal_mark = ","),
                      trim_ws = TRUE)
View(housing)
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


## Visualizando os dados

library(ggplot2)
g <- ggplot(data = hr,aes(x = area,y=preco))
g <- g +  geom_point() +
     labs( title = "Pre�os de Venda de im�veis",
           y = "Pre�o (x R$1000,00)",
           x = "�rea (x 100m2)" )
g
### Inserindo retas verticais ---
#### Quanto custa casa em rela��o aos vizinhos?

g + geom_vline(xintercept = 2.0, size = 2,
                    colour = "green",
                    linetype = "longdash") +
     
     geom_vline(xintercept = c(1.93,2.07),
                colour = "red",
                linetype = "dotdash", size = 1) +

     geom_point(data = hr[10:11,],aes(x = area,y=preco),size=3,colour="red")


##Modelo inicial - Regress�o Linear----
#' Regressao_Simples
hr_lm <- lm(data = hr, preco ~ area)

###Dados da regress�o----
hr_lm
#plot(hr_lm)

###Plotando a reta da regress�o sem ggplot
# Aten��o a sequencia plot(x,y) >>> X primeiro 
plot(hr$area,hr$preco)
abline(hr_lm$coeff)

#ou apenas a op��o abaixo (a fun��o ir� buscar o objeto "coeff" nos argumentos)
abline(hr_lm$coeff)


###Alternativa 2 (Usando ggplot e geom_abline() )
g + geom_abline(intercept = hr_lm$coef[1], slope = hr_lm$coef[2])


### Regress�o Linear (Direto no ggplot) ----
g + stat_smooth(method = lm, se = FALSE, formula = y ~ x,
                   colour = "Black",linetype = "solid") +

    geom_vline(xintercept = 2.0, size = 1,
                    colour = "green",
                    linetype = "longdash")



### Regress�o Linear polinomial quadr�tica----
g + stat_smooth(method = lm, se = FALSE, formula = y ~ poly(x,2, raw=TRUE), colour="Red")


### Regress�o Linear polinomial ----
g + stat_smooth(method = lm, se = FALSE, formula = y ~ poly(x,17,raw=TRUE), colour="Blue")



#' Testando comparando v�rios modelos, mas usando `lm()` e n�o `ggplot`  

hr_modelo1 <- summary( lm(preco ~ area, data = hr))

resumo <- c( 1 , hr_modelo1$adj.r.squared , hr_modelo1$sigma) 
names(resumo) <- c("Modelo" ,"R^2 ajustado", "se")

hr_modelo2 <- summary(lm(preco ~ area + I(area^2), data = hr))
resumo <- rbind(resumo,c(2,hr_modelo2$adj.r.squared,hr_modelo2$sigma)) 


hr_modelo3 <- summary(lm(preco ~ poly(area,17,raw=TRUE), data = hr))
resumo <- rbind(resumo,c( 3, hr_modelo3$adj.r.squared,hr_modelo3$sigma)) 
resumo


