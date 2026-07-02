# Functions to process the metadata of raman file 
# file are assumed to have the file format: "YYYY-MM-DD HH-MM-SS-PWRmw-DELAYms-NBx"
# Author: André Fabbri 
# E-mail: andre.fabbri@cnr.it
# Version: 1.0
# License: Apache

if (!require(hms)) install.packages(hms)
library(hms) ## for time manipulation
if (!require(lubridate)) install.packages(lubridate)
library(lubridate) # date manipulation
if (!require(stringr)) install.packages(stringr)
library(stringr)## for string operation str_replace_all


#' extractMetadataFromFileName
#' 
#' This function transform the filename into the metadata of the file 
#' @param filename the filename 
#' @return dataframe containing the metadata 
#' 
extractMetadataFromFileName <- function(filename){
  filename_std = str_replace_all(filename,c(" "="-","\\."="-"))
  splitVec = str_split_1(filename_std,"-")
  return(data.frame(
    filename= filename,
    date=as.Date(paste(splitVec[1],splitVec[2],splitVec[3],sep="-"),"%Y-%m-%d"),
    time=as_hms(paste(splitVec[4],splitVec[5],splitVec[6],sep = ":")),
    pwr_mw=as.numeric(gsub("\\D", "",splitVec[7])),
    delay_ms=as.numeric(gsub("\\D", "",splitVec[8])),
    rep_x=as.numeric(gsub("\\D", "",splitVec[9]))
  ))
}

#' intersectFileWithDate
#' 
#' This function intersect the file corresponding to the fieldbook data considering 
#' day, month and time 
#' 
#' CAUTION due to manipulation error only the day and month of the filename is considered 
#'  
#' @param fieldBookTibble tibble containing the metadata from the fieldbook require column 
#'  date, startTime, endTime, spectrumNb, id all other column are reported 
#' @param  dataFileTibble tibble conatining the filename and metadata extracted form it. Requires columns 
#'  date,time all other column are reported
#' 
#' @return tibble with the merged metadata according to the time 
#' 
intersectFileWithDate <- function(fieldBookTibble,dataFileTibble){
  out <- fieldBookTibble %>% 
    mutate(field_day= day(date), 
           field_month= month(date)) %>%
    left_join(y = dataFileTibble %>% 
                mutate(file_day=day(date),
                       file_month= month(date)) %>%
                select (-date)
              ,by = join_by(field_day == file_day, field_month == file_month, startTime < time, endTime> time)
    ) %>% 
    select(-startTime,-endTime,-field_day,-field_month) %>% 
    rename(spectrum_expected=spectrumNb) %>% 
    group_by(id,date) %>%
    #add_count(id,date, name = spectrum_matching) %>% 
    mutate(spectrum_matching=sum(!is.na(time))) %>% 
    relocate(spectrum_matching,.after=spectrum_expected) %>% 
    ungroup()
  ## generate warning 
  if(sum(out %>% mutate(diff =spectrum_expected  - spectrum_matching) %>% select(diff))>0){
    warning("Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns")
  }
  return(out)
}

#' loadRamanDataFile
#' 
#' This function loads the data from the raw raman datafile with the following structrure 
#' first column correspond to wavelength and second column the value 
#' All the value are transposed in a dataframe with the column name 
#' corresponding to the first column of the file rounded
#' The filename is indicated also as an identifier
#' 
#' @param filepath the filepath of the data file
#' @param filename the unique identifier for the file 
#' @return dataframe with the filename and all wavelength as column
#' 
loadRamanDataFile <-function(filepath, filename) {
  data <- read.table(filepath, sep = '\t',header = FALSE)
  value <- as.data.frame(t(data[2]))
  colnames(value) <- t(round(data[1]))
  return(value %>% mutate(filename=filename))
  
}

