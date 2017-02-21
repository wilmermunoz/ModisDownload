#' Listar productos Modis
#'
#'Este comando permite retornar el listado de los productos modis
#'@import XML
#'@import RCurl
#'@import httr
#'@param coleccion Corresponde a la colección del producto (int)
#'@return Retorna el vector del listado de productos (list)
#'@examples ListarProductoModis(5) #list()
#'
#'@examples coleccion = ListarColeccionModis()[8]
#'@examples ListarProductoModis(coleccion) #list()
#'

ListarProductoModis <- function(coleccion){

  input_collection <- coleccion
  search_mod <- getURL(paste0("ftp://ladsweb.nascom.nasa.gov/allData/",input_collection,"/"))
  search_mod <- readLines(tc <- textConnection(search_mod)); close(tc)
  list_mod<-strsplit(search_mod," ")
  text_modis <- "\nProductos Disponibles: \n \n"

  list_col <- grep("dr", list_mod)
  list_mod_t <- list()
  for(j in 1:length(list_col)){

    list_mod_t[j] <- list_mod[list_col[j]]
  }
  modis_ <- ""
  for(i in 1:length(list_mod_t) ){
    modis_[i]<-toString(paste0(list_mod_t[[i]][length(list_mod_t[[i]])]))
    text_modis<-paste0(text_modis,"[",i,"]\t",modis_[i],"\n")

  }

  cat(text_modis)
  return(modis_)

}
