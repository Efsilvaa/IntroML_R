####################################################
# Construindo uma MATRIZ/tabela de dados -----------
#   Qualitativos (categoricos) manualmente
####################################################


# In�cio -------------------------------------------

# Observe que o texto no formato acima vira uma sess�o
# no documento, que funciona como um bookmark e aparece
# na barra inferior desta janela 
#---------------------------------------------------

# Exemplo 1 ----
# Ex.: Um engenheiro agr�nomo faz um levantamento das
# principais atividades agr�colas em uma amostra
# contendo 20 propriedades de certa regi�o.

# Valores assumidos pela vari�vel aleat�ria na pesquisa:
# caf� (C), leite (L), silvicultura (S), milho (M),
# soja (So), laranja (LA). 


# Entrada de dados como vetor

at<-c("C","L","L","M","C","M","So","L","L","C","M","C",
      "S","L","C","LA","C","M","C","C")
tab.at<-table(at)

df<-matrix(0,5,3)
colnames(df)<-c("fa","fr","fp")
rownames(df)<-c("Caf�","Leite","Milho","Outras","Total")

df[1,1]<-tab.at["C"]
df[2,1]<-tab.at["L"]
df[3,1]<-tab.at["M"]
df[4,1]<-sum(tab.at["So"], tab.at["S"], tab.at["LA"])
df[5,1]<-length(at)

df
for(i in 1:5) {df[i,2]<-df[i,1]/length(at)}
for(i in 1:5) {df[i,3]<-df[i,2]*100}
df

# Gr�ficos de Barras/Colunas---------------------------------
barplot(df[1:4,2],xlab="Atividade",ylab="Freq��ncia relativa")

# Com cores em cinza e horizontal --------------------------- 
barplot(df[1:4,2],horiz=T,
            col = gray(seq(0.4,1.0,length=4)))

help(barplot)


#Gr�fico de pizza
pie(df[1:4,1])
pie(df[1:4,2])

pie(rep(1,20),col=rainbow(20))
pie(rep(1,40),col=rainbow(40))

pie(df[1:4,2], col= c("red","blue","green","gray"))

# Fim --------------------------

