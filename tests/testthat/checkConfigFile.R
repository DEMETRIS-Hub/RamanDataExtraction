source("./.../../R/checkConfigFile.R")

library(testthat)

#' util_default_base_list
#' 
#' This utility function return a new default list 
#' @return default list 
util_default_base_list <- function(){
  return(
    list(datasetDir="dflt_datasetDir",
         fieldBookFilename="dftl_fieldBookFilename",
         id="dflt_id",
         date="dflt_date",
         startTime="dflt_startTime",
         endTime="dflt_endTime",
         spectrumNb="dflt_spectrumNb", 
         destSubDir="dflt_destSubDir",
         outputFilename="dflt_outputFilename",
         location="dflt_location",
         block="dflt_block",
         factor1="dflt_factor1",
         factor2="dflt_factor2")
  )
}

#' util_check_missing_param_error
#' 
#' This utility function provide the default setup for testing missing parameter error  
#' @parameter missing parameter
#' @return void
util_check_missing_param_error <- function(param) {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), param)]
  
  expect_error(
    checkNamedParameter(input_list),
    paste0("Missing compulsory parameter: ", param),
    fixed = TRUE
  )
}



test_that("Check nominal case ", {
  # 1. Setup: Create input and expected output
  input_list <- util_default_base_list()
  expected_output <- util_default_base_list()
  
  # 2. Action: Run the function
  actual_output <- checkNamedParameter(input_list)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})


test_that("Check missing datasetDir ", {
  # 1. Setup: Create input and expected output
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "datasetDir")]
  # 2. Action: Run the function
  # 3. Expectation: Check error
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: datasetDir",
               fixed=TRUE)
})


test_that("Check empty datasetDir ", {
  # 1. Setup: Create input and expected output
  input_list <- util_default_base_list()
  input_list[["datasetDir"]] = "" 
  
  # 2. Action: Run the function
  # 3. Expectation: Check error
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: datasetDir",
               fixed=TRUE)
})


test_that("Check missing fieldBookFilename ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "fieldBookFilename")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: fieldBookFilename",
               fixed=TRUE)
})

test_that("Check empty fieldBookFilename ", {
  input_list <- util_default_base_list()
  input_list[["fieldBookFilename"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: fieldBookFilename",
               fixed=TRUE)
})

test_that("Check missing id ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "id")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: id",
               fixed=TRUE)
})

test_that("Check empty id ", {
  input_list <- util_default_base_list()
  input_list[["id"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: id",
               fixed=TRUE)
})

test_that("Check missing date ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "date")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: date",
               fixed=TRUE)
})

test_that("Check empty date ", {
  input_list <- util_default_base_list()
  input_list[["date"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: date",
               fixed=TRUE)
})


test_that("Check missing startTime ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "startTime")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: startTime",
               fixed=TRUE)
})

test_that("Check empty startTime ", {
  input_list <- util_default_base_list()
  input_list[["startTime"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: startTime",
               fixed=TRUE)
})
test_that("Check missing endTime ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "endTime")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: endTime",
               fixed=TRUE)
})

test_that("Check empty endTime ", {
  input_list <- util_default_base_list()
  input_list[["endTime"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: endTime",
               fixed=TRUE)
})

test_that("Check missing spectrumNb ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "spectrumNb")]
  
  expect_error(checkNamedParameter(input_list),
               "Missing compulsory parameter: spectrumNb",
               fixed=TRUE)
})

test_that("Check empty spectrumNb ", {
  input_list <- util_default_base_list()
  input_list[["spectrumNb"]] = "" 
  
  expect_error(checkNamedParameter(input_list),
               "Empty compulsory parameter: spectrumNb",
               fixed=TRUE)
})