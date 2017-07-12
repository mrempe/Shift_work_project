function [avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time,...
	      std_wake_episodes_vs_time,std_SWS_episode_duration_vs_time,std_REMS_episode_duration_vs_time] = group_and_plot_Wepisodes_SWS_REMS_duration(shift,state,num_simulations)
% USAGE: [avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time] = group_and_plot_Wepisodes_SWS_REMS_duration(shift,state,num_simulations)


if strcmp(shift,'AW') || strcmp(shift,'none')
	W1_indices = 16561:22321;  % 16 hours
	W2_indices = 25201:30961;
	W3_indices = 33841:39601;
	W4_indices = 42481:48241;
elseif strcmp(shift,'RW')
	W1_indices = 12241:18001;
	W2_indices = 20881:26641;
	W3_indices = 29521:35281;
	W4_indices = 38161:43921;
else
	error('Shift must either be ''AW'',''RW'', or ''none'' ')
end 




for j=1:num_simulations
	baseline_runs = contiguous(state(1:8641,j),['W' 'S' 'R']);
	W1_runs = contiguous(state(W1_indices,j),['W' 'S' 'R']);
	W2_runs = contiguous(state(W2_indices,j),['W' 'S' 'R']);
	W3_runs = contiguous(state(W3_indices,j),['W' 'S' 'R']);
	W4_runs = contiguous(state(W4_indices,j),['W' 'S' 'R']);

	B_wake_runs{j}   = baseline_runs{1,2};
	B_sleep_runs{j}  = baseline_runs{2,2};
	B_REM_runs{j}    = baseline_runs{3,2};
	W1_wake_runs{j}  = W1_runs{1,2};
	W1_sleep_runs{j} = W1_runs{2,2};
	W1_REM_runs{j}   = W1_runs{3,2};
	W2_wake_runs{j}  = W2_runs{1,2};
	W2_sleep_runs{j} = W2_runs{2,2};
	W2_REM_runs{j}   = W2_runs{3,2};
	W3_wake_runs{j}  = W3_runs{1,2};
	W3_sleep_runs{j} = W3_runs{2,2};
	W3_REM_runs{j}   = W3_runs{3,2};
	W4_wake_runs{j}  = W4_runs{1,2};
	W4_sleep_runs{j} = W4_runs{2,2};
	W4_REM_runs{j}   = W4_runs{3,2};

	% Number of wake episodes
	B_num_wake_episodes(j)  = size(B_wake_runs{j},1);
	W1_num_wake_episodes(j) = size(W1_wake_runs{j},1);
	W2_num_wake_episodes(j) = size(W2_wake_runs{j},1);
	W3_num_wake_episodes(j) = size(W3_wake_runs{j},1);
	W4_num_wake_episodes(j) = size(W4_wake_runs{j},1);

	
% Baseline
	for i=1:size(B_wake_runs{j},1)
    	if B_wake_runs{j}(i,2)-B_wake_runs{j}(i,1)+1 >= 2 
    		B_w_episode_length{j}(i) = B_wake_runs{j}(i,2)-B_wake_runs{j}(i,1)+1;
		end 
	end

	for i=1:size(B_sleep_runs{j},1)
    	B_s_episode_length{j}(i) = B_sleep_runs{j}(i,2)-B_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(B_REM_runs{j},1)
		B_r_episode_length{j}(i) = B_REM_runs{j}(i,2)-B_REM_runs{j}(i,1)+1;
	end
	B_mean_SWS_length(j)  = mean(B_s_episode_length{j}) * 10;
	B_mean_wake_length(j) = mean(B_w_episode_length{j}) * 10;
	B_mean_REM_length(j)  = mean(B_r_episode_length{j}) * 10;


% W1
	for i=1:size(W1_wake_runs{j},1)
    	if W1_wake_runs{j}(i,2)-W1_wake_runs{j}(i,1)+1 >=2
    		W1_w_episode_length{j}(i) = W1_wake_runs{j}(i,2)-W1_wake_runs{j}(i,1)+1;
    	end 
	end

	for i=1:size(W1_sleep_runs{j},1)
    	W1_s_episode_length{j}(i) = W1_sleep_runs{j}(i,2)-W1_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W1_REM_runs{j},1)
		W1_r_episode_length{j}(i) = W1_REM_runs{j}(i,2)-W1_REM_runs{j}(i,1)+1;
	end
	W1_mean_SWS_length(j)  = mean(W1_s_episode_length{j}) * 10;
	W1_mean_wake_length(j) = mean(W1_w_episode_length{j}) * 10;
	W1_mean_REM_length(j)  = mean(W1_r_episode_length{j}) * 10;


