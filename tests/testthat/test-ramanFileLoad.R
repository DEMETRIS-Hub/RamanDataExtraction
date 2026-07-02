## test function for ramanFileLoad
# Author: André Fabbri 
# E-mail: andre.fabbri@cnr.it
# Version: 1.0
# License: Apache

#source("./.../../R/ramanFileLoad.R")

if (!require(testthat)) install.packages('testthat',repos = "http://cran.us.r-project.org")
library(testthat) ## test
if (!require(hms)) install.packages('hms',repos = "http://cran.us.r-project.org")
library(hms) ## for time manipulation
if (!require(dplyr)) install.packages('dplyr',repos = "http://cran.us.r-project.org")
library(dplyr) ## for tibble manipulation
if (!require(stringr)) install.packages('stringr',repos = "http://cran.us.r-project.org")
library(stringr)## for string operation str_extract str_split

#' util_default_dataFileTibble
#' 
#' This utility function return a default datafile tibble
#' @return default tibble 
util_default_dataFileTibble <- function(){
  return(
    tibble(
      date=c(as.Date("2026-03-23","%Y-%m-%d"),
             as.Date("2026-03-23","%Y-%m-%d"),
             as.Date("2026-03-23","%Y-%m-%d"),
             as.Date("2026-03-26","%Y-%m-%d")),
      time= c(as_hms("10:35:24"),
              as_hms("10:36:24"),
              as_hms("10:47:24"),
              as_hms("10:24:24")),
      filename = c("filename1.txt",
                   "filename2.txt",
                   "filename3.txt",
                   "filename4.txt")
    )
  )
}

test_that("Nominal case extractMetadataFromFileName ", {
  # 1. Setup: Create input and expected output
  input_parameter <- "2024-03-23 15-33-08-500mw-5000ms-1x.txt"
  
  expected_output <- data.frame(
    filename="2024-03-23 15-33-08-500mw-5000ms-1x.txt",                        
    date=as.Date("2024-03-23","%Y-%m-%d"),
    time=as_hms("15:33:08"),
    pwr_mw=500,
    delay_ms=5000,
    rep_x=1
  )
  # 2. Action: Run the function
  actual_output <- extractMetadataFromFileName(input_parameter)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})


test_that("intersectFileWithDate - Case 1 fieldbookentry", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=as.Date("2026-03-23","%Y-%m-%d"),
    startTime= as_hms("10:35:00"),
    endTime= as_hms("10:36:00"),
    id = 1,
    spectrumNb=1,
    fieldBookCol = 0
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=as.Date("2026-03-23","%Y-%m-%d"),
    id=1,
    spectrum_expected=1,
    spectrum_matching=1,
    fieldBookCol = 0, 
    time = as_hms("10:35:24"),
    filename = "filename1.txt"
  )
  
  # 2. Action: Run the function
  actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})

test_that("intersectFileWithDate - Case 1 fieldbookentry with 2 record on the same date", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=as.Date("2026-03-23","%Y-%m-%d"),
    startTime= as_hms("10:35:00"),
    endTime= as_hms("10:37:00"),
    id = 1,
    spectrumNb=2,
    fieldBookCol = 0
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-23","%Y-%m-%d")),
    id=c(1,1),
    spectrum_expected=c(2,2),
    spectrum_matching=c(2,2),
    fieldBookCol = c(0,0), 
    time = c(as_hms("10:35:24"),
             as_hms("10:36:24")),
    filename = c("filename1.txt","filename2.txt")
  )
  
  # 2. Action: Run the function
  actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})

test_that("intersectFileWithDate - Case 2 fieldbookentry same id", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    startTime= c(as_hms("10:35:00"),
                 as_hms("10:24:00")),
    endTime= c(as_hms("10:36:00"),
               as_hms("10:30:00")),
    id = c(1,1),
    spectrumNb=c(1,1),
    fieldBookCol = c(0,0)
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    id=c(1,1),
    spectrum_expected=c(1,1),
    spectrum_matching=c(1,1),
    fieldBookCol = c(0,0), 
    time = c(as_hms("10:35:24"),
             as_hms("10:24:24")),
    filename = c("filename1.txt","filename4.txt")
  )
  
  # 2. Action: Run the function
  actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})  


