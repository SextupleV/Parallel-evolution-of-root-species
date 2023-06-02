#!/usr/bin/Rscript

##################

# Evaluate the difference in three gene modes between woody and herbaceous plants.

library(ggplot2)

data = read.table("tableS4",header = T)

# HGT

ggplot(data,aes(x = Habit, y = Number_of_HGT-derived_genes)) +
  geom_boxplot(fill = c('green','blue'), show.legend = FALSE, width = 0.7) + 
  geom_jitter(width = 0.2, alpha = 0.6) 

wilcox.test(data$Number_of_HGT-derived_genes[data$Habit=='Herbaceous'],data$Number_of_HGT-derived_genes[data$Habit=='Woody'],alternative = 'two.side')


# WGD

ggplot(data,aes(x = Habit, y = Number_of_WGD-derived_genes)) +
  geom_boxplot(fill = c('green','blue'), show.legend = FALSE, width = 0.7) + 
  geom_jitter(width = 0.2, alpha = 0.6) 

wilcox.test(data$Number_of_WGD-derived_genes[data$Habit=='Herbaceous'],data$Number_of_WGD-derived_genes[data$Habit=='Woody'],alternative = 'two.side')


# TD

ggplot(data,aes(x = Habit, y = Number_of_TD-derived_genes)) +
  geom_boxplot(fill = c('green','blue'), show.legend = FALSE, width = 0.7) + 
  geom_jitter(width = 0.2, alpha = 0.6) 

wilcox.test(data$Number_of_TD-derived_genes[data$Habit=='Herbaceous'],data$Number_of_TD-derived_genes[data$Habit=='Woody'],alternative = 'two.side')


