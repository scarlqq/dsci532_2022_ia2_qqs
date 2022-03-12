library(dash)
library(dashBootstrapComponents)
library(dashCoreComponents)
library(dashHtmlComponents)
library(ggplot2)
library(ggthemes)
library(plotly)
library(readr)
library(dplyr)
library(stringr)
library(lubridate)

url = 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-11/stressor.csv'
stressor <- read_csv(url)

stressor['start_month'] <- str_split_fixed(stressor$months, '-', 2)[,1]
stressor['year'] <- as.character(stressor$year)
stressor['start_month'] <- as.integer(factor(stressor$start_month, levels = month.name))
stressor["time"] <- paste0(stressor$year,"-",stressor$start_month,"-","01")
stressor <- stressor %>% select(-c(year, months, start_month))
stressor["period"] = paste0(year(stressor$time), "-", quarter(stressor$time)) 


start_date = (unique(stressor[['period']]))
end_date = (unique(stressor[['period']]))
state = (unique(stressor[['state']]))

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(
  dbcContainer(
    list(
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlH1(
                            "Bee Colony Dashboard"
                            # style=list(
                            #     "background-color": "#E9AB17",
                            #     "font-family": "Roboto",
                            #     "textAlign": "center",
                            #     "font-weight": "800",
                            #     "border": "2px solid #000000",
                            #     "border-radius": "5px",
                            # ),
                        ),
                        htmlH4(
                            "Select the period for map... (not in use for now)"
                            # style=list("font-family": "Roboto", "font-weight": "600"),
                        ),
                        dbcRow(
                            dccDropdown(
                                id='select_state_2',
                                value='Alabama',
                                options = state,
                                className = 'text-dark'
                                # style=list(
                                #     "height": "50px",
                                #     "vertical-align": "middle",
                                #     "font-family": "Roboto",
                                #     "font-size": "28px",
                                #     "textAlign": "center",
                                #     "border-radius": "10px",
                                # ),
                                # placeholder="Select a period"
                            )
                        ),
                        htmlBr(),
                        htmlH4(
                            "Select a state for trend and stressor..."
                            # style=list("font-family": "Roboto", "font-weight": "600"),
                        ),
                        dbcRow(
                            dccDropdown(
                                id='select_state',
                                value='Alabama',
                                options = state,
                                className = 'text-dark'
                                # style=list(
                                #     "height": "50px",
                                #     "vertical-align": "middle",
                                #     "font-family": "Roboto",
                                #     "font-size": "28px",
                                #     "textAlign": "center",
                                #     "border-radius": "10px",
                                # ),
                                # placeholder="Select a state"
                            )
                        ),
                        htmlBr(),
                        htmlH4(
                            "Select the period for trend and stressor..."
                            # style=list("font-family": "Roboto", "font-weight": "600"),
                        ),
                        dbcRow(
                            list(
                                dbcCol(
                                    dccDropdown(
                                        id='select_start_date',
                                        value='2015-1',
                                        options = start_date,
                                        className = 'text-dark', 
                                        # style=list(
                                        #     "height": "50px",
                                        #     "vertical-align": "middle",
                                        #     "font-family": "Roboto",
                                        #     "font-size": "28px",
                                        #     "textAlign": "center",
                                        #     "border-radius": "10px",
                                        # ),
                                        # placeholder="Select a year"
                                    )
                                ),
                                dbcCol(
                                    dccDropdown(
                                        id='select_end_date',
                                        value='2015-4',
                                        options = end_date,
                                        className = 'text-dark'
                                        # style=list(
                                        #     "height": "50px",
                                        #     "vertical-align": "middle",
                                        #     "font-family": "Roboto",
                                        #     "font-size": "28px",
                                        #     "textAlign": "center",
                                        #     "border-radius": "10px",
                                        # ),
                                        # placeholder="Select a time period"
                                    )
                                )
                              ),
                            className="g-0",
                        )
                    ),
                    md=6,
                    align="start",
                ),
                htmlBr(),
                dbcCol(
                    dbcCard(
                        list(
                            dbcCardHeader(
                                
                                    htmlH4(
                                        "Bee colony loss percentages by state (not in use for now)"
                                        # style=list(
                                        #     "font-family": "Roboto",
                                        #     "font-weight": "600",
                                        # ),
                                    ),
                                
                            ),
                            dbcCardBody(
                                htmlIframe(
                                    id="plot-area-3",
                                    # style=list("width": "100%", "height": "320px")
                                )
                            )
                        )
                        # style=list(
                        #     "width": "100%",
                        #     "height": "400px",
                        #     "background-color": "#FBE7A1",
                        #     "border": "2px solid #000000",
                        #     "border-radius": "5px",
                        # ),
                    )
                )
            )
        ),
        htmlBr(),
        dbcRow(
          list(
                dbcCol(
                    (
                        dbcCard(
                            list(
                                dbcCardHeader(
                                    htmlH4(
                                        "Number of bee colonies over time (not in use for now)"
                                        # style=list(
                                        #     "font-family": "Roboto",
                                        #     "font-weight": "600",
                                        # ),
                                    )
                                ),
                                dbcCardBody(
                                    htmlIframe(
                                        id="plot-area-2"
                                        # style=list("width": "100%", "height": "320px"),
                                    )
                                )
                            )
                            # style=list(
                            #     "width": "100%",
                            #     "height": "400px",
                            #     "background-color": "#FBE7A1",
                            #     "border": "2px solid #000000",
                            #     "border-radius": "5px",
                            # ),
                        )
                    ),
                    md=6,
                ),
                dbcCol(
                    list(
                        dbcCard(
                            list(
                                dbcCardHeader(
                                    
                                        htmlH4(
                                            "Bee colony stressors (in use!)"
                                            # style=list(
                                            #     "font-family": "Roboto",
                                            #     "font-weight": "600",
                                            # ),
                                        ),
                                    
                                ),
                                dbcCardBody(
                                    list(
                                        dccGraph(
                                            id="plot-area"
                                            # style=list("width": "100%", "height": "270px"),
                                        ),
                                        htmlH6(
                                            "Note that the percentage will add to more than 100 as a colony can be affected by multiple stressors in the same quarter."
                                            # style=list("font-family": "Roboto"),
                                        )
                                    )
                                )
                            )
                            # style=list(
                            #     "width": "100%",
                            #     "height": "400px",
                            #     "background-color": "#FBE7A1",
                            #     "border": "2px solid #000000",
                            #     "border-radius": "5px",
                            # ),
                        )
                    )
                )
            )
        )
    )
    # style={"background-color": "#FFF8DC"}
  )
)

