library(shiny)
library(echarts4r)
library(lubridate)
library(dplyr)

ui <- fluidPage(
  echarts4rOutput("plot"),
  br(),
  echarts4rOutput("timeseries")
)

server <- function(input, output, session){

  
  output$plot <- renderEcharts4r({
    mtcars |>
    e_charts(cyl) |> 
     e_boxplot(disp, colorBy="data",) |>
     e_boxplot(hp, colorBy="data",) |>
     e_boxplot(mpg, colorBy="data",) |>
     e_tooltip(trigger = "axis") |>
     e_title("Descriptive Stats on mtcars Data") 
  })
  
 
    output$timeseries <- renderEcharts4r({
  
      lakers |> 
          mutate(date = lubridate::ymd(date)) |>
          mutate(points = points+runif(n=34624, min=-0.5, max=0.5) ) |>
          group_by(date) |>
          summarise(points2 = sum(points),
                    min= points2 - (50 +min(points)),
                    max=points2 + (50+max(points)) )|>
          e_charts(date) |>
          e_line(points2) |>
          e_band2(min, max, color = "lemonchiffon") |>
          e_y_axis(scale = TRUE) |>
          e_datazoom(start = 50) |>
     e_tooltip(trigger = "axis") |>
     e_title("Lakers Timeseries Data") 
  })

  
  
}

shinyApp(ui, server)