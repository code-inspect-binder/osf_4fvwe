#' Return the means grouped on specific conditions
#' 
#' @param y_col name of the column with dependent variable (e.g., RTs)
#' @param cols a character vector with the names of the columns to group
#' @param df the tibble with the variables
#'
#' @return a tibble with the mean of the column y_col grouped on cols (the name
#'   of the column with the mean is "DV")

return_means <- 
  
  function(y_col, cols, df){
    
    df %>% 
      group_by(across(matches(cols))) %>% 
      # summarise(RT = mean({{y_col}})) %>% 
      summarise(DV = mean({{y_col}})) %>% 
      ungroup()
    
  }