% W2
	for i=1:size(W2_wake_runs{j},1)
    	if W2_wake_runs{j}(i,2)-W2_wake_runs{j}(i,1)+1 >=2
    		W2_w_episode_length{j}(i) = W2_wake_runs{j}(i,2)-W2_wake_runs{j}(i,1)+1;
    	end 
	end

	for i=1:size(W2_sleep_runs{j},1)
    	W2_s_episode_length{j}(i) = W2_sleep_runs{j}(i,2)-W2_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W2_REM_runs{j},1)
		W2_r_episode_length{j}(i) = W2_REM_runs{j}(i,2)-W2_REM_runs{j}(i,1)+1;
	end
	W2_mean_SWS_length(j)  = mean(W2_s_episode_length{j}) * 10;
	W2_mean_wake_length(j) = mean(W2_w_episode_length{j}) * 10;
	W2_mean_REM_length(j)  = mean(W2_r_episode_length{j}) * 10;

% W3
	for i=1:size(W3_wake_runs{j},1)
    	if W3_wake_runs{j}(i,2)-W3_wake_runs{j}(i,1)+1 >=2
    		W3_w_episode_length{j}(i) = W3_wake_runs{j}(i,2)-W3_wake_runs{j}(i,1)+1;
    	end 
	end

	for i=1:size(W3_sleep_runs{j},1)
    	W3_s_episode_length{j}(i) = W3_sleep_runs{j}(i,2)-W3_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W3_REM_runs{j},1)
		W3_r_episode_length{j}(i) = W3_REM_runs{j}(i,2)-W3_REM_runs{j}(i,1)+1;
	end
	W3_mean_SWS_length(j)  = mean(W3_s_episode_length{j}) * 10;
	W3_mean_wake_length(j) = mean(W3_w_episode_length{j}) * 10;
	W3_mean_REM_length(j)  = mean(W3_r_episode_length{j}) * 10;

% W4
	for i=1:size(W4_wake_runs{j},1)
    	if W4_wake_runs{j}(i,2)-W4_wake_runs{j}(i,1)+1 >= 2
    		W4_w_episode_length{j}(i) = W4_wake_runs{j}(i,2)-W4_wake_runs{j}(i,1)+1;
    	end 
	end

	for i=1:size(W4_sleep_runs{j},1)
    	W4_s_episode_length{j}(i) = W4_sleep_runs{j}(i,2)-W4_sleep_runs{j}(i,1)+1;
    
	end

	for i=1:size(W4_REM_runs{j},1)
		W4_r_episode_length{j}(i) = W4_REM_runs{j}(i,2)-W4_REM_runs{j}(i,1)+1;
	end
	W4_mean_SWS_length(j)  = mean(W4_s_episode_length{j}) * 10;
	W4_mean_wake_length(j) = mean(W4_w_episode_length{j}) * 10;
	W4_mean_REM_length(j)  = mean(W4_r_episode_length{j}) * 10;

end  % end of looping over num_simulations


% average over the simulations
B_global_av_wake_length = mean(B_mean_wake_length);
B_global_av_SWS_length  = mean(B_mean_SWS_length);
B_global_av_REM_length  = mean(B_mean_REM_length);
B_global_av_wake_episodes = mean(B_num_wake_episodes);


W1_global_av_wake_length = mean(W1_mean_wake_length);
W1_global_av_SWS_length  = mean(W1_mean_SWS_length);
W1_global_av_REM_length  = mean(W1_mean_REM_length);
W1_global_av_wake_episodes = mean(W1_num_wake_episodes);


W2_global_av_wake_length = mean(W2_mean_wake_length);
W2_global_av_SWS_length  = mean(W2_mean_SWS_length);
W2_global_av_REM_length  = mean(W2_mean_REM_length);
W2_global_av_wake_episodes = mean(W2_num_wake_episodes);


W3_global_av_wake_length = mean(W3_mean_wake_length);
W3_global_av_SWS_length  = mean(W3_mean_SWS_length);
W3_global_av_REM_length  = mean(W3_mean_REM_length);
W3_global_av_wake_episodes = mean(W3_num_wake_episodes);


