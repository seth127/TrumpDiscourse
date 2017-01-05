library(ggplot2)

#######################
# plotting parameters #
#######################

# type: 'both' 'TrumpRemarks' 'TrumpStatements'
# model: 'all' 'class' 'reg' or name of model 
# date: 'min' or date to start the plot, format '2016-04-01' for April 1st
# title: a string for the plot title, defaults to blank

###############################
# plotting with color by type #
###############################

tpt <- function(df, type = "both", model = "all", date = 'min', title = '') {
  # filter remarks vs statements
  if (type == 'both') {
    type <- c('TrumpRemarks', 'TrumpStatements')
  }
  # filter models
  if (model == 'all') {
    model <- levels(moddf$Model)
  } else if (model == 'class') {
    model <- c('rfClass', 'svmClass')
  } else if (model == 'reg') {
    model <- c('rfReg', 'svmReg')
  }
  # filter date
  if (date == 'min') {
    date <- min(df$date)
  }
  
  # plot
  g <- ggplot(df[df$type %in% type & df$Model %in% model & df$date >= as.Date(date), ], aes(x=date, y=Prediction)) + ggtitle(title)
  g <- g + geom_line(aes(colour=type))
  g <- g + geom_point(aes(colour=type, title=title))
  g
}

################################
# plotting with color by model #
################################

tpm <- function(df, type = "both", model = "all", date = 'min', title = '') {
  # filter remarks vs statements
  if (type == 'both') {
    type <- c('TrumpRemarks', 'TrumpStatements')
  }
  # filter models
  if (model == 'all') {
    model <- levels(moddf$Model)
  } else if (model == 'class') {
    model <- c('rfClass', 'svmClass')
  } else if (model == 'reg') {
    model <- c('rfReg', 'svmReg')
  }
  # filter date
  if (date == 'min') {
    date <- min(df$date)
  }
  
  # plot
  g <- ggplot(df[df$type %in% type & df$Model %in% model & df$date >= as.Date(date), ], aes(x=date, y=Prediction))  + ggtitle(title)
  g <- g + geom_line(aes(colour=Model))
  g <- g + geom_point(aes(colour=Model, title=title))
  g
}

###############################
# plotting with color by type #
###############################

tptop <- function(df, type = "both", model = "all", date = 'min', title = '') {
  # filter remarks vs statements
  if (type == 'both') {
    type <- c('TrumpRemarks', 'TrumpStatements')
  }
  # filter models
  if (model == 'all') {
    model <- levels(moddf$Model)
  } else if (model == 'class') {
    model <- c('rfClass', 'svmClass')
  } else if (model == 'reg') {
    model <- c('rfReg', 'svmReg')
  }
  # filter date
  if (date == 'min') {
    date <- min(df$date)
  }
  
  # plot
  g <- ggplot(df[df$type %in% type & df$Model %in% model & df$date >= as.Date(date), ], aes(x=date, y=Prediction)) + ggtitle(title)
  g <- g + geom_line(aes(colour=Topic))
  g <- g + geom_point(aes(colour=Topic, title=title))
  g
}