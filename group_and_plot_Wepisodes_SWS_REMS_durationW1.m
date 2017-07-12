function [avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time,...
	      std_wake_episodes_vs_time,std_SWS_episode_duration_vs_time,std_REMS_episode_duration_vs_time] = group_and_plot_Wepisodes_SWS_REMS_durationW1(shift,state,num_simulations)
% USAGE: [avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time] = group_and_plot_Wepisodes_SWS_REMS_duration(shift,state,num_simulations)


if strcmp(shift,'AW')
	W1_hour1_indices  = 16561:16921; %46-47
	W1_hour2_indices  = 16921:17281; %47-48
	W1_hour3_indices  = 17281:17641; %48-49
	W1_hour4_indices  = 17641:18001; %49-50
	W1_hour5_indices  = 18001:18361; %50-51
	W1_hour6_indices  = 18361:18721; %51-52
	W1_hour7_indices  = 18721:19081; %52-53
	W1_hour8_indices  = 19081:19441; %53-54
	W1_hour9_indices  = 19441:19801; %54-55
	W1_hour10_indices = 19801:20161; %55-56
	W1_hour11_indices = 20161:20521; %56-57
	W1_hour12_indices = 20521:20881; %57-58
	W1_hour13_indices = 20881:21241; %58-59
	W1_hour14_indices = 21241:21601; %59-60
	W1_hour15_indices = 21601:21961; %60-61
	W1_hour16_indices = 21961:22321; %61-62
elseif strcmp(shift,'RW')
	W1_hour1_indices = 12241:12601;  %35-36
	W1_hour2_indices = 12601:12961;
	W1_hour3_indices = 12961:13321;
	W1_hour4_indices = 13321:13681;
	W1_hour5_indices = 13681:14041;
	W1_hour6_indices = 14041:14401;
	W1_hour7_indices = 14401:14761;
	W1_hour8_indices = 14761:15121;
	W1_hour9_indices = 15121:15481;
	W1_hour10_indices = 15481:15841;
	W1_hour11_indices = 15841:16201;
	W1_hour12_indices = 16201:16561;
	W1_hour13_indices = 16561:16921;
	W1_hour14_indices = 16921:17281;
	W1_hour15_indices = 17281:17641;
	W1_hour16_indices = 17641:18001;

else
	error('Shift must either be ''AW'' or ''RW'' ')
end 




