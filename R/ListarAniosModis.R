#' Listar anios del producto Modis
#'
#'Este comando permite retornar el listado de anios existentes en el producto Modis seleccionado
#'@import XML
#'@import RCurl
#'@import httr
#'@param coleccion Corresponde a la colección del producto (int)
#'@param producto Corresponde al producto de Modis (char)
#'@return Retorna el vector del listado de anios (list)
#'@examples ListarAniosModis(5,"MOD03") #list()
#'
#'@examples coleccion = ListarColeccionModis()
#'@examples producto = ListarProductoModis(coleccion[8])
#'@examples ListarAniosModis(coleccion[8],producto[213]) #list()
#'@export
ListarAniosModis <- function(coleccion, producto){
input_collection <- coleccion
input_producto <- producto
search_anio <- getURL(paste0("ftp://ladsweb.nascom.nasa.gov/allData/",input_collection,"/",input_producto,"/"))
search_anio <- readLines(tc <- textConnection(search_anio)); close(tc)
list_anio<-strsplit(search_anio," ")

list_an <- grep("dr", list_anio)
list_anio_t <- list()
for(j in 1:length(list_an)){

  list_anio_t[j] <- list_anio[list_an[j]]
}
anios_ <- ""
for(i in 1:length(list_anio_t) ){
  anios_[i]<-toString(paste0(list_anio_t[[i]][length(list_anio_t[[i]])]))

}
anios_ <- as.matrix(anios_)
colnames(anios_)=c("Anios Disponibles")
rownames(anios_)<- c(1:length(list_anio_t))
return(anios_)

}
