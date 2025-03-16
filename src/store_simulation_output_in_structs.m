function [num, mean, daily_percent, std] = store_simulation_output_in_structs(sleep_averages,sleep_std)
%
%
% ----averages ------------------------------
% --- number of episodes --------------------- 
num.wake_episodesAWsim = sleep_averages.AW.num_w_episodes;
num.sws_episodesAWsim  = sleep_averages.AW.num_sws_episodes;
num.rems_episodesAWsim = sleep_averages.AW.num_REMS_episodes;

num.wake_episodesRWsim = sleep_averages.RW.num_w_episodes;
num.sws_episodesRWsim  = sleep_averages.RW.num_sws_episodes;
num.rems_episodesRWsim = sleep_averages.RW.num_REMS_episodes;

% episode duration
mean.wake_lengthAWsim = sleep_averages.AW.wake_episode_duration;
mean.sws_lengthAWsim  = sleep_averages.AW.SWS_episode_duration;
mean.rems_lengthAWsim = sleep_averages.AW.REMS_episode_duration;

mean.wake_lengthRWsim = sleep_averages.RW.wake_episode_duration;
mean.sws_lengthRWsim  = sleep_averages.RW.SWS_episode_duration;
mean.rems_lengthRWsim = sleep_averages.RW.REMS_episode_duration;

% daily percentages
daily_percent.in_wake_AWsim = sleep_averages.AW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
daily_percent.in_sws_AWsim  = sleep_averages.AW.time_in_sws./[1440 960 960 960 960]; % 960 minutes in 16 hours.  For W1, W2, W3, W4
daily_percent.in_rems_AWsim = sleep_averages.AW.time_in_rems./[1440 960 960 960 960];% all averages are done over 16 hours (between shifts), not 24

daily_percent.in_wake_RWsim = sleep_averages.RW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
daily_percent.in_sws_RWsim  = sleep_averages.RW.time_in_sws./[1440 960 960 960 960];
daily_percent.in_rems_RWsim = sleep_averages.RW.time_in_rems./[1440 960 960 960 960];



%--- std ----------------------------
% number of episodes
std.wake_episodes_vs_timeAWsim = sleep_std.AW.num_w_episodes;
std.sws_episodes_vs_timeAWsim  = sleep_std.AW.num_sws_episodes;
std.rems_episodes_vs_timeAWsim = sleep_std.AW.num_REMS_episodes;

std.wake_episodes_vs_timeRWsim = sleep_std.RW.num_w_episodes;
std.sws_episodes_vs_timeRWsim  = sleep_std.RW.num_sws_episodes;
std.rems_episodes_vs_timeRWsim = sleep_std.RW.num_REMS_episodes;


% episode duration 
std.wake_episode_duration_vs_timeAWsim = sleep_std.AW.wake_episode_duration;
std.sws_episode_duration_vs_timeAWsim  = sleep_std.AW.SWS_episode_duration;
std.rems_episode_duration_vs_timeAWsim = sleep_std.AW.REMS_episode_duration;

std.wake_episode_duration_vs_timeRWsim = sleep_std.RW.wake_episode_duration;
std.sws_episode_duration_vs_timeRWsim  = sleep_std.RW.SWS_episode_duration;
std.rems_episode_duration_vs_timeRWsim = sleep_std.RW.REMS_episode_duration;


% daily percentages
std.daily_percent_in_wake_AWsim = sleep_std.AW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
std.daily_percent_in_sws_AWsim  = sleep_std.AW.time_in_sws./[1440 960 960 960 960];
std.daily_percent_in_rems_AWsim = sleep_std.AW.time_in_rems./[1440 960 960 960 960];

std.daily_percent_in_wake_RWsim = sleep_std.RW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
std.daily_percent_in_sws_RWsim  = sleep_std.RW.time_in_sws./[1440 960 960 960 960];
std.daily_percent_in_rems_RWsim = sleep_std.RW.time_in_rems./[1440 960 960 960 960];

