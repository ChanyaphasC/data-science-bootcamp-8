#------------ Data Visualization -------------
# comment
# load library

library(tidyverse)
View(mtcars)

###### our first chart 
# one variable, continuous
# create a histogram with ggplot2

ggplot(data = mtcars,
       mapping = aes(x=mpg)) + 
  geom_histogram()    #histogram

ggplot(data = mtcars,
       mapping = aes(x=mpg)) + 
  geom_density()      #curve

ggplot(data = mtcars,
       mapping = aes(x=mpg)) + 
  geom_boxplot()

## base layer

basechart = ggplot(data = mtcars,
       mapping = aes(x=mpg))

basechart + geom_histogram(bins=10,fill="yellowgreen") #bins chart size เยอะไปคือถี่ยิบ, fill = chart colors  
#--------------------------------------
student = data.frame(id=1:5,gender=c("M","M","M","F","F"))

ggplot(data=student,
       mapping = aes(x=gender)) +
  geom_bar(fill="pink")

## two variable,both continuous

base2 = ggplot(mtcars,aes(x=hp,y=mpg))
base2 + geom_point(size=2,col="pink3",
                   alpha=0.5) #alpha จาง ทับกันจะเข้ม

#linear model (method="lm")

base2 +
  geom_smooth(method="lm",col="black",fill="gold") +
  geom_point() + 
  theme_minimal()

## two variable, on discrete
## on continuous

ggplot(diamonds,
       aes(price)) +
  geom_boxplot() +
  coord_flip()

ggplot(diamonds,
       aes(x=color, y=carat)) + #เรียงตามต่างๆเช่นตามสี
  geom_boxplot()

ggplot(diamonds,
       aes(x=cut, y=price)) +
  geom_boxplot()
  
ggplot(diamonds,
       aes(x=cut, y=price)) +
  geom_violin()

## summarise data = build geom_col

p1 = diamonds %>%
  group_by(cut) %>%
  summarise(med_price = median(price)) %>%
  ggplot(aes(cut,med_price)) + 
  geom_col() +
  theme_minimal()

## qplot -> quick plot
library(ggplot2)
p2 = qplot(x=price, data=diamonds,
      geom="histogram", bins=10)
p3 = qplot(x=carat, y=price, data=diamonds,
      geom="point")
p4= qplot(x=cut, data=diamonds,
      geom="bar")

## patchwork -> show chart any chart
p2 / p3 / p4

## ggplot()
## overplotting

ggplot(diamonds, aes(carat,price)) +
  geom_point(shape=".")   #too much data

ggplot(sample_n(diamonds,500), 
       aes(carat,price)) +
  geom_point(alpha=0.5)

set.seed(95)
ggplot(sample_frac(diamonds,0.08), 
       aes(carat,price,col=cut)) +
  geom_point(alpha=0.5) + 
  theme_minimal() + 
  scale_color_brewer(type="qual",palette=1)
  
## facet grid
## segment our chart into group

ggplot(sample_frac(diamonds,0.08), 
       aes(carat,price,col=cut)) +
  geom_point(alpha=0.5) + 
  theme_minimal() + 
  scale_color_brewer(type="qual",palette=1) +
  facet_wrap(~cut)

## lables
ggplot(mtcars,aes(hp,mpg)) +
  geom_point() +
  theme_minimal() + 
  labs(title="My first scatter plot",
       subtitle="Awesome work!",
       x="Hourse power",
       y="Miles per gallon",
       caption="Source: R studio")

## simple bar chart
library(ggthemes)
ggplot(diamonds,aes(cut,fill=color)) +
  geom_bar(positon="stack") +
  theme_wsj()



## install more theme for ggplot chart




















