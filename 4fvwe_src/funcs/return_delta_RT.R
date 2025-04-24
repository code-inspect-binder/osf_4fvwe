#' Return delta RTs
#' 
#' @description
#' Return the delta reaction time of the experimental conditions minus neutral
#' condition. Before subtracting, the values of the dependent variable ("y_col";
#' e.g., RT) are grouped across level in the variables in "cols_to_group" and 
#' in "cols_to_subtract" and the mean is calculated.
#' Example:
#' cols_to_group <- c('sj', 'SOA', 'problem_size')
#' cols_to_subtract <- c('prime_type', 'prime_decade_consistency')
#' neutral_cond <- 'neutral'
#' 
#' @param df the tibble with the variables
#' @param y_col name of the column with dependent variable (e.g., RT)
#' @param cols_to_group a character vector with the names of the columns to group
#' @param cols_to_subtract character vector with the names of the column that 
#'   with the conditions to subtract
#' @param neutral_cond the name (character) of the neutral condition to subtract
#' 
#' @return a tibble with the delta RTs for each level of the variable in 
#'   "cols_to_group" and the non-neutral conditions in "cols_to_subtract"

return_delta_RT <-
  
  function(df, y_col, cols_to_group, cols_to_subtract, neutral_cond) {
    
    cols_names <- c(cols_to_group, cols_to_subtract)
    
    df %>% 
      group_by(across(matches(cols_names))) %>% 
      # summarise(RT = mean(RT)) %>%
      summarise(DV = mean({{y_col}})) %>%
      ungroup() %>% 
      pivot_wider(id_cols = all_of(cols_to_group),
                  names_from = all_of(cols_to_subtract),
                  values_from = DV) %>%
      relocate(matches(neutral_cond), .after = last_col()) %>% 
      mutate(
        across(
          where(is.numeric),
          ~ . - pull(across(matches(neutral_cond)))
        )
      ) %>% 
      select(!matches(neutral_cond)) %>% 
      pivot_longer(-all_of(cols_to_group),
                   names_to = 'cond',
                   values_to = 'dRT')
  }
