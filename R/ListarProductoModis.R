#' Listar productos Modis
#'
#'Este comando permite retornar el listado de los productos modis
#'@import XML
#'@import RCurl
#'@import httr
#'@param coleccion Corresponde a la colección del producto (int)
#'@return Retorna el vector del listado de productos (list)
#'@examples productos = ListarProductoModis(5) #list()
#'
#'@examples coleccion = ListarColeccionModis()
#'@examples ListarProductoModis(coleccion[8]) #list()
#'@export

ListarProductoModis <- function(coleccion){

  input_collection <- coleccion
  search_mod <- getURL(paste0("ftp://ladsweb.nascom.nasa.gov/allData/",input_collection,"/"))
  search_mod <- readLines(tc <- textConnection(search_mod)); close(tc)
  list_mod<-strsplit(search_mod," ")

  list_col <- grep("dr", list_mod)
  list_mod_t <- list()
  for(j in 1:length(list_col)){

    list_mod_t[j] <- list_mod[list_col[j]]
  }
  modis_ <- ""
  for(i in 1:length(list_mod_t) ){
    modis_[i]<-toString(paste0(list_mod_t[[i]][length(list_mod_t[[i]])]))

  }
  modis_ <- as.matrix(modis_)
  colnames(modis_)=c("Productos Disponibles")
  rownames(modis_)<- c(1:length(list_col))
  return(modis_)

}
