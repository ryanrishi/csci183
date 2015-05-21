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
bike_theft$loc[str_detect(bike_theft$LOCATION, "Engineering")] <- "Engineering"

loc <- table(bike_theft$loc)

bike_theft$DOW <- "N/A"
bike_theft$date <- mdy(bike_theft$DATE)
bike_theft$DOW <- wday(bike_theft$date)

