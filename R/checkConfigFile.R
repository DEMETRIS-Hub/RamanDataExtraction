## function that load the config file checking all parameters 


#' Default output directory 
p_configDefaultDestSubDir= "./out/"
#' Default output filename 
p_configDefaultOutputFilename= "campaign_sumup.xlsx"

#' checkEmptyValue
#' 
#' This utility function check whether the existing provided parameter is null, n.a. or empty 
#' @param parameter to check 
#' @return boolean value 
checkEmptyValue <- function(parameter){
  return(is.null(parameter) || is.na(parameter) || nchar(parameter) ==0 )
}
  


#' checkNamedParameter
#'
#' This function takes a list of named parameter and check on the compulsory 
#' parameter or optional parameter. In the latter case it sets defaults values 
#' with a dedicated warning
#'
#' Compulsory parameter (existing or not null):
#' - datasetDir: directory with all the raw datasets
#' - fieldBookFilename: spreadsheet with all the metadata for the processing
#' - id: id of the individual element monitored (plant, leaf) in the fieldbook file
#' - date: date of the sample in the fieldbook file
#' - start_time: starting time of the sample in the fieldbook file
#' - ending_time: ending time of the sample in the fieldbook file 
#' - spectrum_nb: number of spectrum collected for this id colname in the fieldbook file
#' 
#' Optional parameter with default: if missing or empty a default value is set 
#' - destSubDir: directory to write the input  (./out/)
#' - outputFilename: filename output (campaign_sumup.xlsx)
#' 
#' Optional parameter: if missing no warning and if empty a warning is set 
#' - location: location colname in the fieldbook file ("NULL")
#' - block: block or replica  colname in the fieldbook file ("NULL")
#' - factor1: first factor or treatment  of the experiment in the fieldbook file ("NULL")
#' - factor2: second factor or treatment of the experiement in the fieldbook file ("NULL")
#' 
#' @param paramList list of named parameter
#' @return list corrected with default values if the parameter is missing or empty
#' @export
#' @examples
#' fixedConfigYml <- checkNamedParameter(configYml)

checkNamedParameter <- function(paramList){
  if(!hasName(paramList,"datasetDir")){
    stop("Missing compulsory parameter: datasetDir")
  }
  if(checkEmptyValue(paramList[["datasetDir"]])){
      stop("Empty compulsory parameter: datasetDir")
  }
  if(!hasName(paramList,"fieldBookFilename")){
    stop("Missing compulsory parameter: fieldBookFilename")
  }
  if(checkEmptyValue(paramList[["fieldBookFilename"]])){
    stop("Empty compulsory parameter: fieldBookFilename")
  }
  if(!hasName(paramList,"id")){
    stop("Missing compulsory parameter: id")
  }
  if(checkEmptyValue(paramList[["id"]])){
    stop("Empty compulsory parameter: id")
  }
  if(!hasName(paramList,"date")){
    stop("Missing compulsory parameter: date")
  }
  if(checkEmptyValue(paramList[["date"]])){
    stop("Empty compulsory parameter: date")
  }
  if(!hasName(paramList,"startTime")){
    stop("Missing compulsory parameter: startTime")
  }
  if(checkEmptyValue(paramList[["startTime"]])){
    stop("Empty compulsory parameter: startTime")
  }
  if(!hasName(paramList,"endTime")){
    stop("Missing compulsory parameter: endTime")
  }
  if(checkEmptyValue(paramList[["endTime"]])){
    stop("Empty compulsory parameter: endTime")
  }
  if(!hasName(paramList,"spectrumNb")){
    stop("Missing compulsory parameter: spectrumNb")
  }
  if(checkEmptyValue(paramList[["spectrumNb"]])){
    stop("Empty compulsory parameter: spectrumNb")
  }
  if(hasName(paramList,"location")){
    if(checkEmptyValue(paramList[["location"]])){
      warning("Empty optional parameter: location")
    }
  }
  if(hasName(paramList,"block")){
    if(checkEmptyValue(paramList[["block"]])){
      warning("Empty optional parameter: block")
    }
  }
  if(hasName(paramList,"factor1")){
    if(checkEmptyValue(paramList[["factor1"]])){
      warning("Empty optional parameter: factor1")
    }
  }
  if(hasName(paramList,"factor2")){
    if(checkEmptyValue(paramList[["factor2"]])){
      warning("Empty optional parameter: factor2")
    }
  }
  if(!hasName(paramList,"destSubDir")){
    warning(paste0("Missing optional parameter: destSubDir -> set default: ",p_configDefaultDestSubDir))
    paramList[["destSubDir"]] <- p_configDefaultDestSubDir
  }
  if(checkEmptyValue(paramList[["destSubDir"]])){
    warning(paste0("Empty optional parameter: destSubDir -> set default: ",p_configDefaultDestSubDir))
    paramList[["destSubDir"]] <- p_configDefaultDestSubDir
  }
  if(!hasName(paramList,"outputFilename")){
    warning(paste0("Missing optional parameter: outputFilename -> set default: ",p_configDefaultOutputFilename))
    paramList[["outputFilename"]] <- p_configDefaultOutputFilename
  }
  if(checkEmptyValue(paramList[["outputFilename"]])){
    warning(paste0("Empty optional parameter: outputFilename -> set default: ",p_configDefaultOutputFilename))
    paramList[["outputFilename"]] <- p_configDefaultOutputFilename
  }
  return(paramList)
}


