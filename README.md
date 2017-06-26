# hfittR - How Fricked is the Tube?

[![Travis-CI Build Status](https://travis-ci.org/lissahyacinth/hfittR.svg?branch=master)](https://travis-ci.org/lissahyacinth/hfittR)

hfittR comprises of an API for using the [TfL Unified API](https://api.tfl.gov.uk/) in R without the issues introduced by directly calling JSON URLs, and a forecasting package to determine current delays in underground activity compared to forecasted normal activity. 

## Current Status 
Building a series of workers to reliably gather data from TFL and store it locally. Current iteration is pure R, but will be expanding into Ruby to do process control & management. 

## Installation
```R
require(devtools)
install_github("lissahyacinth/hfittR")
```

### API 
```InitTFL()``` 
Create local directory ```~\.hfittr``` to store API information, and builds the tube mapping for all lines. Will take in an APP Key and APP ID. Can be forced with ```InitTFL(updateLocalData = TRUE)```, but takes a few minutes to complete as it determines all endpoints for the tube, then all points along those endpoints. Used for Fuzzy Matching Naptan IDs back to station names.

### Data Storage - Not Started
Storing data using SQLite on a local directory. 

### Forecasting - Not Started
Using a BSTS model with a Causal Impact model to interpret the difference in predicted/actual performance for periods of recorded time.

### Basic Usage
```R
library(hfittR)
api_table <- hfittR:::apiInfo(updateAPIKey = FALSE)
app_id = api_table$app_id
app_key = api_table$app_key
tflDf <- tflRequest(app_id = app_id, 
                    app_key = app_key, 
                    request = "all line arrivals", args = list("Line"= "london-overground"))
```

### Possible Queries

```R
tflRequest(request = VARCHAR, 
              app_id = app_id, 
              app_key = app_key, 
              args = list(VARCHAR)
              )
 ```
Modes are like DLR, Tube, Overground, Lines are the lines that work on that mode, and StopPoints are the stations on that line. StopPoints are all in a NAPTAN id, which is what you need to query any information about that station. The API tries to avoid the hassle of having to go through a process to work out each NAPTAN code by generating a huge table ahead of time, and then (by default) reloads that table every week. 

The order of ownership (seems) to roughly work as follows, as a StopPoint belongs to a Line which belongs to a Mode.

* Mode 
  * Line
    * StopPoint

### Currently Implemented Requests

| Request Name               | Arguments       | Summary                                                               |
|----------------------------|-----------------|-----------------------------------------------------------------------|
| all routes                 | Mode            | Return all routes for that Mode                                       |
| all lines                  | Mode            | Return all lines for that Mode (Victoria, Circle, etc)                |
| all line arrivals          | Line            | Return all arrival data for that Line                                 |
| route section              | StopPoint       | Return Route Sections accessible from that StopPoint                  |
| all modes                  |                 | Return all possible modes                                             |
| route section              | StopPoint       | Return Route Sections accessible from that StopPoint                  |
| arrival prediction         | StopPoint       | Return arrival prediction for that StopPoint                          |
| stopPoints by line station | StopPoint, Line | Return all StopPoints accessible from that StopPoint on provided Line |
| timetable from A to B      | StopPointA,StopPointB, Line| Return all schedules for trips between A and B on provided Line       |
