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
install.packages("devtools")
library(devtools)
devtools::install_github("wilmermunoz/ModisDownload")
```

## Uso


```r
library(ModisDownload)
```

## Ejemplos

Listar colecciones:
```r
coleccion = ListarColeccionModis()
```

Listar productos:
```r
coleccion = ListarColeccionModis()
productos = ListarProductoModis(coleccion[8])
```

Listar años disponibles:
```r
coleccion = ListarColeccionModis()
productos = ListarProductoModis(coleccion[8])
anios = ListarAniosModis(coleccion[8],productos[213])
```

Descargar productos:
```r
coleccion = ListarColeccionModis()
producto = ListarProductoModis(coleccion[8])
salida = "c:/DOWNLOAD/MODIS/MOD03"
fecha_o = "2001-01-01"
fecha_f = "2001-12-31"
lngmin = -81.7
latmin = -4.2
lngmax = -66.8
latmax = 13.3
tipo = "hdf"
DescargarModis(coleccion[8],producto[213],salida,fecha_o,fecha_f,lngmin,latmin,lngmax,latmax, tipo)

```




