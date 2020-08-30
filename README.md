# clase_3


## 1. Descargar la clase

Para descargar las clases debes seguir los siguientes pasos:

```{r}
# 1. Establecer el directorio de trabajo en el que quieres descargar la carpeta
setwd("~/Downloads")

# 2. Descargar el repositorio
download.file(url = "https://github.com/taller-R/clase_3/archive/master.zip", 
              destfile = "clase_3.zip")

# 3. Descomprimir las carpeta
unzip(zipfile = "clase_3.zip")

# 4. Cambiar nuevamente el directorio de trabajo
setwd("~/Downloads/clase_3-master")

# 5. Inspeccionar archivos en el directorio 
list.files()
```
O puede seguir las siguientes [instruciones](https://eduard-martinez.github.io/blog/github/clonar_github.html) para crear una version de control de GitHub en Rstudio.  



## 2. Instalar librerias de la clase

Despues de descargar o clonar el repositorio de la clase, usted debe instalar las siguientes librerias:

```{r}
install.packages('tidyverse')
install.packages('readxl') 
install.packages('haven')
```

Ahora debe abrir al archivo **Clase 3.html** de la carpeta **help** y el archivo **Clase 3.R** de la carpeta **codes**.

## 3. Notas
* Los vídeos de la clase se encuentran [aquí](https://www.dropbox.com/sh/49dw2absf405pty/AAD5aPP82qmwjUuy_zzOOADra?dl=0). 

* Por favor hacer todas las correcciones ortográficas a este y los demas archivos .Rmd del repositorio.