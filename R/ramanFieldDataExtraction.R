# **Raman data file merging script**
#
# This simple script expect to write in a single excel file Raman text datafile in a directory 
# according to their filename and the metadata inserted in another excel fieldbook file
#
# All the script parameter are written in a yaml config file

# Author: André Fabbri 
# E-mail: andre.fabbri@cnr.it
# Version: 1.0
# License: Apache

if (!require(dplyr)) install.packages('dplyr',repos = "http://cran.us.r-project.org")
library(dplyr) ## for tibble manipulation

if (!require(stringr)) install.packages('stringr',repos = "http://cran.us.r-project.org")
library(stringr)## for string operation str_extract str_split
if (!require(yaml)) install.packages('yaml',repos = "http://cran.us.r-project.org")
library(yaml) ##read_yaml

# source("./R/checkConfigFile.R")
# source("./R/fieldBookLoad.R")
# source("./R/extractRamanData.R")

# ### argument processing for config filename 
# args = commandArgs(trailingOnly=TRUE)
# if(length(args)==0){
#   p_configFile <- "./config.yml"
# }else{
#   p_configFile <- args[1]
# }


#' ramanFieldDataExtraction
#' Main function to match and extract Raman file based on the fieldbook
#' 
#' 
#' @param configFilePathname filepath of the config file (default ./config.yml)
#' @return dataset written
#' @export


ramanFieldDataExtraction <- function(configFilePathname = "./config.yml"){
### load config file
  configRamanMetadata <-  read_yaml(configFilePathname)
  configRamanMetadata= checkNamedParameter(configRamanMetadata)

  ### load fieldBookfile
  fieldBookAbsFilename <- paste0(configRamanMetadata$datasetDir,
                                 "/",
                                 configRamanMetadata$fieldBookFilename)
  fieldBook <- fieldBookLoad(fieldBookAbsFilename, configRamanMetadata)

  ## extract data
  dataset <- extractRamanData(fieldBook,configRamanMetadata$datasetDir)

  ##craate directory if not existing 
  ### create directory if necessary
  ifelse(!dir.exists(file.path(configRamanMetadata$destSubDir)),
         dir.create(file.path(configRamanMetadata$destSubDir)),
         "Dest directory already exists")
  
  ## write data
  write.xlsx(dataset,file = paste0(configRamanMetadata$destSubDir,"/", configRamanMetadata$outputFilename))
  return(dataset)
}

