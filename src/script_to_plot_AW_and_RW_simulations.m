% 
% This is the main script to run the simulations that made up the publication
% "Mathematical modeling of sleep state dynamics in a rodent model of shift work.” 
% Neurobiology of sleep and circadian rhythms vol. 5 37-51. 28 Apr. 2018
% 
% The script makes all the figures from the publication. 
%
% To run: make sure that the following .mat files containing the experimental data are in 
% the same directory where you saved this .m file: all_experimental_data.mat, 
% p_vals_experimental_data.mat, and optimized_values_baseline_and_work_1.5.mat




% ---- Load experimental data to constrain the model (and plot) ----
%load 'all_experimental_data.mat'
load 'all_experimental_bout_and_percentages_data.mat'
load 'p_vals_experimental_data.mat'
load 'optimized_values_baseline_and_work_1.5.mat' 
load 'experimental_data_for_colored_state_plots.mat'  
% ------------------------------------------------------------------

% ---- Set flags ---------------------------------------------------
compute_transitions = 0;  % flag to call code to make a table of state transitions
only_make_plots     = 0;
% ------------------------------------------------------------------



% ---- Set parameter values ----------------------------------------
[input_paramsAW,input_paramsRW] = set_simulation_param_values(K_optimized_for_AW_during_work_1_5,K_optimized_for_RW_during_work_1_5);
% ---- End of setting parameters ---------------------------------------------------------------------


% ---- Run the markov chain model -----------------------------------------------------------------------------------------------------
[S_AW,sleepstateAW,long_wake_timingsAW,sleep_averages.AW,sleep_std.AW] = two_process_model_with_markov_chain(134,input_paramsAW,'AW',1);
[S_RW,sleepstateRW,long_wake_timingsRW,sleep_averages.RW,sleep_std.RW] = two_process_model_with_markov_chain(134,input_paramsRW,'RW',1);
% -------------------------------------------------------------------------------------------------------------------------------------


% ---- Generate transition tables, if desired -------------------------------
if compute_transitions
	latexAW = generate_transition_tables(sleep_averages.AW,sleep_stdAW,'AW');
	latexRW = generate_transition_tables(sleep_averages.RW,sleep_stdRW,'RW');
end
% ---------------------------------------------------------------------------



% ---- Store simulation output in structs -------------------------------------------------------
[num, means, daily_percent, stds] = add_simulation_output_to_structs(num, daily_percent,sleep_averages,sleep_std); 
% -----------------------------------------------------------------------------------------------

% -----------------------------------------------------------------------------------------------
% -----------------------------------------------------------------------------------------------
%    Plotting
% ----------------------------------------------------------------------------------------------- 
% some parameters for all the panels: linewidth, font sizes, etc. 
plotparams.markersize           = 12;
plotparams.legend_fontsize      = 14;
plotparams.axFontSize           = 14;
plotparams.axlinewidth          = 2;
plotparams.linewidth            = 1.5;
plotparams.title_fontsize       = 16;
plotparams.panel_label_fontsize = 22;




% ------- number of wake episodes, SWS episodes, REMS episodes -------------
make_bout_num_figure(plotparams,num,stds,p_vals)
% --------------------------------------------------------------------------


% --- figure showing average episode duration for each sleep state
make_bout_duration_figure(plotparams,means,stds,episode_duration,p_vals)
% --------------------------------------------------------------------------


% ----------------------------------------------------------------
% --- Figure showing average daily percentage of time spent in each sleep state
make_percentages_figure(plotparams,daily_percent,stds)
% ----------------------------------------------------------------


% ----------------------------------------------------------------------------------------------------------------
% ----------  Figure showing state percentages with colors -------------------------------------------------------
% ----------------------------------------------------------------------------------------------------------------
make_shaded_state_percentages_plot_AW_RW_with_exp_data(0:10/60/60:134,sleepstateAW,sleepstateRW,Colored_state_per_exp_data_AW,Colored_state_per_exp_data_RW);
% -----------------------------------------------------------------------------------------------------------------
% ----------------------------------------------------------------------------------------------------------------



% ---------------------------------------------------------------------------------------------------------------
% ----------- Figure showing homeostat and sleepiness and alertness (output from model) -------------------------
% ---------------------------------------------------------------------------------------------------------------
make_homeostat_and_sleepiness_figures(S_AW,S_RW,0:10/60/60:134,long_wake_timingsAW,long_wake_timingsRW)
% ---------------------------------------------------------------------------------------------------------------




