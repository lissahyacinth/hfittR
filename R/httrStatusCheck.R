#' @title Check HTTR Response against common HTTP Codes
#' @description 
#' \code{httrStatusCheck(resp = resp)} returns 0,1, or declares an error.
#' @param resp Response object from \code{httr::GET(url)}
#' @importFrom httr status_code http_error
#' @importFrom jsonlite fromJSON

httrStatusCheck <- function(resp){
  switch(as.character(status_code(resp)),
         "200" = return(0),
         "408" = return(1)
         )
  if(http_error(resp)){
    stop(
      sprintf(
        "[httrStatusCheck:: TfL Request Failed [%s]\n%s\n<%s>]",
        status_code(resp),
        fromJSON(content(resp, "text"))$message,
        fromJSON(content(resp, "text"))$documentation_url
      )
    )
  }
}