app$callback(
  output('plot-area', 'figure'),
  list(input('select_state', 'value'),
       input('select_start_date', 'value'),
       input('select_end_date', 'value')),
  function(state, start_date, end_date) {
    p <- stressor %>%  filter(state == {{state}} & (period >= {{start_date}} & period <= {{end_date}})) %>%
      ggplot(aes(x = period,
                 y = stress_pct,
                 fill = stressor,
                 text = stress_pct)) +
      geom_bar(position="stack", stat="identity") + 
      labs(title = 'Bee colony stressors', x = 'Time period', y = 'Impacted colonies(%)')
  ggplotly(p)
  }
)

app$callback(
  output('plot-area-2', 'figure'),
  list(input('select_state', 'value'),
       input('select_start_date', 'value'),
       input('select_end_date', 'value')),
  function(state, start_date, end_date) {
    p <- stressor %>%  filter(state == {{state}} & (period >= {{start_date}} & period <= {{end_date}})) %>%
      ggplot(aes(x = period,
                 y = stress_pct,
                 fill = stressor,
                 text = stress_pct)) +
      geom_bar(position="stack", stat="identity") + 
      labs(title = 'Bee colony stressors', x = 'Time period', y = 'Impacted colonies(%)')
  ggplotly(p)
  }
)

app$callback(
  output('plot-area-3', 'figure'),
  list(input('select_state', 'value'),
       input('select_start_date', 'value'),
       input('select_end_date', 'value')),
  function(state, start_date, end_date) {
    p <- stressor %>%  filter(state == {{state}} & (period >= {{start_date}} & period <= {{end_date}})) %>%
      ggplot(aes(x = period,
                 y = stress_pct,
                 fill = stressor,
                 text = stress_pct)) +
      geom_bar(position="stack", stat="identity") + 
      labs(title = 'Bee colony stressors', x = 'Time period', y = 'Impacted colonies(%)')
  ggplotly(p)
  }
)
# app$run_server(debug = T)
app$run_server(host = '0.0.0.0')