% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ListarProductoModis.R
\name{ListarProductoModis}
\alias{ListarProductoModis}
\title{Listar productos Modis}
\usage{
ListarProductoModis(coleccion)
}
\arguments{
\item{coleccion}{Corresponde a la colección del producto (int)}
}
\value{
Retorna el vector del listado de productos (list)
}
\description{
Este comando permite retornar el listado de los productos modis
}
\examples{
productos = ListarProductoModis(5) #list()

coleccion = ListarColeccionModis()
ListarProductoModis(coleccion[8]) #list()
}
