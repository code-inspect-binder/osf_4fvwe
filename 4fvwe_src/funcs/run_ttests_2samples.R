#' Compute 2-sample t-test, effect size, mean and SD for RTs.
#' 
#' @param y_col name of the column with dependent variable (e.g., RTs)
#' @param x_col name of the column with independent variable
#' @param x1 first group (in x_col column)
#' @param x2 second group (in x_col column)
#' @param df the tibble with the variables
#'
#' @return a list with the statistics for the t-test

run_ttests_2samples <-
  
  function(y_col, x_col, x1, x2, df) {
    
    # source(here('my_functions', 'return_effect_sizes.R'))
    
    var_1 <- 
      df %>% 
      filter({{x_col}} == x1) %>% 
      pull({{y_col}})
    
    var_2 <- 
      df %>% 
      filter({{x_col}} == x2) %>% 
      pull({{y_col}})
    
    q1 <- t.test(var_1,
                 var_2,
                 paired = TRUE,
                 alternative = "two.sided")
    
    Cohen_d_z <- return_Cohen_d_z(var_1, var_2)
    
    Hedges_g_av <- return_Hedges_g_av(var_1, var_2)
    
    diffs <- var_1 - var_2
    
    # standard error: (standard_deviation)/(sqrt(N))
    std.error <- sd(diffs) / sqrt(length(diffs))
    
    tibble(
      var1 = x1,
      var2 = x2,
      mean_var1 = mean(var_1),
      mean_var2 = mean(var_2),
      mean_diff = mean(diffs),
      std_error = std.error,
      t = unname(q1$statistic),
      df = unname(q1$parameter),
      p = q1$p.value,
      sig = q1$p.value < 0.05,
      Cohen_d_z = Cohen_d_z,
      Hedges_g_av = Hedges_g_av)
    
}
