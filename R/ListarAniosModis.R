#' Listar años del producto Modis
#'
#'Este comando permite retornar el listado de años existentes en el producto Modis seleccionado
#'@import XML
#'@import RCurl
#'@import httr
#'@param coleccion Corresponde a la colección del producto (int)
#'@param producto Corresponde al producto de Modis (char)
#'@return Retorna el vector del listado de años (list)
#'@examples ListarAniosModis(5,"MOD03") #list()
#'
#'@examples coleccion = ListarColeccionModis()[8]
#'@examples producto = ListarProductoModis(coleccion)[213]
#'@examples ListarAniosModis(coleccion,producto) #list()
#'@export
ListarAniosModis <- function(coleccion, producto){
input_collection <- coleccion
input_producto <- producto
search_anio <- getURL(paste0("ftp://ladsweb.nascom.nasa.gov/allData/",input_collection,"/",input_producto,"/"))
search_anio <- readLines(tc <- textConnection(search_anio)); close(tc)
list_anio<-strsplit(search_anio," ")
text_anio <- "\nAños Disponibles: \n \n"

list_an <- grep("dr", list_anio)
list_anio_t <- list()
for(j in 1:length(list_an)){

  list_anio_t[j] <- list_anio[list_an[j]]
}
anios_ <- ""
for(i in 1:length(list_anio_t) ){
  anios_[i]<-toString(paste0(list_anio_t[[i]][length(list_anio_t[[i]])]))
  text_anio<-paste0(text_anio,"[",i,"]\t",anios_[i],"\n")

}

cat(text_anio)
return(anios_)

}