for j=1:num_simulations
	W1_hour1_runs  = contiguous(state(W1_hour1_indices,j),['W' 'S' 'R']);
	W1_hour2_runs  = contiguous(state(W1_hour2_indices,j),['W' 'S' 'R']);
	W1_hour3_runs  = contiguous(state(W1_hour3_indices,j),['W' 'S' 'R']);
	W1_hour4_runs  = contiguous(state(W1_hour4_indices,j),['W' 'S' 'R']);
	W1_hour5_runs  = contiguous(state(W1_hour5_indices,j),['W' 'S' 'R']);
	W1_hour6_runs  = contiguous(state(W1_hour6_indices,j),['W' 'S' 'R']);
	W1_hour7_runs  = contiguous(state(W1_hour7_indices,j),['W' 'S' 'R']);
	W1_hour8_runs  = contiguous(state(W1_hour8_indices,j),['W' 'S' 'R']);
	W1_hour9_runs  = contiguous(state(W1_hour9_indices,j),['W' 'S' 'R']);
	W1_hour10_runs = contiguous(state(W1_hour10_indices,j),['W' 'S' 'R']);
	W1_hour11_runs = contiguous(state(W1_hour11_indices,j),['W' 'S' 'R']);
	W1_hour12_runs = contiguous(state(W1_hour12_indices,j),['W' 'S' 'R']);
	W1_hour13_runs = contiguous(state(W1_hour13_indices,j),['W' 'S' 'R']);
	W1_hour14_runs = contiguous(state(W1_hour14_indices,j),['W' 'S' 'R']);
	W1_hour15_runs = contiguous(state(W1_hour15_indices,j),['W' 'S' 'R']);
	W1_hour16_runs = contiguous(state(W1_hour16_indices,j),['W' 'S' 'R']);


	W1_hour1_wake_runs{j}   = W1_hour1_runs{1,2};
	W1_hour1_sleep_runs{j}  = W1_hour1_runs{2,2};
	W1_hour1_REM_runs{j}    = W1_hour1_runs{3,2};
	W1_hour2_wake_runs{j}   = W1_hour2_runs{1,2};
	W1_hour2_sleep_runs{j}  = W1_hour2_runs{2,2};
	W1_hour2_REM_runs{j}    = W1_hour2_runs{3,2};
	W1_hour3_wake_runs{j}   = W1_hour3_runs{1,2};
	W1_hour3_sleep_runs{j}  = W1_hour3_runs{2,2};
	W1_hour3_REM_runs{j}    = W1_hour3_runs{3,2};
	W1_hour4_wake_runs{j}   = W1_hour4_runs{1,2};
	W1_hour4_sleep_runs{j}  = W1_hour4_runs{2,2};
	W1_hour4_REM_runs{j}    = W1_hour4_runs{3,2};
	W1_hour5_wake_runs{j}   = W1_hour5_runs{1,2};
	W1_hour5_sleep_runs{j}  = W1_hour5_runs{2,2};
	W1_hour5_REM_runs{j}    = W1_hour5_runs{3,2};
	W1_hour6_wake_runs{j}   = W1_hour6_runs{1,2};
	W1_hour6_sleep_runs{j}  = W1_hour6_runs{2,2};
	W1_hour6_REM_runs{j}    = W1_hour6_runs{3,2};
	W1_hour7_REM_runs{j}    = W1_hour7_runs{3,2};
	W1_hour7_wake_runs{j}   = W1_hour7_runs{1,2};
	W1_hour7_sleep_runs{j}  = W1_hour7_runs{2,2};
	W1_hour8_REM_runs{j}    = W1_hour8_runs{3,2};
	W1_hour8_wake_runs{j}   = W1_hour8_runs{1,2};
	W1_hour8_sleep_runs{j}  = W1_hour8_runs{2,2};
	W1_hour9_REM_runs{j}    = W1_hour9_runs{3,2};
	W1_hour9_wake_runs{j}   = W1_hour9_runs{1,2};
	W1_hour9_sleep_runs{j}  = W1_hour9_runs{2,2};
	W1_hour10_REM_runs{j}    = W1_hour10_runs{3,2};
	W1_hour10_wake_runs{j}   = W1_hour10_runs{1,2};
	W1_hour10_sleep_runs{j}  = W1_hour10_runs{2,2};
	W1_hour11_REM_runs{j}    = W1_hour11_runs{3,2};
	W1_hour11_wake_runs{j}   = W1_hour11_runs{1,2};
	W1_hour11_sleep_runs{j}  = W1_hour11_runs{2,2};
	W1_hour12_REM_runs{j}    = W1_hour12_runs{3,2};
	W1_hour12_wake_runs{j}   = W1_hour12_runs{1,2};
	W1_hour12_sleep_runs{j}  = W1_hour12_runs{2,2};
	W1_hour13_REM_runs{j}    = W1_hour13_runs{3,2};
	W1_hour13_wake_runs{j}   = W1_hour13_runs{1,2};
	W1_hour13_sleep_runs{j}  = W1_hour13_runs{2,2};
	W1_hour14_REM_runs{j}    = W1_hour14_runs{3,2};
	W1_hour14_wake_runs{j}   = W1_hour14_runs{1,2};
	W1_hour14_sleep_runs{j}  = W1_hour14_runs{2,2};
	W1_hour15_REM_runs{j}    = W1_hour15_runs{3,2};
	W1_hour15_wake_runs{j}   = W1_hour15_runs{1,2};
	W1_hour15_sleep_runs{j}  = W1_hour15_runs{2,2};
	W1_hour16_REM_runs{j}    = W1_hour16_runs{3,2};
	W1_hour16_wake_runs{j}   = W1_hour16_runs{1,2};
	W1_hour16_sleep_runs{j}  = W1_hour16_runs{2,2};
	

	% Number of wake episodes
	W1_hour1_num_wake_episodes(j)  = size(W1_hour1_wake_runs{j},1);
	W1_hour2_num_wake_episodes(j)  = size(W1_hour2_wake_runs{j},1);
	W1_hour3_num_wake_episodes(j)  = size(W1_hour3_wake_runs{j},1);
	W1_hour4_num_wake_episodes(j)  = size(W1_hour4_wake_runs{j},1);
	W1_hour5_num_wake_episodes(j)  = size(W1_hour5_wake_runs{j},1);
	W1_hour6_num_wake_episodes(j)  = size(W1_hour6_wake_runs{j},1);
	W1_hour7_num_wake_episodes(j)  = size(W1_hour7_wake_runs{j},1);
	W1_hour8_num_wake_episodes(j)  = size(W1_hour8_wake_runs{j},1);
	W1_hour9_num_wake_episodes(j)  = size(W1_hour9_wake_runs{j},1);
	W1_hour10_num_wake_episodes(j)  = size(W1_hour10_wake_runs{j},1);
	W1_hour11_num_wake_episodes(j)  = size(W1_hour11_wake_runs{j},1);
	W1_hour12_num_wake_episodes(j)  = size(W1_hour12_wake_runs{j},1);
	W1_hour13_num_wake_episodes(j)  = size(W1_hour13_wake_runs{j},1);
	W1_hour14_num_wake_episodes(j)  = size(W1_hour14_wake_runs{j},1);
	W1_hour15_num_wake_episodes(j)  = size(W1_hour15_wake_runs{j},1);
	W1_hour16_num_wake_episodes(j)  = size(W1_hour16_wake_runs{j},1);

	
% hour1
	for i=1:size(W1_hour1_wake_runs{j},1)
    	W1_hour1_w_episode_length{j}(i) = W1_hour1_wake_runs{j}(i,2)-W1_hour1_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour1_sleep_runs{j},1)
    	W1_hour1_s_episode_length{j}(i) = W1_hour1_sleep_runs{j}(i,2)-W1_hour1_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour1_REM_runs{j},1)
		W1_hour1_r_episode_length{j}(i) = W1_hour1_REM_runs{j}(i,2)-W1_hour1_REM_runs{j}(i,1)+1;
	end
	W1_hour1_mean_SWS_length(j)  = mean(W1_hour1_s_episode_length{j}) * 10;
	W1_hour1_mean_wake_length(j) = mean(W1_hour1_w_episode_length{j}) * 10;
	W1_hour1_mean_REM_length(j)  = mean(W1_hour1_r_episode_length{j}) * 10;


