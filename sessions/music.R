music.all <- read.csv("music-all.csv")

# impute NAs - can I do this with is.na() ?

df <- as.data.frame(music.all)
df[is.na(df)] <- 0
rm(df)

pr_music <- prcomp (music.all[4:73], retx = TRUE, scale = TRUE)
df <- as.data.frame(pr_music$x)

library(ggplot2)
p <- ggplot(df, aes(x=PC1, y=PC2, label = music.all$artist))
p + geom_text()

