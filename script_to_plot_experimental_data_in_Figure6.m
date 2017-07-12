% script to plot the experimental data in Figure 6 of the experimental shift work paper (J Biol Rhythms)


load 'FIG6_Experimental_Data.mat'



figure

% -------
% ------- TOP PANEL ---------------
h1=plot([1:5],wake_episodes_RW_averages,'k',[1:5],wake_episodes_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],wake_episodes_RW_averages,wake_episode_RW_SEM,'k');

h3=plot([1:5],wake_episodes_AW_averages,'k',[1:5],wake_episodes_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],wake_episodes_AW_averages,wake_episode_AW_SEM,'k');

axis([0 5.5 80 240])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel('Number of wake episodes')


% --------
% ------ MIDDLE PANEL -----------------
figure
h1=plot([1:5],SWS_episode_duration_RW_averages,'k',[1:5],SWS_episode_duration_RW_averages,'ko','MarkerSize',12);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],SWS_episode_duration_RW_averages,SWS_episode_duration_RW_SEM,'k');

h3=plot([1:5],SWS_episode_duration_AW_averages,'k',[1:5],SWS_episode_duration_AW_averages,'ko','MarkerSize',12);
 
h4=errorbar([1:5],SWS_episode_duration_AW_averages,SWS_episode_duration_AW_SEM,'k');

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',14)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
ax.YTick = [100 150 200 250 300]
ax.LineWidth = 1.5;
ax.FontSize = 16;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'SWS'; '(episode duration, seconds)'})


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
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'}
ax.YTick = [80 90 100 110 120 130 140]
ax.LineWidth = 1.5;
ax.FontSize = 12;
set(gca,'box','off')
set(gca,'color','none')
ylabel({'REM sleep'; '(episode duration, seconds)'})