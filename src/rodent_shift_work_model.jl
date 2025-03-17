################################################################
# 
# rodent_shift_work_model.jl
#
# This script runs the simulations and generates (some) of
# the figures in "Mathematical modeling of sleep state dynamics 
# in a rodent model of shift work.” Neurobiology of sleep and 
# circadian rhythms vol. 5 37-51. 28 Apr. 2018
#
#
################################################################


# import packages
using MAT
using Distributions
using Statistics
using Plots
using Plots.PlotMeasures



# include functions
include("set_simulation_param_values.jl")
include("two_process_model_with_markov_chain.jl")
include("make_shaded_state_percentages_plot.jl")
#################################################################


# read in experimental data to compare with model output
exp_data_dict      = matread("./data/all_experimental_bout_and_percentages_data.mat")
exp_pvals_dict     = matread("./data/p_vals_experimental_data.mat")
opt_vals_dict  	   = matread("./data/optimized_values_baseline_and_work_1.5.mat")
colored_vals_dict  = matread("./data/experimental_data_for_colored_state_plots.mat")

opt_params_AW = opt_vals_dict["K_optimized_for_AW_during_work_1_5"] # parameters for active work (AW) case
opt_params_RW = opt_vals_dict["K_optimized_for_RW_during_work_1_5"] # parameters for rest work (RW) case]


# set parameter values for the simulations
input_paramsAW,input_paramsRW = set_simulation_param_values(opt_params_AW,opt_params_RW);


# run the model for both cases
S_AW,sleepstateAW,long_wake_timingsAW,sleep_averages_AW,sleep_std_AW = two_process_model_with_markov_chain(134,input_paramsAW,"AW",0);
S_RW,sleepstateRW,long_wake_timingsRW,sleep_averages_RW,sleep_std_RW = two_process_model_with_markov_chain(134,input_paramsRW,"RW",0);

# plot the output, comparing experimental data to model output
colored_state_data_AW = colored_vals_dict["Colored_state_per_exp_data_AW"]
colored_state_data_RW = colored_vals_dict["Colored_state_per_exp_data_RW"]

p1, p2, p3, p4 = make_shaded_state_percentages_plot(collect(0:10/60/60:134),sleepstateAW,sleepstateRW,colored_state_data_AW,colored_state_data_RW);
plot(p1, p3, p2, p4, layout = grid(4, 1, heights=[0.25 ,0.25, 0.25, 0.25]))
plot!(size=(650,800))
