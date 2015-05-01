# SCORED 0.49346

# meat
booking_bool <- (test$prop_review_score == 5) * 1

# construct srch.prop_id column
srch.prop_id <- paste(test$srch_id, test$prop_id, sep = '-')  

# construct data frame
df <- data.frame(srch.prop_id, booking_bool)
df <- rename(df, c("srch.prop_id" = "srch-prop_id"))

# write to csv
write.csv(df, row.names = FALSE, file = "review-score.csv")
