## function to load the fieldbookfile 

# Author: André Fabbri 
# E-mail: andre.fabbri@cnr.it
# Version: 1.0
# License: Apache


if (!require(openxlsx)) install.packages('openxlsx',repos = "http://cran.us.r-project.org")
library(openxlsx) ## for write.xlsx function
if (!require(dplyr)) install.packages('dplyr',repos = "http://cran.us.r-project.org")
library(dplyr) ## for tibble manipulation
if (!require(hms)) install.packages('hms',repos = "http://cran.us.r-project.org")
library(hms) ## for time manipulation

#' p_secondInOneDay : global constant representing second in one day
p_secondInOneDay = 86400

#' renameCompulsoryParameter
#'
#' This function takes rename in a tibble the compulsory parameter 
#' @param fieldBookdData tibble with compulsory parameter's config file name  
#' @param fieldBookMetadata named list with fieldbook user column name 
#' @return tibble with with compulsory parameter's script name 
renameCompulsoryParameter <- function(fieldBookdData, fieldBookMetadata){
  return(fieldBookdData %>% rename(
    date = fieldBookMetadata$date,
    startTime = fieldBookMetadata$startTime,
    endTime = fieldBookMetadata$endTime,
    spectrumNb = fieldBookMetadata$spectrumNb,
    id= fieldBookMetadata$id,
    location = any_of(fieldBookMetadata$location),
    block = any_of(fieldBookMetadata$block),
    factor1 = any_of(fieldBookMetadata$factor1),
    factor2 = any_of(fieldBookMetadata$factor2)
  ))
}

#' fieldBookLoad
#' 
#' This function load the field book file and rename the column 
#' @param fieldBookAbsolutePath absolute path of the field book 
#' @param fieldBookMetadata fieldbook metadata 
#' @return tibble containing the field book content (need further post processing)
#' 
fieldBookLoad <- function(fieldBookAbsolutePath,fieldBookMetadata){
  data <- read.xlsx(fieldBookAbsolutePath,
                        skipEmptyRows = TRUE,
                        detectDates = TRUE,
                        sep.names = " ")
  data = renameCompulsoryParameter(data,fieldBookMetadata)
  data = data %>% mutate(startTime= hms::as_hms(startTime * p_secondInOneDay),
                         endTime = hms::as_hms(endTime * p_secondInOneDay) )
  return(data)
}





