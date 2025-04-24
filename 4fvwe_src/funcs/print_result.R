#' Print a txt and csv file with the results
#' 
#' @param stats_to_print the tibble/table to print
#' @param name_file name of the file to write
#'
#' @return 2 files with the results (txt and csv)

print_result <- 
  
  function(stats_to_print, name_file){
    
    knitr::kable(
      stats_to_print,
      format = "rst")  %>%
      cat(
        file = here('results', str_c(name_file, '.txt', sep = "")),
        sep = "\n")
    
    stats_to_print %>% 
      write_csv(file = here('results', str_c(name_file, '.csv', sep = "")))
    
    }
