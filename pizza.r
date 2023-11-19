pizzafl <- c("Hawaiian", "Seafood", "Cheese Bacon", "Double Cheese", "Peperoni")
pizza_price <- c(200, 280, 360)
pizza_size <- c("Small", "Medium", "Large")

order_pizza <- function() {
  name <- readline("Enter your Name: ")
  print(paste("Hi!", name, ",", "Welcome to PIZZAZA"))
  print("Menu:")
  print(pizzafl)
  
  while (TRUE) {
    piz <- readline("Select your pizza: ")
    if (piz %in% pizzafl) {
      print(paste("You selected:", piz))
      while (TRUE) {
        print("Size:")
        print(pizza_size)
        size <- readline("Select size: ")
        if (size %in% pizza_size) {
          if (size == "Small") {
            print(paste("You selected:", size))
            print(paste("You ordered:", piz, ", size:", size, ", Price:", 200)) }
            
         else if (size == "Medium") {
            print(paste("You selected:", size))
            print(paste("You ordered:", piz, ", size:", size, ", Price:", 280)) }
          else if (size == "Large") {
            print(paste("You selected:", size))
            print(paste("You ordered:", piz, ", size:", size, ", Price:", 360)) }
          break
        } else {
          print("Sorry, your selection is incorrect.") }
      }
      break
    } else {
      print("Sorry, your selection is incorrect.") }
  }
}
order_pizza()
