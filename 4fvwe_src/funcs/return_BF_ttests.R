#' Return Bayes factors
#' 
#' @description 
#' It returns a table with Bayes factors for the Bayesian equivalent of the 
#' t-test. It uses the package "BayesFactor".
#' 
#' @param data tibble with the variables
#' @param cond_to_group variables to group on
#' @param cond_to_compare variable with the condition to compare
#' @param def_cond character: the default condition used as baseline for the test
#' @param DV character: name of the dependent variable (default: 'RT')
#' @param ID character: name of the variable with the subjects ID (default: 'sj')
#' 
#' @return a tibble with the Bayes factors 

return_BF_ttest <- 
  
  function(data, cond_to_group, cond_to_compare, def_cond, DV = 'RT', ID = 'sj') {
    
    # Split the data frame into the groups defined by the combination between 
    # "cond_to_group" and "cond_to_compare". The number of rows of "df_tmp_1"
    # correspond to the number of groups.
    df_tmp_1 <- 
      data %>% 
      group_by({{cond_to_group}}, {{cond_to_compare}}) %>% 
      group_nest() %>% 
      mutate(
        # the column "data" is automatically created by "group_nest()"
        aggr_data = map(data,
                        ~ return_means({{DV}}, ID, .))
      )
    
    # "cond_to_group" is converted to character (needed below for full_join)
    col <- as_label(enquo(cond_to_group))
    
    # The row with "def_cond" is moved to a new column and duplicated (this is
    # done with reference to "cond_to_group")
    df_tmp_2 <- 
     full_join(
       df_tmp_1 %>% 
         filter({{cond_to_compare}} != def_cond),
       df_tmp_1 %>% 
         filter({{cond_to_compare}} == def_cond),
       by = col
       )
    
    # Compute the Bayes factors
    df_tmp_3 <- 
      df_tmp_2 %>% 
      mutate(
        # "DV" is the column with the means returned by "return_means()"
        BF_test = map2(aggr_data.y,
                       aggr_data.x,
                       ~ttestBF(x = .x$DV,
                                y = .y$DV,
                                paired = TRUE)),
        BF_value = map(BF_test,
                       ~extractBF(.) %>% 
                         tibble %>% 
                         select(bf, error))
      )
    
    # Un-nest the Bayes factor value and the error
    df_tmp_3 %>% 
      unnest(BF_value)
    
  }

