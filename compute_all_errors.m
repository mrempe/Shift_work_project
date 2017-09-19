function [num_w_episode_error,SWS_duration_error]=compute_all_errors(params)


% actual (experimental) values that I am comparing model output to
actual{1} = [206.6667  112.2500  116.0000  125.1818  123.4286];  % experimental data for wake episodes_AW_averages try to read this in eventually. 
actual{2} = [ 172.3173  267.5280  270.9395  229.6896  244.0745]; % experimental data for SWS_episode_duration_AW_averages   




% run the model with parameter values "param"
%[sim_w_episode_num,sim_SWS_duration] = run_model(params);
input_params.taui = params(1);
input_params.taud = params(2);
[S,sleepstate,num_wake_episodesAW,mean_SWS_lengthAW,REMS_episode_duration_AW_averages,...
 std_wake_episodes_vs_timeAW,std_SWS_episode_duration_vs_timeAW,REMS_episode_duration_AW_Std] = two_process_model_with_markov_chain(134,input_params,'AW',1);

sim_w_episode_num = num_wake_episodesAW;
sim_SWS_duration  = mean_SWS_lengthAW;


gross_W_episode_error    = sim_w_episode_num - actual{1};
gross_SWS_duration_error = sim_SWS_duration  - actual{2};

num_w_episode_error = norm(gross_W_episode_error,2)^2;
SWS_duration_error  = norm(gross_SWS_duration_error,2)^2;


