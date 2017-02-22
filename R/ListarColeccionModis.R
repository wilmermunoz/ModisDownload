#' Listar Coleccion de Modis
#'
#'Este comando permite retornar el listado de las colecciones
#'@import XML
#'@import RCurl
#'@import httr
#'@return Retorna el vector del listado de colecciones (list)
#'@examples coleccion = ListarColeccionModis() #list()
#'@export
ListarColeccionModis <- function(){
search_collection <- getURL("ftp://ladsweb.nascom.nasa.gov/allData/")
search_collection <- readLines(tc <- textConnection(search_collection)); close(tc)
list_collection<-strsplit(search_collection," ")
text_collection <- "\nColección Disponibles: \n \n"

list_col <- grep("dr", list_collection)
list_collection_t <- list()
for(j in 1:length(list_col)){

  list_collection_t[j] <- list_collection[list_col[j]]
}
collection <- ""
for(i in 1:length(list_collection_t) ){
  collection[i]<-toString(paste0(list_collection_t[[i]][length(list_collection_t[[i]])]))
  text_collection<-paste0(text_collection,"[",i,"]\t",collection[i],"\n")

}

cat(text_collection,"\nInfo:\thttps://modis-atmos.gsfc.nasa.gov/")
return(invisible(collection))
}
