## Logistic EP03

mtcars %>% head()

str(mtcars)

# convert am to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("Auto", "Manual"))
class(mtcars$am)
table(mtcars$am)

# Build model
# split data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, n*0.7)
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ]

# train model binomial = binary classification
logit_model <- glm(am ~ mpg, data = train_data, 
                   family = "binomial")
p_train <- predict(logit_model, type="response")
train_data$pred <- if_else(p_train>= 0.5, "Manual", "Auto")
mean(train_data$am == train_data$pred)

# test model
p_train <- predict(logit_model, newdata = test_data, type="response")
test_data$pred <- if_else(p_train>= 0.5, "Manual", "Auto")
mean(test_data$am == test_data$pred)
### overfitting !


########## Logistic EP04
## Binary Classification
happiness <- c(10, 8, 9, 7, 8, 5, 9, 6, 8, 7, 1, 1, 3, 1, 4, 5, 6, 3, 2, 0)
divorce <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

df <- data.frame(happiness, divorce)

# fit Logistic Regression Full Dataset
model <- glm(divorce ~ happiness, data = df, family = "binomial")

summary(model)

# Predict and Evaluate Model
df$prob_divorce <- predict(model, type = "response")  # response = probability

df$pred_divorce <- ifelse(df$prob_divorce >= 0.5, 1, 0)

# Confusion matrix
conM <- table(df$pred_divorce, df$divorce,
      dnn = c("Predicted", "Actual"))

# Model Evaluation
conM[1, 1]; conM[1, 2]; conM[2, 1]; conM[2, 2]

cat("Accuracy: ", (conM[1,1] + conM[2,2]) / sum(conM))
cat("Precision: ", conM[2,2] / (conM[2,1] + conM[2,2]))
cat("Recal: ", conM[2,2] / (conM[1,2] + conM[2,2]))
cat("F1 score: ",2 * ((0.9*0.9) / (0.9 + 0.9)))


library(titanic)
head(titanic_train)

# DROP NA
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

# Split data
set.seed(42)
sample(1:6, 1)

n <- nrow(titanic_train)
id <- sample(1:n, size = n*0.7)  # 70% train 30% test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

# Train model
glm(Survived ~ Pclass + Age, data = titanic_train, family = "binomial")


# Test Model



# Accuracy