% hour2
	for i=1:size(W1_hour2_wake_runs{j},1)
    	W1_hour2_w_episode_length{j}(i) = W1_hour2_wake_runs{j}(i,2)-W1_hour2_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour2_sleep_runs{j},1)
    	W1_hour2_s_episode_length{j}(i) = W1_hour2_sleep_runs{j}(i,2)-W1_hour2_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour2_REM_runs{j},1)
		W1_hour2_r_episode_length{j}(i) = W1_hour2_REM_runs{j}(i,2)-W1_hour2_REM_runs{j}(i,1)+1;
	end
	W1_hour2_mean_SWS_length(j)  = mean(W1_hour2_s_episode_length{j}) * 10;
	W1_hour2_mean_wake_length(j) = mean(W1_hour2_w_episode_length{j}) * 10;
	W1_hour2_mean_REM_length(j)  = mean(W1_hour2_r_episode_length{j}) * 10;

	
% hour3
	for i=1:size(W1_hour3_wake_runs{j},1)
    	W1_hour3_w_episode_length{j}(i) = W1_hour3_wake_runs{j}(i,2)-W1_hour3_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour3_sleep_runs{j},1)
    	W1_hour3_s_episode_length{j}(i) = W1_hour3_sleep_runs{j}(i,2)-W1_hour3_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour3_REM_runs{j},1)
		W1_hour3_r_episode_length{j}(i) = W1_hour3_REM_runs{j}(i,2)-W1_hour3_REM_runs{j}(i,1)+1;
	end
	W1_hour3_mean_SWS_length(j)  = mean(W1_hour3_s_episode_length{j}) * 10;
	W1_hour3_mean_wake_length(j) = mean(W1_hour3_w_episode_length{j}) * 10;
	W1_hour3_mean_REM_length(j)  = mean(W1_hour3_r_episode_length{j}) * 10;


% hour4
	for i=1:size(W1_hour4_wake_runs{j},1)
    	W1_hour4_w_episode_length{j}(i) = W1_hour4_wake_runs{j}(i,2)-W1_hour4_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour4_sleep_runs{j},1)
    	W1_hour4_s_episode_length{j}(i) = W1_hour4_sleep_runs{j}(i,2)-W1_hour4_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour4_REM_runs{j},1)
		W1_hour4_r_episode_length{j}(i) = W1_hour4_REM_runs{j}(i,2)-W1_hour4_REM_runs{j}(i,1)+1;
	end
	W1_hour4_mean_SWS_length(j)  = mean(W1_hour4_s_episode_length{j}) * 10;
	W1_hour4_mean_wake_length(j) = mean(W1_hour4_w_episode_length{j}) * 10;
	W1_hour4_mean_REM_length(j)  = mean(W1_hour4_r_episode_length{j}) * 10;


% hour5
	for i=1:size(W1_hour5_wake_runs{j},1)
    	W1_hour5_w_episode_length{j}(i) = W1_hour5_wake_runs{j}(i,2)-W1_hour5_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour5_sleep_runs{j},1)
    	W1_hour5_s_episode_length{j}(i) = W1_hour5_sleep_runs{j}(i,2)-W1_hour5_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour5_REM_runs{j},1)
		W1_hour5_r_episode_length{j}(i) = W1_hour5_REM_runs{j}(i,2)-W1_hour5_REM_runs{j}(i,1)+1;
	end
	W1_hour5_mean_SWS_length(j)  = mean(W1_hour5_s_episode_length{j}) * 10;
	W1_hour5_mean_wake_length(j) = mean(W1_hour5_w_episode_length{j}) * 10;
	W1_hour5_mean_REM_length(j)  = mean(W1_hour5_r_episode_length{j}) * 10;


% hour6
	for i=1:size(W1_hour6_wake_runs{j},1)
    	W1_hour6_w_episode_length{j}(i) = W1_hour6_wake_runs{j}(i,2)-W1_hour6_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour6_sleep_runs{j},1)
    	W1_hour6_s_episode_length{j}(i) = W1_hour6_sleep_runs{j}(i,2)-W1_hour6_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour6_REM_runs{j},1)
		W1_hour6_r_episode_length{j}(i) = W1_hour6_REM_runs{j}(i,2)-W1_hour6_REM_runs{j}(i,1)+1;
	end
	W1_hour6_mean_SWS_length(j)  = mean(W1_hour6_s_episode_length{j}) * 10;
	W1_hour6_mean_wake_length(j) = mean(W1_hour6_w_episode_length{j}) * 10;
	W1_hour6_mean_REM_length(j)  = mean(W1_hour6_r_episode_length{j}) * 10;

	
% hour7
	for i=1:size(W1_hour7_wake_runs{j},1)
    	W1_hour7_w_episode_length{j}(i) = W1_hour7_wake_runs{j}(i,2)-W1_hour7_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour7_sleep_runs{j},1)
    	W1_hour7_s_episode_length{j}(i) = W1_hour7_sleep_runs{j}(i,2)-W1_hour7_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour7_REM_runs{j},1)
		W1_hour7_r_episode_length{j}(i) = W1_hour7_REM_runs{j}(i,2)-W1_hour7_REM_runs{j}(i,1)+1;
	end
	W1_hour7_mean_SWS_length(j)  = mean(W1_hour7_s_episode_length{j}) * 10;
	W1_hour7_mean_wake_length(j) = mean(W1_hour7_w_episode_length{j}) * 10;
	W1_hour7_mean_REM_length(j)  = mean(W1_hour7_r_episode_length{j}) * 10;


