source("/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-cleaning.R")
source("/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-plotting.R")
library(ggplot2)
library(reshape2)

# load rawdf
setwd("/Users/Seth/Documents/TrumpDiscourse/modelOutput/newDocsLogs")
rawdf <- read.csv("newDocsPredictions-coco_3_cv_3_netAng_30_twc_15_tfidfNoPro_pronounFrac_bin_1-H9FJGD.csv", stringsAsFactors = F)

# get cleaned df
df <- cleanTrumpPredictions(rawdf)

# write.csv(df, "/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-rankings1.csv", row.names = F)

# reshape to plot model comparison
moddf <- melt(df,id=c("type", "title", "date"), variable_name="Pred")
names(moddf)[4:5] <- c("Model", "Prediction")

# plotting parameters
# function(df, type = "both", model = "all", date = 'min', title = '')
#
# type: 'both' 'TrumpRemarks' 'TrumpStatements'
# model: 'all' 'class' 'reg' or name of model 
# date: 'min' or date to start the plot, format '2016-04-01' for April 1st
# title: a string for the plot title, defaults to blank

#plot all
tpm(moddf)
#plot all from 4/16
tpm(moddf, date='2016-04-01')

#plot class from 4/16
tpm(moddf, model = 'class', date='2016-04-01')

# statements vs. remarks
tpt(moddf, 'both', 'svmClass','min', title = 'SVM Predictions')
tpt(moddf, 'both', 'rfClass','min', title = "Random Forest Predictions")
