# Making a Shot Chart Script
## This script is how I will create the charts for this project
## Inputs: data from the shots data script, which can be found in the data folder
## Outputs: 

library(tidyverse)
klay_scatterplot <- ggplot(data = thompson) + geom_point(aes(x = x, y = y, color = shot_made_flag))
klay_scatterplot

## Importing Images
install.packages("jpeg")
install.packages("grid")

library(jpeg)
library(grid)

## Example Klay Shot Chart
getwd()
court_file <- "images/nba-court.jpg"
court_image <- rasterGrob( readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

klay_shot_chart <- ggplot(data = thompson) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
klay_shot_chart

## Making Shot Charts of Each Player

klay_shot_chart <- ggplot(data = thompson) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) 
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
klay_shot_chart

kevin_shot_chart <- ggplot(data = durant) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal()
kevin_shot_chart

draymond_shot_chart <- ggplot(data = green) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal()
draymond_shot_chart

stephen_shot_chart <- ggplot(data = curry) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()
stephen_shot_chart

andre_shot_chart <- ggplot(data = igoudala) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Igoudala (2016 season)') + theme_minimal()
andre_shot_chart


## Exporting Shot Charts for Each Player
getwd()

pdf(file = "../images/andre-igoudala-shot-chart.pdf", width = 6.5, height = 5)
andre_shot_chart
dev.off()

pdf(file = "../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
stephen_shot_chart
dev.off()

pdf(file = "../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
draymond_shot_chart
dev.off()

pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
klay_shot_chart
dev.off()

pdf(file = "../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
kevin_shot_chart
dev.off

## Facetted Shot Chart
shots_data$name <-  as.factor(shots_data$name)

install.packages("png")
library("png")

total_shot_chart <- ggplot(data = shots_data)  +  annotation_custom(court_image)  + geom_point(aes(x = x, y = y, color = shot_made_flag))  + ylim(-50, 420)+ ggtitle('Shot Chart: GSW by Player') + facet_wrap(~name)  

total_shot_chart
## Exporting GSW Shot Chart

getwd()
pdf(
  file = "images/gsw-shot-charts.pdf", width = 8, height = 7
)
total_shot_chart
dev.off()

png(
  filename = "images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 100 
)
total_shot_chart
dev.off()



