% script to run the two_process_model_with_markov_chain once for the AW case and once for the RW 
% case and make three figures:  1) plot wake duration vs day for both AW and RW
%								2) SWS episode duration for AW and RW
%								3) REMS episode duration for AW and RW



[S,sleepstate,num_wake_episodesAW,mean_SWS_lengthAW,REMS_episode_duration_AW_averages,...
 std_wake_episodes_vs_timeAW,std_SWS_episode_duration_vs_timeAW,REMS_episode_duration_AW_Std] = two_process_model_with_markov_chain(134,8.6,3.2,'AW',1);

[S,sleepstate,num_wake_episodesRW,mean_SWS_lengthRW,REMS_episode_duration_RW_averages,...
 std_wake_episodes_vs_timeRW,std_SWS_episode_duration_vs_timeRW,REMS_episode_duration_RW_Std]=two_process_model_with_markov_chain(134,8.6,3.2,'RW',1);



% plot wake episodes vs time
figure

% -------
% ------- TOP PANEL ---------------
h1=plot([1:5],num_wake_episodesRW,'k',[1:5],num_wake_episodesRW,'ko','MarkerSize',10);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_wake_episodesRW,std_wake_episodes_vs_timeRW/length(num_wake_episodesRW),'k');

h3=plot([1:5],num_wake_episodesAW,'k',[1:5],num_wake_episodesAW,'ko','MarkerSize',10);
 
h4=errorbar([1:5],num_wake_episodesAW,std_wake_episodes_vs_timeAW/length(num_wake_episodesAW),'k');

axis([0 5.5 80 240])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
legend('RW','AW');
legend boxoff
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
set(gca,'box','off')
ylabel('Number of wake episodes')


% --------
% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],mean_SWS_lengthRW,'k',[1:5],mean_SWS_lengthRW,'ko','MarkerSize',10);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],mean_SWS_lengthRW,std_SWS_episode_duration_vs_timeRW/length(mean_SWS_lengthRW),'k');

h3=plot([1:5],mean_SWS_lengthAW,'k',[1:5],mean_SWS_lengthAW,'ko','MarkerSize',10);
 
h4=errorbar([1:5],mean_SWS_lengthAW,std_SWS_episode_duration_vs_timeAW/length(mean_SWS_lengthAW),'k');

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
legend('RW','AW');
legend boxoff
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
ax.YTick = [100 150 200 250 300]
set(gca,'box','off')
ylabel({'SWS'; '(episode duration, seconds)'})



% --------
% ------- BOTTOM PANEL ----------------
figure
h1=plot([1:5],REMS_episode_duration_RW_averages,'k',[1:5],REMS_episode_duration_RW_averages,'ko','MarkerSize',10);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],REMS_episode_duration_RW_averages,REMS_episode_duration_RW_Std,'k');

h3=plot([1:5],REMS_episode_duration_AW_averages,'k',[1:5],REMS_episode_duration_AW_averages,'ko','MarkerSize',10);
 
h4=errorbar([1:5],REMS_episode_duration_AW_averages,REMS_episode_duration_AW_Std,'k');

axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
legend('RW','AW');
legend boxoff
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
ax.YTick = [80 90 100 110 120 130 140]
set(gca,'box','off')
ylabel({'REM sleep'; '(episode duration, seconds)'})

