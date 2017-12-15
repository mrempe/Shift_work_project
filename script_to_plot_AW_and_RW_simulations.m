% script to run the two_process_model_with_markov_chain once for the AW case and once for the RW 
% case and make three figures:  1) plot wake duration vs day for both AW and RW
%								2) SWS episode duration for AW and RW
%								3) REMS episode duration for AW and RW

%profile on 


% [S,sleepstate,num_wake_episodesAW,mean_SWS_lengthAW,REMS_episode_duration_AW_averages,...
%  std_wake_episodes_vs_timeAW,std_SWS_episode_duration_vs_timeAW,REMS_episode_duration_AW_Std] = two_process_model_with_markov_chain(134,input_params,'AW',1);

% [S,sleepstate,num_wake_episodesRW,mean_SWS_lengthRW,REMS_episode_duration_RW_averages,...
%  std_wake_episodes_vs_timeRW,std_SWS_episode_duration_vs_timeRW,REMS_episode_duration_RW_Std] = two_process_model_with_markov_chain(134,input_params,'RW',1);

%load('GODLIKE_optimization.mat','best_choice_of_params')
% set the values of the parameters to the optimized values
% input_params.ahat_W_S_base = best_choice_of_params.ahat_W_S_base;
% input_params.ahat_S_W_base = best_choice_of_params.ahat_S_W_base;
% input_params.ahat_W_R_base = best_choice_of_params.ahat_W_R_base;
% input_params.ahat_R_W_base = best_choice_of_params.ahat_R_W_base;
% input_params.ahat_S_R_base = best_choice_of_params.ahat_S_R_base;
% input_params.ahat_R_S_base = best_choice_of_params.ahat_R_S_base;
%input_params.taui = best_choice_of_params_9obj.taui;
%input_params.taud = best_choice_of_params_9obj.taud;

%% -- set parameters using a vector --------
% best_choice = Pareto_individuals(132,:);
% input_params.ahat_W_S_base = best_choice(3);
% input_params.ahat_S_W_base = best_choice(4);
% input_params.ahat_W_R_base = best_choice(5);
% input_params.ahat_R_W_base = best_choice(6);
% input_params.ahat_S_R_base = best_choice(7);
% input_params.ahat_R_S_base = best_choice(8);

%% -- parameters used in Europe talks and first submission of paper ---
%  --------------------------------------------------------------------
% input_params.ahat_W_S_base = 0.003;
% input_params.ahat_S_W_base = 0.006;
% input_params.ahat_W_R_base = 0.007;
% input_params.ahat_R_W_base = 1.2374e-04;
% input_params.ahat_S_R_base = 0.007;
% input_params.ahat_R_S_base = 0.001;

% input_paramsAW.taui = 12;
% input_paramsAW.taud = K_usingRWnew(1);
% input_paramsAW.ahat_W_S_base = 0.027;  % 11.16.17 I determined this value by matching the duration of SWS episodes to Lu PNAS 2004 Figure 2 on a semilogy plot
% input_paramsAW.ahat_S_W_base = K_usingRWnew(2); % using power law this value should be 1.  
% input_paramsAW.ahat_W_R_base = K_usingRWnew(3);
% input_paramsAW.ahat_R_W_base = K_usingRWnew(4);
% input_paramsAW.ahat_S_R_base = K_usingRWnew(5);
% input_paramsAW.ahat_R_S_base = K_usingRWnew(6);

% input_paramsRW.taui = 12;
% input_paramsRW.taud = K_usingRWnew(1);
% input_paramsRW.ahat_W_S_base = 0.027;  % 11.16.17 I determined this value by matching the duration of SWS episodes to Lu PNAS 2004 Figure 2 on a semilogy plot
% input_paramsRW.ahat_S_W_base = K_usingRWnew(2);   % using power law this value should be 1.   
% input_paramsRW.ahat_W_R_base = K_usingRWnew(3);
% input_paramsRW.ahat_R_W_base = K_usingRWnew(4);
% input_paramsRW.ahat_S_R_base = K_usingRWnew(5);
% input_paramsRW.ahat_R_S_base = K_usingRWnew(6);

