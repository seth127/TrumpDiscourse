source("/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-cleaning.R")
source("/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-plotting.R")
library(plotly)
library(reshape2)

# load rawdf
setwd("/Users/Seth/Documents/TrumpDiscourse/modelOutput/newDocsLogs")
rawdf <- read.csv("newDocsPredictions-coco_3_cv_3_netAng_30_twc_15_tfidfNoPro_pronounFrac_bin_1-H9FJGD.csv", stringsAsFactors = F)

# get cleaned df
df <- cleanTrumpPredictions(rawdf)
# write.csv(df, "/Users/Seth/Documents/TrumpDiscourse/Analysis/trump-rankings1.csv", row.names = F)

#### FAKE TOPICS
# topics <- c("Immigration", "Foreign Policy", "Economy")
# df$Topic <- sample(topics, nrow(df), replace = T)

topicize <- function(sampleText) {
  sampleText <- as.character(sampleText)
  if (grepl("Briti|Iran|Middle East|Terror", sampleText)) {
    topic <- 'Foreign Policy'
  } else if (grepl("Immigrat|Visa|Refuge|Amnesty|Border", sampleText)) {
    topic <- 'Immigration'
  } else if (grepl("Clinton|Cruz|Sanders|Kasich|Graham", sampleText)) {
    topic <- 'Opponents'
  } else if (grepl(" at .+ in ", sampleText)) {
    topic <- 'campaign trail'
  } else {
    topic <- 'other'
  }
  topic
}

df$Topic <- character(nrow(df))
for (i in 1:nrow(df)) {
  df$Topic[i] <- topicize(df$title[i])
}


# reshape to plot model comparison
moddf <- melt(df,id=c("type", "title", "date", "Topic"), variable_name="Pred")
names(moddf)[5:6] <- c("Model", "Prediction")



# plotting parameters
# function(df, type = "both", model = "all", date = 'min', title = '')
#
# type: 'both' 'TrumpRemarks' 'TrumpStatements'
# model: 'all' 'class' 'reg' or name of model 
# date: 'min' or date to start the plot, format '2016-04-01' for April 1st
# title: a string for the plot title, defaults to blank

# library(plotly)
# p <- plot_ly(moddf, x = ~date, y = ~Prediction, color = ~Model, type = "scatter") %>%
# p

#plot all
ggplotly(tpm(moddf), tooltip = c('x', 'title', 'y')) # not sure how to use tooltip yet, default seem to work the same

#plot all from 4/16
ggplotly(tpm(moddf, date='2016-04-01'), tooltip = c('x', 'title', 'y'))

#plot class from 4/16
ggplotly(tpm(moddf, model = 'class', date='2016-04-01'), tooltip = c('x', 'title', 'y'))

# statements vs. remarks
ggplotly(tpt(moddf, 'both', 'svmClass','min', title = 'SVM Predictions'), tooltip = c('x', 'title', 'y'))
ggplotly(tpt(moddf, 'both', 'rfClass','min', title = "Random Forest Predictions"), tooltip = c('x', 'title', 'y'))

#statements only
ggplotly(tpm(moddf, type = "TrumpStatements",model = 'class'), tooltip = c('x', 'title', 'y'))


#plot by FAKE topic from 4/16
ggplotly(tptop(moddf, model = 'svmClass', date='2016-04-01'))

ggplotly(tptop(moddf, model = 'rfClass', date='2016-04-01'))
ggplotly(tptop(moddf, model = 'svmReg', date='2016-04-01'))
