library('haven')
library('vcd')

GSS2010 <- read_dta('GSS2010.dta')
GSS2012 <- read_dta('GSS2012.dta')

# impute NAs for marhomo
GSS2010$marhomo[is.na(GSS2010$marhomo)] <- mean(GSS2010$marhomo, na.rm = TRUE)
GSS2012$marhomo[is.na(GSS2012$marhomo)] <- mean(GSS2012$marhomo, na.rm = TRUE)

# impute NAs for eqwlth
GSS2010$eqwlth[is.na(GSS2010$eqwlth)] <- mean(GSS2010$eqwlth, na.rm = TRUE)
GSS2012$eqwlth[is.na(GSS2012$eqwlth)] <- mean(GSS2012$eqwlth, na.rm = TRUE)

liberal <- sum(
  (GSS2010$marhomo < mean(GSS2010$marhomo) & GSS2010$eqwlth < mean(GSS2010$eqwlth)),
  (GSS2012$marhomo < mean(GSS2012$marhomo) & GSS2012$eqwlth < mean(GSS2012$eqwlth))
)

libertarian <- sum(
  (GSS2010$marhomo < mean(GSS2010$marhomo) & GSS2010$eqwlth > mean(GSS2010$eqwlth)),
  (GSS2012$marhomo < mean(GSS2012$marhomo) & GSS2012$eqwlth > mean(GSS2012$eqwlth))
)

hardhat <- sum(
  (GSS2010$marhomo > mean(GSS2010$marhomo) & GSS2010$eqwlth < mean(GSS2010$eqwlth)),
  (GSS2012$marhomo > mean(GSS2012$marhomo) & GSS2012$eqwlth < mean(GSS2012$eqwlth))
)

conservative <- sum(
  (GSS2010$marhomo > mean(GSS2010$marhomo) & GSS2010$eqwlth > mean(GSS2010$eqwlth)),
  (GSS2012$marhomo > mean(GSS2012$marhomo) & GSS2012$eqwlth > mean(GSS2012$eqwlth))
)

total <- sum(liberal, libertarian, hardhat, conservative) # this is counting people that answered both questions

# percentages
liberal_per <- round(liberal / total * 100)
libertarian_per <- round(libertarian / total * 100)
hardhat_per <- round(hardhat / total * 100)
conservative_per <- round(conservative / total * 100)

tbl <- matrix(c(liberal_per, libertarian_per, hardhat_per, conservative_per), nrow=2, ncol=2)
dimnames(tbl) = list(c("Favor", "Oppose"), c("Favor", "Oppose"))

mosaic(tbl, main = "Where To Find The Libertarians", sub = "Americans' views on gay marriage and income redistribution, 2010-12", gp = gpar(c("blue", "green", "yellow", "red"), 2, 2))
labeling_cells(c("Liberal", "Libertarian", "Hardhat", "Conservative"))
