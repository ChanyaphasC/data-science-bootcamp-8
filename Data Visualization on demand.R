# get working directory
getwd()

library(tidyverse)
head(mtcars)

### basic plots (base R)
hist(mtcars$mpg) # quantitative column

## Analyzing horse power
# Histogram - One Quantitative variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)

mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto", "Manual"))

# Bar plot - One Qualitative variable
barplot(table(mtcars$am))

# Box plot 
boxplot(mtcars$hp)
fivenum(mtcars$hp) # min,Q25,Q50,Q70,max five number summary
min(mtcars$hp)
quantile(mtcars$hp, probs =c(.25, .5, .75))
quantile(mtcars$hp, props =c(.25, .5, .75))

## whisker calculation
Q3 <- quantile(mtcars$hp, probs = .75)
Q1 <- quantile(mtcars$hp, probs = .25)
IQR_hp <- Q3-Q1

Q3 + 1.5*IQR_hp # ???????????????????????????
Q1 + 1.5*IQR_hp

boxplot.stats(mtcars$hp, coef = 1.5)

## filter outliers
hp_noout <- mtcars %>%
  filter(hp < 335)

boxplot(hp_noout$hp)

## Boxplot 2 varibles
# Qualitative x Quantitative
data(mtcars)  # load original dataframe
mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto", "Manual"))

boxplot(mpg ~ am ,data = mtcars,
        col = c("pink", "skyblue"))

## Scatter plot
# 2 x Quantitative
plot(mtcars$hp, mtcars$mpg, pch = 16, 
     col="blue",
     main = "Relationship between HP and MPG",
     xlab = "Horse Power",
     ylab = "Mile Per Gallon")
cor(mtcars$hp, mtcars$mpg) # negative value
lm(mpg ~ hp, data = mtcars) # same negative value


### ggplot
library(tidyverse)

## First Plot
ggplot(data = mtcars, mapping = aes(x=hp, y=mpg)) +
  geom_point() +
  geom_smooth() +
  geom_rug()

ggplot(data = mtcars, mapping = aes(hp, mpg)) +
  geom_point(size=3, col="blue", alpha=0.6) 

ggplot(mtcars, aes(hp)) +
  geom_histogram(bins=10, fill="greenyellow", col="blue")

p <- ggplot(mtcars, aes(hp))
p + geom_boxplot()
p + geom_histogram()
p + geom_density()

## Box plot by groups
diamonds %>% count(cut)

## geom_bar --> factor data ?????????????????????????????????????????????????????????????????????????????????????????????????????????
ggplot(diamonds, mapping = aes(cut, fill=color)) +
  geom_bar(position = "dodge")

set.seed(42)
small_diamonds <- sample_n(diamonds, 5000)

ggplot(small_diamonds , mapping = aes(carat, price)) +
  geom_point()

## Facet : small multiples #?????????????????????
ggplot(small_diamonds , mapping = aes(carat, price)) +
  geom_point() + 
  geom_smooth() +
  facet_wrap(~color, ncol=2)

ggplot(small_diamonds , mapping = aes(carat, price)) +
  geom_point() + 
  geom_smooth(method="lm", col="green") +
  facet_wrap(~color, ncol=2) +
  theme_minimal() +
  labs(title="Relationship between Carat and Price by Color",
       x = "Carat", y = "Price usa", caption = "Source Diamonds from ggplot2 package")

## Final example
ggplot(small_diamonds , aes(carat, price), col=cut) +
  geom_point(sizw=3, alpha=0.6) + 
  facet_wrap(~color, ncol=2) + 
  theme_minimal()
























