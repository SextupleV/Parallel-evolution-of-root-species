#!/usr/bin/Rscript

# Inputfile is in the following format (tab separated):

# group	num1	num2	num3	num4
# a	100	200	500	3000
# b	200	300	600	4000
# c	300	400	700	5000
#  ... 


data <- read.table("inputfile",header = T,row.names = 1)

row_number <- nrow(data )
for (x in 1:row_number) {
  test =data [x,1:4]
  test <- as.numeric(test)
  test <- matrix(test,nrow=2)
  out <- fisher.test(test,alternative = "greater")  # the alternative hypothesis and must be one of "two.sided", "greater" or "less".
  data[x,5] <- out$p.value
}
names(data)[5]<-"pvalue"
data$fdr  = p.adjust(data$pvalue,method = "BH")  # p.adjust.methods :holm, hochberg, hommel, bonferroni, BH, BY, fdr, none
data$negative_log10fdr = -log10(data$fdr)

write.table (data,"fisher_result.tab", row.names = T,col.names =T, quote =F,sep="\t")


