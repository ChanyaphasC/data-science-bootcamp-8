# load ggplot library
# update at this file, just another comment
library(ggplot2)

ggplot(diamonds, aes(carat, price)) +
  geom_point()
