library(ggplot2)

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
  g <- ggplot(df[df$type %in% type & df$Model %in% model & df$date >= as.Date(date), ], aes(x=date, y=Prediction,colour=type)) + geom_line() + geom_point() + ggtitle(title)
  g
}

tpm <- function(df, type = "both", model = "all", date = 'min') {
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
  g <- ggplot(df[df$type %in% type & df$Model %in% model & df$date >= as.Date(date), ], aes(x=date, y=Prediction,colour=Model)) + geom_line() + geom_point()
  g
}