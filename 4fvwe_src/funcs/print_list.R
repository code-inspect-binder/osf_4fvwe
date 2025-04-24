#' Print a txt and csv file with the results
#' 
#' @param ts it should a list with results, but it could work with other objects
#' @param name_file string with the name of the file to write
#'
#' @return a file txt with the results

print_list <- 
  
  function(ts, name_file){
    file = here('results', str_c(name_file, '.txt', sep = ''))
    
    sink(file) # start writing to a file
    
    print(ts)
    
    sink() # stop writing to the file
  
  }