% hour8
	for i=1:size(W1_hour8_wake_runs{j},1)
    	W1_hour8_w_episode_length{j}(i) = W1_hour8_wake_runs{j}(i,2)-W1_hour8_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour8_sleep_runs{j},1)
    	W1_hour8_s_episode_length{j}(i) = W1_hour8_sleep_runs{j}(i,2)-W1_hour8_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour8_REM_runs{j},1)
		W1_hour8_r_episode_length{j}(i) = W1_hour8_REM_runs{j}(i,2)-W1_hour8_REM_runs{j}(i,1)+1;
	end
	W1_hour8_mean_SWS_length(j)  = mean(W1_hour8_s_episode_length{j}) * 10;
	W1_hour8_mean_wake_length(j) = mean(W1_hour8_w_episode_length{j}) * 10;
	W1_hour8_mean_REM_length(j)  = mean(W1_hour8_r_episode_length{j}) * 10;

% hour9
	for i=1:size(W1_hour9_wake_runs{j},1)
    	W1_hour9_w_episode_length{j}(i) = W1_hour9_wake_runs{j}(i,2)-W1_hour9_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour9_sleep_runs{j},1)
    	W1_hour9_s_episode_length{j}(i) = W1_hour9_sleep_runs{j}(i,2)-W1_hour9_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour9_REM_runs{j},1)
		W1_hour9_r_episode_length{j}(i) = W1_hour9_REM_runs{j}(i,2)-W1_hour9_REM_runs{j}(i,1)+1;
	end
	W1_hour9_mean_SWS_length(j)  = mean(W1_hour9_s_episode_length{j}) * 10;
	W1_hour9_mean_wake_length(j) = mean(W1_hour9_w_episode_length{j}) * 10;
	W1_hour9_mean_REM_length(j)  = mean(W1_hour9_r_episode_length{j}) * 10;


% hour10
	for i=1:size(W1_hour10_wake_runs{j},1)
    	W1_hour10_w_episode_length{j}(i) = W1_hour10_wake_runs{j}(i,2)-W1_hour10_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour10_sleep_runs{j},1)
    	W1_hour10_s_episode_length{j}(i) = W1_hour10_sleep_runs{j}(i,2)-W1_hour10_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour10_REM_runs{j},1)
		W1_hour10_r_episode_length{j}(i) = W1_hour10_REM_runs{j}(i,2)-W1_hour10_REM_runs{j}(i,1)+1;
	end
	W1_hour10_mean_SWS_length(j)  = mean(W1_hour10_s_episode_length{j}) * 10;
	W1_hour10_mean_wake_length(j) = mean(W1_hour10_w_episode_length{j}) * 10;
	W1_hour10_mean_REM_length(j)  = mean(W1_hour10_r_episode_length{j}) * 10;

	
% hour11
	for i=1:size(W1_hour11_wake_runs{j},1)
    	W1_hour11_w_episode_length{j}(i) = W1_hour11_wake_runs{j}(i,2)-W1_hour11_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour11_sleep_runs{j},1)
    	W1_hour11_s_episode_length{j}(i) = W1_hour11_sleep_runs{j}(i,2)-W1_hour11_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour11_REM_runs{j},1)
		W1_hour11_r_episode_length{j}(i) = W1_hour11_REM_runs{j}(i,2)-W1_hour11_REM_runs{j}(i,1)+1;
	end
	W1_hour11_mean_SWS_length(j)  = mean(W1_hour11_s_episode_length{j}) * 10;
	W1_hour11_mean_wake_length(j) = mean(W1_hour11_w_episode_length{j}) * 10;
	W1_hour11_mean_REM_length(j)  = mean(W1_hour11_r_episode_length{j}) * 10;


% hour12
	for i=1:size(W1_hour12_wake_runs{j},1)
    	W1_hour12_w_episode_length{j}(i) = W1_hour12_wake_runs{j}(i,2)-W1_hour12_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour12_sleep_runs{j},1)
    	W1_hour12_s_episode_length{j}(i) = W1_hour12_sleep_runs{j}(i,2)-W1_hour12_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour12_REM_runs{j},1)
		W1_hour12_r_episode_length{j}(i) = W1_hour12_REM_runs{j}(i,2)-W1_hour12_REM_runs{j}(i,1)+1;
	end
	W1_hour12_mean_SWS_length(j)  = mean(W1_hour12_s_episode_length{j}) * 10;
	W1_hour12_mean_wake_length(j) = mean(W1_hour12_w_episode_length{j}) * 10;
	W1_hour12_mean_REM_length(j)  = mean(W1_hour12_r_episode_length{j}) * 10;


