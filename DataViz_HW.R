View(diamonds)
library(ggplot2)
library(tidyverse)


first <- diamonds %>%
  select(carat, color, cut) %>%
  filter(diamonds$carat >= 0.5, diamonds$cut == "Premium")

ggplot(first, mapping = aes(carat, color)) + 
  geom_histogram() +
  geom_smooth(col = "black") +
  theme_minimal()

ggplot(diamonds, aes(x = clarity, y = table, col = clarity)) +
  geom_violin() +
  labs(title = "",x = "Clarity", y = "Table") +
  theme_minimal()

a <- diamonds %>%
  filter(clarity == "I1") %>%
  select(carat, clarity)

# 1
ggplot(diamonds, aes(carat, clarity)) +
  geom_point(size = 3, alpha = 0.5, col = "violet") +
  geom_smooth(method = 'lm', formula = 'y ~ x') +
  theme_minimal()

# 2
ggplot(diamonds, mapping = aes(cut, fill=color)) +
  geom_bar(position = "dodge") +
  labs(title = "Bar plot of Cut Grades vs. Diamond Color") +
  scale_fill_manual(values = c("#66c2a5", "#fc8d62", "#8da0cb",
                               "#e78ac3", "#a6d854", "#ffd92f", "#e5c494"))

# 3
diamonds %>%
  group_by(cut) %>%
  summarise(meanprice = mean(price), maxprice = max(price)) %>%
  
  ggplot(mapping = aes(cut)) +
  geom_point(aes(y = maxprice), col = "salmon", size = 3, shape = 17) +
  geom_point(aes(y = meanprice), col = "green3", size = 3, shape = 16) +
  labs(x = "Cut", y = "Price") +
  theme_minimal()
  

# 4
ggplot(diamonds %>%
         mutate(price = ifelse(price <= 1000, "Cheap","Expensive")), aes(x = cut, fill=price)) +
  geom_bar() +
  labs(title = "Bar Plot of Cut vs. Price", 
       x = "Cut",
       y = "Price",
       fill = "Price Category") +
  theme_minimal()

# 5.
ggplot(diamonds, aes(x = clarity, y = table, col = clarity)) +
  geom_violin() +
  labs(title = "The table width of diamonds for each clarity",x = "Clarity", y = "Table") +
  theme_minimal()





diamonds %>%
  group_by(cut) %>%
  summarise(meanprice = mean(price), maxprice = max(price)) %>%
  
  ggplot(mapping = aes(cut)) +
  geom_point(aes(y = maxprice), col = "red", size = 3, shape = 17) +
  geom_point(aes(y = meanprice), col = "blue3", size = 3, shape = 16) +
  geom_text(aes(y = maxprice, label = round(maxprice, 2)), vjust = -0.5, color = "red") +
  geom_text(aes(y = meanprice, label = round(meanprice, 2)), vjust = 0.5, color = "blue3") +
  labs(x = "Cut", y = "Price") +
  theme_minimal()



