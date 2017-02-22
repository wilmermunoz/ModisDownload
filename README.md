---
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# ModisDownload

Este paquete permite la descarga de productos MODIS en más de 12 colecciones y 430 productos [info](https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table)


## Requisitos

```r
XML
RCurl
httr
```

## Instalación

```R
devtools::install_github("wilmermunoz/ModisDownload")
```

## Uso


```r
library(ModisDownload)
```

## Ejemplos

```r
Listar colecciones:

coleccion = ListarColeccionModis()
```

```r
Listar productos:

coleccion = ListarColeccionModis()
productos = ListarProductoModis(coleccion[8])
```
```r
Listar años disponibles:

coleccion = ListarColeccionModis()
productos = ListarProductoModis(coleccion[8])
anios = ListarAniosModis(coleccion[8],productos[213])
```
```r
Descargar productos:

coleccion = ListarColeccionModis()
producto = ListarProductoModis(coleccion[8])
salida = "c:/DOWNLOAD/MODIS/MOD03"
fecha_o = "2001-01-01"
fecha_f = "2001-12-31"
lngmin = -81.7
latmin = -4.2
lngmax = -66.8
latmax = 13.3
DescargarModis(coleccion[8],producto[213],salida,fecha_o,fecha_f,lngmin,latmin,lngmax,latmax)

```




---
###Wilmer Muñoz - 2017
---
