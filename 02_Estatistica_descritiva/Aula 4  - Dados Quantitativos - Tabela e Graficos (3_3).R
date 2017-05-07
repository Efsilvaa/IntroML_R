# Construção da tabela de frequências de dados contínuos ----

#Pesos de cães

caes = c( 5.5, 19.0, 28.0, 30.0, 33.0, 40.0, 40.0, 40.3, 40.5,
          12.6, 12.6, 14.2, 14.2, 17.5, 17.5, 18.0, 19.0, 19.2, 21.0, 21.0,
          27.0, 27.0, 27.0, 27.2, 28.0, 28.0, 30.0, 30.0, 39.8, 13.5)


# Media ----
mean(caes)

#Mediana ----
median(caes) 

#Quartis ----
quantile(caes)

#Percentis ----
# Exemplo: (0.32, .60, .72)
quantile(caes,c(0.32, .60, .72))

# Histogramas de frequência----
hist(caes)

#Max e Min ----
range(caes)

#Amplitude ----
max(caes) - min(caes)

# ou use diff
diff(range(caes))

# Distância interquartil ----
IQR(caes)

#Variancia amostral ----
var(caes)

#Desvio padrão ----
sd(caes)

#Sumário das 5 medidas ----
# Obs: totalizando 6 medidas :)

# min e max, média e mediana e quartis
summary(caes)

#Gráficos -----------

#boxplot
  boxplot(caes)

#agregando mais informações da posição dos dados
  boxplot(caes)
  rug(caes, side = 2)

# com cor fica melhor
  rug(caes, side = 2,col = "light blue")


#Histograma de frequência
?hist
hist(caes)
rug(caes, side = 1,col = "red")

# Histograma de densidade ----

hist(caes, freq=F)

#Mostrando que o histograma é sensivel
# ao número de barras
hist(caes,  breaks=2)
hist(caes, freq=F, breaks=4)
hist(caes, freq=F, breaks=8)

#incluindo uma linha de densidade de probabilidade
lines(density(caes), col="darkgreen", lwd=2)
rug(caes, side = 1,col = "dark blue")

# veja o help da função rug()
?rug()

# Retornando a nossa tabela de dados tab3 

# Media eliminando NA's----
# Tente tirar a média de uma variável contendo NA's
mean(tab3$NFILHOS) #com NA's

#Agora sem considerá-los 
mean(tab3$NFILHOS,na.rm=T) #sem considerar NA's


#Mediana ----
# Media eliminando NA's----
# Tente calcular contendo NA's
median(tab3$NFILHOS) #com NA's

#Agora sem considerá-los 
median(tab3$NFILHOS,na.rm=T) #sem considerar NA's


#Quartis ----
quantile(caes)

# Gráfico de ramos e folhas (steam and leaf)

stem(tab3$SALMIN)

# Compare com o histograma
hist(tab3$SALMIN,freq=F)
lines(density(tab3$SALMIN), col="darkgreen", lwd=2)

#Vamos ver a distribuição de probabillidade acumulada
x=ecdf(tab3$SALMIN)
plot(x)

#distribuição dos pontos
stripchart(tab3$IDADE)
#distribuição dos pontos na ordem dos registro
dotchart(tab3$IDADE)


# Relacionando variável categórica com variável quantitativa ----
#Voltando ao box plot
boxplot(tab3$SALMIN ~ tab3$ESTCIV)

# Gráficos  variáveis contínuas ----
dotchart(tab3$IDADE)
stripchart(tab3$IDADE)

# Gráfico de pontos ------
plot(tab3$SALMIN~tab3$IDADE)

# tentando visualizar a associação com outra variável ----
plot(tab3$SALMIN~tab3$IDADE, col = tab3$NFILHOS)

# sairam alguns pontos nas baixas idades?
tab<-tab3[tab3$IDADE<30,]
tab

plot(tab3$SALMIN~tab3$IDADE, col = (tab3$NFILHOS+10))
tab3[is.na(tab3$NFILHOS),]


