# hfittR - How Fricked is the Tube?

hfittR comprises of an API for using the [TfL Unified API](https://api.tfl.gov.uk/) in R without the issues introduced by directly calling JSON URLs, and a forecasting package to determine current delays in underground activity compared to forecasted normal activity. 

## Current Status 
In process of building the API out to a workable form.

### API 
```InitTFL()``` 
Create local directory ```~\.hfittr``` to store API information, and (currently) the tube map. Will take in an APP Key and APP ID. 

### Data Storage - Not Started
The core issue behind hfittR is that there is not a general store for historical Tube performance, and so there needs to be a worker that collects data for however long is required before estimates can be made into 'how fricked is the tube anyway?'. 
This is going to be a SQL storage done within R and SQLLite. 

### Forecasting - Not Started
Using a BSTS model with a Causal Impact model to interpret the difference in predicted/actual performance for periods of recorded time.
