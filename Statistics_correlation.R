## Correlation
cor(mtcars$hp, mtcars$mpg)
cor(mtcars$wt, mtcars$mpg)

plot(mtcars$hp, mtcars$mpg, pch=16)
plot(mtcars$wt, mtcars$mpg, pch=16)
plot(mtcars$wt, mtcars$hp, pch=17)

cor(mtcars[ , c("mpg", "wt", "hp")])

# dplyr (tidyverse)
library(dplyr)
mtcars %>%
  select(mpg, wt, hp, am) %>%
  cor()

# compute correlation (r) and sig test pearson's test
cor.test(mtcars$hp, mtcars$mpg)

## Linear Regression
# mpg = f(hp)
mpghp = lm(mpg ~ hp, data=mtcars)

summary(mpghp)

mpghp$coefficients[[1]] + mpghp$coefficients[[2]]*200

new_cars <- data.frame(
  hp = c(250, 320, 400, 410, 450)
)

# predict()
new_cars$mpg_pred <- predict(mpghp, newdata = new_cars)
#new_cars$hp_pred <- NULL
summary(mtcars$hp)

# Root mean square error RMSE
# Multiple Linear Regression
# mpg = f(hp, wt, am)
# mpg = b0 + b1*hp + b3*wt + b3*am
mlp <- lm(mpg ~ hp + wt + am, data = mtcars)

coefs <- coef(mlp)
coefs[1] + coefs[2]*200 + coefs[3]*3.5 + coefs[4]*1

# Build Full Model
lmfit_full <- lm(mpg ~ ., data = mtcars)
lmfit_full

mtcars$predicted <- predict(lmfit_full)
head(mtcars)

# Train RMSE
squared_error <- (mtcars$mpg - mtcars$predicted) **2
rmse <- sqrt(mean(squared_error))
rmse

# split data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, n*0.8)
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ]

# Train Model
model1 <- lm(mpg ~ hp + wt, data = train_data)
pred_train <- predict(model1)
error_train <- train_data$mpg - pred_train
rmse_train <- sqrt(mean(error**2))

# Test Model
pred_test <- predict(model1, newdata = test_data)
error_test <- test_data$mpg - pred_test
rmse_test <- sqrt(mean(error_test**2))

# Print Result
cat("RMSE Train: ", rmse_train,
    "\nRMSE Test: ", rmse_test)














