# request_table =
#  data.table("request_name" = c("all routes",
#                                "all lines",
#                                "all line arrivals",
#                                "route section",
#                                "all modes",
#                                "arrival prediction",
#                                "stopPoints by line station",
#                                "timetable from A to B"),
#             "base_url" = c("https://api.tfl.gov.uk/Line/Mode/{Mode}/Route",
#                            "https://api.tfl.gov.uk/Line/Mode/{Mode}",
#                            "https://api.tfl.gov.uk/line/{Line}/arrivals",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/Route",
#                            "https://api.tfl.gov.uk/StopPoint/Meta/Modes",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/Arrivals",
#                            "https://api.tfl.gov.uk/StopPoint/{StopPoint}/CanReachOnLine/{Line}",
#                            "https://api.tfl.gov.uk/Line/{Line}/Timetable/{StopPointA}/to/{StopPointB}"),
#             "args" = I(list(
#                        list("{Q1}" = "Mode"),
#                        list("{Q1}" = "Mode"),
#                        list("{Q1}" = "Line"),
#                        list("{Q1}" = "StopPoint"),
#                        list(""),
#                        list("{Q1}" = "StopPoint"),
#                        list("{Q1}" = "StopPoint",
#                             "{Q2}" = "Line"),
#                        list("{Q1}" = "Line",
#                             "{Q2}" = "StopPoint",
#                             "{Q3}" = "StopPoint"))
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