% input_paramsAW.taui = 12;
% input_paramsAW.taud = K(1);
% input_paramsAW.ahat_W_S_base = 0.027;  % 11.16.17 I determined this value by matching the duration of SWS episodes to Lu PNAS 2004 Figure 2 on a semilogy plot
% input_paramsAW.ahat_S_W_base = K(2); % using power law this value should be 1.  
% input_paramsAW.ahat_W_R_base = K(3);
% input_paramsAW.ahat_R_W_base = K(4);
% input_paramsAW.ahat_S_R_base = K(5);
% input_paramsAW.ahat_R_S_base = K(6);

% Find the indices where each parameter lives
taud_idx  = find(ismember(K_optimized_12_14.names,'taud'));
gamma_idx = find(ismember(K_optimized_12_14.names,'gamma'));
mu_idx    = find(ismember(K_optimized_12_14.names,'mu'));
delta_idx = find(ismember(K_optimized_12_14.names,'delta'));
c1_idx    = find(ismember(K_optimized_12_14.names,'c1'));
c2_idx    = find(ismember(K_optimized_12_14.names,'c2'));
WS_offset_idx = find(ismember(K_optimized_12_14.names,'WS_offset'));
SR_offset_idx = find(ismember(K_optimized_12_14.names,'SR_offset'));







input_paramsAW.taui = 13;
input_paramsAW.taud  = K_optimized_12_14.values(taud_idx);  %4.5;
input_paramsAW.gamma = K_optimized_12_14.values(gamma_idx);
input_paramsAW.mu    = K_optimized_12_14.values(mu_idx); %0.015;
input_paramsAW.delta = K_optimized_12_14.values(delta_idx);
input_paramsAW.c1    = K_optimized_12_14.values(c1_idx);
input_paramsAW.c2    = K_optimized_12_14.values(c2_idx);
input_paramsAW.WS_offset = K_optimized_12_14.values(WS_offset_idx);
input_paramsAW.SR_offset = K_optimized_12_14.values(SR_offset_idx);


input_paramsRW = input_paramsAW; 


% input_params.ahat_W_S_base = best_choice_of_params_9obj.ahat_W_S_base;
% input_params.ahat_S_W_base = best_choice_of_params_9obj.ahat_S_W_base;
% input_params.ahat_W_R_base = best_choice_of_params_9obj.ahat_W_R_base;
% input_params.ahat_R_W_base = best_choice_of_params_9obj.ahat_R_W_base;
% input_params.ahat_S_R_base = best_choice_of_params_9obj.ahat_S_R_base;
% input_params.ahat_R_S_base = best_choice_of_params_9obj.ahat_R_S_base;

[S,sleepstate,sleep_averagesAW,sleep_stdAW] = two_process_model_with_markov_chain(134,input_paramsAW,'AW',1);
[S,sleepstate,sleep_averagesRW,sleep_stdRW] = two_process_model_with_markov_chain(134,input_paramsRW,'RW',1);

%----averages ------------------------------
%--- number of episodes --------------------- 
num_wake_episodesAWsim = sleep_averagesAW.num_w_episodes;
num_sws_episodesAWsim  = sleep_averagesAW.num_sws_episodes;
num_rems_episodesAWsim = sleep_averagesAW.num_REMS_episodes;

num_wake_episodesRWsim = sleep_averagesRW.num_w_episodes;
num_sws_episodesRWsim  = sleep_averagesRW.num_sws_episodes;
num_rems_episodesRWsim = sleep_averagesRW.num_REMS_episodes;

% episode duration
mean_wake_lengthAWsim = sleep_averagesAW.wake_episode_duration;
mean_sws_lengthAWsim  = sleep_averagesAW.SWS_episode_duration;
mean_rems_lengthAWsim = sleep_averagesAW.REMS_episode_duration;

mean_wake_lengthRWsim = sleep_averagesRW.wake_episode_duration;
mean_sws_lengthRWsim  = sleep_averagesRW.SWS_episode_duration;
mean_rems_lengthRWsim = sleep_averagesRW.REMS_episode_duration;

