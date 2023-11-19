data("BostonHousing")

View(BostonHousing)

mini_house <- BostonHousing %>%
  select(medv, rm, age, dis)

## normalization min-max scaling [0-1]
normalize_data <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

## apply this function to all columns in dataframe
mini_house_norm <- apply(mini_house, 2, normalize_data)

## kmeans clustering
km_result <- kmeans(mini_house, centers=5)

## assign cluster back to dataframe
mini_house$cluster <- km_result$cluster

## run decriptive statistics
mini_house %>%
  group_by(cluster) %>%
  summarise(avg_price = mean(medv),
            avg_rooms = mean(rm))

