#!/usr/bin/Rscript


##################

# Calcuate the correlation between plant height and three gene derived modes.


data = read.table("tableS5",header = T) # tableS5 can be obtained from Supplementary materials.

data$Hight=log2(data$Hight+1)

#### HGT

plot(data$hight,data$Number_of_HGT-derived_genes,pch=16,cex=2,xlim = c(0,7),ylim = c(0.05,200))

abline(lm(data$Number_of_HGT-derived_genes~data$Hight))

cor.test(data$Hight,data$Number_of_HGT-derived_genes)



#### WGD

plot(data$hight,data$Number_of_WGD-derived_genes,pch=16,cex=2,xlim = c(0,7),ylim = c(0.05,40000))

abline(lm(data$Number_of_WGD-derived_genes~data$Hight))

cor.test(data$Hight,data$Number_of_WGD-derived_genes)


#### TD

plot(data$hight,data$Number_of_TD-derived_genes,pch=16,cex=2,xlim = c(0,7),ylim = c(0.05,20000))

abline(lm(data$Number_of_TD-derived_genes~data$Hight))

cor.test(data$Hight,data$Number_of_TD-derived_genes)





