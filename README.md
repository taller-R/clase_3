# INSTRUCCIONES


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
O puede seguir [estas](https://eduard-martinez.github.io/blog/github/clonar_github.html) instruciones para crear una versión de control de Git en Rstudio que contenga este repositorio.  



## 2. Leer las instrucciones iniciales

Despues de descargar o clonar el repositorio de la clase, usted debe abrir el archivo **Intro-clase-3.html** que se encuentra dentro de la carpeta del repositorio. Siga atentamente las instrucciones.



## 3. Script de la clase

Ahora puedes ir a la carpeta **codes** y abrir el script **Clase 4.R** para replicar la clase.

## 4. Notas

* Los vídeos de la clase se encuentran [aquí](https://www.dropbox.com/sh/49dw2absf405pty/AAD5aPP82qmwjUuy_zzOOADra?dl=0). Nota: Dropbox no deja reproducir los vídeos más de 1 hora en linea, debe descargarlos para que pueda verlos completos. 

* Por favor hacer todas las correcciones ortográficas a este y los demas archivos .Rmd del repositorio.