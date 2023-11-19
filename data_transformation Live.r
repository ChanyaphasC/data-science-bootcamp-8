library(tidyverse)
library(RSQLite)
library(glue)

# string template
my_name <- "Toy"
age <- 34
city <- "Bangkok"

text <- glue("Hello my name is {my_name} and I'm {age} years old and I live in {city}")

# working with date
d <- "2023-06-17"
class(d)

# tidyverse - dplyr
# 1. select
# 2. filter
# 3. arrange
# 4. mutate (create new column)
# 5. summarise + group_by (aggregate in SQL)

View(mtcars)

select(mtcars, mpg, cyl, disp, hp, am)

select(mtcars, mile_per_gallon = mpg, weight = wt)

select(mtcars, starts_with("a"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))

## rownames to column
mtcars <- rownames_to_column(mtcars, var="model")

## filter by condition
## filter mtcars dataframe for hp>100
filter(mtcars, hp > 100 | disp > 300 | mpg > 15)

filter(mtcars, model == "Mazda RX4")

filter(mtcars, grepl("^M", model))

## dplyr the right way %>% (PIPE)
## data pipeline in R
mtcars %>%
  select(model, mpg, am, hp) %>%
  filter(hp > 100, mpg > 15)
  
## sort data
df1 <- mtcars %>%
  select(am, mpg) %>%
  arrange(am, desc(mpg))

## mutate - create new column
mtcars %>%
  select(model, mpg) %>%
  filter(mpg > 20) %>%
  mutate(model = tolower(model),
         mpg_double = mpg*2,
         mpg_add_five = mpg+5,
         mpg_log = log(mpg))

## mutate am, 0=Auto, 1=Manual
mtcars <- mtcars %>%
  mutate(am = ifelse(am==0, "Auto", "Manual"))

## summarise + group_by
mtcars %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg),
            n = n())

## simple pipeline
mtcars %>%
  select(mpg, hp, wt, am) %>%
  filter(mpg >= 15) %>%
  group_by(am) %>%
  summarise(n= n())

## read_csv() from internet
df <- read_csv("https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv")

df %>% head

df %>% tail

df %>%
  select(model, milePerGallon = mpg) %>%
  arrange(milePerGallon)

## sampling (random sample)
set.seed(42)
df %>%
  select(model, hp) %>%
  filter(hp > 100) %>%
  sample_n(3) 

## sampling %
df %>%
  sample_frac(0.1) # 10%

## count => create frequency table
df %>%
  count(am)

## bind_rows()
## UNION in SQL

df1 <- mtcars %>% 
  filter(hp>300)

df2 <- mtcars %>%
  filter(hp <= 80)

df3 <- mtcars %>%
  filter(am == "Auto")

df4 <- mtcars %>%
  filter(mpg >= 20)

full_df <- df1 %>%
  bind_rows(df2) %>%
  bind_rows(df3) %>%
  bind_rows(df4)

## stack a lot of dataframe
list_df <- list(df1, df2, df3, df4)
full_df <- bind_rows(list_df)
View(full_df)

## bind_cols() vs. join()
df1 <- data.frame(id = 1:4, 
                  name = c("A","B","C","D"))

df2 <- data.frame(id = c(1:3,5),
                  country = c("US","UK","TH","JP"))

df3 <- data.frame(id = 1:4,
                  classes = c("data", "data", "ux", "business"))
  
bind_cols(df1, df2)
  
## inner join different col names
df1 %>%
  inner_join(df2, by=c("id" = "student_id") )


## inner join
inner_join(df1, df2, by="id")
left_join(df1, df2, by="id")

df1 %>%
  full_join(df2, by="id") %>%
  drop_na()

## join multiple tables
df1 %>%
  inner_join(df2, by="id") %>%
  inner_join(df3, by="id")

## clean missing values

df3 <- data.frame(id = 1:5,
                  classes = c("data", NA, 
                              "ux", "business",
                              NA),
                  score = c(2.5, 2.8, 2.9, 3, NA))

df3 %>% 
  mutate(classes = replace_na(classes, "woohoo!"),
         # mean imputation
         score = replace_na(score, mean(score, na.rm=T)))





