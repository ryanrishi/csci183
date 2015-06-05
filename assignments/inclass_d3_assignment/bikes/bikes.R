setwd('~/git/csci183/assignments/inclass_d3_assignment/')
bike_theft <- read.csv('bikes/bike_theft_rev.csv', header = TRUE)

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

bike_theft$DOW <- "N/A"
bike_theft$date <- mdy(bike_theft$DATE)
bike_theft$DOW <- wday(bike_theft$date)
bike_theft$yearmon <- strftime(bike_theft$date, '%Y-%m')

locations <- c("Swig", "Dunne", "McLaughlin", "Walsh", "Casa", "Sobrato", "Campisi", 
               "Sanfilippo", "Nobili", "Graham", "Benson", "Bannan", "Daly", "Kenna", 
               "O'Connor", "Malley", "Villas", "Bellarmine")

#bike_theft$DATE <- as.Date(bike_theft$DATE, "%Y-%m-%d")
#bike_theft$DayOfWeek <- weekdays(as.Date(bike_theft$DATE))
#bike_theft$time <- as.Date(bike_theft$TIME..Hours., )
WorstDayOfWeek <- table(bike_theft$DOW)
sort(WorstDayOfWeek, decreasing = TRUE)

# calculate number of bike thefts per location per month
allYearMon <- unique(bike_theft$yearmon)
# remove NAs
# allYearMon <- apply(allYearMon, 1, function(x) unique(x[!is.na(x)]))
# allYearMon <- allYearMon[!is.na(allYearMon)]
#df <- data.frame("Location" = locations)

df <- as.data.frame.matrix(table(bike_theft$loc, bike_theft$yearmon))
library('plyr')
rename(df, c("row.names" = "name"))

write.table(df, file="bike_theft_loc_occurrences.tsv", sep='\t')


###   PART 2  ###
install.packages('choroplethr')
library(choroplethr)
library(acs)
api.key.install('4f32526cc94e8dd53cf2f751eff6967a1069878a')
acs_data <- get_acs_data("B08101", "county",column_idx = 41,)
acs_employment <- get_acs_data('B08101', 'county', column_idx = 1)
bikes2 <- data.frame(id = acs_data$df$region, rate= acs_data$df$value / (mean(acs_data$df$value) + sd(acs_data$df$value))) # this seems to work well, but idk why mean+sd
write.table(bikes2, file="bike2.tsv", sep='\t', row.names = F)

