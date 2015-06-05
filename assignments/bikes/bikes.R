setwd('~/git/csci183/assignments/bikes/')
bike_theft <- read.csv('bike_theft_rev.csv', header = TRUE)

library('stringr')

bike_theft$loc <- "OTHER"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Swig")] <- "Swig"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Dunne")] <- "Dunne"
bike_theft$loc[str_detect(bike_theft$LOCATION, "McLaughlin")] <- "McLaughlin"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Walsh")] <- "Walsh"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Casa")] <- "Casa"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Sobrato")] <- "Sobrato"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Campisi")] <- "Campisi"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Sanfilippo")] <- "Sanfilippo"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Nobili")] <- "Nobili"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Graham")] <- "Graham"
# non-resident halls
bike_theft$loc[str_detect(bike_theft$LOCATION, "Benson")] <- "Benson"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Bannan")] <- "Bannan"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Daly")] <- "Daly"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Kenna")] <- "Kenna"
bike_theft$loc[str_detect(bike_theft$LOCATION, "O'Connor")] <- "O'Connor"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Malley")] <- "Malley"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Villa")] <- "Villas"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Bellarmine")] <- "Bellarmine"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Engineering")] <- "Bannan"

loc <- table(bike_theft$loc)

library('zoo')
library('lubridate')

locations <- c("Swig", "Dunne", "McLaughlin", "Walsh", "Casa", "Sobrato", "Campisi", 
               "Sanfilippo", "Nobili", "Graham", "Benson", "Bannan", "Daly", "Kenna", 
               "O'Connor", "Malley", "Villas", "Bellarmine")

# worst day of week
bike_theft$DOW <- "N/A"
bike_theft$date <- mdy(bike_theft$DATE)
bike_theft$DOW <- wday(bike_theft$date)
bike_theft$yearmon <- strftime(bike_theft$date, '%Y-%m')

WorstDayOfWeek <- table(bike_theft$DOW)
sort(WorstDayOfWeek, decreasing = TRUE) # see output.txt for results

# worst month of year
bike_theft$month <- month(bike_theft$date)
WorstMonth <- table(bike_theft$month)
sort(WorstMonth, decreasing = T) # see output.txt for results

# worst location
WorstLocation <- table(bike_theft$loc)
sort(WorstLocation, decreasing = T) # see output.txt for results

# There are a lot of "OTHER". Can we improve the locations?
bike_theft[bike_theft$loc == 'OTHER',]$LOCATION
# looks like Learning Commons, Locatelli, and Orradre are two big ones.
bike_theft$loc[str_detect(bike_theft$LOCATION, "Learning Common")] <- "Learning Commons"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Locatelli")] <- "Locatelli"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Orradre")] <- "Orradre"


