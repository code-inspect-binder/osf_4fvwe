#' Return the data frame to use with the functions for the raincloud plots
#' 
#' @description 
#' It returns a tibble that can be used to plot each condition against the 
#' corresponding neutral condition. It generates the data frame that is used
#' with the raincloud plots functions.
#' 
#' @param df tibble with the variables
#' @param cond_to_group variables to group on
#' @param cond_to_compare variable with the condition to compare
#' @param def_cond character: the default condition used as baseline
#' 
#' @return a tibble with the for raincloud plots

return_df_plot <- 
  
  function(df, cond_to_group, cond_to_compare, def_cond) {
    
    df_tmp_1 <- 
      df %>% 
      mutate(
        neutral = case_when(
          {{cond_to_compare}} == def_cond ~ 'neutral',
          TRUE ~ 'other_cond'
        )
      ) %>% 
      group_by({{cond_to_group}}, {{cond_to_compare}}) %>% 
      group_nest()
    
    # "cond_to_group" is converted to character (needed below for full_join)
    col_group <- as_label(enquo(cond_to_group))
    
    # "cond_to_compare" is converted to character (needed below for rename)
    col_comp <- as_label(enquo(cond_to_compare))
    
    # The row with "def_cond" is moved to a new column and duplicated (this is
    # done with reference to "cond_to_group")
    df_tmp_2 <- 
      full_join(
        df_tmp_1 %>% 
          filter({{cond_to_compare}} != def_cond),
        df_tmp_1 %>% 
          filter({{cond_to_compare}} == def_cond),
        by = col_group
      )
    
    df_tmp_2 %>% 
      mutate(
        df_joined = map2(data.y,
                         data.x,
                         ~full_join(.x, .y))
      ) %>% 
      unnest(df_joined) %>% 
      rename(cond = (starts_with(col_comp) & ends_with('.x')))
    
  }
