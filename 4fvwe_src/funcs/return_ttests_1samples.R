#' Return a table with 1-sample t-test
#' 
#' @param y_col name of the column with dependent variable (e.g., RTs)
#' @param x_col name of the column with independent variable
#' @param cond_to_test list with the condition to analyze in the t-test
#' @param cond_to_group character vector with the variables to group on to calculate the mean
#' @param df the tibble with the variables
#'
#' @return a tibble with the results and statistics for the t-test

return_ttest_1samples <- 
  
  function(y_col, x_col, cond_to_test, cond_to_group, df) {
    
    map2(
      list(df),
      cond_to_test,
      ~ filter(.x, {{x_col}} %in% .y)
    ) %>% 
      map(
        ~ return_means({{y_col}}, cond_to_group, .)
      ) %>% 
      map2_df(
        cond_to_test,
        # "DV" is the column with the means returned by "return_means()"
        ~ run_ttests_1samples(DV, {{x_col}}, .y, .x)
      ) %>% 
      mutate(p_adj = p.adjust(p, method = 'holm'),
             Sig_adj = p.adjust(p, method = 'holm') < 0.05)
    
  }
