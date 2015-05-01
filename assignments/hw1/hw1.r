nyt1 <- read.csv(url("http://stat.columbia.edu/~rachel/datasets/nyt1.csv"))

#	Also, how on earth are newborns reading NYT articles?

#	df will look like:
#	Age		Impressions	Clicks	CTR
#	<18		14059		15097	...
#	18-24	14097		125097	...
#	25-34	0871		019745	...
#	35-44	154097		1345097	...
#	45-54	1452		2790	...
#	55-64	1345		150972	...
#	65+		230597		1570	...

nyt1$ageCat <- cut(nyt1$Age, c(-Inf, 0, 18, 24, 34, 44, 54, 64, Inf))


df = data.frame()
for (row in nyt1) {

	if (row$Age < 18) {
		df$Age <- "<18"
	}
	else if (row$Age < 24) {
		df$Age <- "18-24"
	}
	else if(row$Age < 34) {
		df$Age <- "25-34"
	}
	else if(row$Age < 44) {
		df$Age <- "35-44"
	}
	else if(row$Age < 54) {
		df$Age <- "45-54"
	}
	else if(row$Age < 65) {
		df$Age <- "55-64"
	}
	else {
		df$Age <- "65+"
	}

	df$Impressions <- row$Impressions
	df$Clicks <- row$Clicks
	df$CTR <- row$Clicks / row$Impressions

}
