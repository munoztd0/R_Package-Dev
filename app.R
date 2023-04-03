# check if package manager is installed
if(!require(pacman)) {
  install.packages("pacman")
}
# loads the necessary packages
pacman::p_load(shiny, echarts4r, lubridate, dplyr)


ui <- fluidPage(
  echarts4rOutput("plot"),
  br(),
  echarts4rOutput("timeseries"),
  br(),
  echarts4rOutput("outliers")
)

server <- function(input, output, session){

  
  output$plot <- renderEcharts4r({
    mtcars |>
    e_charts(cyl) |> 
     e_boxplot(disp, colorBy="data",) |>
     e_boxplot(hp, colorBy="data",) |>
     e_boxplot(mpg, colorBy="data",) |>
     e_tooltip(trigger = "axis") |>
     e_title("Descriptive Stats on mtcars Data") |>
     e_toolbox_feature(feature = "saveAsImage")  # add the download button!
  })
  
  

  


    output$timeseries <- renderEcharts4r({
      
        #create dummy data for demonstration purposes
      
      lakers |>           
          mutate(date = lubridate::ymd(date)) |>
          mutate(points = points+runif(n=34624, min=-0.5, max=0.5) ) |>
          group_by(date) |>
          summarise(points2 = sum(points),
                min= points2 - (50 +min(points)),
                max=points2 + (50+max(points)) ) |> 
          e_charts(date) |>
          e_line(points2) |>
          e_band2(min, max, color = "lemonchiffon") |>
          e_tooltip(trigger = "axis") |>
          e_title("Lakers Timeseries Data") |>
          e_toolbox_feature(feature = "saveAsImage")  # add the download button!
  })
    
    
    
    
     output$outliers <- renderEcharts4r({
       
        starwars |>
          e_charts(mass) |>
          e_scatter(height, bind = name, symbol_size = 5, legend =F) |>
          e_datazoom() |>
          e_tooltip(
            formatter = htmlwidgets::JS("
              function(params){
                return('<strong>' + params.name + 
                        '</strong><br />mass: ' + params.value[0] + 
                        '<br />height: ' + params.value[1]) 
                        }
            ")) |> # little JS formatter to make it pretty
          e_title("Starwars Outlier Data") |>
          e_toolbox_feature(feature = "saveAsImage")  # add the download button!
  })

  
  
}

shinyApp(ui, server)