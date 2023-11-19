### Essentail ML : Ep on demand
## Regression Example

# Split Data
library(caret)
mtcars
train_test_split <- function(data) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(n, size=0.8*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train_data, test_data))
}

split_data <- train_test_split(mtcars)

split-data[[1]]   # train data
split_data[[2]]   # test data

# Train Model : Linear Regression Model
lm_model <- train(mpg ~ hp, 
                  data = split_data[[1]],
                  method = "lm")

# Score and evaluate
pred <- predict(lm_model, newdata=split_data[[2]])

error <- split_data[[2]]$mpg - pred
rmse <- sqrt(mean(error**2))


### Classification Example

library(caret)

# load clean data
data("mtcars")

# prepare data change am datatype to factor
mtcars$am <- factor(mtcars$am, 
                    levels=c(0,1), 
                    labels=c("Auto", "Manual"))

# split data
split_data <- train_test_split(mtcars)

# train model : Logistic Regression Model
glm_model <- train(am ~ mpg, # classification 
                   data = split_data[[1]],
                   method = "glm")

# score and evaluate
p <- predict(glm_model, newdata=split_data[[2]])

acc <- mean(p == split_data[[2]]$am)










