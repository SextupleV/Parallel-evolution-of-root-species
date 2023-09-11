#!/usr/bin/Rscript

####################

library(dplyr)
library(purrr)
library(taxize)
library(readr)  
library(magrittr) 
library(rgbif) 

# Reading species information

gbif_taxon_keys <- 
  
  readr::read_csv("noncrop_list.txt") %>%  # noncrop_list.txt can be obtained from Supplementary materials.
  
  pull("Species") %>%
  
  taxize::get_gbifid_(method="backbone") %>% 
  
  imap(~ .x %>% mutate(original_sciname = .y)) %>%
  
  bind_rows() %T>%
  
  filter(matchtype == "EXACT" & status == "ACCEPTED") %>%
  
  filter(kingdom == "Plantae") %>%
  
  pull(usagekey)


occ_download(
  
  pred_in("taxonKey", gbif_taxon_keys),
  
  user="xxxx", pwd="xxxx", email="xxxx"
  
) # Please replace with your user information


########################
