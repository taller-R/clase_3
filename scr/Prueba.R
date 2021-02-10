# Elaborado por: Eduard Martinez
# Colaborador:
# Fecha elaboracion: 10/02/2021
# Fecha ultima modificacion: 10/02/2021

# initial configuration
rm(list = ls()) # clean environment
pacman::p_load(tidyverse,haven,readxl,WriteXLS) # load packages


a = 2
b = '2'
vector_c = c("hola",'a') # podemos usar ' o " para caracteres
is.character(vector_c)
is.character('hola')





char_vec = c("a","b","c","r","d","a","e","c","a","r","r")


vector2 = c(1,2)

as.numeric(c(1,2,'c'))

a = c(1,2,'3')
b = as.numeric(a)

char_vec[5]
char_vec = char_vec[-5]
char_vec

i,j
matriz_n[1,]
matriz_n[,1]
matriz_n[4,3]

