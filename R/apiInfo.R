apiInfo <- function(updateAPIKey = FALSE){
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
 return(api_table) 
}