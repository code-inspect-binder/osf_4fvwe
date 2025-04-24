#' Return a table with 2-sample t-test
#' 
#' @param y_col name of the column with dependent variable (e.g., RTs)
#' @param x_col name of the column with independent variable
#' @param cond_to_compare list with the pairs of condition to compare in the t-test
#' @param cond_to_group character vector with the variables to group on to calculate the mean
#' @param df the tibble with the variables
#'
#' @return a tibble with the results and statistics for the t-test

return_ttest_2samples <- 
  
  function(y_col, x_col, cond_to_compare, cond_to_group, df) {
    
    map2(
      list(df),
      cond_to_compare,
      ~ filter(.x, prime_cond %in% .y)
    ) %>% 
      map(
        ~ return_means({{y_col}}, cond_to_group, .)
      ) %>% 
      map2_df(
        cond_to_compare,
        # "DV" is the column with the means returned by "return_means()"
        ~ run_ttests_2samples(DV, {{x_col}}, .y[[1]], .y[[2]], .x)
      )
    
}
