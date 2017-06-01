checkArgs <- function(argument, expression){
  if(missing(argument)||missing(expression)){
    stop("[checkArgs::] Requires an argument and an expression to be evaluated")
  }
  if(!argument %in% argument_table$argument_name){
    stop(paste0("[checkArgs::] Argument ",argument, " not known - try one of Mode, StopPoint, Line."))
  }
  if(grepl(x = expression, pattern = argument_table[argument_name == argument, options], perl = TRUE) == FALSE){
    stop(paste0("[checkArgs::] Argument ",argument, " doesn't know how to use \"", expression, "\""))
  }
}