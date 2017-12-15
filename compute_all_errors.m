function E=compute_all_errors(params,actual)
%[num_w_episode_error,SWS_duration_error]=compute_all_errors(params,actual)

% actual (experimental) values that I am comparing model output to
% actual{1} = [206.6667  112.2500  116.0000  125.1818  123.4286];  % experimental data for wake episodes_AW_averages try to read this in eventually. 
% actual{2} = [ 172.3173  267.5280  270.9395  229.6896  244.0745]; % experimental data for SWS_episode_duration_AW_averages   




% run the model with parameter values "params"
%[sim_w_episode_num,sim_SWS_duration] = run_model(params);
%input_params.taui = params(1);  % taui
%input_params.taud = params(2);  % taud 
% input_params.taui = params(1); %8.6;  % taui
% input_params.taud = params(2); %3.2;  % taud
% input_params.ahat_W_S_base = params(3); %0.003;
% input_params.ahat_S_W_base = params(4); %0.006;
% input_params.ahat_W_R_base = params(5); %0.007;
% input_params.ahat_R_W_base = params(6); %1.2374e-04;
% input_params.ahat_S_R_base = params(7); %0.007;
% input_params.ahat_R_S_base = params(8); %0.001;
% % input_params.ahat_W_S_base = 0.003;
% input_params.ahat_S_W_base = 0.006;
% input_params.ahat_W_R_base = 0.007;
% input_params.ahat_R_W_base = 1.2374e-04;
% input_params.ahat_S_R_base = 0.007;
% input_params.ahat_R_S_base = 0.001;


% input_params.taui = 13;
% input_params.taud = params(1);
% input_params.gamma = params(2);
% input_params.mu    = 0.01;
% input_params.c1    = 0.5;
% input_params.c2    = 0.1;
% input_params.WS_offset = params(3);
% input_params.SR_offset = 0.006;
% input_params.delta = 


% Find the indices where each parameter lives
% taud_idx  = find(ismember(K_optimized_12_13.names,'taud'));
% gamma_idx = find(ismember(K_optimized_12_13.names,'gamma'));
% mu_idx    = find(ismember(K_optimized_12_13.names,'mu'));
% delta_idx = find(ismember(K_optimized_12_13.names,'delta'));
% c1_idx    = find(ismember(K_optimized_12_13.names,'c1'));
% c2_idx    = find(ismember(K_optimized_12_13.names,'c2'));
% WS_offset_idx = find(ismember(K_optimized_12_13.names,'WS_offset'));
% SR_offset_idx = find(ismember(K_optimized_12_13.names,'SR_offset'));


input_params.taui = 13;
input_params.taud  = params(1);
input_params.gamma = params(2);
input_params.mu    = params(3);
input_params.delta = params(4);
input_params.c1    = params(5);
input_params.c2    = params(6);
input_params.WS_offset = params(7);
input_params.SR_offset = params(8);




% [~,sleepstate,num_wake_episodesAW,mean_SWS_lengthAW,REMS_episode_duration_AW_averages,...
% std_wake_episodes_vs_timeAW,std_SWS_episode_duration_vs_timeAW,REMS_episode_duration_AW_Std] = two_process_model_with_markov_chain(134,input_params,'AW',0);

[~,~,sleep_measure_averages,sleep_measure_stds] = two_process_model_with_markov_chain(134,input_params,'AW',0);

sim_wake_episode_num = sleep_measure_averages.num_w_episodes;
sim_SWS_episode_num  = sleep_measure_averages.num_sws_episodes;
sim_REMS_episode_num = sleep_measure_averages.num_REMS_episodes;

sim_wake_duration = sleep_measure_averages.wake_episode_duration;
sim_SWS_duration  = sleep_measure_averages.SWS_episode_duration;
sim_REMS_duration = sleep_measure_averages.REMS_episode_duration;

sim_wake_percentage = [sleep_measure_averages.time_in_w(1)/1440    sleep_measure_averages.time_in_w(2:end)./960];
sim_SWS_percentage  = [sleep_measure_averages.time_in_sws(1)/1440  sleep_measure_averages.time_in_sws(2:end)./960];
sim_REMS_percentage = [sleep_measure_averages.time_in_rems(1)/1440 sleep_measure_averages.time_in_rems(2:end)./960];


