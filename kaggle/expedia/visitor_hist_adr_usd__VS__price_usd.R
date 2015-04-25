# visitor_hist_adr_usd vs price
visitor_hist_adr_usd <- train$visitor_hist_adr_usd
price_usd <- train$price_usd

# Let's take about 15% standard deviation
booking_bool <- vector(mode = "logical", length = nrow(price_usd))


# assign to vectors
srch.prop_id <- c(1234-5678)
booking_bool <- c(TRUE)

# construct the data frame
df = data.frame(srch.prop_id, booking_bool)

# write to CSV
write.csv(df, file = 'rrishi_submission_1.csv')
