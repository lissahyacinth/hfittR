#' @title Format a URL for TfL API
#' @description 
#' \code{constructUrl} returns a formatted URL with AppID and AppKey
#' @param url - Origin URL 
#' @param app_id TfL App ID
#' @param app_key App Key

constructUrl <- function(url, app_id, app_key){
	if(missing(app_id) || missing(app_key)){
		stop("Requires an App Key and App ID")
	}
	if(missing(url)){
		stop("Requires a URL to query")
	}
	return(paste0(url, "?app_id=", app_id, "&app_key=", app_key))
	
	
}