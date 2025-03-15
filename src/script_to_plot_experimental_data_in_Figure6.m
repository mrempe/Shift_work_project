% script to plot the experimental data in Figure 6 of the experimental shift work paper (J Biol Rhythms)


load 'FIG6_Experimental_Data.mat'
load 'all_experimental_data.mat'


figure

% ------- first figure, number of wake episodes, SWS episodes, REMS episodes
% ------- TOP PANEL ---------------
h1=plot([1:5],num_wake_episodes_RW_averages,'k',[1:5],num_wake_episodes_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_wake_episodes_RW_averages,num_wake_episodes_RW_SEM,'k');

h3=plot([1:5],num_wake_episodes_AW_averages,'k',[1:5],num_wake_episodes_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_wake_episodes_AW_averages,num_wake_episodes_AW_SEM,'k');

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
title('Experimental Data')

% ------- MIDDLE PANEL ---------------
figure 
h1=plot([1:5],num_sws_episodes_RW_averages,'k',[1:5],num_sws_episodes_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_sws_episodes_RW_averages,num_sws_episodes_RW_SEM,'k');

h3=plot([1:5],num_sws_episodes_AW_averages,'k',[1:5],num_sws_episodes_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_sws_episodes_AW_averages,num_sws_episodes_AW_SEM,'k');

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
title('Experimental Data')

% ------- BOTTOM PANEL ---------------
figure 
h1=plot([1:5],num_REMS_episodes_RW_averages,'k',[1:5],num_REMS_episodes_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],num_REMS_episodes_RW_averages,num_REMS_episodes_RW_SEM,'k');

h3=plot([1:5],num_REMS_episodes_AW_averages,'k',[1:5],num_REMS_episodes_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],num_REMS_episodes_AW_averages,num_REMS_episodes_AW_SEM,'k');

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
title('Experimental Data')
%-----------------------------------------------------------------------------
%---- END OF FIGURES SHOWING NUMBER OF EPISODES
% -----------------------------------------------------------------------------

% --- FIGURE SHOWING AVERAGE EPISODE DURATION FOR EACH SLEEP STATE
% ------ TOP PANEL -----------------
figure
h1=plot([1:5],wake_episode_duration_RW_averages,'k',[1:5],wake_episode_duration_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],wake_episode_duration_RW_averages,wake_episode_duration_RW_SEM,'k');

h3=plot([1:5],wake_episode_duration_AW_averages,'k',[1:5],wake_episode_duration_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],wake_episode_duration_AW_averages,wake_episode_duration_AW_SEM,'k');

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
title('Experimental Data')


% --------
% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],SWS_episode_duration_RW_averages,'k',[1:5],SWS_episode_duration_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],SWS_episode_duration_RW_averages,SWS_episode_duration_RW_SEM,'k');

h3=plot([1:5],SWS_episode_duration_AW_averages,'k',[1:5],SWS_episode_duration_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],SWS_episode_duration_AW_averages,SWS_episode_duration_AW_SEM,'k');

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
title('Experimental Data')

% --------
% ------- BOTTOM PANEL ----------------
figure
h1=plot([1:5],REMS_episode_duration_RW_averages,'k',[1:5],REMS_episode_duration_RW_averages,'ko','MarkerSize',10);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],REMS_episode_duration_RW_averages,REMS_episode_duration_RW_SEM,'k');

h3=plot([1:5],REMS_episode_duration_AW_averages,'k',[1:5],REMS_episode_duration_AW_averages,'ko','MarkerSize',10);
 
h4=errorbar([1:5],REMS_episode_duration_AW_averages,REMS_episode_duration_AW_SEM,'k');

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
title('Experimental Data')


% --- FIGURE SHOWING AVERAGE DAILY PERCENTAGE OF TIME SPENT IN EACH SLEEP STATE
% ------ TOP PANEL -----------------
figure
h1=plot([1:5],100*daily_percent_in_wake_RW_averages,'k',[1:5],100*daily_percent_in_wake_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_wake_RW_averages,100*daily_percent_in_wake_RW_SEM,'k');

h3=plot([1:5],100*daily_percent_in_wake_AW_averages,'k',[1:5],100*daily_percent_in_wake_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_wake_AW_averages,100*daily_percent_in_wake_AW_SEM,'k');

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
title('Experimental Data')

% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],100*daily_percent_in_sws_RW_averages,'k',[1:5],100*daily_percent_in_sws_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_sws_RW_averages,100*daily_percent_in_sws_RW_SEM,'k');

h3=plot([1:5],100*daily_percent_in_sws_AW_averages,'k',[1:5],100*daily_percent_in_sws_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_sws_AW_averages,100*daily_percent_in_sws_AW_SEM,'k');

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
title('Experimental Data')

% --- BOTTOM PANEL ----------------------------------------------
figure
h1=plot([1:5],100*daily_percent_in_REMS_RW_averages,'k',[1:5],100*daily_percent_in_REMS_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*daily_percent_in_REMS_RW_averages,100*daily_percent_in_REMS_RW_SEM,'k');

h3=plot([1:5],100*daily_percent_in_REMS_AW_averages,'k',[1:5],100*daily_percent_in_REMS_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],100*daily_percent_in_REMS_AW_averages,100*daily_percent_in_REMS_AW_SEM,'k');

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
title('Experimental Data')
