#' @title Initialise TfL Connection
#' @description 
#' \code{initTFL} connects the API and creates local tables
#' @importFrom jsonlite fromJSON
#' @importFrom data.table as.data.table data.table fwrite fread
#' @param updateAPIKey Boolean - Update stored API Key?
#' @param updateLocalData Boolean - Update stored data?
#' @export


initTFL <- function(
  updateAPIKey = FALSE, 
  updateLocalData = FALSE
                    ){
## Read Key from a local table
if(!dir.exists("~/.hfittR")){
  dir.create("~/.hfittR")
}
if((!exists("api_table") & !file.exists("~/.hfittR/api_table.csv")) || updateAPIKey == TRUE){
  print("No TfL API Details Found, please enter below:")
  app_id <- readline("App ID:")
  app_key <- readline("App Key:")
  api_table <- data.frame(
    "app_id" = app_id, 
    "app_key" = app_key)
  fwrite(api_table, file = "~/.hfittR/api_table.csv", row.names = FALSE)
}else{
  if(!exists("api_table")){
    api_table = fread("~/.hfittR/api_table.csv")
  }
}
app_id = api_table$app_id
app_key = api_table$app_key

### Update Local Data required for Routing
if(updateRoutes() == TRUE | updateLocalData == TRUE){
  all_routes = tflRequest(request = "all routes", 
    app_id = app_id, 
    app_key = app_key, 
    args = list("Mode" = "overground"))
  all_lines =  data.table("lines" = tflRequest(request = "all lines", 
   app_id = app_id, 
   app_key = app_key, 
   args = list("Mode" = "overground"))$id)

  route_stations =
  unique(
    rbind(as.data.table(all_routes$routeSections)[, .('stationName' = originationName, 'ID' = originator)],
      as.data.table(all_routes$routeSections)[, .('stationName' = destinationName, 'ID' = destination)])
    )
  fwrite(as.data.table(all_lines), file = "~/.hfittR/all_lines.csv")
  fwrite(as.data.table(route_stations), file=  "~/.hfittR/route_stations.csv")
}
}
