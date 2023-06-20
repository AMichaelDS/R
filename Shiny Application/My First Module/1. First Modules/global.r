library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(data.table)

data("mtcars")
mtcars$cyl <- as.factor(mtcars$cyl)

colChoices <- colnames(mtcars) 
xAxisChoices <- colnames(mtcars)
yAxisChoices <- colnames(mtcars)
cylinderChoices <- unique(mtcars$cyl)