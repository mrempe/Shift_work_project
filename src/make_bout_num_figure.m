function make_bout_num_figure(plotparams,num,stds,p_vals)


figure
set(gcf,'Position',[50, 50, 1110, 950]);
p=panel();
p.pack(3,2);
p.fontsize = plotparams.axFontSize;

% % set spacing between panels
p.fa.margin       = 2;
p.fa.marginleft   = 28;
p.fa.margintop    = 15;
p.fa.marginbottom = 10;
p(1,2).marginleft = 30;
p(2,2).marginleft = 30;
p(3,2).marginleft = 30;

% ------- TOP LEFT PANEL ---------------
%subplot(3,2,1)  
p(1,1).select();
dataAW = num.wake_episodes_AW_averages;
dataRW = num.wake_episodes_RW_averages;
stdAW  = num.wake_episodes_AW_SEM;
stdRW  = num.wake_episodes_RW_SEM;
h1     = plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2 = errorbar([1:5],dataRW,stdRW,'k');
h3 = plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
h4 = errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth    = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth    = plotparams.linewidth;

axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend = legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',plotparams.legend_fontsize)
ax = gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = plotparams.axlinewidth;
set(gca,'LineWidth',plotparams.linewidth);
ax.FontSize = plotparams.axFontSize;
ax.XColor   = 'none';
set(gca,'box','off')
set(gca,'color','none')
%pbaspect(ax,[3 1 1])
yl = p(1,1).ylabel({'Wake episodes';'(numbers)'});
yl.FontWeight = 'bold';
tle = p(1,1).title('Experimental Data');
tle.FontSize = plotparams.title_fontsize;
t2 = text(1.8,146.5,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = plotparams.axFontSize;
t3 = text(1.8,89.9,'###');
t3.FontSize = plotparams.axFontSize;
t4 = text(2.8,160,'###'); 
t4.FontSize = plotparams.axFontSize;
t5 = text(2.8,89.7,'###');
t5.FontSize = plotparams.axFontSize;
t6 = text(3.8,153.5,'###'); 
t6.FontSize = plotparams.axFontSize;
t7 = text(3.8,95,'###');
t7.FontSize = plotparams.axFontSize;
t8 = text(4.8,165,'###'); 
t8.FontSize = plotparams.axFontSize;
t9 = text(4.8,97.3,'###');
t9.FontSize = plotparams.axFontSize;
t10 = text(-1.2,265,'A');
t10.FontSize = plotparams.panel_label_fontsize;
 
% % --- TOP RIGHT PANEL ---------------
% %subplot(3,2,2)
p(1,2).select();
dataAW = num.wake_episodesAWsim;
dataRW = num.wake_episodesRWsim;
stdAW  = stds.wake_episode_duration_vs_timeRWsim./sqrt(50);  % divide by sqrt of # of simulations to get SEM, not std
stdRW  = stds.wake_episode_duration_vs_timeAWsim./sqrt(50);
h5=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',plotparams.markersize);
set(h5(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h6 = errorbar([1:5],dataRW,stdRW,'k');
h7 = plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',plotparams.markersize);
h8 = errorbar([1:5],dataAW,stdAW,'k');
h5(1).LineWidth = plotparams.linewidth;
h5(2).LineWidth = plotparams.linewidth;
h6.LineWidth    = plotparams.linewidth;
h7(1).LineWidth = plotparams.linewidth;
h7(2).LineWidth = plotparams.linewidth;
h8.LineWidth    = plotparams.linewidth;
axis([0 5.5 80 250])
set(get(get(h5(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h6,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h7(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h8,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
%pbaspect(ax,[3 1 1])
yl = p(1,2).ylabel({'Wake episodes'; '(numbers)'});
yl.FontWeight = 'bold';
tle=p(1,2).title('Simulation Output');
tle.FontSize = plotparams.title_fontsize;
significance_num_w_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num.wake_episodes_AW_averages,num.wake_episodes_AW_SEM*sqrt(50),...
							   num.wake_episodes_RW_averages,num.wake_episodes_RW_SEM*sqrt(50),p,1,2,ax)
hold off




% % ------- MIDDLE LEFT PANEL ---------------
% %subplot(3,2,3)
p(2,1).select();
dataAW = num.sws_episodes_AW_averages;
dataRW = num.sws_episodes_RW_averages;
stdAW  = num.sws_episodes_AW_SEM;
stdRW  = num.sws_episodes_RW_SEM;

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
axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=p(2,1).ylabel({'SWS episodes';'(numbers)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
add_hashtags_and_stars_to_figure(p_vals.SWS_num_ep_to_baseline_AW,p_vals.SWS_num_ep_to_baseline_RW, ...
								 p_vals.SWS_num_ep_strains,dataAW,dataRW,p,2,1,ax);
t10 = text(-1.2,265,'B');
t10.FontSize = plotparams.panel_label_fontsize;
hold off
 

% % ---- MIDDLE RIGHT PANEL --------------
% %subplot(3,2,4)
p(2,2).select();
dataAW = num.sws_episodesAWsim;
dataRW = num.sws_episodesRWsim;
stdAW  = stds.sws_episodes_vs_timeAWsim./sqrt(50);
stdRW  = stds.sws_episodes_vs_timeRWsim./sqrt(50);

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
axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=p(2,2).ylabel({'SWS episodes';'(numbers)'});
yl.FontWeight = 'bold';
significance_num_sws_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num.sws_episodes_AW_averages,num.sws_episodes_AW_SEM*sqrt(50),...
							   num.sws_episodes_RW_averages,num.sws_episodes_RW_SEM*sqrt(50),p,2,2,ax)
hold off

% ------- BOTTOM LEFT PANEL ---------------
%subplot(3,2,5)
p(3,1).select();
dataAW = num.REMS_episodes_AW_averages;
dataRW = num.REMS_episodes_RW_averages;
stdAW  = num.REMS_episodes_AW_SEM;
stdRW  = num.REMS_episodes_RW_SEM;
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
axis([0 5.5 30 110])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30 50 70 90 110];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl=p(3,1).ylabel({'REMS episodes';'(numbers)'});
yl.FontWeight = 'bold';
add_hashtags_and_stars_to_figure(p_vals.REMS_num_ep_to_baseline_AW,p_vals.REMS_num_ep_to_baseline_RW, ...
								 p_vals.REMS_num_ep_strains,dataAW,dataRW,p,3,1,ax);
t10 = text(-1.2,114,'C');
t10.FontSize = plotparams.panel_label_fontsize;
hold off 


% ------- BOTTOM RIGHT PANEL ---------------
%subplot(3,2,6)
p(3,2).select();
dataAW = num.rems_episodesAWsim;
dataRW = num.rems_episodesRWsim;
stdAW  = stds.rems_episodes_vs_timeAWsim./sqrt(50);
stdRW  = stds.rems_episodes_vs_timeRWsim./sqrt(50);
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
axis([0 5.5 30 110])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30 50 70 90 110];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl =p(3,2).ylabel({'REMS episodes';'(numbers)'});
yl.FontWeight = 'bold';
significance_num_r_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num.REMS_episodes_AW_averages,num.REMS_episodes_AW_SEM*sqrt(50),...
							   num.REMS_episodes_RW_averages,num.REMS_episodes_RW_SEM*sqrt(50),p,3,2,ax)
hold off