#####
test_that("intersectFileWithDate - Case 2 fieldbookentry with one mismatch on date", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-27","%Y-%m-%d")),
    startTime= c(as_hms("10:35:00"),
                 as_hms("10:24:00")),
    endTime= c(as_hms("10:36:00"),
               as_hms("10:30:00")),
    id = c(1,1),
    spectrumNb=c(1,1),
    fieldBookCol = c(0,0)
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-27","%Y-%m-%d")),
    id=c(1,1),
    spectrum_expected=c(1,1),
    spectrum_matching=c(1,0),
    fieldBookCol = c(0,0), 
    time = c(as_hms("10:35:24"),
             NA),
    filename = c("filename1.txt",NA)
  )
  
  # 2. Action: Run the function
  expect_warning(
    actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile),
    "Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns"
  )
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
  
  
})

test_that("intersectFileWithDate - Case 2 fieldbookentry with one mismatch on time", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    startTime= c(as_hms("10:35:00"),
                 as_hms("10:28:00")),
    endTime= c(as_hms("10:36:00"),
               as_hms("10:30:00")),
    id = c(1,1),
    spectrumNb=c(1,1),
    fieldBookCol = c(0,0)
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    id=c(1,1),
    spectrum_expected=c(1,1),
    spectrum_matching=c(1,0),
    fieldBookCol = c(0,0), 
    time = c(as_hms("10:35:24"),
             NA),
    filename = c("filename1.txt",NA)
  )
  
  # 2. Action: Run the function
  expect_warning(
    actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile),
    "Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns"
  )
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})

test_that("intersectFileWithDate - Case 1 fieldbookentry with 2 record on the same date but only one match", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=as.Date("2026-03-23","%Y-%m-%d"),
    startTime= as_hms("10:35:00"),
    endTime= as_hms("10:36:00"),
    id = 1,
    spectrumNb=2,
    fieldBookCol = 0
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=as.Date("2026-03-23","%Y-%m-%d"),
    id=1,
    spectrum_expected=2,
    spectrum_matching=1,
    fieldBookCol = 0, 
    time = as_hms("10:35:24"),
    filename = "filename1.txt"
  )
  
  # 2. Action: Run the function
  expect_warning(
    actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile),
    "Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns"
  )
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
})
#####################################################

test_that("intersectFileWithDate - Case 3 fieldbookentry all match on the 4 records", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    startTime= c(as_hms("10:35:00"),
                 as_hms("10:40:00"),
                 as_hms("10:24:00")),
    endTime= c(as_hms("10:38:00"),
               as_hms("10:50:00"),
               as_hms("10:30:00")),
    id = c(1,2,1),
    spectrumNb=c(2,1,1),
    fieldBookCol = c(0,1,2)
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-23","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    id=c(1,1,2,1),
    spectrum_expected=c(2,2,1,1),
    spectrum_matching=c(2,2,1,1),
    fieldBookCol = c(0,0,1,2), 
    time = c(as_hms("10:35:24"),
             as_hms("10:36:24"),
             as_hms("10:47:24"),
             as_hms("10:24:24")),
    filename = c("filename1.txt",
                 "filename2.txt",
                 "filename3.txt",
                 "filename4.txt")
  )
  
  # 2. Action: Run the function
  actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile)
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
  
})

test_that("intersectFileWithDate - Case 3 fieldbookentry with no match on the 4 record", {
  # 1. Setup: Create input and expected output
  input_fieldBook = tibble(
    date=c(as.Date("2026-03-24","%Y-%m-%d"),
           as.Date("2026-03-24","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    startTime= c(as_hms("10:35:00"),
                 as_hms("10:40:00"),
                 as_hms("10:30:00")),
    endTime= c(as_hms("10:36:00"),
               as_hms("10:50:00"),
               as_hms("10:40:00")),
    id = c(1,2,1),
    spectrumNb=c(2,1,1),
    fieldBookCol = c(0,1,2)
  )
  
  input_dataFile = util_default_dataFileTibble()
  
  expected_output = tibble(
    date=c(as.Date("2026-03-24","%Y-%m-%d"),
           as.Date("2026-03-24","%Y-%m-%d"),
           as.Date("2026-03-26","%Y-%m-%d")),
    id=c(1,2,1),
    spectrum_expected=c(2,1,1),
    spectrum_matching=c(0,0,0),
    fieldBookCol = c(0,1,2), 
    time = as_hms(c(NA,
                    NA,
                    NA)),
    filename = as.character(c(NA,
                              NA,
                              NA))
  )
  
  # 2. Action: Run the function
  expect_warning(
    actual_output <- intersectFileWithDate(input_fieldBook,input_dataFile),
    "Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns"
  )
  
  
  # 3. Expectation: Check if the actual output matches the expected output
  expect_equal(actual_output, expected_output)
  
})

