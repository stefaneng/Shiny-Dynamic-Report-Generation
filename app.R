library(shiny)

ui <- fluidPage(

  # Application title
  titlePanel("Dynamic Report Generation using R markdown and Shiny"),

  p("Downloading dynamically generated reports is easy with rmarkdown::render"),
  p("See the blog post describing this application here: https://stefanengineering.com/2019/08/31/dynamic-r-markdown-reports-with-shiny"),
  p("Using the envir parameter makes it simple to pass only the variables we want to the document."),
  p("This application creates a simple report with each of the data sets selected"),
  selectInput('datasets', label = 'Select data sets to include in the report', multiple = TRUE, choices = list("mtcars", "iris", "AirPassengers", "CO2")),
  p("The report is generated using the pander package, which has nice table printing functionality such as spliting large tables."),
  downloadButton('download', label = 'Download the report')
)

server <- function(input, output) {
  output$download <- downloadHandler(
    filename = "listing.pdf",
    content = function(f) {

      e <- new.env()
      # For each of the data sets selected, get the variable based on the string
      e$datasets <- lapply(input$datasets, get)
      rmarkdown::render('template.Rmd', output_format = rmarkdown::pdf_document(),
                        output_file=f,
                        envir = e)
    }
  )
}

shinyApp(ui = ui, server = server)
