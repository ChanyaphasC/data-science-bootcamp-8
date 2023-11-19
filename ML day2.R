library(tidyverse)
library(caret)
library(mlbench)

data("BostonHousing")

# rename data
df <- BostonHousing

# complete data?
complete.cases(df) # ==> show TRUE
mean(complete.cases(df)) # ==> show 1

# 1. train test split
split_data <- function(df, train_size=0.8){
  set.seed(42)
  n <- nrow(df)
  id <- sample(1:n, size=n*train_size)
  train_df <- df[id,]
  test_df <- df[-id,]
  list(train = train_df, test_df)
}
prep_data <- split_data(df)
train_data <- prep_data[[1]]
test_data <- prep_data[[2]]

# 2. train model
model <- train(medv~rm + b+ crim,
               data =train_data,
               method = "lm")

# 3. score/ predict new data (test/ unseen data)
p <- predict(model, newdata=test_data)

# 4. evaluate model ==> absolute metrics
# mae, mse, rmse
error_mae <- function(actual, pred) {
  error <- actual - pred
  mean(abs(error))
}

error_mse <-function(actual, pred) {
  error <- actual - pred
  mean(error**2)
}

error_rmse <-function(actual, pred) {
  error <- actual - pred
  sqrt(mean(error**2))
}

error_mae(test_data$medv, p)
error_mse(test_data$medv, p)
error_rmse(test_data$medv, p)

## save model .RDS
#saveRDS(model, "lm_model.RDS")

## read RDS
#model <- readRDS("lm_model.RDS")

## train control
## change resampling technique

ctrl <- trainControl(
  method = "Boot",
  number = 50,
  verboseIter = TRUE
)

## golden rule: K-Fold CV
set.seed(25)
ctrl <- trainControl(
  method = "CV",
  number = 5,
  verboseIter = TRUE)

## Leave-One-Out Cross-Validation 
ctrl <- trainControl(
  method = "LOOCV",
  verboseIter = TRUE) # ==> ไม่นิยมใช้ เหมาะสำหรับข้อมูลไม่เยอะ

model <- train(medv~rm + b+ crim,
               data =train_data,
               method = "lm",
               trControl = ctrl)
model

## add preProcess
set.seed(25)
ctrl <- trainControl(
  method = "CV",
  number = 5,
  verboseIter = TRUE)
model <- train(medv~rm + b+ crim,
               data =train_data,
               method = "lm",
               preProcess = c("center", "scale"), # ==> can change
               trControl = ctrl)
model

## variable importance
varImp(model)

# train final model using [KNN]
set.seed(25)
ctrl <- trainControl(
  method = "CV",
  number = 5,
  verboseIter = TRUE
)
modelknn <- train(medv~rm + b+ crim + lstat + age,
               data = train_data,
               method = "knn",
               preProcess = c("range", "zv", "nzv"),
               tuneLenght = 4,
               trControl = ctrl)
modelknn # ==> hyperparameter, show you a good K.

## predict test set
p <- predict(model, newdata=test_data)

## rmse for test set
error_rmse(actual=test_data$medv, p)



## 09/10/23
# hyperparameter tuning in train process
# -> tuneLenght: scope for finding K wider

## train final model using k=5
model_k5 <- train(medv~rm + b+ crim + lstat + age,
                  data = train_data,
                  method = "knn",
                  tuneGrid = data.frame(k=5),
                  preProcess = c("range", "zv", "nzv"),
                  trControl = trainControl(method="none"))

# predict test set
p_train <- predict(model_k5)
p_test <- predict(model_k5, newdata=test_data)

# rmse for test set
rmse_train <- error_rmse(train_data$medv, p_train)
rmse_test <- error_rmse(test_data$medv, p_test)
rmse_train; rmse_test

# tuneLenght(เราแค่บอกว่าจะtune k ทั้งหมดกี่ค่า)  vs. tuneGrid (set K manually)
set.seed(42)
ctrl <- trainControl(
  method = "cv",
	number =5,
	verboseIter = TRUE)

## tuneGrid
model <- train(medv ~ rm + b + crim + lstat + age,
               data = train_data,
               method = "knn",
               metric = "Rsquared",
               tuneGrid = data.frame(k = c(5,7,13)), ## vs. tuneLength
               preProcess = c("center", "scale"),
               trControl = ctrl)

## repeated k-fold cross validation
set.seed(42)
ctrl <- trainControl(
  method = "repeatedcv", 
  number = 5, # k=5
  repeats = 5, # repeats=5
  verboseIter = TRUE )

model <- train(medv~rm + b + crim + lstat + age,
               data = train_data,
               method = "knn",
               tuneGrid = data.frame(k = c(5,7,13)),
               preProcess = c("center", "scale"),
               trControl = ctrl)





