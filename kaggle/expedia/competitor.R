# Based on competitor's rates and difference
# is Expedia the best on the market? Basically all rows were Expedia has the lowest price.
# Expedia is never the worst nor the best. If you AND all of the rates together, every row is 0.
# all_comp_rates <- 
expedia_best <- (train$comp1_rate & train$comp2_rate & train$comp3_rate & train$comp4_rate & train$comp5_rate & train$comp6_rate & train$comp7_rate) == 1

expedia_best <- vector(mode = "logical", length = nrow(train))

if (train$comp1_rate == 1) {
  if (train$com)
}

for (comp in 1:7) {
  if (train)
}
