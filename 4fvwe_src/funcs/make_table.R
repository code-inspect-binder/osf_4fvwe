#' Set the formatting for the tables in the html file
#' for R Markdown
#' 
#' @param df the tibble with the statistics
#' @param cpt the caption to use in the table
#' @param d number of digits
#'
#' @return a formatted table

make_table <-
  
  function(df, cpt, d = 2) {
    
    df %>%
      kbl(caption = cpt, digits = d) %>%
      kable_classic(full_width = FALSE, html_font = 'Cambria') %>% 
      kable_styling(bootstrap_options = c('striped', 'hover', 'condensed'))
 
  }
