soil <- read.csv("soil.csv")

soil_matrix <- as.matrix(soil)
install.packages("glmnet")
library(glmnet)

comps <- prcomp(soil_matrix, retx = TRUE, scale = TRUE)
df <- as.data.frame(comps$x)

pH <- glmnet(x = soil_matrix, y = df$PC1, family = "gaussian")

plot(pH)

cv_pH <- cv.glmnet(soil_matrix, df$PC1)
cv_pH$lambda.min

plot(coef(cv_pH))



