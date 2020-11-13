library(shiny)
library(tidyverse)
library(plotly)

args <- commandArgs(trailingOnly=T);

port <- as.numeric(args[[1]]);



library(Rtsne)
pt <- read_csv("derived_data/pokemon_tidy.csv")

py <- pt %>% group_by(type1) %>% select(.,attack, defense, sp_attack, sp_defense, speed, hp,name)

fitt <- Rtsne(py %>% select(.,attack, defense, sp_attack, sp_defense, speed, hp),dims =2, check_duplicates = FALSE);

fig <- plot_ly(fitt$Y %>% as.data.frame() %>% as_tibble() %>% mutate(label=py$type1) %>% mutate(name= py$name), x = ~V1 , y = ~V2, color = ~label, text=~name, hoverinfo = 'text', type = 'scatter', mode = 'markers')


ui <- basicPage(
  titlePanel("Pokemon TSNE"),
  mainPanel(
    plotlyOutput("graph")
    
            ))

server <- function(input, output) {
  
  output$graph <- renderPlotly({plot_ly(fitt$Y %>% as.data.frame() %>% as_tibble() %>% mutate(label=py$type1) %>% mutate(name= py$name), x = ~V1 , y = ~V2, color = ~label, text=~name, hoverinfo = 'text', type = 'scatter', mode = 'markers')
  
})}


print(sprintf("Starting shiny on port %d", port));
shinyApp(ui = ui, server = server, options = list(port=port, host="0.0.0.0"))