gross_num_W_episode_error    = sim_wake_episode_num - actual.num_wake_episodes;
gross_num_SWS_episode_error  = sim_SWS_episode_num - actual.num_sws_episodes;
gross_num_REMS_episode_error = sim_REMS_episode_num - actual.num_rems_episodes; 

gross_wake_duration_error = sim_wake_duration - actual.wake_episode_duration;
gross_SWS_duration_error  = sim_SWS_duration  - actual.sws_episode_duration;
gross_REMS_duration_error = sim_REMS_duration - actual.rems_episode_duration;

gross_wake_percentage_error = sim_wake_percentage - actual.percent_in_wake;
gross_SWS_percentage_error  = sim_SWS_percentage  - actual.percent_in_sws;
gross_REMS_percentage_error = sim_REMS_percentage - actual.percent_in_rems;


% % old way
% num_w_episode_error = norm(gross_W_episode_error,2)^2;
% SWS_duration_error  = norm(gross_SWS_duration_error,2)^2;

% % New way
% NRMSE_w_episode = 1 - (norm(gross_W_episode_error)/(norm(actual{1}-mean(actual{1}))));
% NRMSE_SWS_duration = 1 - (norm(gross_SWS_duration_error)/(norm(actual{2}-mean(actual{2}))));

% ---- NUMBER OF EPISODES --------------
% num of wake episodes error 
NRMSE_w_episode = sqrt(mean((gross_num_W_episode_error).^2));
NRMSE_w_episode = NRMSE_w_episode/(max(actual.num_wake_episodes)-min(actual.num_wake_episodes));

% num of SWS episodes error
NRMSE_sws_episode = sqrt(mean((gross_num_SWS_episode_error).^2));
NRMSE_sws_episode = NRMSE_sws_episode/(max(actual.num_sws_episodes)-min(actual.num_sws_episodes));

% num of REMS episodes error
NRMSE_rems_episode = sqrt(mean((gross_num_REMS_episode_error).^2));
NRMSE_rems_episode = NRMSE_rems_episode/(max(actual.num_rems_episodes)-min(actual.num_rems_episodes));

% --- EPISODE DURATION -------------
% wake episode duration error
NRMSE_wake_duration = sqrt(mean((gross_wake_duration_error).^2));
NRMSE_wake_duration = NRMSE_wake_duration/(max(actual.wake_episode_duration)-min(actual.wake_episode_duration));

% SWS episode duration error
NRMSE_SWS_duration = sqrt(mean((gross_SWS_duration_error).^2));
NRMSE_SWS_duration = NRMSE_SWS_duration/(max(actual.sws_episode_duration)-min(actual.sws_episode_duration));

% REMS episode duration error
NRMSE_REMS_duration = sqrt(mean((gross_REMS_duration_error).^2));
NRMSE_REMS_duration = NRMSE_REMS_duration/(max(actual.rems_episode_duration)-min(actual.rems_episode_duration));

% --- PERCENTAGE OF TIME SPENT IN EACH STATE -------------
% wake percentage error
NRMSE_wake_percentage = sqrt(mean((gross_wake_percentage_error).^2));
NRMSE_wake_percentage = NRMSE_wake_percentage/(max(actual.percent_in_wake)-min(actual.percent_in_wake));

% SWS percentage error
NRMSE_SWS_percentage = sqrt(mean((gross_SWS_percentage_error).^2));
NRMSE_SWS_percentage = NRMSE_SWS_percentage/(max(actual.percent_in_sws)-min(actual.percent_in_sws));

% REMS percentage error
NRMSE_REMS_percentage = sqrt(mean((gross_REMS_percentage_error).^2));
NRMSE_REMS_percentage = NRMSE_REMS_percentage/(max(actual.percent_in_rems)-min(actual.percent_in_rems));






%num_w_episode_error = NRMSE_w_episode;
%SWS_duration_error  = NRMSE_SWS_duration;
 
%% -- 9 element version ----
% for use with GODLIKE
 E = [NRMSE_w_episode       NRMSE_sws_episode    NRMSE_rems_episode ... 
 	  NRMSE_wake_duration   NRMSE_SWS_duration   NRMSE_REMS_duration ...
 	  NRMSE_wake_percentage NRMSE_SWS_percentage NRMSE_REMS_percentage];


%% -- only match number of wake episodes and sws episode duration --
%E = [NRMSE_w_episode NRMSE_SWS_duration];



% make the error a scalar so I can use single objective optimization
% for use with fminsearch
E = 0.1*E(1)+0.1*sum(E(2:end));
