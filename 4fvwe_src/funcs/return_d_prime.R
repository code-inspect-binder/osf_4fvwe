#' Calculate d' (d prime) in all SOA conditions for the
#' prime visibility task
#' 
#' @param myTibble a tibble grouped by "sj" and "SOA"
#'
#' @return a tibble with d' values for all SOA conditions
#' and the intermediate parameters to calculate the d'

return_d_prime <-
  
  function(myTibble) {
    
    myTibble %>% 
      group_by(sj, SOA) %>% 
      summarise(
        
        # tot letter trials
        n_letter = sum(c(prime_type == 'letter')),
        
        # tot number trials
        n_number = sum(c(prime_type == 'number')),
        
        # hits (n true positive)
        hit = sum(c(prime_type == 'number' & acc == 1)),
        
        # false alarm (n false positive)
        false_al = sum(c(prime_type == 'letter' & acc == 0)),
        
        # hit rate
        hr = hit / n_number,
        
        # false alarm rate
        fr = false_al / n_letter,
        
        #  z-transform of hit rate
        # (quantile function: inverse cumulative function)
        z_hr = qnorm(hr, mean = 0, sd = 1),
        
        #  z-transform of false alarm rate
        # (quantile function: inverse cumulative function)
        z_fr = qnorm(fr, mean = 0, sd = 1),
        
        # calculate d prime
        d_prime = z_hr - z_fr
      ) %>% 
      ungroup()
}
