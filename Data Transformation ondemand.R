
# read csv file
library(readr)
library(dplyr)
imdb = read.csv("imdb.csv", stringsAsFactors=FALSE)
View(imdb)

# review data structure
glimpse(imdb)

# print head and tail of data
head(imdb,10)
tail(imdb,10)

# select columns
select(imdb,MOVIE_NAME,RATING)
select(imdb,movie_name = MOVIE_NAME,released_year=YEAR)

# pipe Operation
#df %>% select() %>% filter() %>% mutate() %>% arrange()
imdb %>% 
  select(movie_name = MOVIE_NAME,released_year=YEAR) %>% 
  head(10)

## filter data 1
filter(imdb,SCORE>=9.0)
imdb %>% filter(SCORE>=9.0)

names(imdb) = tolower(names(imdb))
imdb %>%
  select(movie_name,year,score) %>%
  filter(score>=9)

imdb %>%
  select(movie_name,length,score) %>%
  filter(score==8.8|score==8.3|score==9.0)

imdb %>%
  select(movie_name,length,score) %>%
  filter(score %in% c(8.3,8.8,9.0))

# filter string columns
imdb %>%
  select(movie_name,genre,rating) %>%
           filter(rating == "PG-13")
imdb %>%
  select(movie_name,genre,rating) %>%
  filter(grepl("Drama",imdb$genre)) #have drama in column genre

#-> grepl("Drama",imdb$genre) search pattern(show TRUE FALSE)

imdb %>%
  select(movie_name) %>%
  filter(grepl("King",imdb$movie_name)) #have "King" in movie_name

## create new column
imdb %>%
  mutate(score_group = if_else(score >= 9,"High Rating","Low Rating"),
         lenght_group = if_else(length>=120,"Long Film","Short Film"))
imdb %>% 
  select(movie_name,score) %>%
  mutate(score_update = score+0.1) %>%
  head(10)
           
## arrange data
imdb %>%
  arrange(length) %>%
  head(10)   # low>high
imdb %>% 
  arrange(desc(length)) %>% #descending h>l
  head(10)
imdb %>%
  arrange(rating,desc(length))

## summary statistics and group by
imdb %>%
  filter(rating != "") %>%  #del blank
  group_by(rating) %>%      #group by rating
  summarise(mean_length = mean(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            n = n())
## join tables
favorite_films = data.frame(id=c(5,10,25,30,98))

favorite_films %>%
  inner_join(imdb,by= c("id" = "no"))  #ดึงมาเฉพาะ2ตารางที่มีแถวค่าเหมือนกัน


### Export CSV file

imdb_prep = imdb %>%
  select(movie_name,released_year = year,rating,length,score) %>% 
  filter(rating == "R" & released_year >2000)
write.csv(imdb_prep,"imdb_prep.csv",row.names = FALSE)

---------------- Intermediate-------------
### tibble เหมือนDF แต่การแสดงผลลัพธ์ใน consoleสวยกว่า datafram
  #ปกติและแสดงจำนวนrows * column,แสดงผลแค่ 10 row
install.packages("tidyverse")

library(tidyverse)
df_tibble = tibble(id=1:3,name=c("nina","jang","kook")) # Tibble
df = data.frame(id=1:3,name=c("nina","jang","kook"))    # Dataframe

# convert dataframe to tibble
mtcars
mtcars_tibble = tibble(mtcars)

# sample data #sample_n() สุ่มจำนวนrowตามที่เราต้องการ
# sample_frac() สุ่มเป็น %ได้

sample_n(mtcars,size=5) #random size all the time
set.seed(42) #lock result 

sample_frac(mtcars,size=0.30) 

## slice ใช้ดึง rowที่เราต้องการจาก dataframe/tibble
mtcars %>%
  slice(1:5)

mtcars %>% 
  slice(mtcars,1:5)

mtcars[1:5]

mtcars %>%
  slice(sample(nrow(mtcars),10))

slice(mtcars)

tibble แสดงผลใน console สวยกว่า dataframe ปกติ
tibble แสดงจำนวน rows x columns
tibble แสดงผลแค่ 10 rows (default)

df[5:9,]
df %>% slice(5:9)
slice(df,5:9)
