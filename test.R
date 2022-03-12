library(dash)
library(dashBootstrapComponents)
library(dashCoreComponents)
library(dashHtmlComponents)

app = Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(
  htmlH1(
    "Bee Colony Dashboard",
    style=list(
      'color' = 'black', 
      'background-color' = '#E9AB17'
      # "font-family": "Roboto",
      # "textAlign": "center",
      # "font-weight": "800",
      # "border": "2px solid #000000",
      # "border-radius": "5px",
    ),
  )
)

app$run_server(debug = T)