% hour13
	for i=1:size(W1_hour13_wake_runs{j},1)
    	W1_hour13_w_episode_length{j}(i) = W1_hour13_wake_runs{j}(i,2)-W1_hour13_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour13_sleep_runs{j},1)
    	W1_hour13_s_episode_length{j}(i) = W1_hour13_sleep_runs{j}(i,2)-W1_hour13_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour13_REM_runs{j},1)
		W1_hour13_r_episode_length{j}(i) = W1_hour13_REM_runs{j}(i,2)-W1_hour13_REM_runs{j}(i,1)+1;
	end
	W1_hour13_mean_SWS_length(j)  = mean(W1_hour13_s_episode_length{j}) * 10;
	W1_hour13_mean_wake_length(j) = mean(W1_hour13_w_episode_length{j}) * 10;
	W1_hour13_mean_REM_length(j)  = mean(W1_hour13_r_episode_length{j}) * 10;


% hour14
	for i=1:size(W1_hour14_wake_runs{j},1)
    	W1_hour14_w_episode_length{j}(i) = W1_hour14_wake_runs{j}(i,2)-W1_hour14_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour14_sleep_runs{j},1)
    	W1_hour14_s_episode_length{j}(i) = W1_hour14_sleep_runs{j}(i,2)-W1_hour14_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour14_REM_runs{j},1)
		W1_hour14_r_episode_length{j}(i) = W1_hour14_REM_runs{j}(i,2)-W1_hour14_REM_runs{j}(i,1)+1;
	end
	W1_hour14_mean_SWS_length(j)  = mean(W1_hour14_s_episode_length{j}) * 10;
	W1_hour14_mean_wake_length(j) = mean(W1_hour14_w_episode_length{j}) * 10;
	W1_hour14_mean_REM_length(j)  = mean(W1_hour14_r_episode_length{j}) * 10;

	
% hour15
	for i=1:size(W1_hour15_wake_runs{j},1)
    	W1_hour15_w_episode_length{j}(i) = W1_hour15_wake_runs{j}(i,2)-W1_hour15_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour15_sleep_runs{j},1)
    	W1_hour15_s_episode_length{j}(i) = W1_hour15_sleep_runs{j}(i,2)-W1_hour15_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour15_REM_runs{j},1)
		W1_hour15_r_episode_length{j}(i) = W1_hour15_REM_runs{j}(i,2)-W1_hour15_REM_runs{j}(i,1)+1;
	end
	W1_hour15_mean_SWS_length(j)  = mean(W1_hour15_s_episode_length{j}) * 10;
	W1_hour15_mean_wake_length(j) = mean(W1_hour15_w_episode_length{j}) * 10;
	W1_hour15_mean_REM_length(j)  = mean(W1_hour15_r_episode_length{j}) * 10;


% hour16
	for i=1:size(W1_hour16_wake_runs{j},1)
    	W1_hour16_w_episode_length{j}(i) = W1_hour16_wake_runs{j}(i,2)-W1_hour16_wake_runs{j}(i,1)+1;
	end

	for i=1:size(W1_hour16_sleep_runs{j},1)
    	W1_hour16_s_episode_length{j}(i) = W1_hour16_sleep_runs{j}(i,2)-W1_hour16_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_hour16_REM_runs{j},1)
		W1_hour16_r_episode_length{j}(i) = W1_hour16_REM_runs{j}(i,2)-W1_hour16_REM_runs{j}(i,1)+1;
	end
	W1_hour16_mean_SWS_length(j)  = mean(W1_hour16_s_episode_length{j}) * 10;
	W1_hour16_mean_wake_length(j) = mean(W1_hour16_w_episode_length{j}) * 10;
	W1_hour16_mean_REM_length(j)  = mean(W1_hour16_r_episode_length{j}) * 10;

end  % end of looping over num_simulations


% average over the simulations
W1_hour1_global_av_wake_length = mean(W1_hour1_mean_wake_length);
W1_hour1_global_av_SWS_length  = mean(W1_hour1_mean_SWS_length);
W1_hour1_global_av_REM_length  = mean(W1_hour1_mean_REM_length);
W1_hour1_global_av_wake_episodes = mean(W1_hour1_num_wake_episodes);

W1_hour2_global_av_wake_length = mean(W1_hour2_mean_wake_length);
W1_hour2_global_av_SWS_length  = mean(W1_hour2_mean_SWS_length);
W1_hour2_global_av_REM_length  = mean(W1_hour2_mean_REM_length);
W1_hour2_global_av_wake_episodes = mean(W1_hour2_num_wake_episodes);

W1_hour3_global_av_wake_length = mean(W1_hour3_mean_wake_length);
W1_hour3_global_av_SWS_length  = mean(W1_hour3_mean_SWS_length);
W1_hour3_global_av_REM_length  = mean(W1_hour3_mean_REM_length);
W1_hour3_global_av_wake_episodes = mean(W1_hour3_num_wake_episodes);

W1_hour4_global_av_wake_length = mean(W1_hour4_mean_wake_length);
W1_hour4_global_av_SWS_length  = mean(W1_hour4_mean_SWS_length);
W1_hour4_global_av_REM_length  = mean(W1_hour4_mean_REM_length);
W1_hour4_global_av_wake_episodes = mean(W1_hour4_num_wake_episodes);

W1_hour5_global_av_wake_length = mean(W1_hour5_mean_wake_length);
W1_hour5_global_av_SWS_length  = mean(W1_hour5_mean_SWS_length);
W1_hour5_global_av_REM_length  = mean(W1_hour5_mean_REM_length);
W1_hour5_global_av_wake_episodes = mean(W1_hour5_num_wake_episodes);

