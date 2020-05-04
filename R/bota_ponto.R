

#' marcador de decimal
#'
#' @description Função criada para auxiliar baixa_domicilio. Serve para inserir ponto que separa inteiro de decimal.
#'
#' @param x Caracter que vai receber ponto
#' @param apos Quantidade de caracter a esquerda do ponto
#'
#' @return valor com ponto
#' @export
#'
#' @importFrom stringr str_c str_sub
#'
#' @examples
#' bota_ponto("123456")
#' bota_ponto("123456", apos = 2)
#' bota_ponto("123456", 1)
bota_ponto <- function(x, apos = 3) {
  as.numeric(str_c(str_sub(x, end = apos),".",
                   str_sub(x, start = (apos+1))))
}



