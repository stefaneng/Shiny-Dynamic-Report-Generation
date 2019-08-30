library(shiny)

ui <- fluidPage(
  downloadButton('download')
)

server <- function(input, output) {
  output$download <- downloadHandler(
    filename = "listing.pdf",
    content = function(f) {
      
      e <- new.env()
      e$datasets <- list(mtcars, iris)
      rmarkdown::render('template.Rmd', output_format = rmarkdown::pdf_document(),
                        output_file=f,
                        envir = e)
    }
  )
}

shinyApp(ui = ui, server = server)
