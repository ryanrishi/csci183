# No kids! This is targeted towards searches that meet the following criteria:
# srch_saturday_night_bool = 1
# srch_children_count = 0
# promotion_flag = 1
# srch_length_of_stay = 1 or 2
# visitor_location_country_id = prop_country_id
# Let's see where this goes!

rm(booking_bool)
setwd("/Users/rrishi/git/csci183/kaggle/expedia")

# meat
booking_bool <- (train$srch_saturday_night_bool == 1) * 1
booking_bool <- booking_bool * (train$srch_children_count == 0)
booking_bool <- booking_bool * (train$srch_length_of_stay <= 2)
booking_bool <- booking_bool * (train$orig_destination_distance < mean(train$orig_destination_distance))
booking_bool <- booking_bool * (train$promotion_flag == 1)
booking_bool <- booking_bool * (train$prop_starrating > 4)
booking_bool <- booking_bool * (train$srch_room_count == 1)
booking_bool <- booking_bool * (train$srch_adults_count == 2)
booking_bool <- booking_bool * (train$comp1_rate == 1)
booking_bool <- booking_bool * (train$srch_booking_window < 4)
#booking_bool <- booking_bool * (train$prop_location_score1 > mean(train$prop_location_score1))
booking_bool <- booking_bool * (train$srch_query_affinity_score > mean(train$srch_query_affinity_score))


# construct srch.prop_id column
srch.prop_id <- paste(train$srch_id, train$prop_id, sep = '-')  

# construct data frame
df <- data.frame(srch.prop_id, booking_bool)
df <- rename(df, c("srch.prop_id" = "srch-prop_id"))

# write to csv
write.csv(df, row.names = FALSE, file = "no-kids.csv")

table(booking_bool == train$booking_bool)

# THIS ONE IS GOOD!
# FALSE   TRUE 
# 8358  292263 

