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


### nominal case
test_that("Check nominal case ", {
  # 1. Setup: Create input and expected output
  input_list <- util_default_base_list()
  expected_output <- util_default_base_list()
  
  # 2. Action: Run the function
  actual_output <- checkNamedParameter(input_list)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})

### compulsory parameter 
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
### optional parameter with default
test_that("Check missing destSubDir ", {
  base_list <- util_default_base_list()
  input_list <- base_list[setdiff(names(base_list), "destSubDir")]
  
  expect_output <- util_default_base_list()
  expect_output[["destSubDir"]] = "./out/" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Missing optional parameter: destSubDir -> set default: ./out/",
                 fixed=TRUE)
  expect_setequal(actual_output, expect_output)
  })

test_that("Check empty destSubDir ", {
  base_list <- util_default_base_list()
  input_list <- base_list
  input_list[["destSubDir"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["destSubDir"]] = "./out/" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Empty optional parameter: destSubDir -> set default: ./out/",
                 fixed=TRUE)
  expect_setequal(actual_output, expect_output)
})


test_that("Check missing outputFilename ", {
  base_list <- util_default_base_list()
  input_list <- base_list[setdiff(names(base_list), "outputFilename")]
  
  expect_output <- util_default_base_list()
  expect_output[["outputFilename"]] = "campaign_sumup.xlsx" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Missing optional parameter: outputFilename -> set default: campaign_sumup.xlsx",
                 fixed=TRUE)
  expect_setequal(actual_output, expect_output)
})

test_that("Check empty outputFilename ", {
  base_list <- util_default_base_list()
  input_list <- base_list
  input_list[["outputFilename"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["outputFilename"]] = "campaign_sumup.xlsx" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Empty optional parameter: outputFilename -> set default: campaign_sumup.xlsx",
                 fixed=TRUE)
  expect_setequal(actual_output, expect_output)
})



### optional parameter 
test_that("Check missing location ", {
  base_list <- util_default_base_list()
  input_list <- base_list[setdiff(names(base_list), "location")]
  
  expect_no_warning(checkNamedParameter(input_list))
})

test_that("Check empty location ", {
  input_list <- util_default_base_list()
  input_list[["location"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["location"]] = "" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
               "Empty optional parameter: location",
               fixed=TRUE)
  expect_equal(actual_output, expect_output)
  
})


test_that("Check missing block ", {
  base_list <- util_default_base_list()
  input_list <- base_list[setdiff(names(base_list), "block")]
  
  expect_no_warning(checkNamedParameter(input_list))
})

test_that("Check empty block ", {
  input_list <- util_default_base_list()
  input_list[["block"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["block"]] = "" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Empty optional parameter: block",
                 fixed=TRUE)
  expect_equal(actual_output, expect_output)
  
})

test_that("Check missing factor1 ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "factor1")]
  
  expect_no_warning(checkNamedParameter(input_list))
})

test_that("Check empty factor1 ", {
  input_list <- util_default_base_list()
  input_list[["factor1"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["factor1"]] = "" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Empty optional parameter: factor1",
                 fixed=TRUE)
  expect_equal(actual_output, expect_output)
  
})

test_that("Check missing factor2 ", {
  base_list <- util_default_base_list()
  
  input_list <- base_list[setdiff(names(base_list), "factor2")]
  
  expect_no_warning(checkNamedParameter(input_list))
})

test_that("Check empty factor2 ", {
  input_list <- util_default_base_list()
  input_list[["factor2"]] = "" 
  
  expect_output <- util_default_base_list()
  expect_output[["factor2"]] = "" 
  
  
  expect_warning(actual_output <- checkNamedParameter(input_list),
                 "Empty optional parameter: factor2",
                 fixed=TRUE)
  expect_equal(actual_output, expect_output)
  
})