W4_global_av_wake_length = mean(W4_mean_wake_length);
W4_global_av_SWS_length  = mean(W4_mean_SWS_length);
W4_global_av_REM_length  = mean(W4_mean_REM_length);
W4_global_av_wake_episodes = mean(W4_num_wake_episodes);


% std's over the simulations
B_global_std_wake_length = std(B_mean_wake_length);
B_global_std_SWS_length  = std(B_mean_SWS_length);
B_global_std_REM_length  = std(B_mean_REM_length);
B_global_std_wake_episodes = std(B_num_wake_episodes);


W1_global_std_wake_length = std(W1_mean_wake_length);
W1_global_std_SWS_length  = std(W1_mean_SWS_length);
W1_global_std_REM_length  = std(W1_mean_REM_length);
W1_global_std_wake_episodes = std(W1_num_wake_episodes);


W2_global_std_wake_length = std(W2_mean_wake_length);
W2_global_std_SWS_length  = std(W2_mean_SWS_length);
W2_global_std_REM_length  = std(W2_mean_REM_length);
W2_global_std_wake_episodes = std(W2_num_wake_episodes);


W3_global_std_wake_length = std(W3_mean_wake_length);
W3_global_std_SWS_length  = std(W3_mean_SWS_length);
W3_global_std_REM_length  = std(W3_mean_REM_length);
W3_global_std_wake_episodes = std(W3_num_wake_episodes);


W4_global_std_wake_length = std(W4_mean_wake_length);
W4_global_std_SWS_length  = std(W4_mean_SWS_length);
W4_global_std_REM_length  = std(W4_mean_REM_length);
W4_global_std_wake_episodes = std(W4_num_wake_episodes);

% Now put the averages and std's together into vectors to make them easy to plot
% Each vector contains 5 entries: B, W1, W2, W3, W4
avg_wake_episodes_vs_time         = [B_global_av_wake_episodes W1_global_av_wake_episodes W2_global_av_wake_episodes W3_global_av_wake_episodes W4_global_av_wake_episodes];
avg_SWS_episode_duration_vs_time  = [B_global_av_SWS_length    W1_global_av_SWS_length    W2_global_av_SWS_length    W3_global_av_SWS_length    W4_global_av_SWS_length];
avg_REMS_episode_duration_vs_time = [B_global_av_REM_length    W1_global_av_REM_length    W2_global_av_REM_length    W3_global_av_REM_length    W4_global_av_REM_length];

std_wake_episodes_vs_time  		  = [B_global_std_wake_episodes W1_global_std_wake_episodes W2_global_std_wake_episodes W3_global_std_wake_episodes W4_global_std_wake_episodes];
std_SWS_episode_duration_vs_time  = [B_global_std_SWS_length    W1_global_std_SWS_length    W2_global_std_SWS_length    W3_global_std_SWS_length    W4_global_std_SWS_length];
std_REMS_episode_duration_vs_time = [B_global_std_REM_length    W1_global_std_REM_length    W2_global_std_REM_length    W3_global_std_REM_length    W4_global_std_REM_length];


% Finally, plot it all
figure
%subplot(3,1,1)
h1=plot([1:5],avg_wake_episodes_vs_time,'k',[1:5],avg_wake_episodes_vs_time,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],avg_wake_episodes_vs_time,std_wake_episodes_vs_time,'k');
axis([0 5.5 80 240])
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
ylabel('Number of wake episodes')
title(shift)

figure
%subplot(3,1,2)
h3=plot([1:5],avg_SWS_episode_duration_vs_time,'k',[1:5],avg_SWS_episode_duration_vs_time,'ko','MarkerSize',12);
set(h3(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h4=errorbar([1:5],avg_SWS_episode_duration_vs_time,std_SWS_episode_duration_vs_time,'k');
axis([0 5.5 100 300])
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
ylabel({'SWS'; '(episode duration, seconds)'})
title(shift)

figure
%subplot(3,1,3)
h5=plot([1:5],avg_REMS_episode_duration_vs_time,'k',[1:5],avg_REMS_episode_duration_vs_time,'ko','MarkerSize',12);
set(h5(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h6=errorbar([1:5],avg_REMS_episode_duration_vs_time,std_REMS_episode_duration_vs_time,'k');
axis([0 5.5 80 140])
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
ylabel({'REM sleep'; '(episode duration, seconds)'})
title(shift)






