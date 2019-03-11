# R Script for Made Shots
## This script is the code that will contain the required variables to be used in the visualization phasea
## The inputs in this script required are: five raw data csv files found in data
## The output is a CSV file of the shot data for each player, as well as a summary TXT file. These can be found in the data and output folders, respectively.

getwd()
setwd("workout01")


## Importing Data for each player
curry <- read.csv("data/stephen-curry.csv", stringsAsFactors = FALSE)
igoudala <- read.csv("data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("data/klay-thompson.csv", stringsAsFactors = FALSE)


## Adding a column name to each imported data frame
curry$name <- "Stephen Curry"
igoudala$name <- "Andre Iguodala"
green$name <- "Draymond Green"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"

## Changing original values of shot_made_flag
curry$shot_made_flag[curry$shot_made_flag == "n"] <-  "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y" ] <- "shot_yes"


igoudala$shot_made_flag[igoudala$shot_made_flag == "n" ] = "shot_no"
igoudala$shot_made_flag[igoudala$shot_made_flag == "y"] = "shot_yes"

green$shot_made_flag[green$shot_made_flag == "n"] = "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] = "shot_yes"

durant$shot_made_flag[durant$shot_made_flag == "n" ] = "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y" ] = "shot_yes"

thompson$shot_made_flag[thompson$shot_made_flag == "n" ] = "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y" ] <- "shot_yes"

## Adding a column called minute

curry$minute <- 12*curry$period - curry$minutes_remaining
thompson$minute <- 12*thompson$period - thompson$minutes_remaining
green$minute <- 12*green$period - green$minutes_remaining
igoudala$minute <- 12*igoudala$period - igoudala$minutes_remaining
durant$minute <- 12*durant$period - durant$minutes_remaining

## Setting summarys of individuals to ouput

sink(
 file = 'stephen-curry-summary.txt'
)
summary(curry)
sink()

sink(
  file = 'andre-igoudala-summary.txt'
)
summary(igoudala)
sink()

sink(
  file = 'draymond-green-summary.txt'
)
summary(green)
sink()

sink(
  file = 'kevin-durant-summary.txt'
)
summary(durant)
sink()

sink(
  file = 'klay-thompson-summary.txt'
)
summary(thompson)
sink()

## Creating a tibble object and exporting it
shots_data <- rbind(curry, durant, green, igoudala, thompson)
setwd("../data")
write.csv(
  x = shots_data, 
  file = "shots-data-summary.csv"
)

## Sinking a summary of the table
sink(
  file = '../output/shots-data-summary.txt'
)
summary(shots_data)
sink()