% daily percentages
daily_percent_in_wake_AWsim = sleep_averagesAW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
daily_percent_in_sws_AWsim  = sleep_averagesAW.time_in_sws./[1440 960 960 960 960]; % 960 minutes in 16 hours.  For W1, W2, W3, W4
daily_percent_in_rems_AWsim = sleep_averagesAW.time_in_rems./[1440 960 960 960 960];% all averages are done over 16 hours (between shifts), not 24

daily_percent_in_wake_RWsim = sleep_averagesRW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
daily_percent_in_sws_RWsim  = sleep_averagesRW.time_in_sws./[1440 960 960 960 960];
daily_percent_in_rems_RWsim = sleep_averagesRW.time_in_rems./[1440 960 960 960 960];



%--- std ----------------------------
% number of episodes
std_wake_episodes_vs_timeAWsim = sleep_stdAW.num_w_episodes;
std_sws_episodes_vs_timeAWsim  = sleep_stdAW.num_sws_episodes;
std_rems_episodes_vs_timeAWsim = sleep_stdAW.num_REMS_episodes;

std_wake_episodes_vs_timeRWsim = sleep_stdRW.num_w_episodes;
std_sws_episodes_vs_timeRWsim  = sleep_stdRW.num_sws_episodes;
std_rems_episodes_vs_timeRWsim = sleep_stdRW.num_REMS_episodes;


% episode duration 
std_wake_episode_duration_vs_timeAWsim = sleep_stdAW.wake_episode_duration;
std_sws_episode_duration_vs_timeAWsim  = sleep_stdAW.SWS_episode_duration;
std_rems_episode_duration_vs_timeAWsim = sleep_stdAW.REMS_episode_duration;

std_wake_episode_duration_vs_timeRWsim = sleep_stdRW.wake_episode_duration;
std_sws_episode_duration_vs_timeRWsim  = sleep_stdRW.SWS_episode_duration;
std_rems_episode_duration_vs_timeRWsim = sleep_stdRW.REMS_episode_duration;


% daily percentages
std_daily_percent_in_wake_AWsim = sleep_stdAW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
std_daily_percent_in_sws_AWsim  = sleep_stdAW.time_in_sws./[1440 960 960 960 960];
std_daily_percent_in_rems_AWsim = sleep_stdAW.time_in_rems./[1440 960 960 960 960];

std_daily_percent_in_wake_RWsim = sleep_stdRW.time_in_w./[1440 960 960 960 960];  % divide by 1440 since 1440 minutes in 24 hours
std_daily_percent_in_sws_RWsim  = sleep_stdRW.time_in_sws./[1440 960 960 960 960];
std_daily_percent_in_rems_RWsim = sleep_stdRW.time_in_rems./[1440 960 960 960 960];



% plot wake episodes vs time
figure

% ------- first figure, number of wake episodes, SWS episodes, REMS episodes
% ------- TOP PANEL ---------------
h1=plot([1:5],num_wake_episodesRWsim,'k',[1:5],num_wake_episodesRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_wake_episodesRWsim,std_wake_episodes_vs_timeRWsim,'k');

h3=plot([1:5],num_wake_episodesAWsim,'k',[1:5],num_wake_episodesAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_wake_episodesAWsim,std_wake_episodes_vs_timeAWsim,'k');

axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel('Number of wake episodes')
title('Simulation Output')

% ------- MIDDLE PANEL ---------------
figure 
h1=plot([1:5],num_sws_episodesRWsim,'k',[1:5],num_sws_episodesRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_sws_episodesRWsim,std_sws_episodes_vs_timeRWsim,'k');

h3=plot([1:5],num_sws_episodesAWsim,'k',[1:5],num_sws_episodesAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_sws_episodesAWsim,std_sws_episodes_vs_timeAWsim,'k');

axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel('Number of SWS episodes')
title('Simulation Output')

% ------- BOTTOM PANEL ---------------
figure 
h1=plot([1:5],num_rems_episodesRWsim,'k',[1:5],num_rems_episodesRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_rems_episodesRWsim,std_rems_episodes_vs_timeRWsim,'k');

h3=plot([1:5],num_rems_episodesAWsim,'k',[1:5],num_rems_episodesAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_rems_episodesAWsim,std_rems_episodes_vs_timeAWsim,'k');

