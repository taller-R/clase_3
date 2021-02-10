# Elaborado por: Eduard Martinez
# Colaboradores:
# Fecha de elaboracion: 05/02/2020
# Ultima modificacion: 10/02/2021

# intial configuration
rm(list = ls()) # limpia el entorno de R
pacman::p_load(tidyverse,readxl,haven,WriteXLS) # cargar y/o instalar paquetes a usar
print('No fijamos un WD porque estamos trabajando en un R-project')

#++++++++++++++++++++++++++++++#
# 1. Estructuras de datos en R #
#++++++++++++++++++++++++++++++#

getwd() # obtener la ruta del directorio de trabajo actual

list.files() # obtener vector nombres de archivos en el wd

list.files(path = '.' , pattern = '.md') # vector nombres archivos markdown (.md)

setwd('ruta del nuevo directorio de trabajo') # Establecer un directorio de trabajo

#++++++++++++++++++++++++#
# 2. Tipos de datos en R #
#++++++++++++++++++++++++#

# carácter
vector_c = c("hola",'a') # podemos usar ' o " para caracteres
is.character(vector_c)

# lógico
vector_l = c(NA,TRUE,FALSE)
is.logical(vector_l)

# númerico
vector_n = c(5,2)
is.numeric(vector_n)

#++++++++++++++++++++++++++++++#
# 3. Estructuras de datos en R #
#++++++++++++++++++++++++++++++#

#--------------------------------------
# Dim |  Homogeneos	 |  Heterogeneos  |
#--------------------------------------
#  1d	|    Vector    |   Listas       |
#  2d	|    Matriz    |   Dataframe    |
#  nd	|    Array     |                |
#--------------------------------------



### Vectores ###

# character
char_vec = c("a","b","c","r","d","a","e","c","a","r","r")
char_vec

# logicos
log_vec = c(TRUE, FALSE, T, F)
log_vec

# numericvos
log_num = 1:10
log_num

# ¡Ojo! Los elementos no son homogeneos
vector2 = c(1,2,"c")
str(vector2)

# transformaciones a vectores
vector2 = as.numeric(vector2) # Los elementos que no se pueden transformar en un n'umero se convierten en NA
str(vector2)

# seleccionar elementos de un vector
char_vec
char_vec[2] # Elemento numero 2
char_vec[1:5] # 5 primeros elementos
char_vec = char_vec[-1] # Eliminar el elemento de la posicion 1 del vector
char_vec
char_vec = char_vec[char_vec != "a"] # Dejar todos los elementos de char_vec diferentes de "a"
char_vec 
!char_vec %in% c("c","r")
char_vec = char_vec[!char_vec %in% c("c","r")] # Eliminar todos los elementos de char_vec que sean diferentes de c y r
char_vec 



### Matrices ###

# generemos una matriz de numeros aleatorios (de una distribucion normal)
matriz_n = matrix(rnorm(n = 25,mean = 100 ,sd = 10) , nrow = 5, ncol = 5) # Matriz de 5*5
matriz_n # Ver la matriz sobre la consola
nrow(matriz_n) # numero de filas
ncol(matriz_n) # numero de columnas
rownames(matriz_n) # nombre de filas
colnames(matriz_n) # nombre de columnas

# cambiemos los nombres de las columnas en una matriz
colnames(matriz_n)
colnames(matriz_n) = c("Columna 1","Columna 2","Columna 3","Columna 4","Columna 5")
colnames(matriz_n)[2] = "Col 2"
matriz_n
rownames(matriz_n) # Cambien ustedes los nombres de las filas

# elementos de una matriz
matriz_n[1,2]
matriz_n[,2]
matriz_n[4,]
A = matriz_n[,3]
A




### Dataframes ###

# generemos un dataframe
nota_numerica = seq(0,10,2)
nota_numerica
nota_alfabetica = c("a","b","b","a","c","b")
nota_alfabetica
dfm = data.frame(nota_numerica,nota_alfabetica) # Creamos el dataframe

# elementos de un dataframe
dfm 
dfm[3,1]
dfm[,2]




### Listas ###

# crear y guardar objetos en una lista
lista = list()
lista[[1]] = dfm
lista[[2]] = matriz_n
lista[[3]] = A

# atributos de una lista
class(lista[[1]]) # Elemento 1
colnames(lista[[1]]) # Elemento 1
class(lista[[2]]) # Elemento 2
colnames(lista[[2]]) # Elemento 2
length(lista) # LArgo de la lista

# ver elementos de una lista
lista
lista[[1]][,2]
lista[[1]][,2]



#+++++++++++++++++++++++++++++++++++++++#
# 4. Importar y exportar bases de datos #
#+++++++++++++++++++++++++++++++++++++++#

# 4.0. Fuente bases de datos
browseURL(url = 'https://www.policia.gov.co/grupo-información-criminalidad/estadistica-delictiva', browser = getOption("browser")) # Datos hurtos
browseURL(url = 'https://www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral', browser = getOption("browser")) # Datos GEIH

# 4.1 Inspeccionemos las bases de datos en nuestro directorio de trabajo
list.files("./data/input/")

# 4.2.1 Importar bases de datos en formato .csv
?read.csv2
data_csv = read.csv2(file = 'data/input/censo 2018.csv' ,sep = ",", header = T, stringsAsFactors = F) 
data_csv = data.frame(data_csv) # Convertir en dataframe
head(data_csv) # Ver primeras observaciones
str(data_csv) # Inspeccionar las variables del dataframe


# 4.2.2 Importar bases de datos en formato .xls y .xlsx (https://www.policia.gov.co/grupo-información-criminalidad/estadistica-delictiva)
excel_sheets(path = 'data/input/hurto-personas-2020_0.xlsx') # Hojas que contiene el excel 
?read_excel
data_xls = read_excel(path = 'data/input/hurto-personas-2020_0.xlsx' , sheet = "Sheet1" , col_names = TRUE) # Cargar archivo
str(data_xls) 
head(data_xls)


# 4.2.3 Importar bases de datos en formato .dta
?read_dta
data_dta = read_dta(file = 'data/input/Area - Caracteristicas generales (Personas).dta') 
str(data_dta)
head(data_dta)


# 4.2.4 Importar bases de datos en formato .rds
?readRDS # Obtener ayuda de la funcion
data_rds = readRDS(file = 'data/input/proyecciones DANE 2005-2020.rds') 
str(data_rds) 


# 4.2.5 Importar bases de datos en formato .Rdata
?load
load(file = 'data/input/proyecciones DANE 2005-2020.Rdata')
str(data_rdata)


# 4.3.1 Exportar bases de datos en formato .csv
?write.csv
write.csv(x = data_csv , file = 'data/output/censo 2018.csv')


# 4.3.2 Exportar bases de datos en formato .xls y .xlsx 
?WriteXLS
WriteXLS(x = data_xls, ExcelFileName = "data/output/Hurtos 2020.xlsx" , SheetNames =  "Hurtos") 


# 4.3.3 Exportar bases de datos en formato .dta
?write_dta
write_dta(data = data_dta ,path = 'data/output/Area - Caracteristicas generales (Personas).dta') 


# 4.3.4 Exportar bases de datos en formato .rds
?saveRDS
saveRDS(object = data_rds, file = 'data/output/proyecciones DANE 2005-2020.rds')


# 4.3.5 Exportar bases de datos en formato .Rdata
?save
save(data_rds,data_dta,data_xls,data_csv,data_rdata,file = 'data/output/Datos.Rdata')

