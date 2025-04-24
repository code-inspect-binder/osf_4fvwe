#' Return the stats of the conditions

#' @param myTibble the tibble with the variables
#' @param condition_names a character vector with the columns to group
#' @param ID variable with the subjects ID (default: 'sj')
#' @param DV dependent variable to analyze (default: 'RT')
#'
#' @return a tibble with the stats across the grouped column (condition_names)

return_stats <-
  
  function(myTibble, condition_names, ID = 'sj', DV = 'RT') {
    
    # character vector with "condition columns" and ID (default is 'sj')
    column_names <- c(ID, condition_names)
    
    # number of decimal digits in round()
    nd <- 3
    
    myTibble %>% 
      group_by(across(matches(column_names))) %>% 
      summarise(
        mean_DV = mean(.data[[DV]])
      ) %>% 
      ungroup() %>% 
      group_by(across(matches(condition_names))) %>% 
      summarise(
        N_sj = n_distinct(sj),
        Mean = round(mean(mean_DV), digits = nd),
        SD = round(sd(mean_DV), digits = nd),
        # standard error: (standard_deviation)/(sqrt(N))
        SE = round(SD / sqrt(N_sj), digits = nd)
      ) %>% 
      ungroup() 
  }
