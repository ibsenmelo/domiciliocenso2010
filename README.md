
<!-- README.md is generated from README.Rmd. Please edit that file -->

# domiciliocenso2010

Baixa os microdados de domicilio do censo de 2010 e faz os ajustes pelos
pesos dos dados amostrais.

## Installation

You can install the released version of domiciliocenso2010 from GITHUB
with:

``` r
library(devtools)
library(readr)
install_github("ibsenmelo/domiciliocenso2010")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(domiciliocenso2010)
# baixando os dados de Roraima
rr<-baixa_domicilio("RR", delete.dir = FALSE)
```

Agora basta usar o pacote survey. O exemplo abaixo verifica a renda
média per capita por área de ponderação.

``` r

library(survey)

media_est_rdpc_apond <- svyby(~ v6531, ~v0011, domicrj_plan, svymean, na.rm=TRUE)


result_apond <- cbind(media_est_rdpc_apond$v0011,
                      coef(media_est_rdpc_apond),
                      SE(media_est_rdpc_apond),
                      confint(media_est_rdpc_apond)) 



colnames(result_apond) <- c("apond","Media_rdpc", "SE_Media_rdpc", 
                      "LI_Media_rdpc", "LS_Media_rdpc")

head(result_apond)
```

Salvando o resultado em csv.

``` r
write_csv(as.data.frame(result_apond), "apond_renda_media.csv")
```
