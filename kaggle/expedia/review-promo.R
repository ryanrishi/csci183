# SCORED 0.50135

# meat
booking_bool <- (train$prop_review_score == 5) * 1
booking_bool <- booking_bool * (train$promotion_flag == 1)

# construct srch.prop_id column
srch.prop_id <- paste(train$srch_id, train$prop_id, sep = '-')  

# construct data frame
df <- data.frame(srch.prop_id, booking_bool)
df <- rename(df, c("srch.prop_id" = "srch-prop_id"))

# write to csv
write.csv(df, row.names = FALSE, file = "review-score.csv")

table(booking_bool == train$booking_bool)

# FALSE   TRUE 
# 10250 290371 