W1_hour6_global_av_wake_length = mean(W1_hour6_mean_wake_length);
W1_hour6_global_av_SWS_length  = mean(W1_hour6_mean_SWS_length);
W1_hour6_global_av_REM_length  = mean(W1_hour6_mean_REM_length);
W1_hour6_global_av_wake_episodes = mean(W1_hour6_num_wake_episodes);

W1_hour7_global_av_wake_length = mean(W1_hour7_mean_wake_length);
W1_hour7_global_av_SWS_length  = mean(W1_hour7_mean_SWS_length);
W1_hour7_global_av_REM_length  = mean(W1_hour7_mean_REM_length);
W1_hour7_global_av_wake_episodes = mean(W1_hour7_num_wake_episodes);

W1_hour8_global_av_wake_length = mean(W1_hour8_mean_wake_length);
W1_hour8_global_av_SWS_length  = mean(W1_hour8_mean_SWS_length);
W1_hour8_global_av_REM_length  = mean(W1_hour8_mean_REM_length);
W1_hour8_global_av_wake_episodes = mean(W1_hour8_num_wake_episodes);

W1_hour9_global_av_wake_length = mean(W1_hour9_mean_wake_length);
W1_hour9_global_av_SWS_length  = mean(W1_hour9_mean_SWS_length);
W1_hour9_global_av_REM_length  = mean(W1_hour9_mean_REM_length);
W1_hour9_global_av_wake_episodes = mean(W1_hour9_num_wake_episodes);

W1_hour10_global_av_wake_length = mean(W1_hour10_mean_wake_length);
W1_hour10_global_av_SWS_length  = mean(W1_hour10_mean_SWS_length);
W1_hour10_global_av_REM_length  = mean(W1_hour10_mean_REM_length);
W1_hour10_global_av_wake_episodes = mean(W1_hour10_num_wake_episodes);

W1_hour11_global_av_wake_length = mean(W1_hour11_mean_wake_length);
W1_hour11_global_av_SWS_length  = mean(W1_hour11_mean_SWS_length);
W1_hour11_global_av_REM_length  = mean(W1_hour11_mean_REM_length);
W1_hour11_global_av_wake_episodes = mean(W1_hour11_num_wake_episodes);

W1_hour12_global_av_wake_length = mean(W1_hour12_mean_wake_length);
W1_hour12_global_av_SWS_length  = mean(W1_hour12_mean_SWS_length);
W1_hour12_global_av_REM_length  = mean(W1_hour12_mean_REM_length);
W1_hour12_global_av_wake_episodes = mean(W1_hour12_num_wake_episodes);

W1_hour13_global_av_wake_length = mean(W1_hour13_mean_wake_length);
W1_hour13_global_av_SWS_length  = mean(W1_hour13_mean_SWS_length);
W1_hour13_global_av_REM_length  = mean(W1_hour13_mean_REM_length);
W1_hour13_global_av_wake_episodes = mean(W1_hour13_num_wake_episodes);

W1_hour14_global_av_wake_length = mean(W1_hour14_mean_wake_length);
W1_hour14_global_av_SWS_length  = mean(W1_hour14_mean_SWS_length);
W1_hour14_global_av_REM_length  = mean(W1_hour14_mean_REM_length);
W1_hour14_global_av_wake_episodes = mean(W1_hour14_num_wake_episodes);

W1_hour15_global_av_wake_length = mean(W1_hour15_mean_wake_length);
W1_hour15_global_av_SWS_length  = mean(W1_hour15_mean_SWS_length);
W1_hour15_global_av_REM_length  = mean(W1_hour15_mean_REM_length);
W1_hour15_global_av_wake_episodes = mean(W1_hour15_num_wake_episodes);

W1_hour16_global_av_wake_length = mean(W1_hour16_mean_wake_length);
W1_hour16_global_av_SWS_length  = mean(W1_hour16_mean_SWS_length);
W1_hour16_global_av_REM_length  = mean(W1_hour16_mean_REM_length);
W1_hour16_global_av_wake_episodes = mean(W1_hour16_num_wake_episodes);


% std's over the simulations
W1_hour1_global_std_wake_length = std(W1_hour1_mean_wake_length);
W1_hour1_global_std_SWS_length  = std(W1_hour1_mean_SWS_length);
W1_hour1_global_std_REM_length  = std(W1_hour1_mean_REM_length);
W1_hour1_global_std_wake_episodes = std(W1_hour1_num_wake_episodes);

W1_hour2_global_std_wake_length = std(W1_hour2_mean_wake_length);
W1_hour2_global_std_SWS_length  = std(W1_hour2_mean_SWS_length);
W1_hour2_global_std_REM_length  = std(W1_hour2_mean_REM_length);
W1_hour2_global_std_wake_episodes = std(W1_hour2_num_wake_episodes);

W1_hour3_global_std_wake_length = std(W1_hour3_mean_wake_length);
W1_hour3_global_std_SWS_length  = std(W1_hour3_mean_SWS_length);
W1_hour3_global_std_REM_length  = std(W1_hour3_mean_REM_length);
W1_hour3_global_std_wake_episodes = std(W1_hour3_num_wake_episodes);

