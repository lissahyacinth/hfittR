#' @title Initialise TfL Connection
#' @description 
#' \code{initTFL} connects the API and creates local tables
#' @importFrom jsonlite fromJSON
#' @importFrom data.table as.data.table data.table fwrite fread rbindlist
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
# Read/Create API Info
api_table <- apiInfo(updateAPIKey = updateAPIKey)
app_id = api_table$app_id
app_key = api_table$app_key

### Update Local Data required for Routing
if(updateRoutes() == TRUE | updateLocalData == TRUE){
  ### User Settings - currently hardcoded
  user_set_mode = "tube"
  
  ### Initialise Routes & Lines for given Mode
  all_routes = tflRequest(request = "all routes", 
    app_id = app_id, 
    app_key = app_key, 
    args = list("Mode" = user_set_mode))
  all_lines =  data.table("lines" = tflRequest(request = "all lines", 
   app_id = app_id, 
   app_key = app_key, 
   args = list("Mode" = user_set_mode))$id)

  route_stations =
  unique(
    rbind(rbindlist(all_routes$routeSections)[, .('stationName' = originationName, 'ID' = originator)],
          rbindlist(all_routes$routeSections)[, .('stationName' = destinationName, 'ID' = destination)])
    )
  
  ### Create the actual mapping required 
  station_mapping = data.table("mode" = '', "line" = '', "station_name" = '', "naptan_code" = '')
  for(line_num in 1:nrow(all_lines)){
  cat(sprintf("Creating Underground Mapping for %s line",all_lines[line_num]))
  station_mapping = rbind(station_mapping, unique(rbindlist(lapply(route_stations$ID, function(x){
    return(
      tflRequest(request = "stopPoints by line station", 
                               app_id = app_id, 
                               app_key = app_key, 
                               args = list("StopPoint" = x, 
                                           "Line" = as.character(all_lines[line_num]) 
                                          ))
        )
  }))[, .("mode" = user_set_mode,
          "line" = all_lines[line_num],
          "station_name" = name, 
          "naptan_code" = id)]), fill = TRUE)
  }
  cat(sprintf("Writing Station Mapping. Discovered %s stations.", (nrow(station_mapping) -1)))
  fwrite(as.data.table(station_mapping[mode != '']), file = "~/.hfittR/station_db.csv")
  fwrite(as.data.table(all_lines), file = "~/.hfittR/all_lines.csv")
  fwrite(as.data.table(route_stations), file=  "~/.hfittR/route_stations.csv")
}
}


