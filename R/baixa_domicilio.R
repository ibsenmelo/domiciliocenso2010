

#' @title baixa dados de domicilio
#'
#' @param estado_sigla Sigla do estado
#'
#' @param delete.dir apagar pasta com os arquivos baixados. Default TRUE. Modificar para FALSE caso queira manter os dados originais.
#'
#' @return dados ajustados pelos pesos do desenho amostral
#'
#' @importFrom stringr str_detect str_c
#'
#' @importFrom readr read_fwf fwf_cols
#'
#' @importFrom dplyr inner_join
#'
#' @importFrom survey svydesign
#'
#' @importFrom stats aggregate
#'
#' @importFrom utils download.file unzip
#'
#' @export
#'
#' @examples
#' # baixando os dados de Roraima
#' # rr<-baixa_domicilio("RR", delete.dir = FALSE)
baixa_domicilio <- function(estado_sigla, delete.dir = TRUE) {


  file.path<-"ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/"

  data.file <- str_c(file.path,estado_sigla,".zip")

  dir.create("pasta_temp") # cria uma pasta para baixar os dados

  download.file ( data.file , "pasta_temp/tempo.zip")

  unzip("pasta_temp/tempo.zip" , exdir ="./pasta_temp")

  files<-list.files(str_c("pasta_temp/",estado_sigla,"/"))

  path_1<- str_c("pasta_temp/",estado_sigla,"/",files[str_detect(files, "Domicilio")])


  teste1 = read_fwf(path_1,
                    fwf_cols(v0001 = 2, v0002 =  5, v0011 = 13, v0300 = 8, v0010 = 16, v1001 = 1, v1002 = 2,
                             v1003 = 3, v1004 =  2, v1006 =  1, v4001 = 2, v4002 =  2, v0201 = 1, v2011 = 6,
                             v2012 = 9, v0202 =  1, v0203 =  2, v6203 = 3, v0204 =  2, v6204 = 3, v0205 = 1,
                             v0206 = 1, v0207 =  1, v0208 =  2, v0209 = 1, v0210 =  1, v0211 = 1, v0212 = 1,
                             v0213 = 1, v0214 =  1, v0215 =  1, v0216 = 1, v0217 =  1, v0218 = 1, v0219 = 1,
                             v0220 = 1, v0221 =  1, v0222 =  1, v0301 = 1, v0401 =  2, v0402 = 1, v0701 = 1,
                             v6529 = 7, v6530 = 10, v6531 =  8, v6532 = 9, v6600 = 30))



  if (delete.dir == TRUE) {
    unlink("pasta_temp", recursive = TRUE)  # apaga a pasta criada anteriormente
  }


  teste1$v0010<-bota_ponto(teste1$v0010)
  teste1$v6530<-bota_ponto(teste1$v6530,5)
  teste1$v6531<-bota_ponto(teste1$v6531,6)
  teste1$v6532<-bota_ponto(teste1$v6532,4)

  domicrj_dat<-as.data.frame(sapply(teste1, as.numeric))

  tamanho_pop <- aggregate(v0010 ~ v0011, data=domicrj_dat, FUN="sum")

  names(tamanho_pop) <- c("v0011", "Ndompop")

  domicrj_dat <- inner_join(domicrj_dat, tamanho_pop, by="v0011")



  (svydesign(data=domicrj_dat,
             ids = ~1,
             strata = ~v0011,
             fpc = ~Ndompop ,
             weights = ~v0010))

}



