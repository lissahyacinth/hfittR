# hfittR - How Fricked is the Tube?

[![Travis-CI Build Status](https://travis-ci.org/lissahyacinth/hfittR.svg?branch=master)](https://travis-ci.org/lissahyacinth/hfittR)

hfittR comprises of an API for using the [TfL Unified API](https://api.tfl.gov.uk/) in R without the issues introduced by directly calling JSON URLs, and a forecasting package to determine current delays in underground activity compared to forecasted normal activity. 

## Current Status 
In process of building the API out to a workable form.

## Installation
```R
require(devtools)
install_github("lissahyacinth/hfittR", ref = "api")
```

### API 
```InitTFL()``` 
Create local directory ```~\.hfittr``` to store API information, and (currently) the tube map. Will take in an APP Key and APP ID. 

### Data Storage - Not Started
The core issue behind hfittR is that there is not a general store for historical Tube performance, and so there needs to be a worker that collects data for however long is required before estimates can be made into 'how fricked is the tube anyway?'. 
This is going to be a SQL storage done within R and SQLLite. 

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