axis([0 5.5 40 120])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [40 60 80 100 120];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel('Number of REMS episodes')
title('Simulation Output')
%-----------------------------------------------------------------------------
%---- END OF FIGURES SHOWING NUMBER OF EPISODES
% -----------------------------------------------------------------------------

% --- FIGURE SHOWING AVERAGE EPISODE DURATION FOR EACH SLEEP STATE
% ------ TOP PANEL -----------------
figure
h1=plot([1:5],mean_wake_lengthRWsim,'k',[1:5],mean_wake_lengthRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],mean_wake_lengthRWsim,std_wake_episode_duration_vs_timeRWsim,'k');

h3=plot([1:5],mean_wake_lengthAWsim,'k',[1:5],mean_wake_lengthAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],mean_wake_lengthAWsim,std_wake_episode_duration_vs_timeAWsim,'k');

axis([0 5.5 100 400])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'Wake'; '(episode duration, seconds)'})
title('Simulation Output')


% --------
% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],mean_sws_lengthRWsim,'k',[1:5],mean_sws_lengthRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],mean_sws_lengthRWsim,std_sws_episode_duration_vs_timeRWsim,'k');

h3=plot([1:5],mean_sws_lengthAWsim,'k',[1:5],mean_sws_lengthAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],mean_sws_lengthAWsim,std_sws_episode_duration_vs_timeAWsim,'k');


axis([0 5.5 100 400])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'SWS'; '(episode duration, seconds)'})
title('Simulation Output')

% --------
% ------- BOTTOM PANEL ----------------
figure
h1=plot([1:5],mean_rems_lengthRWsim,'k',[1:5],mean_rems_lengthRWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],mean_rems_lengthRWsim,std_rems_episode_duration_vs_timeRWsim,'k');

h3=plot([1:5],mean_rems_lengthAWsim,'k',[1:5],mean_rems_lengthAWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],mean_rems_lengthAWsim,std_rems_episode_duration_vs_timeAWsim,'k');

axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend3=legend('RW','AW');
legend boxoff
set(h_legend3,'FontSize',12)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = 1.5;
ax.FontSize = 12;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'REM sleep'; '(episode duration, seconds)'})
title('Simulation Output')


% --- FIGURE SHOWING AVERAGE DAILY PERCENTAGE OF TIME SPENT IN EACH SLEEP STATE
% ------ TOP PANEL -----------------
figure
h1=plot([1:5],100*daily_percent_in_wake_RWsim,'k',[1:5],100*daily_percent_in_wake_RWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_wake_RWsim,100*std_daily_percent_in_wake_RWsim,'k');

h3=plot([1:5],100*daily_percent_in_wake_AWsim,'k',[1:5],100*daily_percent_in_wake_AWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_wake_AWsim ,100*std_daily_percent_in_wake_AWsim,'k');

axis([0 5.5 0 100])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 20 40 60 80 100];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'Percentage of time'; 'spent in wakefulness'})
title('Simulation Output')

% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],100*daily_percent_in_sws_RWsim,'k',[1:5],100*daily_percent_in_sws_RWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_sws_RWsim,100*std_daily_percent_in_sws_RWsim,'k');

h3=plot([1:5],100*daily_percent_in_sws_AWsim,'k',[1:5],100*daily_percent_in_sws_AWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_sws_AWsim ,100*std_daily_percent_in_sws_AWsim,'k');
axis([0 5.5 0 100]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 20 40 60 80 100];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'Percentage of time'; 'spent in SWS'})
title('Simulation Output')

% --- BOTTOM PANEL ----------------------------------------------
figure
h1=plot([1:5],100*daily_percent_in_rems_RWsim,'k',[1:5],100*daily_percent_in_rems_RWsim,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_rems_RWsim,100*std_daily_percent_in_rems_RWsim,'k');

h3=plot([1:5],100*daily_percent_in_rems_AWsim,'k',[1:5],100*daily_percent_in_rems_AWsim,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_rems_AWsim,100*std_daily_percent_in_rems_AWsim,'k');
axis([0 5.5 0 100]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 20 40 60 80 100];
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'Percentage of time'; 'spent in REMS'})
title('Simulation Output')


%profile viewer