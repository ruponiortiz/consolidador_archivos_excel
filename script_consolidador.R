rm(list=ls())
#carga y consolidacion de OCAS de distintos años
# install.packages("dplyr")
# install.packages("plyr")
# install.packages("openxlsx")
#install.packages("readxl")
require(readxl)
require(dplyr)
require (plyr)
#library("openxlsx")

documento<-list.files("archivos")

#dataframe vacio
DATAFRAME<-data.frame()



###Lectura de bases de datos
#notas: por actualizar la informacion del año 2016 y agregar 2017
for(i in 1:length(documento)){
my_data <- read_excel(paste("archivos/",documento[i],sep=""))
my_data$SECTOR<- gsub(".XLS","",toupper(documento[i]))
names(my_data)[1]<-"COD_ESTRUCTURA_GEO"
names(my_data)[3]<-"REGION"
#se le agrega la columna comuna a aquellos que no la poseen
if(ncol(my_data)==6){
  my_data$COMUNA<-my_data$CIUDAD
}


#ordenar el dataframe para que todos queden con las columnas en la misma posicion
my_data<-my_data %>% select(COD_ESTRUCTURA_GEO,PAIS,REGION,CIUDAD,COMUNA,SECTOR)
DATAFRAME<-rbind(DATAFRAME,my_data)
rm(my_data)
}





require(openxlsx)
openxlsx::write.xlsx(DATAFRAME,"CONSOLIDADO_ESTRUCTURA_GEOGRAFICA.xlsx")
