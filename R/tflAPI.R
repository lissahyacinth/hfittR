#' @title Query an API with Timeout Handling
#' @description 
#' \code{tflAPI(formatted_url = url)} returns a JSON Object or timesout.
#' @param formatted_url URL for querying an API
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET http_type content

tflAPI <- function(formatted_url){
  timeouts = 0
  while(timeouts < 3){
    resp <- GET(formatted_url)
    if(http_type(resp) != "application/json"){
      stop("[tflAPI:: API did not return json]", call. = FALSE)
    }
    timeouts <- timeouts + as.numeric(httrStatusCheck(resp = resp))
    if(timeouts == 0){
      return(fromJSON(content(resp, "text")))
    }
  }
  stop("[tflAPI:: Operation Timed Out - Attempt 3]")
}


