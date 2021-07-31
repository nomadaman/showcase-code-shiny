#Loading the libraries
library("shiny")
library("plotly")
library("shinymaterial")
library("wordcloud2")
library("dplyr")
library("tidyr")
library("tidytext")
library("igraph")
library("ggraph")


######## UI ##############
#                        #
#                        #
# Developer: Aman Madaan #
#                        #
#                        #
##########################

ui <- material_page(title = "Find Trends using GoogleTrends",
                    tags$br(),
                    material_side_nav(
                        fixed = FALSE,
                        shiny::tags$h3("Selections"),
                        
                        
                        material_text_box(
                            input_id = "vec1",
                            label = "Search the Keywords like - flu, covid",
                            color = "#ef5350"
                        ),
                        
                        
                        material_dropdown(
                            input_id = "geography",
                            label = "Country",
                            choices = list(
                                "Worldwide", "Australia"),
                            selected = "Australia"
                        ),
                        
                        material_dropdown(
                            input_id = "period",
                            label = "Time Period",
                            choices = c(
                                "Last day",
                                "Last seven days",
                                "Past 30 days",
                                "Past 90 days",
                                "Past 12 months",
                                "Last five years"
                            ),
                            selected = "Last five years"
                        ),
                        material_button(
                            input_id = "Submit",
                            label = "Search",
                            color = "black"
                        )
                        
                        
                    ),
                    
                    
                    material_tabs(
                        tabs = c(
                            "How-To-Use the APP?" = "usecase",
                            "Trend" = "example_tab_1",
                            "Graph (Text-Mining)" = "example_tab_2"
                            
                        )
                        
                    ),
                    
                    #content for how to use tab?
                    material_tab_content(
                        tab_id = "usecase",
                       
                        material_card(
                            depth = 5,
                            size="small",
                            title="How to use the App/Dashboard?",
                            
                            br(),
                            "Instructions -:",
                            br(),
                            br(),
                            shiny::HTML(
                                        "<ul><li>We have got three tabs in this dashboard.</li>
                                        <li>To start with your search please proceed to top left toggle button near to the title.</li>
                                        <li>Enter the Selections/Inputs.</li>
                                        <li>After the selections, Please click on search button.</li>
                                        <li>Depending on the search we can click on Trends tab or the other one</li></ul>"),
                            br(),
                            
                            "Trend tab:",
                            "Trend Analysis graph",
                            
                            br(),
                            "Graph Text-Mining Tab:",
                            "Graph covers the flow or connection of the keyword to some other keywords",
                            br(),
                            br(),
                            HTML('<p>View the <a href="https://github.com/nomadaman/showcase-code-shiny">code</a></p>'),
                            br(),
                            br()
                        )
                    ),
                    
                    #tab content for trend tab
                    material_tab_content( 
                        tab_id="example_tab_1",
                        
                        material_column(
                            width = 9,
                            material_card(
                                title = "Google Trends",
                                size="medium",
                                depth = 4,
                                plotlyOutput("gtrends_plot")
                            )
                        ))
                    ,
                    
                    #tab content for Graph tab
                    material_tab_content(
                                        tab_id="example_tab_2",
                                             material_card(
                                             depth = 4, 
                                             size="small",
                                             title = "GRAPH",
                                             plotOutput("plot1")
                                         )
                    )
                    
)
