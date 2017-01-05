
source("/Users/Seth/Documents/Trump/Analysis/trump-cleaning.R")

setwd("/Users/Seth/Documents/Trump/modelOutput/newDocsLogs")

rawdf <- read.csv("newDocsPredictions-coco_3_cv_3_netAng_30_twc_15_tfidfNoPro_pronounFrac_bin_1-H9FJGD.csv", stringsAsFactors = F)

df <- cleanTrumpPredictions(rawdf)