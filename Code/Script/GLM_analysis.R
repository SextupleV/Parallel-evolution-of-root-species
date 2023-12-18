#!/usr/bin/Rscript

#########

data = read.table("GLM_analysis.txt",header=T) # 'GLM_analysis.txt' file can be obtained from the 'inputfile_for_script' folder

variables = colnames(data[,-3:-1])

data$height=log2(data$height+1)
data$ESP=log2(data$ESP)

results = data.frame(matrix(nrow = length(variables),ncol = 4))
names(results) = c("variable","pv_lin","beta_lin","var_lin") 
for (i in 1:length(variables)){  
  var = variables[i]
  pro_td = cbind(data$TD,data$non_TD)
  model = try(glm(as.formula(paste("pro_td~",var,sep="")),family=binomial, data = data))
  results$variable[i] = var
  results$pv_lin[i] = summary(model)$coefficients[nrow(summary(model)$coefficients),4]
  results$beta_lin[i] = summary(model)$coefficients[nrow(summary(model)$coefficients),1]
  results$var_lin[i] = 100*(model$null.deviance-model$deviance)/model$null.deviance
}

write.table(results,"GLM_results.txt",row.names = F,col.names =T,quote =T,sep="\t")

########################


