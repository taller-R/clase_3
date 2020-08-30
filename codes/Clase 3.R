# Elaborado por: Eduard F. Martinez Gonzalez
# Fecha: 5 de febrero de 2020
# Nota: No se usan acentos ni caracteres especiales para evitar conflictos entre los diferentes sistemas operativos 


#--------------------------#
# 0. Configuración inicial #
#--------------------------#

#### 0.1 Limpiar la consola, el entorno y fijar directorio de trabajo
cat("\f")
rm(list=ls())
setwd("~/Dropbox/teaching/taller de R/github/Clases/Clase 3") # Cambiar este directorio
getwd()

#### 0.2 Instalar las librerias que vamos a usar en la clase de hoy
for ( paquete in c('tidyverse','readxl','haven') ){
      if (length(grep(paquete,installed.packages()[,1])) == 0 ){ install.packages(paquete)}
      else { print(paste0("La libreria ", "'", paquete ,"'", " ya esta instalada."))}
      rm(paquete)
}

#### 0.3 Llamar las librerias
library('tidyverse') ; library('readxl') ; library('haven')

#------------------------------------------------------#
# 1. Importar bases de datos desde diferentes formatos #
#------------------------------------------------------#


#### 1.1 Inspeccionemos las bases de datos en nuestro directorio de trabajo
list.files("./datos/originales/")


#### 1.2.1 Importar bases de datos en formato .csv
?read.csv2
data_csv <- read.csv2(file = 'datos/originales/censo 2018.csv' ,sep = ",", header = T, stringsAsFactors = F) 
data_csv = data.frame(data_csv) # Convertir en dataframe
str(data_csv) # Inspeccionar las variables del dataframe
"Podemos cargar y convertir la base de datos en un dataframe en una misma linea (usando el operador Pipe)"
data_csv <- read.csv2(file = 'datos/originales/censo 2018.csv' ,sep = ",", header = T, stringsAsFactors = F) %>% data.frame() 


#### 1.2.2 Importar bases de datos en formato .xls y .xlsx (https://www.policia.gov.co/grupo-información-criminalidad/estadistica-delictiva)
excel_sheets(path = 'datos/originales/hurto-personas-2020_0.xlsx') # Hojas que contiene el excel 
?read_excel
data_xls <- read_excel(path = 'datos/originales/hurto-personas-2020_0.xlsx' , sheet = "Sheet1" , col_names = TRUE) # Cargar archivo
str(data_xls) 
head(data_xls)


#### 1.2.3 Importar bases de datos en formato .dta
?read_dta
data_dta <- read_dta(file = 'datos/originales/Area - Caracteristicas generales (Personas).dta') 
str(data_dta)
head(data_dta)


#### 1.2.4 Importar bases de datos en formato .rds
?readRDS # Obtener ayuda de la funcion
data_rds = readRDS(file = 'datos/originales/proyecciones DANE 2005-2020.rds')  %>% data.frame() 
str(data_rds) 


#### 1.2.5 Importar bases de datos en formato .Rdata
?load
load(file = 'datos/originales/proyecciones DANE 2005-2020.Rdata')
str(data_rdata)


#--------------------------------------------#
# 2. Filtrar dataframes (filas y/o columnas) #
#--------------------------------------------#

# Funcion %>% (Pipe)
c("2","4") %>% as.numeric(.) 
c("4","25") %>% as.numeric() %>% sqrt() %>% + 2  
sqrt( as.numeric( c("4","25") ) ) + 2  # Esto es equivalente a la linea anterior
  

#### 2.1.1 Seleccionar columnas de un dataframe usando los nombre de las variables
colnames(data_rdata)

data_rdata_1 = dplyr::select(data_rdata , municipio , `codigo dane` , mes , cantidad) # usar `` cuando hay espacios en los nombres

data_rdata_2 = dplyr::select(data_rdata , -departamento) # Anteponer el - cuando quiero eliminar una variable

data_rdata_3 = data_rdata[,c('municipio' , 'codigo dane' , 'mes' , 'cantidad')] # Usando el vector de los nombres


#### 2.1.2 Seleccionar columnas de un dataframe usando la posicion de las columnas
colnames(data_rdata)

colnames(data_rdata)[c(2,3,9)]

data_rdata_4 = data_rdata[,c(2,3,9)] # Usando el vector de los nombres


#### 2.1.2.1 Veamos la funcion grep
grep(pattern = 'la' , x = c('Hola','Pola','Nada','Todo'))

grep(pattern = 'municipio' , x = colnames(data_rdata))

nombres = c( grep(pattern = 'municipio' , x = colnames(data_rdata)) , 
             grep(pattern = 'codigo dane' , x = colnames(data_rdata)) , 
             grep(pattern = 'mes' , x = colnames(data_rdata)) , 
             grep(pattern = 'cantidad' , x = colnames(data_rdata))
            )


