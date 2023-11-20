
library(tidyverse)
library(caret)
library(mlbench)

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes

## 1. split data
set.seed(42)
n <- nrow(df)
id <- sample(n, size=0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]

## 2. train model
# Logistic Model
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)

logistic_model <- train(diabetes ~ .,
                        data = train_df,
                        mothod = "glm",
                        trControl = ctrl)
p <- predict(logistic_model, newdata=test_df)


# ridge/ Lasso regression
# regularized regression
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)

my_grid <- expand.grid(alpha= 0:1,
                       lambda= seq(0.0005, 0.05, length=20))


glmnet_model <- train(diabetes ~ .,
                      data = train_df,
                      method = "glmnet",
                      tuneGrid = my_grid,
                      trControl = ctrl)

p <- predict(glmnet_model, newdata=test_df)


## Decision tree
library(rpart)
library(rpart.plot)

tree_model <- train(diabetes ~ .,
                      data = train_df,
                      method = "rpart",
                    ## complexity parameter
                    # high cp => good generalization
                    tuneGrid = expand.grid(cp=c(0.02,0.1,0.25)),
                      trControl = ctrl)

rpart.plot((tree_model$finalModel))

p <- predict(tree_model, newdata=test_df)


## Random forest model
# mtry hyperparameter => column
rf_model <- train(diabetes ~ .,
                  data = train_df,
                  method = "rf",
                  #tuneGrid = expand.grid(mtry = c(3,5)),
                  tuneLength =5,
                  trControl = ctrl)

p <- predict(rf_model, newdata=test_df)



## 3. score new data set
p <- predict(logistic_model, newdata=test_df)

## 4. evaluate model
confusionMatrix(p, test_df$diabetes,
                positive = "pos",
                mode = "prec_recall")


## resamples() => compare model performance
# Predict diabetes

model1 <- train(diabetes ~ .,
                data = train_df,
                mothod = "glm",
                trControl = trainControl(
                  method = "cv",
                  number = 5))

model2 <- train(diabetes ~ .,
                data = train_df,
                mothod = "rpart",
                trControl = trainControl(
                  method = "cv",
                  number = 5))

model3 <- train(diabetes ~ .,
                data = train_df,
                mothod = "rf",
                trControl = trainControl(
                  method = "cv",
                  number = 5))

model4 <- train(diabetes ~ .,
                data = train_df,
                mothod = "glmnet",
                trControl = trainControl(
                  method = "cv",
                  number = 5))

## resamples
list_models = list(
  logistic = model1,
  tree = model2,
  randomForest = model3,
  glmnet = model4 
)

results <- resamples(list_models)

summary(results)






















