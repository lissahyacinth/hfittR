#' @title Query an API with Timeout Handling
#' @description 
#' \code{tflAPI(formatted_url = url)} returns a JSON Object or timesout.
#' @param formatted_url URL for querying an API
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET http_type content

tflAPI <- function(formatted_url){
  timeouts = 0
  while(timeouts < 3){
    resp <- tryCatch({
      GET(formatted_url)
    }, error = function(e){
      timeouts <<- timeouts + 1
      sprintf("[tflAPI:: Request Timed Out, Request %s of 3]", 
              as.character(timeouts))
      return(0L)
    })
    if(typeof(resp) == "list"){
      if(http_type(resp) != "application/json"){
      stop("[tflAPI:: API did not return json]", call. = FALSE)
      }
    }
    if(timeouts == 0){
      return(fromJSON(content(resp, "text")))
    }
  }
  stop(sprintf("[tflAPI:: Operation Timed Out - Attempt %s of 3]", 
               as.character(timeouts)))
}


