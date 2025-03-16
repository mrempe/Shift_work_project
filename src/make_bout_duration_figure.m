function make_bout_duration_figure(plotparams,means,stds,episode_duration,p_vals)



% ------ TOP PANEL -----------------
figure
set(gcf,'Position',[50, 50, 1110 950]);
pa=panel();
pa.pack(3,2);
pa.fontsize = plotparams.axFontSize;

% % set spacing between panels
pa.fa.margin = 2;
pa.fa.marginleft = 28;
pa.fa.margintop = 15;
pa.fa.marginbottom = 10;
pa(1,2).marginleft = 30;
pa(2,2).marginleft = 30;
pa(3,2).marginleft = 30;
% ------- TOP LEFT PANEL ---------------
%subplot(3,2,1)  
pa(1,1).select();
dataAW = episode_duration.wake_AW_averages;
dataRW = episode_duration.wake_RW_averages;
stdAW  = episode_duration.wake_AW_SEM;
stdRW  = episode_duration.wake_RW_SEM;
%subplot(3,1,1)
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 100 500])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400 500];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(1,1).ylabel({'Wake'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
tle = title('Experimental Data');
tle.FontSize = plotparams.title_fontsize;
add_hashtags_and_stars_to_figure(p_vals.W_ep_duration_to_baseline_AW,p_vals.W_ep_duration_to_baseline_RW, ...
								 p_vals.W_ep_duration_strains,dataAW,dataRW,pa,1,1,ax);
ta = text(-1.2,540,'A');
ta.FontSize = plotparams.panel_label_fontsize;

% ------- TOP RIGHT PANEL ---------------
%subplot(3,2,1)  
pa(1,2).select();
dataAW = means.wake_lengthAWsim;
dataRW = means.wake_lengthRWsim;
stdRW = stds.wake_episode_duration_vs_timeRWsim./sqrt(50);
stdAW = stds.wake_episode_duration_vs_timeAWsim./sqrt(50);
%subplot(3,1,1)
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 100 500])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400 500];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(1,2).ylabel({'Wake'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
tle = pa(1,2).title('Simulation Output');
tle.FontSize = plotparams.title_fontsize;
significance_w_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),episode_duration.wake_AW_averages,episode_duration.wake_AW_SEM*sqrt(50),...
							   episode_duration.wake_RW_averages,episode_duration.wake_RW_SEM*sqrt(50),pa,1,2,ax)

% --------
% ------ MIDDLE LEFT PANEL -----------------
%subplot(3,1,2)
pa(2,1).select();
dataAW = episode_duration.SWS_AW_averages;
dataRW = episode_duration.SWS_RW_averages;
stdAW = episode_duration.SWS_AW_SEM;
stdRW = episode_duration.SWS_RW_SEM;

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(2,1).ylabel({'SWS'; 'episode duration, (s)'});
yl.FontWeight = 'bold';

t2 = text(1.8,187.4,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = plotparams.axFontSize;
t3 = text(1.8,297,'###');
t3.FontSize = plotparams.axFontSize;
t4 = text(2.8,302,'###'); 
t4.FontSize = plotparams.axFontSize;
t5 = text(2.8,175.5,'###');
t5.FontSize = plotparams.axFontSize;
t6 = text(3.8,177,'###'); 
t6.FontSize = plotparams.axFontSize;
t7 = text(3.8,258,'###');
t7.FontSize = plotparams.axFontSize;
t8 = text(4.8,272,'###'); 
t8.FontSize = plotparams.axFontSize;
t9 = text(4.8,150,'###');
t9.FontSize = plotparams.axFontSize;
t10 = text(1.9,152.4,'*');
t10.FontSize = 30;
t11 = text(2.9,140.5,'*');
t11.FontSize = 30;
t12 = text(4.9,115,'*');
t12.FontSize = 30;
tb = text(-1.2,320,'B');
tb.FontSize = plotparams.panel_label_fontsize;

% ------ MIDDLE RIGHT PANEL -----------------
%subplot(3,1,2)
pa(2,2).select();
dataAW = means.sws_lengthAWsim;
dataRW = means.sws_lengthRWsim;
stdAW  = stds.sws_episode_duration_vs_timeAWsim./sqrt(50);
stdRW  = stds.sws_episode_duration_vs_timeRWsim./sqrt(50);
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(2,2).ylabel({'SWS'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_sws_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),episode_duration.SWS_AW_averages,episode_duration.SWS_AW_SEM*sqrt(50),...
							   episode_duration.SWS_RW_averages,episode_duration.SWS_RW_SEM*sqrt(50),pa,2,2,ax)
% --------
% ------- BOTTOM LEFT PANEL ----------------
%subplot(3,1,3)
pa(3,1).select();
dataAW = episode_duration.REMS_AW_averages;
dataRW = episode_duration.REMS_RW_averages;
stdAW  = episode_duration.REMS_AW_SEM;
stdRW  = episode_duration.REMS_RW_SEM;

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend3=legend('RW','AW');
% legend boxoff
% set(h_legend3,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pa(3,1).ylabel({'REM sleep'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
t2 = text(1.8,105,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = plotparams.axFontSize;
t3 = text(1.8,136,'###');
t3.FontSize = plotparams.axFontSize;
t4 = text(2.8,128.7,'###'); 
t4.FontSize = plotparams.axFontSize;
t5 = text(2.8,103,'###');
t5.FontSize = plotparams.axFontSize;
t6 = text(3.8,127,'###'); 
t6.FontSize = plotparams.axFontSize;
t7 = text(3.8,103.5,'###');
t7.FontSize = plotparams.axFontSize;
t8 = text(4.8,136,'###'); 
t8.FontSize = plotparams.axFontSize;
t9 = text(4.8,95,'###');
t9.FontSize = plotparams.axFontSize;
t10 = text(4.9,85,'*');
t10.FontSize = 30;
tc = text(-1.2,142,'C');
tc.FontSize = plotparams.panel_label_fontsize;

% ------- BOTTOM RIGHT PANEL ----------------
%subplot(3,1,3)
pa(3,2).select();
dataAW = means.rems_lengthAWsim;
dataRW = means.rems_lengthRWsim;
stdAW  = stds.rems_episodes_vs_timeAWsim./sqrt(50);
stdRW  = stds.rems_episodes_vs_timeRWsim./sqrt(50); 
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend3=legend('RW','AW');
% legend boxoff
% set(h_legend3,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl=pa(3,2).ylabel({'REM sleep'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_rems_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),episode_duration.REMS_AW_averages,episode_duration.REMS_AW_SEM*sqrt(50),...
							   episode_duration.REMS_RW_averages,episode_duration.REMS_RW_SEM*sqrt(50),pa,3,2,ax)



