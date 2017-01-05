
cleanTrumpPredictions <- function(rawdf) {
  splitGroupId <- function(groupIdVector) {
    titleStrings <- character(length(groupIdVector))
    dateStrings <- character(length(groupIdVector))
    typeStrings <- character(length(groupIdVector))
    for (i in 1:length(groupIdVector)) {
      string <- unlist(strsplit(groupIdVector[i], 'TrumpTexts/'))[2]
      # get type
      typeStrings[i] <- unlist(strsplit(string, '/raw/'))[1]
      # get file and date
      fileString <- unlist(strsplit(string, '/raw/Donald J. Trump: '))[2]
      fileString <- gsub("Press Release - ", "", fileString)
      #
      titleStrings[i] <- unlist(strsplit(fileString, ' - '))[1]
      dateStrings[i] <- unlist(strsplit(fileString, ' - '))[2]
    }
    # get rid of .txt at the end
    dateStrings <- gsub(".txt", "", dateStrings)
    # get rid of "by DJT" in the middle of some titles
    titleStrings <- gsub("by Donald J. Trump ", "", titleStrings)
    # save in a list and return
    biglist <- list(typeStrings, titleStrings, dateStrings)
    biglist
  }
  
  # create stringList
  stringList <- splitGroupId(rawdf$groupId)
  
  # combine into data frame
  df <- data.frame(type = stringList[[1]],
                   title = stringList[[2]],
                   date = as.Date(stringList[[3]], format = "%B %d, %Y"),
                   rfReg = rawdf$rfPred,
                   svmReg = rawdf$svmPred,
                   rfClass = rawdf$rfClassPred,
                   svmClass = rawdf$svmClassPred)
  
  # return data frame
  df
}
# 
# splitGroupId <- function(groupIdVector) {
#   titleStrings <- character(length(groupIdVector))
#   dateStrings <- character(length(groupIdVector))
#   typeStrings <- character(length(groupIdVector))
#   for (i in 1:length(groupIdVector)) {
#     string <- unlist(strsplit(groupIdVector[i], 'TrumpTexts/'))[2]
#     # get type
#     typeStrings[i] <- unlist(strsplit(string, '/raw/'))[1]
#     # get file and date
#     fileString <- unlist(strsplit(string, '/raw/Donald J. Trump: '))[2]
#     fileString <- gsub("Press Release - ", "", fileString)
#     #
#     titleStrings[i] <- unlist(strsplit(fileString, ' - '))[1]
#     dateStrings[i] <- unlist(strsplit(fileString, ' - '))[2]
#   }
#   # get rid of .txt at the end
#   dateStrings <- gsub(".txt", "", dateStrings)
#   # get rid of "by DJT" in the middle of some titles
#   titleStrings <- gsub("by Donald J. Trump ", "", titleStrings)
#   # save in a list and return
#   biglist <- list(typeStrings, titleStrings, dateStrings)
#   biglist
# }
# 
# stringList <- splitGroupId(rawdf$groupId)
# 
# df <- data.frame(type = stringList[[1]],
#                  title = stringList[[2]],
#                  date = as.Date(stringList[[3]], format = "%B %d, %Y"),
#                  rfReg = rawdf$rfPred,
#                  svmReg = rawdf$svmPred,
#                  rfClass = rawdf$rfClassPred,
#                  svmClass = rawdf$svmClassPred)