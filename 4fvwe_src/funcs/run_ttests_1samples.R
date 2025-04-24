#' Compute 1-sample t-test, mean and SD for RTs.
#' 
#' @param y_col name of the column with dependent variable (e.g., RTs)
#' @param x_col name of the column with independent variable
#' @param x1 first group (in x_col column)
#' @param df the tibble with the variables
#' @param m true value of the mean (mu in t.test) (default is 0)
#'
#' @return a list with the statistics for the t-test

run_ttests_1samples <-
  
  function(y_col, x_col, x1, df, m = 0) {
    
    # source(here('my_functions', 'return_effect_sizes.R'))
    
    var_1 <- 
      df %>% 
      # filter({{x_col}} == x1) %>% 
      pull({{y_col}})
    
    q1 <- t.test(var_1,
                 alternative = "two.sided",
                 mu = m)
    
    # standard error: (standard_deviation)/(sqrt(N))
    std.error <- sd(var_1) / sqrt(length(var_1))
    
    tibble(
      var1 = x1,
      mean_var1 = mean(var_1),
      std_error = std.error,
      t = unname(q1$statistic),
      df = unname(q1$parameter),
      p = q1$p.value,
      sig = q1$p.value < 0.05)
    
  }
