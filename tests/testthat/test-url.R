context("URL Parsing")
test_that("Simple API Parse Works",{
expect_equal(typeof(tflRequest("all lines", app_id = 'test', app_key = 'test', args = list("Mode" = 'overground'))),
           "list")
})