# request_table =
#  data.table("request_name" = c("all routes",
#                                "all lines",
#                                "route section",
#                                "all modes",
#                                "stopPoints by line station"),
#             "base_url" = c("https://api.tfl.gov.uk/Line/Mode/{Mode}/Route",
#                            "https://api.tfl.gov.uk/Line/Mode/{Mode}",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/Route",
#                            "https://api.tfl.gov.uk/StopPoint/Meta/Modes",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/CanReachOnLine/{Line}"),
#             "args" = I(list(
#                        list("{Q1}" = "Mode"),
#                        list("{Q1}" = "Mode"),
#                        list("{Q1}" = "StopPoint"),
#                        list(""),
#                        list("{Q1}" = "StopPoint",
#                             "{Q2}" = "Line"))
#                        )
#           )
# 
# argument_table =
#   data.table("argument_name" = c("Mode",
#                             "StopPoint",
#                             "Line"),
#              "options" = c("(?:^|(?<= ))(bus|cable-car|coach|cycle|cycle-hire|dlr|interchange-keep-sitting|interchange-secure|national-rail|overground|replacement-bus|river-bus|river-tour|tflrail|tram|tube|walking)(?:(?= )|$)",
#                            "^[0-9]{1,5}[A-Z]*[0-9]?$",
#                            "(?:^|(?<= ))(london-overground|bakerloo|central|circle|district|hammersmith-city|jubilee|metropolitan|northern|piccadilly|victoria|waterloo-city)(?:(?= )|$)"
#              )
#   )
# 
# 
# save(file = "data/request_table.rda", request_table)
# save(file = "data/argument_table.rda", argument_table)