#### 2.1.2.2 Usemos el vector con la posicion de los nombres
data_rdata_5 = data_rdata[,nombres]


#### 2.1.2.3 Limpiemos el entorno de los nuevos objetos que creamos
rm(data_rdata_1,data_rdata_2,data_rdata_3,data_rdata_4,data_rdata_5)

'Revisen en casa esta otra forma de eliminar los objetos que empiezan por data_rdata_ usando la funcion grep'
ls()
grep('data_rdata_',ls())
ls()[grep('data_rdata_',ls())]
rm(list = ls()[grep('data_rdata_',ls())])


#### 2.2 Filtrar filas de un dataframe
'Vamos a sellecionar solo algunas columnas del dataframe data_csv'
View(data_csv)
data_csv = data_csv[,c(2,4,7)]
colnames(data_csv) = c('cod_dane','name_muni','poblacion')
view(data_csv)


#### 2.2.1 Usando la posicion de las filas
nrow(data_csv)
nrow(data_csv)-3
41:(nrow(data_csv)-3)
data_csv_1 = data_csv[41:(nrow(data_csv)-3),]


#### 2.2.2 Usando los atributos de la variable
data_csv_2 = subset(x = data_csv, subset = is.na(name_muni) == F)

data_csv_3 = subset(x = data_csv, subset = is.na(name_muni) == F  & as.numeric(poblacion) > 100000)

data_csv_4 = subset(x = data_csv, subset = is.na(name_muni) == F) %>% 
             subset(as.numeric(poblacion) > 100000)

data_csv_5 = dplyr::filter(data_csv, name_muni %in% c('Medellín','Barranquilla','Cartagena'))

#### 2.2.3 Usando un vector
is.na(data_csv$name_muni) 
data_csv_6 = data_csv[is.na(data_csv$name_muni) == F, ]

data_csv_7 = data_csv[ data_csv$name_muni %in% c('Medellín','Barranquilla','Cartagena') , ]


#### 2.2.4 Limpiemos la memoria una vez mas
rm(list = ls()[grep('data_csv_',ls())])


#---------------------------#
# 3 "Colapsar" un dataframe #
#---------------------------#

#### 3.1 Calculos por grupos
'primero aseguremonos que el factor de expancion sea numerico'
is.numeric(data_dta$fex_c_2011)

'numero de encuestados por sexo'
data_dta %>% group_by(P6020) %>% summarise(total = sum(fex_c_2011))

'numero de encuestados por sexo y ciudad'
sexo_area = data_dta %>% group_by(P6020,area) %>% summarise(total = sum(fex_c_2011))

#### 3.2 Calculos por grupos aplicando filtros

'media de la educacion y la edad por sexo'
data_dta %>% group_by(P6020) %>% summarise(education = weighted.mean(ESC, fex_c_2011) ,  age = weighted.mean(P6040, fex_c_2011))

'limpiemos la variable primero'
is.numeric(data_dta$ESC)
data_dta %>% subset(is.na(ESC)==F) %>% group_by(P6020) %>% summarise(education = weighted.mean(ESC, fex_c_2011) , 
                                                                     age = weighted.mean(P6040, fex_c_2011))

'Hagamos el calculo solo para bogota'
data_dta %>% subset(is.na(ESC)==F & area == 11) %>% group_by(P6020) %>% summarise(education = weighted.mean(ESC, fex_c_2011) , 
                                                                                  age = weighted.mean(P6040, fex_c_2011))


#-----------------------------#
# # 4 Exportar bases de datos #
#-----------------------------#

#### 4.1.1 Exportar bases de datos en formato .csv
?write.csv
write.csv(x = data_csv , file = 'datos/procesados/censo 2018.csv')

#### 4.1.2 Exportar bases de datos en formato .xls y .xlsx 
'deben instalar el paquete WriteXLS, pero puede tener un par de problemas.'
WriteXLS::WriteXLS(x = data_xls, ExcelFileName = "datos/procesados/Hurtos 2020.xlsx" , SheetNames =  "Hurtos") 

#### 4.1.3 Exportar bases de datos en formato .dta
?write_dta
write_dta(data = data_dta ,path = 'datos/procesados/Area - Caracteristicas generales (Personas).dta') 

#### 4.1.4 Exportar bases de datos en formato .rds
?saveRDS
saveRDS(object = data_rds, file = 'datos/procesados/proyecciones DANE 2005-2020.rds')

#### 4.1.5 Exportar bases de datos en formato .Rdata
?save
save(data_rds,data_dta,data_xls,data_csv,data_rdata,file = 'datos/procesados/Datos.Rdata')