W1_hour4_global_std_wake_length = std(W1_hour4_mean_wake_length);
W1_hour4_global_std_SWS_length  = std(W1_hour4_mean_SWS_length);
W1_hour4_global_std_REM_length  = std(W1_hour4_mean_REM_length);
W1_hour4_global_std_wake_episodes = std(W1_hour4_num_wake_episodes);

W1_hour5_global_std_wake_length = std(W1_hour5_mean_wake_length);
W1_hour5_global_std_SWS_length  = std(W1_hour5_mean_SWS_length);
W1_hour5_global_std_REM_length  = std(W1_hour5_mean_REM_length);
W1_hour5_global_std_wake_episodes = std(W1_hour5_num_wake_episodes);

W1_hour6_global_std_wake_length = std(W1_hour6_mean_wake_length);
W1_hour6_global_std_SWS_length  = std(W1_hour6_mean_SWS_length);
W1_hour6_global_std_REM_length  = std(W1_hour6_mean_REM_length);
W1_hour6_global_std_wake_episodes = std(W1_hour6_num_wake_episodes);

W1_hour7_global_std_wake_length = std(W1_hour7_mean_wake_length);
W1_hour7_global_std_SWS_length  = std(W1_hour7_mean_SWS_length);
W1_hour7_global_std_REM_length  = std(W1_hour7_mean_REM_length);
W1_hour7_global_std_wake_episodes = std(W1_hour7_num_wake_episodes);

W1_hour8_global_std_wake_length = std(W1_hour8_mean_wake_length);
W1_hour8_global_std_SWS_length  = std(W1_hour8_mean_SWS_length);
W1_hour8_global_std_REM_length  = std(W1_hour8_mean_REM_length);
W1_hour8_global_std_wake_episodes = std(W1_hour8_num_wake_episodes);

W1_hour9_global_std_wake_length = std(W1_hour9_mean_wake_length);
W1_hour9_global_std_SWS_length  = std(W1_hour9_mean_SWS_length);
W1_hour9_global_std_REM_length  = std(W1_hour9_mean_REM_length);
W1_hour9_global_std_wake_episodes = std(W1_hour9_num_wake_episodes);

W1_hour10_global_std_wake_length = std(W1_hour10_mean_wake_length);
W1_hour10_global_std_SWS_length  = std(W1_hour10_mean_SWS_length);
W1_hour10_global_std_REM_length  = std(W1_hour10_mean_REM_length);
W1_hour10_global_std_wake_episodes = std(W1_hour10_num_wake_episodes);

W1_hour11_global_std_wake_length = std(W1_hour11_mean_wake_length);
W1_hour11_global_std_SWS_length  = std(W1_hour11_mean_SWS_length);
W1_hour11_global_std_REM_length  = std(W1_hour11_mean_REM_length);
W1_hour11_global_std_wake_episodes = std(W1_hour11_num_wake_episodes);

W1_hour12_global_std_wake_length = std(W1_hour12_mean_wake_length);
W1_hour12_global_std_SWS_length  = std(W1_hour12_mean_SWS_length);
W1_hour12_global_std_REM_length  = std(W1_hour12_mean_REM_length);
W1_hour12_global_std_wake_episodes = std(W1_hour12_num_wake_episodes);

W1_hour13_global_std_wake_length = std(W1_hour13_mean_wake_length);
W1_hour13_global_std_SWS_length  = std(W1_hour13_mean_SWS_length);
W1_hour13_global_std_REM_length  = std(W1_hour13_mean_REM_length);
W1_hour13_global_std_wake_episodes = std(W1_hour13_num_wake_episodes);

W1_hour14_global_std_wake_length = std(W1_hour14_mean_wake_length);
W1_hour14_global_std_SWS_length  = std(W1_hour14_mean_SWS_length);
W1_hour14_global_std_REM_length  = std(W1_hour14_mean_REM_length);
W1_hour14_global_std_wake_episodes = std(W1_hour14_num_wake_episodes);

W1_hour15_global_std_wake_length = std(W1_hour15_mean_wake_length);
W1_hour15_global_std_SWS_length  = std(W1_hour15_mean_SWS_length);
W1_hour15_global_std_REM_length  = std(W1_hour15_mean_REM_length);
W1_hour15_global_std_wake_episodes = std(W1_hour15_num_wake_episodes);

W1_hour16_global_std_wake_length = std(W1_hour16_mean_wake_length);
W1_hour16_global_std_SWS_length  = std(W1_hour16_mean_SWS_length);
W1_hour16_global_std_REM_length  = std(W1_hour16_mean_REM_length);
W1_hour16_global_std_wake_episodes = std(W1_hour16_num_wake_episodes);



% Now put the averages and std's together into vectors to make them easy to plot
% Each vector contains 16 entries
avg_wake_episodes_vs_time         = [W1_hour1_global_av_wake_episodes  W1_hour2_global_av_wake_episodes  W1_hour3_global_av_wake_episodes  W1_hour4_global_av_wake_episodes ...
									 W1_hour5_global_av_wake_episodes  W1_hour6_global_av_wake_episodes  W1_hour7_global_av_wake_episodes  W1_hour8_global_av_wake_episodes ...
									 W1_hour9_global_av_wake_episodes  W1_hour10_global_av_wake_episodes W1_hour11_global_av_wake_episodes W1_hour12_global_av_wake_episodes ...
									 W1_hour13_global_av_wake_episodes W1_hour14_global_av_wake_episodes W1_hour15_global_av_wake_episodes W1_hour16_global_av_wake_episodes];

