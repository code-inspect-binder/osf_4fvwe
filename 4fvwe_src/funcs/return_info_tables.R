#' Return a set of tables with demographics (gender, age) and performance
#' (percentage of omitted responses, errors, and responses faster than 200 ms)
#' 
#' @param df data frame from which extract the results
#'
#' @return a list with the tables

return_info <- 
  
  function(df){
    
    list(
      # gender
      gender = 
        df %>%
        distinct(gender, sj) %>% 
        tabyl(gender) %>% 
        mutate(percent = percent * 100) %>% 
        make_table('Gender'),
      
      # age
      age =
        df %>%
        distinct(age, sj) %>% 
        summarise(
          mean = mean(age),
          sd = sd(age),
          min = min(age),
          max = max(age)) %>% 
        make_table('Age'),
      
      # percentage incorrect response
      error =
        df %>%
        summarise(
          N_error = sum(acc == 0),
          N_trial = length(acc)) %>% 
        mutate(percent_error = N_error / N_trial * 100) %>% 
        make_table('Percentege incorrect response'),
      
      # percentage omitted responses
      omitted =
        df %>% 
        summarise(
          N_omitted = sum(is.na(RT)),
          N_trial = length(acc)
        ) %>% 
        mutate(percent_omitted = N_omitted / N_trial * 100) %>%
        make_table('Percentege omitted responses'),
      
      # percentage of trials where timing = 'wrong'
      # (that is when the onset/offset was wrong in matlab)
      timing =
        df %>% 
        summarise(
          N_wrong_timing = sum(timing == 'wrong'),
          N_trial = length(timing)
        ) %>% 
        mutate(percent_wrong_timing = N_wrong_timing / N_trial * 100) %>% 
        make_table('Percentege wrong timing (wrong stimuli onset/offset)'),
      
      # percentage RT < 200 ms
      less_200 =
        df %>% 
        summarise(
          N_less_200 = sum(RT <= 200, na.rm = T),
          N_trial = length(RT)
        ) %>% 
        mutate(percent_less_200 = N_less_200 / N_trial * 100) %>% 
        make_table('Percentege RT < 200 ms')
    )
  }