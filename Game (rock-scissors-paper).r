##paoyingchub

win <- 0
loss <- 0
draw <- 0
data <- c("rock", "scissors", "paper")
Bot <- sample(data, 1)

play_game <- function() {
  print(data)
  player <- readline("Answer here: ")
  Bot <- sample(data, 1)
    if (player == "rock" && Bot == "scissors") {
      print("Player Win!")
      win <- win + 1
      } else if (player == "rock" && Bot == "paper") {
        print("Bot Win!")
        loss <- loss + 1
      
      } else if (player == "scissors" && Bot == "rock") {
        print("Bot Win!")
        loss <- loss + 1
      } else if (player == "scissors" && Bot == "paper") {
        print("Player Win!")
        win <- win + 1
        
      } else if (player == "paper" && Bot == "scissors") {
        print("Bot Win!")
        loss <- loss + 1
      } else if (player == "paper" && Bot == "rock") {
        print("Player Win!")
        win <- win + 1
    } else 
      print("Draw !")
      draw <- draw+1

   print(paste("Win",win,",", "Loss",loss,",", "Draw",draw))
}

play_game()




