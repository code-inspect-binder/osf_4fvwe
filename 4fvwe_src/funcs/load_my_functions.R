
func_list <- 
  list(
    'make_table.R',
    'print_list.R',
    'print_result.R',
    'return_BF_ttests.R',
    'return_d_prime.R',
    'return_delta_RT.R',
    'return_df_plot.R',
    'return_effect_sizes.R',
    'return_info_tables.R',
    'return_means.R',
    'return_stats.R',
    'return_ttests_1samples.R',
    'return_ttests_2samples.R',
    'run_ttests_1samples.R',
    'run_ttests_2samples.R')

walk(
  func_list,
  ~ source(here('funcs', .))
)

# Load the functions for the raincloud plots
source('funcs/R_rainclouds.R')
