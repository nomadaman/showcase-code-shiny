a <- grid::arrow(type = "closed", length = unit(.15, "inches")) #setting the griod for graph

###### Server ###############
server <- function(input, output, session) {
    ### Get Country Code
    geo <- reactive({
        if (input$geography == "Worldwide") {
            ""
        }
        
        else{
            
            #for now we havr got just two options in this Australia and Worldwide
            countrycode(input$geography, 'country.name', 'iso2c')
        }
        
    })
    
### Time
    start_date <- reactive({
        if (input$period == "Last five years") {
            "today+5-y"
        }
        else if (input$period == "Past 12 months") {
            "today 12-m"
        }
        else if (input$period == "Past 90 days") {
            "today 3-m"
        }
        else if (input$period == "Past 30 days") {
            "today 1-m"
        }
        else if (input$period == "Last seven days") {
            "now 7-d"
        }
        else if (input$period == "Last  day") {
            "now 1-d"
        }
    })
    
    
    out <- reactive({
        if (length(input$vec1) > 0) {
            unlist(strsplit(input$vec1, ","))
        }
    })
    
    #### Eg : gtrends(keyword = NA, geo = "", time = "today+5-y")
    mk <- reactive({
        if (length(input$vec1 != 0))
            req(input$vec1)
        {
            gtrends(keyword = out(),
                    time = start_date(),
                    geo = geo())
            }
    })
    
    #Plot the Trend
    output$gtrends_plot <- renderPlotly({
        plot(mk())
    })
    
    
    ### Graph for detailed analysis 
    output$plot1 <- renderPlot({
        words <- mk()
        word_related <- as_tibble(words$related_queries)
        word_related %>% filter(keyword == input$vec1)
        
        
        ####bigrsm for graph
        topqueries_bigram <- word_related %>% 
            filter(related_queries == 'top') %>% 
            unnest_tokens(bigram, value, token = 'ngrams', n = 3) %>% separate(bigram, c("word1", "word2"), sep = " ") %>% 
            filter(!word1 %in% stop_words$word, !word2 %in% stop_words$word) %>% 
            count(word1, word2, sort = TRUE) %>% 
            filter(!is.na(word1), !is.na(word2)) %>% 
            graph_from_data_frame() 
        
        ### Setting the seed, just random
        set.seed(0612)
        
        ggraph(topqueries_bigram, layout = "fr") +
            geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                           arrow = a, end_cap = circle(.1, 'inches')) +
            geom_node_point(color = 'blue', size = 3) +
            geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
            theme_void() +
            labs(title = "For Goole Trends: TOP QUERIES",
                 caption = "By: @AMAN MADAAN")
        
        
        
    }
    )
    
    
}