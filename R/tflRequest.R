#' @title Request a JSON object from TfL
#' @description 
#' \code{tflRequest} returns a JSON object
#' @param request Written request, e.g "all lines"
#' @param app_id TfL App ID
#' @param app_key App Key
#' @param args 2D list of arguments to be supplied to the request, e.g. list("Mode" = "underground")
#' @importFrom jsonlite fromJSON
#' @importFrom data.table as.data.table
#' @export


tflRequest <- function(request, 
 app_id, 
 app_key, 
 args = list()){

  if(missing(app_id) || missing(app_key)){
    stop("Requires an App Key and App ID")
  }
  if(missing(request)){
    stop("Requires a request to query")
  }
  
  if(nrow(as.data.table(request_table)[request_name == request]) == 0L){
    stop("No such request found, try one of: 'all routes', 'route type', etc.")
    }else{
      jsonURL = constructUrl(url = as.character(request_table[request_name == request, base_url]), 
        app_id = app_id, 
        app_key = app_key)
    }
    # Check if arguments are required, and if all arguments are provided.  
     if(length(args) != length(as.data.table(request_table)[request_name == request, args][[1]])){
        stop(paste0("[tflRequest:: Missing Arguments]\nRequest: \"", request, 
          "\"\nRequires argument(s): \"",
          paste0(as.data.table(request_table)[request_name == request, args], collapse = ", ") 
          , "\""))
      }
      # Check if arguments required are (roughly) correct
      for(x in 1:length(args)){
        checkArgs(argument = as.character(request_table[request_name == request, args][[1]][x]), 
                  expression = as.character(args[x]))
        jsonURL = gsub(x = jsonURL, pattern = paste0("\\{", names(args[x]), "\\}"), replacement = args[[x]])
      }
    api_resp = tflAPI(formatted_url = jsonURL)
    return(api_resp)
  }