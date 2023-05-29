#!/usr/bin/bash

####################

Rscript - <<EOF

library(dplyr)
library(purrr)
library(taxize)
library(readr)  
library(magrittr) 
library(rgbif) 

# Reading species information

gbif_taxon_keys <- 
  
  readr::read_csv("tableS2") %>%  #tableS2 can be obtained from Supplementary materials.
  
  pull("Species") %>%
  
  taxize::get_gbifid_(method="backbone") %>% 
  
  imap(~ .x %>% mutate(original_sciname = .y)) %>%
  
  bind_rows() %T>%
  
  filter(matchtype == "EXACT" & status == "ACCEPTED") %>%
  
  filter(kingdom == "Plantae") %>%
  
  pull(usagekey)

# Download data from GBIF

occ_download(
  
  pred_in("taxonKey", gbif_taxon_keys),
  
  user="xxxx", pwd="xxxx", email="xxxx"
  
) # Please replace with your user information

EOF


########################

wget --no-check-certificate  https://api.gbif.org/v1/occurrence/download/request/0262483-230224095556074.zip # This data is generated from our research

unzip 0262483-230224095556074.zip

awk 'BEGIN{FS="\t"}{print $199"\t"$138"\t"$139}' occurrence.txt | awk '$2!=""' > GBIF_data # Extract longitude, latitude, and species taxon.

sed -i 's/Magnoliopsida/Angiosperma/' GBIF_data
sed -i 's/Liliopsida/Angiosperma/' GBIF_data
sed -i 's/Polypodiopsida/Ferns/' GBIF_data
sed -i 's/Pinopsida/Gymnosperma/' GBIF_data
sed -i 's/Gnetopsida/Gymnosperma/' GBIF_data
sed -i 's/Lycopodiopsida/Lycophytes/' GBIF_data
sed -i 's/Cycadopsida/Gymnosperma/' GBIF_data
sed -i 's/Marchantiopsida/Bryophytes/' GBIF_data
sed -i 's/Anthocerotopsida/Bryophytes/' GBIF_data
sed -i 's/Sphagnopsida/Bryophytes/' GBIF_data
sed -i 's/Trebouxiophyceae/Chlorophytes/' GBIF_data
sed -i 's/Chlorophyceae/Chlorophytes/' GBIF_data
sed -i 's/Porphyridiophyceae/Rhodophytes/' GBIF_data
sed -i 's/Mamiellophyceae/Chlorophytes/' GBIF_data
sed -i 's/Klebsormidiophyceae/Charophytes/' GBIF_data
sed -i 's/Prasinophyceae/Chlorophytes/' GBIF_data
sed -i 's/Charophyceae/Charophytes/' GBIF_data
sed -i 's/Pedinophyceae/Chlorophytes/' GBIF_data
sed -i 's/Chloropicophyceae/Chlorophytes/' GBIF_data
sed -i 's/Zygnematophyceae/Charophytes/' GBIF_data
sed -i 's/Cyanidiophyceae/Rhodophytes/' GBIF_data
sed -i 's/Florideophyceae/Rhodophytes/' GBIF_data
sed -i 's/Ulvophyceae/Chlorophytes/' GBIF_data
sed -i 's/Bryopsida/Bryophytes/' GBIF_data

########################

Rscript - <<EOF

library(ggplot2) 

data <- read.table("./GBIF_data",header = T)

pdf(file="205plant_map.pdf",width=9, height=6)

# Draw the global distribution map.

ggplot(data, aes(Longitude, Latitude)) + 
  
  scale_color_manual(values = c("Rhodophytes"="#CE5270","Chlorophytes"="#1B5E05","Charophytes"="#08F90E","Bryophytes"="#C1E200","Lycophytes"="#0B0BF7","Ferns"="#06F9F9","Gymnosperma"="#751D22","Angiosperma"="red")) +
  
  geom_point(aes(color = class), alpha=0.5, size=0.005) +
  
  theme(legend.position = 'none', panel.background = element_rect(fill = "white")) +
  
  borders("world")

dev.off()

EOF

#######################

