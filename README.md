# Package for RAMAN raw file processing

This simple package aims to merge seperate raw RAMAN data file in one single 
spreadsheet based on the metadata provided by a fieldbook spreadsheet and the 
filenames of the raw RAMAN data files. 

All the information required to execute the main script "ramanFieldDataExtraction"
are written in a configuration file written in YAML (default is ./config.yml)

## How to install 
The code is available in the repository https://github.com/DEMETRIS-Hub/RamanDataExtraction
to install it run the following code in an R terminal to install this package and 
depending package

```
if (!require(remotes)) install.packages("remotes")
remotes::install_github("DEMETRIS-Hub/RamanDataExtraction")

if (!require(hms)) install.packages('hms',repos = "http://cran.us.r-project.org")
if (!require(stringr)) install.packages('stringr',repos = "http://cran.us.r-project.org")
if (!require(dplyr)) install.packages('dplyr',repos = "http://cran.us.r-project.org")
if (!require(yaml)) install.packages('yaml',repos = "http://cran.us.r-project.org")
if (!require(openxlsx)) install.packages('openxlsx',repos = "http://cran.us.r-project.org")

```

As an alternative you may download the tar.gz archive adn install it locally using  
devtools::install_local()

## Configugation file example 
The configuration File determines the behaviour of the script. You may write a different one 
for each campaign or use the default config.yml. 

Below an example of config file with detailed comments 

```
# File setup for the script
## (Compulsory) directory with the raw data file
datasetDir: .\..\Sardegna Marzo 2026
## (Compulsory) spreadsheet with the field metadata
fieldBookFilename: Summary Raman data Sardegna 2026.xlsx
## (Default: ./out/) directory for the output
destSubDir: ./out/
## (Default: campaign_sumup.xlsx) filename for the output
outputFilename: campaign_sumup.xlsx
# Fieldbook column name mapping 
## (Compulsory) unique identifier 
id: n° pianta
## (Compulsory) acquisition date  
date: Data
## (Compulsory) acquisition starting time 
startTime: orario inizio
## (Compulsory) acquisition ending time 
endTime: orario fine
## (Compulsory) spectrum acquired during the time
spectrumNb: n spettri
## (Optional) location metadata
location: Nome sito
## (Optional) block metadata
block: 
## (Optional) factor1 metadata
factor1:
## (Optional) factor2 metadata
factor2: 

```

## How to run 
Configure properly the config file (cf. ./config.yml in the repository)
Open an RScipt, load the package and executre the main program as below


```
library(pipelineraman)
ramanFieldDataExtraction()
```

Then check in the destSubDir the output spreadsheet.


## Troubleshoot 


### Error - In unzip(xlsxFile, exdir = xmlDir) :  errore 1 during the extraction of the zip archive Called from: file(con, "r")
This means that the fieldbook spreadsheet is already open in another software 
(e.g. MS-Excel). Close the software and run again the script 

### Warning - Empty optional parameter
This warning indicate that an optional field in the config file has been left empty.
These column of the field book won't be indicated then as a metadata. 
To remove the warning, remove the field from the config file 

### Warning - Some file present in the field book were not correclty matched with the Raman filename - check spectrum_expected and spectrum_matching columns
This warning indicates that the number of expected spectrum in the fieldbook 
spreadsheet does not match the raw file timestamp loaded for certain id.
Probably for a mismatch in the timestamp written in the fieldbook.

To identify the interested files check any difference between the two column 
spectrum_expected and spectrum_matching in the output file.







 

