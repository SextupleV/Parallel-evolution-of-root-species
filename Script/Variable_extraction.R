#!/usr/bin/Rscript

setwd("/working/gridded_variables/")

var_list <- c(list.files(pattern = "\\.tif$", full.names = TRUE))

for (x in 1:length(var_list)){
  var = var_list[x]
  
  gbif=read.csv(geo_coordinates.txt,header = T,sep="\t") # geo_coordinates.txt file can be obtained from the 'inputfile_for_script' folder
  gbif_out=gbif
  gbif=data.frame(gbif$decimalLongitude,gbif$decimalLatitude)
  dfsp = SpatialPoints(gbif)
  geovar=raster(var)
  gbif_out$var_value <- raster::extract(geovar,dfsp)
  
  write.table(gbif_out,paste(var,"_variables",sep=""), row.names = F, col.names =T, quote =T,sep="\t")
  
}
