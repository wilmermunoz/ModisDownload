#' Descargar producto Modis
#'
#'Este comando permite realizar la descarga de los productos Modis
#'@import XML
#'@import RCurl
#'@import httr
#'@param Coleccion Corresponde a la colección del producto (int)
#'@param Producto Corresponde al producto (char)
#'@param Salida Corresponde al direcorio de salida (char)
#'@param InicioFecha Corresponde a la fecha inicial (char) <2001-01-01>
#'@param FinFecha Corresponde a la fecha final (char) <2001-12-31>
#'@param LngMin Corresponde al valor mínimo de longitud (char,double) <Coordendas en WGS84-4326>
#'@param LatMin Corresponde al valor mínimo de latitud (char,double) <Coordendas en WGS84-4326>
#'@param LngMax Corresponde al valor máximo de longitud (char,double) <Coordendas en WGS84-4326>
#'@param LatMax Corresponde al valor máximo de latitud (char,double) <Coordendas en WGS84-4326>
#'@return Retorna los archivos almacenados en la ruta de salida
#'@examples DescargarModis(5,"MOD03","C:/DOWNLOAD/MODIS/MOD03/","2001-01-01","2001-12-31",-81.7,-4.2,-66.8,13.3)
#'
#'@examples coleccion = ListarColeccionModis()
#'@examples producto = ListarProductoModis(coleccion[8])
#'@examples salida = "c:/DOWNLOAD/MODIS/MOD03"
#'@examples fecha_o = "2001-01-01"
#'@examples fecha_f = "2001-12-31"
#'@examples lngmin = -81.7
#'@examples latmin = -4.2
#'@examples lngmax = -66.8
#'@examples latmax = 13.3
#'@examples DescargarModis(coleccion[8],producto[213],salida,fecha_o,fecha_f,lngmin,latmin,lngmax,latmax)
#'@export
#'
DescargarModis <- function(Coleccion, Producto,Salida, InicioFecha,FinFecha,LngMin,LatMin,LngMax,LatMax){
search_xml <- getURL("https://wilmermunoz.github.io/index/SearchModis.xml")
search_xml <- readLines(tc <- textConnection(search_xml)); close(tc)
tree_xml <- htmlTreeParse(search_xml,useInternalNodes = T)
search_modis = unlist(xpathApply(tree_xml, '//search', xmlValue))


m_mod <- Producto
m_coll <- Coleccion
m_start <- as.Date(InicioFecha)
m_end <- as.Date(FinFecha)
box_modis<- paste0(LngMin,",",LatMin,",",LngMax,",",LatMax)
folder_mod<- Salida
cafile <- system.file("CurlSSL", "cacert.pem", package = "RCurl")

days_modis <- difftime(m_end,m_start,units = "days")
date_modis <- m_start
name_modis <-''
cont_modis <-0
for (i in 1:(as.numeric(days_modis, units="days")+1)) {
  modis_xml <- GET(paste0(base64Decode(search_modis),'product=',m_mod,
                          '&collection=',m_coll,'&start=',date_modis,'&stop=',date_modis,'&bbox=',box_modis),
                   config(cainfo = cafile))

  modis_html = htmlParse(modis_xml)
  list_mod <- unlist(xpathSApply(modis_html, "//link[@href]", xmlGetAttr, "href"))
  list_ftp <- grep("ftp", list_mod)
  cat("\r", rep.int("#", getOption("width")), sep = "")


  cat("\n\t","\t",m_mod,"\t",toString(date_modis),"\t",length(list_ftp),"Archivos\n\n")


  for(j in 1:length(list_ftp)){
    product <- list_mod[list_ftp[j]]
    vect_product <- strsplit(product, "/")[[1]]
    name_mod <- vect_product[grep(".hdf", vect_product)]
    cat(paste0(j,"/",length(list_ftp),"\t",name_mod,"\n"))
    #download.file(product,destfile=paste0(folder_mod,name_mod),quiet = TRUE)
    GET(product, write_disk(paste0(folder_mod,"/",name_mod), overwrite=TRUE), progress("down"))
    cat("\n")
    cont_modis<- cont_modis+1
    name_modis[cont_modis] <- name_mod
  }
  date_modis <- date_modis+1
}

mod_matr<- as.matrix(name_modis)
colnames(mod_matr)=c("Descargados")
rownames(mod_matr)<- c(1:length(name_modis))
return(mod_matr)

}


