#' See Lakens, D. (2013). Frontiers in Psychology, 4:863
#' doi: 10.3389/fpsyg.2013.00863


#' Calculate Cohen's d ## one-sample with mu = 0
return_Cohen_d <- function(variable_1){
  
  mean_var1 <- mean(variable_1)
  sd_var1 <- sd(variable_1)
  
  Cohen_d <- mean_var1 / sd_var1
  
  return(Cohen_d)
}


#' Calculate Cohen's d_z
return_Cohen_d_z <- function(variable_1, variable_2){
  
  mean_differences <- mean(variable_1) - mean(variable_2)
  sd_var1 <- sd(variable_1)
  sd_var2 <- sd(variable_2)
  cor_var1_var2 <- cor(variable_1, variable_2)
  
  Cohen_d_z <-
    abs(mean_differences) /
    sqrt(
      (sd_var1 ^ 2) + (sd_var2 ^ 2) -
        (2 * sd_var1 * sd_var2 * cor_var1_var2)
    )
  
  return(Cohen_d_z)
}


#' Calculate Cohen's d_av
return_Cohen_d_av <- function(variable_1, variable_2){
  
  mean_differences <- mean(variable_1) - mean(variable_2)
  sd_var1 <- sd(variable_1)
  sd_var2 <- sd(variable_2)
  
  Cohen_d_av <-
    abs(mean_differences) /
    sqrt(
      (sd_var1 ^ 2 + sd_var2 ^ 2) / 2
    )
  
  return(Cohen_d_av)
}


#' Calculate Hedges' g_av
return_Hedges_g_av <- function(variable_1, variable_2){
  
  Cohen_d_av <- return_Cohen_d_av(variable_1, variable_2)
  n_pairs <- variable_1 %>% length()
  
  Hedges_g_av <-
    Cohen_d_av *
    (1 - (3 / (4 * (n_pairs * 2) - 9)))

  return(Hedges_g_av)
}
