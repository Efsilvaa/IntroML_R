#Introdução ao R Studio

# O básico do básico ....


## Como definir o diretório de trabalho
#   1. Menu principal
#   2. Linha de Comando: getwd() ou setwd()

getwd()

#Precisa de ajuda?

#help nos Comandos
?setwd()

#help nos termos
??histogram

# Áreas da IDE 

# Executando o scritp 
# Marcar o texto a ser executado e pressionar ctrl+enter

# Por isso é interessante usar o caracter de comentário "#", assim
# um código pode ser totalmente executado.

#-------------------------------------------------------------

#Script salvo com arquivo "nome.R"

# pronpt do R ">"

# Operador assign "<-"

#    Hoje em dia funciona com sinal de "="

# Basta usar o comando ctrl+enter para na linha deste arquivo
# quando aberto no editor para executá-lo no Console R
# 
# Execute os comandos para começar a se ambientar no R
#-------------------------------------------------------------
  


## Iniciando uma variável do um valor
  
x <- 1
print(x)

x
msg <- "hello"

## Avaliação
  
x <- 5    ## nada é impresso
x         ## auto-printing 
print(x)  ## o valor é impresso como resultado (nunca é usado!)
          ## já que a opção anterior é mais prática

# O `[1]` indica que `x` é um vetor e `5` é o primeiro elemento.


## Printing
  
x <- 1:20 
x

Para fazer a inicialização e ao mesmo tempo imprimir use
 
(x <- 1:10)  # raramente usado  


  #O operador `:` é usado para criar sequência de inteiros.


  ## Criando Vetores
  
x <- c(0.5, 0.6)       ## numérico
x <- c(TRUE, FALSE)    ## lógico
x <- c(T, F)           ## lógico
x <- c("a", "b", "c")  ## caracter
x <- 9:29              ## inteiro 
x <- c(1+0i, 2+4i)     ## complexo


#Usando a função `vector()`


x <- vector("numeric", length = 10) 
x

## Misturando objetos
  
#  Que tal o seguinte?

y <- c(1.7, "a")   ## character
y <- c(TRUE, 2)    ## numeric
y <- c("a", TRUE)  ## character

# Quando diferentes objetos são misturados em um vetor,
#  a “coerção” (coercion) ocorre de modo que todos os element
#  os do vetor sejam da mesmo classe.


## “Explicit Coercion”
  
#  Os Objetos de um vetor precisam ser explicitamente convertidos para 
#  uma classe única, por meio das funções do tipo `as.*`. 

x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

  ## Explicit Coercion
  
#  Quando uma coerção não é passível de ser realizada, 
#  o resultado será `NA`s (resultado não disponível).

x <- c("a", "b", "c")
as.numeric(x)
# [1] NA NA NA
# Warning message:
#  NAs introduced by coercion
as.logical(x)
#[1] NA NA NA

as.complex(x)
#[1] NA NA NA NA

---
  
  ## Matriz
  
#  Matrizes são vetores com o atributo de dimensão. O atributo
#  de dimensão é um vetor de tamanho 2 (nrow, ncol) significando
#  número de linhas e número de colunas.

m <- matrix(nrow = 2, ncol = 3) 
m
dim(m)
attributes(m)


  ## Matriz (...)
  
  #Matrizes são construídas por colunas, então é como se começássemos 
  #pelo canto superior esquerdo e continuássemos até a última linha,
  #passando para a próxima coluna, e assim por diante.
 
m <- matrix(1:6, nrow = 2, ncol = 3) 
m

  ## Matriz (...)
  
m <- 1:10 
m
dim(m) <- c(2, 5)
m

  ## cbind-ing e rbind-ing (colagem por colunas ou por linhas)
  
  # Matrizes podem ser criadas agregando colunas (_column-binding_)
  # ou linhas (_row-binding_) com `cbind()` and `rbind()`.

x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y) 


  ## Listas (List)
  
  # Listas são tipos especiais de vetores onde cada elemento pode ser
  # de uma classe diferente.

x <- list(1, "a", TRUE, 1 + 4i) 
x

  ## Fatores
  
  # Fatores são usados para representar dados categóricos. 

  
  
x <- factor(c("yes", "yes", "no", "yes", "no")) 
x
table(x) 
x

unclass(x)
attr(x,"levels")


  ## Factors
  
  # A ordem dos níveis pode ser definida usando o argumento
  #`levels` na função `factor()`.
  # Essa é uma consideração importante em Modelos lineares
  # pois o primeiro nível (level) é usado como uma referência (baseline)

x <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))
x
Levels: yes no


  ## “Missing Values” (Valores não obtidos) 
  
  # Missing values são rotulados como
  # 'NA'(Not available ) ou  # 'NaN'(Not a Number)
  # para não permitirem operações matemáticas. 

  # - `is.na()`  é usado para testar se os objetos são `NA`

  # - `is.nan()` é usado para testar se os objetos são `NaN`

  # - `NA` possuem classe.  Desta forma eles são classificados
  #    como `NA`  inteiro, `NA` caracter, etc.

  # - `NaN` também é um `NA` mas o inverso não é verdadeiro.   


  ## Missing Values
  
x <- c(1, 2, NA, 10, 3)
is.na(x)

is.nan(x)

x <- c(1, 2, NaN, NA, 4)

is.na(x)

is.nan(x)


  ## Data Frames
  
#  Data frames são usados para armazenar dados tabulares

# - Eles representam um tipo especial de lista onde todos os elementos (colunas) possuem o mesmo tamanho.

 
# - Cada elemento da lista pode ser pensado como uma coluna (uma variável) do seu conjunto de dados 
# 
# - Diferente das matrizes, data frames podem armazenar diferentes classes de objetos em cada coluna (do mesmo modo que as listas);
#
# - matrizes devem conter apenas elementos da mesma classe
# 
# - Data frames também possuem atributos como `row.names`
# 
# - Data frames são criados automaticamente quando importamos um arquivo de dados usando `read.table()` or `read.csv()`
# 
# - Podem ser convertidos em Matrizes usando a função `data.matrix()`
# 


  ## Data Frames
  
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x
nrow(x)
ncol(x)


  ## Nomes
  
#  Objetos em R podem ter nomes, o que é muito útil para a construção (leitura/escrita) de código fácil de ser entendido
#  Não só o código, mas melhora a descrição dos objetos.

x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf") 
x
names(x)


## Nomes
  
  #Listas também podem conter nomes.

x <- list(a = 1, b = 2, c = 3) 
x
 

  ## Nomes
  
  #  e matrizes.

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 
m
