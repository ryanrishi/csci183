bike_theft$loc <- "OTHER"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Swig")] <- "Swig"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Dunne")] <- "Dunne"
bike_theft$loc[str_detect(bike_theft$LOCATION, "McLaughlin")] <- "McLaughlin"
bike_theft$loc[str_detect(bike_theft$LOCATION, "Walsh")] <- "Waslh"
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

bike_theft$DOW <- "N/A"
bike_theft$date <- date.mdy(bike_theft$DATE)
bike_theft$DOW <- date.wday(bike_theft$date)

locations <- c("Swig", "Dunne", "McLaughlin", "Walsh", "Casa", "Sobrato", "Campisi", 
               "Sanfilippo", "Nobili", "Graham", "Benson", "Bannan", "Daly", "Kenna", 
               "O'Connor", "Malley", "Villas", "Bellarmine")

bike_theft$DATE <- as.Date(bike_theft$DATE, "%Y-%m-%d")
bike_theft$DayOfWeek <- weekdays(as.Date(bike_theft$DATE))
bike_theft$time <- as.Date(bike_theft$TIME..Hours., )
WorstDayOfWeek <- table(bike_theft$DayOfWeek)
sort(WorstDayOfWeek, decreasing = TRUE)

# make column for dates in YYYY-MM format
install.packages("zoo")
library(zoo)
bike_theft$YearMon <- as.yearmon(bike_theft$DATE)
bike_theft$YearMon <- format(bike_theft$YearMon, "%Y-%m")

# calculate number of bike thefts per location per month
allYearMon <- unique(bike_theft$YearMon)
# remove NAs
allYearMon <- apply(allYearMon, 1, function(x) unique(x[!is.na(x)]) )
allYearMon <- allYearMon[!is.na(allYearMon)]
df <- data.frame("Location" = locations)

# generate columns with YYYY-MM 
for (date in allYearMon) {
  df[date] <- date
  df[date] <- 0
}

for (date in 1:length(allYearMon) {
  for (loc in 1:length(locations)) {
    df[loc, date] <- bike_theft
  }
}
  
for (date in 1:length(allYearMon)) {
  df[date+1] <- allYearMon[date]
}

for (date in allYearMon) {
  for (loc in 1:length(locations)) {
    df$as.char(date) <- 1 
  }
}

# manually
for (theft in 1:nrow(bike_theft)) {
  if (bike_theft[theft,]$YearMon == "2007-12") {
    
  }
}

table(bike_theft$YearMon == "2007-12")
if (bike_theft$YearMon == "2007-12") {
  print(bike_theft$loc)
}


df <- as.data.frame(table(bike_theft$loc, bike_theft$YearMon))
