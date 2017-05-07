#################################################
# Construção de Tabelas
# Variáveis Qualitativas e qualitativas
# Baseado na aula do Prof. Silvano Cesar da Costa
#################################################


# Primeiros passos -----------------------------

#É interessante definir um diretório de trabalho,
# local "default" para procurar os arquivos de dados.
# Opções:
#  1. Defina um projeto pelo R Studio.
#  2. Use a opção do menu Session/Set working directory
#  3. Use o comando setwd("<new path>")
#     Exemplo: setwd("C:/MyDoc")

#Obs: Use getwd() para mostrar o diretório de trabalho.

# Ao final do trabalho todos os dados da sua sessão
# serão salvos neste diretório.

#

# Leitura dos Dados ---------------------
#
## Opções:
##
##   1. Usar a opção do menu  "Import Dataset"
#        na área "Environment"
# 
##   2. Usar Comando "read.table()
# 
##   Dados separados por espaços (Ex: "mydata.txt")
# 
#     100   a1   b1
#     200   a2   b2
#     300   a3   b3
#     400   a4   b4
# 
# Exemplo:
#   mydata=read.table("mydata.txt") #read text file
#   mydata
#
---
  
  
# Lendo Arquivos de outros formatos ----------------------------

# Melhor opção:
#   Salvar dados como texto e ler com o comando read.table()
# 
# # Lembre-se: No R há sempre um pacote que facilita alguma operação.
# 
#   Alternativa: Usar um dos pacotes disponíveis para o tipo
#                de arquivo desejado
# 
#   Use o comando para instalar no R :
#   >install.packages("nome_do_pacote")
# 
#   E para carregar o pacote na sua sessão:
#   Comandos:
#   >library(nome_do_pacote)           #load package
#   >mydata=read.XXX("mydata.xxx")     #read file
---

#Lendo os dados do arquivo do moodle ------------------------ 


tab3 =read.table("dados1.txt")

# Explorando os dados ----

View(tab3) # Procure por NA´s

# Visualilzando o cabeçalho de dados e a sua estrutura ---- 
names(tab3)
str(tab3)

# Explorando os dados ----
tab3[1:10,]
tab3[1:10,4]
tab3[1, 1:4]
tab3[1:5, 1:5]

# Especificando colunas pelo nome ----  

tab<-tab3[1:3,c('IDADE','SALMIN')]
tab
tab<-tab3[,c('IDADE','SALMIN')]
tab

tab<-tab3[tab3$SALMIN>15,]
tab

# Visualizando o início e fim dos dados ----  

head(tab3)
tail(tab3)

# Sumário dos 5 números ---- 
summary(tab3)

###############################
# Tabela variáveis Qualitativas ---- 
###############################

# Tabela para ESTADO CIVIL ----

table(tab3$ESTCIV)
estado.civil = table(tab3$ESTCIV)
rownames(estado.civil) = c('Casado', 'Solteiro')
estado.civil
addmargins(estado.civil)
addmargins(estado.civil, FUN=list(Total=sum))

# Tabela das Proporções ----
prop.table(estado.civil)
(prop.estciv = round(100*prop.table(estado.civil), 1))
addmargins(prop.estciv, FUN=list(Total=sum))

#------------------------------------------

# Tabela para Grau de Instrução ---

table(tab3$GRAUINSTR)
grau.inst = table(tab3$GRAUINSTR)
rownames(grau.inst) = c('Fundamental', 'Médio','Superior')

grau.inst
addmargins(grau.inst)
addmargins(grau.inst, FUN=list(Total=sum))

#pedindo ajuda no comando 
?addmargins

# Tabela das Proporcoes ----
prop.table(grau.inst)
grau.inst

(prop.grauinstr= round(100*prop.table(grau.inst), 1))
addmargins(prop.grauinstr, FUN=list(Total=sum))

# Outra opção para arrendondar output ----

#grava a configuração anterior e altera a atual
old=options(digits = 2)
prop.table(grau.inst)
# Restaura as opções anteriores
options(old)


# Tabela de Contingência ----

tab = table(tab3$ESTCIV, tab3$GRAUINSTR)
tab

?table



# Gráfico com 2 variáveis ---- 
plot(tab, col="LightYellow")
plot(tab, col="LightYellow", xlab="Estado Civil", ylab='Grau de Instrução',
     main='Tabela de Contingência', las=1, cex.axis=1.1)

mosaicplot(tab)
mosaicplot(tab, las=1, xlab='Estado Civil',
       color=c('lightgreen','lightyellow','red'), ylab='Grau de Instrução',
       main="")

# Gráfico com 3 variáveis ----

tab = table(tab3$ESTCIV, tab3$GRAUINSTR, tab3$PROCED)
tab
mosaicplot(tab, color=1:3, main="Estado Civil x Grau Instrução x Procedência", xlab='Estado Civil', ylab='Grau
             de Instrução', off=5)


#--------------------

# Gráficos de pizza
pie(estado.civil)
pie(estado.civil, labels=c('Casado', 'Solteiro'), radius=1)

pie(estado.civil, labels = paste(c('Casado ', 'Solteiro '), prop.estciv,'%'))
pie(estado.civil, labels = paste(c('Casado ', 'Solteiro '), prop.estciv,'%'), col=c('lightyellow', 'lightgreen'))


pie(estado.civil, labels = paste(c('Casado ', 'Solteiro '), prop.estciv,'%'),
    col=c('lightyellow', 'lightblue'), radius=1, cex=1.5)

pie(estado.civil, labels = paste(c('Casado ', 'Solteiro '), prop.estciv,
     '%'), col=c('lightyellow', 'lightblue'), radius=1, cex=1.5, border='red')

# Forma Direta gráficos de pizza
anim = c(650, 230, 70)
pie(anim)
pie(anim, labels = c('Pequeno Porte','Médio Porte','Grande Porte'))

