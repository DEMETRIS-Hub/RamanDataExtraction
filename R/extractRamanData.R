#  Extract Raman data 
# function to extract raman datafile and intersect them with other metadata 
# 
# Author: André Fabbri 
# E-mail: andre.fabbri@cnr.it
# Version: 1.0
# License: Apache

if (!require(dplyr)) install.packages('dplyr',repos = "http://cran.us.r-project.org")
library(dplyr) ## for tibble manipulation

#source("./R/ramanFileLoad.R")

#' extractRamanData
#' 
#' main function to process and extract the data 
#' @param fieldBook tibble with fieldbook information for file recover 
#' @param datasetDir directory where the raman datafile are stored 
#' @return the dataset file produced
extractRamanData <- function(fieldBook,datasetDir){
  # list all txt file in the directory
  ramanFileList <- list.files(path = datasetDir, pattern = "\\.txt$")
  # extract metadata from the data filename
  ramanFileTibble <- as_tibble(
    do.call(rbind,lapply(ramanFileList,extractMetadataFromFileName)),
    stringsAsFactors = FALSE)
  # intersect metadata from the filename and form the fieldbook
  matchingRamanFile <- intersectFileWithDate(fieldBook,ramanFileTibble)
  # load raman datafiles 
  fileToLoad <- intersect(ramanFileList, matchingRamanFile %>% filter(!is.na(filename)) %>% pull(filename))
  ramanDataset <- do.call(rbind,
  lapply(fileToLoad,function(i) { return(loadRamanDataFile(paste0(datasetDir,
                                                                  "/",i),i))})
  )
  ## merged with metadata 
  ramanDatasetWithMetadata <- matchingRamanFile %>% inner_join(ramanDataset,by = join_by(filename)) 
  return(ramanDatasetWithMetadata)
}
