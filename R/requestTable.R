# request_table =
#  data.table("request_name" = c("all routes",
#                                "all lines",
#                                "route section",
#                                "all modes"),
#             "base_url" = c("https://api.tfl.gov.uk/Line/Mode/{Mode}/Route",
#                            "https://api.tfl.gov.uk/Line/Mode/{Mode}",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/Route",
#                            "https://api.tfl.gov.uk/StopPoint/Meta/Modes"),
#             "args" = c(list("{Q1}" = "Mode"),
#                        list("{Q1}" = "Mode"),
#                        list("{Q1}" = "StopPoint"),
#                        list(""))
#           )
# 
# argument_table = 
#   data.table("argument_name" = c("Mode", 
#                             "StopPoint"), 
#              "options" = c("(?:^|(?<= ))(bus|cable-car|coach|cycle|cycle-hire|dlr|interchange-keep-sitting|interchange-secure|national-rail|overground|replacement-bus|river-bus|river-tour|tflrail|tram|tube|walking)(?:(?= )|$)", 
#                            "")
#   )
# 
# 
# save(file = "data/request_table.rda", request_table)
# save(file = "data/argument_table.rda", argument_table)