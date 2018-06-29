% main optimization script using GODLIKE
%
%
% This script optimally chooses parameter values to minimize error between
% model output and experimental data.  Starting with number of wake episodes 
% and duration of SWS episodes. 


% ---------------------------------------------------------------------------
% Set up actual (experimental) values. These are what I am comparing simulation output to
% actual{1} = [];  % experimental Wake episode data
% actual{2} = [];  % experimental SWS duration data 
 % NEED to make sure multiobjective is reading in actual somehow. 
%load('FIG6_Experimental_Data.mat','wake_episodes_AW_averages','SWS_episode_duration_AW_averages');
load('all_experimental_data.mat');
clear actual 
actual.wake_episode_duration = wake_episode_duration_AW_averages ;   % this variable is in the FIG6_Experimental_Data.mat workspace
actual.sws_episode_duration  = SWS_episode_duration_AW_averages;
actual.rems_episode_duration = REMS_episode_duration_AW_averages;

actual.num_wake_episodes = num_wake_episodes_AW_averages;
actual.num_sws_episodes  = num_sws_episodes_AW_averages;
actual.num_rems_episodes = num_REMS_episodes_AW_averages;

actual.percent_in_wake = daily_percent_in_wake_AW_averages;
actual.percent_in_sws  = daily_percent_in_sws_AW_averages;
actual.percent_in_rems = daily_percent_in_REMS_AW_averages;

%actual{3} = REMS_episode_duration_AW_averages;

FitnessFunction = @(x)multiobjective(x,actual);
% lb = [2.8,0.5, 0.001,0.01,0.01,0.001,0.0005];   % lower bounds.  check these
% ub = [5,  5,   0.1,  1,   5,   0.5,  0.1, ];  

lb = [2.8,0.5,0.001];   % lower bounds.  check these
ub = [5,  5,  0.5]; 

%options = set_options('Display','on','NumObjectives',9);
options = set_options('Display','on','algorithms','PSO','MaxFunEvals',1000,'ItersLb',5);
% single objective
%[solution,func_value,exitflag,output]=GODLIKE(FitnessFunction,lb,ub,[],options);
% multiobjective
%[solution,func_value,Pareto_individuals,Pareto_fitnesses,exitflag,output]=GODLIKE(FitnessFunction,lb,ub,[],options);