avg_SWS_episode_duration_vs_time  = [W1_hour1_global_av_SWS_length  W1_hour2_global_av_SWS_length  W1_hour3_global_av_SWS_length  W1_hour4_global_av_SWS_length ...
									 W1_hour5_global_av_SWS_length  W1_hour6_global_av_SWS_length  W1_hour7_global_av_SWS_length  W1_hour8_global_av_SWS_length ...
									 W1_hour9_global_av_SWS_length  W1_hour10_global_av_SWS_length W1_hour11_global_av_SWS_length W1_hour12_global_av_SWS_length ...
									 W1_hour13_global_av_SWS_length W1_hour14_global_av_SWS_length W1_hour15_global_av_SWS_length W1_hour16_global_av_SWS_length];
									 
avg_REMS_episode_duration_vs_time = [W1_hour1_global_av_REM_length  W1_hour2_global_av_REM_length  W1_hour3_global_av_REM_length  W1_hour4_global_av_REM_length ...
									 W1_hour5_global_av_REM_length  W1_hour6_global_av_REM_length  W1_hour7_global_av_REM_length  W1_hour8_global_av_REM_length ...
									 W1_hour9_global_av_REM_length  W1_hour10_global_av_REM_length W1_hour11_global_av_REM_length W1_hour12_global_av_REM_length ...
									 W1_hour13_global_av_REM_length W1_hour14_global_av_REM_length W1_hour15_global_av_REM_length W1_hour16_global_av_REM_length];
									
std_wake_episodes_vs_time  		  =  [W1_hour1_global_std_wake_episodes  W1_hour2_global_std_wake_episodes  W1_hour3_global_std_wake_episodes  W1_hour4_global_std_wake_episodes ...
									 W1_hour5_global_std_wake_episodes  W1_hour6_global_std_wake_episodes  W1_hour7_global_std_wake_episodes  W1_hour8_global_std_wake_episodes ...
									 W1_hour9_global_std_wake_episodes  W1_hour10_global_std_wake_episodes W1_hour11_global_std_wake_episodes W1_hour12_global_std_wake_episodes ...
									 W1_hour13_global_std_wake_episodes W1_hour14_global_std_wake_episodes W1_hour15_global_std_wake_episodes W1_hour16_global_std_wake_episodes];

std_SWS_episode_duration_vs_time  = [W1_hour1_global_std_SWS_length  W1_hour2_global_std_SWS_length  W1_hour3_global_std_SWS_length  W1_hour4_global_std_SWS_length ...
									 W1_hour5_global_std_SWS_length  W1_hour6_global_std_SWS_length  W1_hour7_global_std_SWS_length  W1_hour8_global_std_SWS_length ...
									 W1_hour9_global_std_SWS_length  W1_hour10_global_std_SWS_length W1_hour11_global_std_SWS_length W1_hour12_global_std_SWS_length ...
									 W1_hour13_global_std_SWS_length W1_hour14_global_std_SWS_length W1_hour15_global_std_SWS_length W1_hour16_global_std_SWS_length];

std_REMS_episode_duration_vs_time = [W1_hour1_global_std_REM_length  W1_hour2_global_std_REM_length  W1_hour3_global_std_REM_length  W1_hour4_global_std_REM_length ...
									 W1_hour5_global_std_REM_length  W1_hour6_global_std_REM_length  W1_hour7_global_std_REM_length  W1_hour8_global_std_REM_length ...
									 W1_hour9_global_std_REM_length  W1_hour10_global_std_REM_length W1_hour11_global_std_REM_length W1_hour12_global_std_REM_length ...
									 W1_hour13_global_std_REM_length W1_hour14_global_std_REM_length W1_hour15_global_std_REM_length W1_hour16_global_std_REM_length];


% Finally, plot it all
figure
subplot(3,1,1)
h1=plot([1:16],avg_wake_episodes_vs_time,'k',[1:16],avg_wake_episodes_vs_time,'ko','MarkerSize',10);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:16],avg_wake_episodes_vs_time,std_wake_episodes_vs_time,'k');
axis([0 16.5 80 240])
ax=gca;
ax.XTick = [1:16];
%ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
set(gca,'box','off')
ylabel('Number of wake episodes')

subplot(3,1,2)
h3=plot([1:16],avg_SWS_episode_duration_vs_time,'k',[1:16],avg_SWS_episode_duration_vs_time,'ko','MarkerSize',10);
set(h3(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h4=errorbar([1:16],avg_SWS_episode_duration_vs_time,std_SWS_episode_duration_vs_time,'k');
axis([0 16.5 100 300])
ax=gca;
ax.XTick = [1:16];
%ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
set(gca,'box','off')
ylabel({'SWS'; '(episode duration, seconds)'})

subplot(3,1,3)
h5=plot([1:16],avg_REMS_episode_duration_vs_time,'k',[1:16],avg_REMS_episode_duration_vs_time,'ko','MarkerSize',10);
set(h5(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h6=errorbar([1:16],avg_REMS_episode_duration_vs_time,std_REMS_episode_duration_vs_time,'k');
axis([0 16.5 80 140])
ax=gca;
ax.XTick = [1:16];
%ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
set(gca,'box','off')
ylabel({'REM sleep'; '(episode duration, seconds)'})






