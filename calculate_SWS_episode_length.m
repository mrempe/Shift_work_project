function [mean_SWS_length,mean_wake_length] = calculate_SWS_episode_length(sleep_state,dt)
% 
% USAGE:  mean_length = calculate_SWS_episode_length(sleep_state)
%
%
%
% input: sleep_state       a vector of 0's and 1's that denote
%                          sleep state
%
%        dt                time step size (this is needed to return
%                          mean episode lenghts in the appropriate
%                          time units


runs = contiguous(sleep_state,[0 1]);

wake_runs  = runs{1,2};
sleep_runs = runs{2,2};

for i=1:size(wake_runs,1)
    w_episode_length(i) = wake_runs(i,2)-wake_runs(i,1)+1;
end

for i=1:size(sleep_runs,1)
    s_episode_length(i) = sleep_runs(i,2)-sleep_runs(i,1)+1;
    
end

mean_SWS_length = mean(s_episode_length) * dt;
mean_wake_length = mean(w_episode_length) * dt;



