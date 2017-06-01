#' @title Check if TfL Data is out of date
#' @description 
#' \code{updateRoutes} returns TRUE/FALSE if data needs updating

updateRoutes <- function(){
  if(file.exists("~/.hfittR/last_init")){
    last_read = read.table("~/.hfittR/last_init")[1,1]
    }else{
      last_read = 0
    }
    if(as.numeric(system("timestamp=$(date +%s);echo $timestamp", intern = T)) - last_read > 60*60*24*7){
      writeLines(system("timestamp=$(date +%s);echo $timestamp", intern = T)
        ,"~/.hfittR/last_init")
      return(TRUE)
    }
    return(FALSE)
  }