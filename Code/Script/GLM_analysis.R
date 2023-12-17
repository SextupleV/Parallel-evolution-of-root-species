#!/usr/bin/Rscript

#########

data = read.table("./GLM_analysis",header=T)

variables = c("absolute_latitude","elevation","bio1","bio2","bio3","bio4","bio5","bio6","bio7","bio8","bio9","bio10","bio11","bio12","bio13","bio14","bio15","bio16",
               "bio17","bio18","bio19","peo_bio1","peo_bio2","peo_bio3","peo_bio4","peo_bio5","peo_bio6","peo_bio7","peo_bio8","peo_bio9","peo_bio10",
               "peo_bio11","peo_bio12","peo_bio13","peo_bio14","peo_bio15","peo_bio16","peo_bio17","peo_bio18","peo_bio19","npp",
               "vapr","wind","srad","ALUM_SAT","BSAT","BULK","CEC_CLAY","CEC_SOIL","CLAY","CN_RATIO","COARSE","ELEC_COND",	
               "ESP","GYPSUM","ORG_CARBON","PH_WATER","REF_BULK","SAND","SILT","TCARBON_EQ","TEB","TOTAL_N","soil_phosphorus","height","GHM","population")

data$height=log2(data$height+1)
data$ESP=log2(data$ESP)

results = data.frame(matrix(nrow = length(variables)+2,ncol = 5))
names(results) = c("variable","pv_lin","beta_lin","AIC_lin","var_lin") 
for (i in 1:length(variables)){  
  curr_att = variables[i]
  ind = which(names(data)==curr_att)
  sub_data = data[which(!is.na(data[,ind])),]
  perc_pp = cbind(sub_data$TD,sub_data$non_TD)
  m1 = try(glm(as.formula(paste("perc_pp~",curr_att,sep="")),family=binomial, data = sub_data))
  
  
  results$variable[i] = curr_att
  results$pv_lin[i] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),4]
  results$beta_lin[i] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),1]
  results$var_lin[i] = 100*(m1$null.deviance-m1$deviance)/m1$null.deviance # pseudo R^2

}



data$leaf_phenology=as.factor(data$leaf_phenology)
perc_pp = cbind(data$TD,data$non_TD)
m1 = glm(perc_pp~leaf_phenology,family=binomial, data = data)


results$variable[length(variables)+1] = "leaf_phenology"
results$pv_lin[length(variables)+1] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),4]
results$beta_lin[length(variables)+1] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),1]
results$var_lin[length(variables)+1] = 100*(m1$null.deviance-m1$deviance)/m1$null.deviance # pseudo R^2


data$growth_habit=as.factor(data$growth_habit)
m1 = glm(perc_pp~growth_habit,family=binomial, data = data)

results$variable[length(variables)+2] = "growth_habit"
results$pv_lin[length(variables)+2] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),4]
results$beta_lin[length(variables)+2] = summary(m1)$coefficients[nrow(summary(m1)$coefficients),1]
results$var_lin[length(variables)+2] = 100*(m1$null.deviance-m1$deviance)/m1$null.deviance # pseudo R^2

results$adj_Pvalue = p.adjust(results$pv_lin,method="BH")

write.table(results,"./GLM_results.txt", row.names = F, 
            col.names =T, quote =T,sep="\t")

########################
