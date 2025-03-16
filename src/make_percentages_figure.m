function make_percentages_figure(plotparams,daily_percent,stds)



figure
set(gcf,'Position',[50, 50, 1110, 950]);
pb=panel();
pb.pack(3,2);
pb.fontsize = plotparams.axFontSize;

pb.fa.margin = 2;
pb.fa.marginleft = 28;
pb.fa.margintop  = 15;
pb.fa.marginbottom = 10;

pb(1,2).marginleft = 30;
pb(2,2).marginleft = 30;
pb(3,2).marginleft = 30;


% ------ TOP LEFT PANEL -----------------
pb(1,1).select();
dataAW = daily_percent.in_wake_AW_averages;
dataRW = daily_percent.in_wake_RW_averages;
stdAW = daily_percent.in_wake_AW_SEM;
stdRW = daily_percent.in_wake_RW_SEM;
%subplot(3,1,1)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 30 80])
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
ax.YTick = [30:10:80];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=ylabel({'% of time'; 'spent in Wake'});
yl.FontWeight = 'bold';
tle = pb(1,1).title('Experimental Data');
tle.FontSize = plotparams.title_fontsize;
significance_w_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,1,1,ax);
ta=text(-1.2,84,'A');
ta.FontSize = plotparams.panel_label_fontsize;


% ------ TOP RIGHT PANEL -----------------
pb(1,2).select();
dataAW = daily_percent.in_wake_AWsim;
dataRW = daily_percent.in_wake_RWsim;
stdAW = stds.daily_percent_in_wake_AWsim./sqrt(50);
stdRW = stds.daily_percent_in_wake_RWsim./sqrt(50);

%subplot(3,1,1)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW ,100*stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 30 80])
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
ax.YTick = [30 40 50 60 70 80];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(1,2).ylabel({'% of time'; 'spent in Wake'});
yl.FontWeight = 'bold';
tle = pb(1,2).title('Simulation Output');
tle.FontSize = plotparams.title_fontsize;
significance_w_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent.in_wake_AW_averages,daily_percent.in_wake_AW_SEM*sqrt(50),...
							   daily_percent.in_wake_RW_averages,daily_percent.in_wake_RW_SEM*sqrt(50),pb,1,2,ax)

% ------ MIDDLE LEFT PANEL -----------------
pb(2,1).select();
dataAW = daily_percent.in_sws_AW_averages;
dataRW = daily_percent.in_sws_RW_averages;
stdAW  = daily_percent.in_sws_AW_SEM;
stdRW  = daily_percent.in_sws_RW_SEM;


%subplot(3,1,2)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;
axis([0 5.5 20 60]);
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
ax.YTick = [20 30 40 50 60];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(2,1).ylabel({'% of time'; 'spent in SWS'});
yl.FontWeight = 'bold';
significance_sws_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,2,1,ax);
tb = text(-1.2,62.5,'B');
tb.FontSize = plotparams.panel_label_fontsize;


% ------ MIDDLE RIGHT PANEL -----------------
pb(2,2).select();
dataAW = daily_percent.in_sws_AWsim;
dataRW = daily_percent.in_sws_RWsim;
stdAW = stds.daily_percent_in_sws_AWsim./sqrt(50);
stdRW = stds.daily_percent_in_sws_RWsim./sqrt(50);


%subplot(3,1,2)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;

axis([0 5.5 20 60]);
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
ax.YTick = [20 30 40 50 60];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(2,2).ylabel({'% of time'; 'spent in SWS'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_sws_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent.in_sws_AW_averages,daily_percent.in_sws_AW_SEM*sqrt(50),...
							   daily_percent.in_sws_RW_averages,daily_percent.in_sws_RW_SEM*sqrt(50),pb,2,2,ax)

% --- BOTTOM LEFT PANEL ----------------------------------------------
%subplot(3,1,3)
pb(3,1).select();
dataAW = daily_percent.in_REMS_AW_averages;
dataRW = daily_percent.in_REMS_RW_averages;
stdAW  = daily_percent.in_REMS_AW_SEM;
stdRW  = daily_percent.in_REMS_RW_SEM;


h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;

axis([0 5.5 0 15]);
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
ax.YTick = [0 5 10 15];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pb(3,1).ylabel({'% of time'; 'spent in REMS'});
yl.FontWeight = 'bold';
significance_rems_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,3,1,ax);
tc = text(-1.2,16,'C');
tc.FontSize = plotparams.panel_label_fontsize;


% --- BOTTOM RIGHT PANEL ----------------------------------------------
%subplot(3,1,3)
pb(3,2).select();
dataAW = daily_percent.in_rems_AWsim;
dataRW = daily_percent.in_rems_RWsim;
stdAW = stds.daily_percent_in_rems_AWsim./sqrt(50);
stdRW = stds.daily_percent_in_rems_RWsim./sqrt(50);

h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',plotparams.markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',plotparams.markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
axis([0 5.5 0 15]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

h1(1).LineWidth = plotparams.linewidth;
h1(2).LineWidth = plotparams.linewidth;
h2.LineWidth = plotparams.linewidth;
h3(1).LineWidth = plotparams.linewidth;
h3(2).LineWidth = plotparams.linewidth;
h4.LineWidth = plotparams.linewidth;

% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',plotparams.legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 5 10 15 ];
ax.LineWidth = plotparams.axlinewidth;
ax.FontSize = plotparams.axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pb(3,2).ylabel({'% of time'; 'spent in REMS'});
yl.FontWeight = 'bold';
significance_rems_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent.in_REMS_AW_averages,daily_percent.in_REMS_AW_SEM*sqrt(50),...
							   daily_percent.in_REMS_RW_averages,daily_percent.in_REMS_RW_SEM*sqrt(50),pb,3,2,ax)

