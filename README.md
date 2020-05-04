
<!-- README.md is generated from README.Rmd. Please edit that file -->

# domiciliocenso2010

Baixa os microdados de domicilio do censo de 2010 e faz os ajustes pelos
pesos dos dados amostrais.

## Installation

You can install the released version of domiciliocenso2010 from GITHUB
with:

``` r
library(devtools)
install_github("ibsenmelo/domiciliocenso2010")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(domiciliocenso2010)
# baixando os dados de Roraima
rr<-baixa_domicilio("RR", delete.dir = FALSE)
```
