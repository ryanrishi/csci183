# this file contains my notes. Said notes may not be coherent.

table(train$prop_starrating)  # 
table(train$visitor_hist_starrating)  # this won't to much good since about 285k / 300k of these values are 0
table(train$visitor_hist_adr_usd)     # "". Darn you privacy!

# for testing, do something like this:
table(booking_bool == train$booking_bool) # the more TRUES, the better

