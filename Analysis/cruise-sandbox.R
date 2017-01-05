library(ggplot2)
library(plotly)

shipNames <- c("Princess", "Voyager", "Paul Simon", "Dangelo", "Virginia", "Meade", "Capt America", "Naw Dawg")

set.seed(1)
cruise <- data.frame(company = sample(c("Carnival", "Norweigen"), 20, replace = T),
                     shipName = sample(shipNames, 20, replace=T),
                     date = sample(seq(from=as.Date('2016-01-01'), to=as.Date('2016-12-31'), by=1), 20),
                     distance = sample(seq(from=300, to=500, by=1), 20)
                     )

g <- ggplot(cruise, aes(x=date, y=distance, colour=company, name = shipName)) + geom_point()
# you have to put the geom_line first or it fucks it up
g <- ggplot(cruise, aes(x=date, y=distance)) + geom_line(aes(colour=company)) + geom_point(aes(colour=company, name = shipName))

ggplotly(g, tooltip = c("x", "name"))

ggplotly(g, tooltip = c("x", "distance"))

ggplotly(g, tooltip = c("x", "company"))


str(g)
