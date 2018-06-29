% this script makes the plots of episode duration vs time for all 3 sleep states for REMS, SWS, and Wake
% using baseline data from the rodent shift work protocol. 

% data from All animals_BoutAnalysis_720-Epochs_RepMeasure_sum across days_720 epochs.xlsx

Wake_bout_durations_v_time = [7.630662376 7.802034307 11.26791834 9.504582601 9.310286907 12.75727317 27.55413731 50.8186119 54.88536156 39.82994988 65.63322457 57.79895497];
REMS_bout_durations_v_time = [9.222668632	11.37911563	12.07333985	12.81372254	12.04456048	11.41994389	8.368829838	6.489906205	5.629611111	6.314293651	5.555916306	4.878205128];
SWS_bout_durations_v_time = [21.11506546	22.91747104	21.32665708	18.17131644	18.54230042	15.04448216	12.62697578	11.33678767	14.00730351	13.32470845	14.02713546	15.40939368];

Wake_bout_durations_v_time_std = [0.817554736	1.187299704	1.592564129	1.326212075	0.828307291	1.349799907	2.054857019	11.903705	7.529903162	5.939266142	29.65074922	8.161591592];
REMS_bout_durations_v_time_std = [0.38401016	0.473191789	0.764951953	0.780768951	0.72880538	0.713736714	0.639016378	0.444451992	0.604284658	0.321333088	0.462291554	0.40053159];
SWS_bout_durations_v_time_std = [1.050873555	1.996437701	1.208392701	1.018592957	1.360712647	0.747096559	0.758993346	0.670290348	0.928434531	0.82692233	0.715391039	1.01707491];

fontsize = 18;
line_thickness = 2;
markersize = 4;
line_color = [0, 0.45, 0.74]

time = 1:2:23

figure
h=plot(time,10*REMS_bout_durations_v_time,time,10*REMS_bout_durations_v_time,'o','MarkerSize',markersize);
hold on 
h2=errorbar(time,10*REMS_bout_durations_v_time,10*REMS_bout_durations_v_time_std,'Color',line_color);
%plot(time,10*REMS_bout_durations_v_time,'LineWidth',line_thickness)
hold off
set(h,'LineWidth',line_thickness)
set(h,'Color',line_color)
set(h2,'MarkerFaceColor',line_color)
set(h2,'MarkerEdgeColor','none')
ha=gca;
ha.FontSize = fontsize;
ha.LineWidth = line_thickness;
set(gca,'XTick',0:4:24);
set(gca,'box','off')
set(gca,'color','none')
xlabel('TIME [H]')
ylabel('Average Episode Duration (s)')
title('REMS')

figure
h=plot(time,10*SWS_bout_durations_v_time,time,10*SWS_bout_durations_v_time,'o','MarkerSize',markersize);
hold on 
h2=errorbar(time,10*SWS_bout_durations_v_time,10*SWS_bout_durations_v_time_std,'Color',line_color);
%plot(time,10*REMS_bout_durations_v_time,'LineWidth',line_thickness)
hold off
set(h,'LineWidth',line_thickness)
set(h,'Color',line_color)
set(h2,'MarkerFaceColor',line_color)
set(h2,'MarkerEdgeColor','none')
ha=gca;
ha.FontSize = fontsize;
ha.LineWidth = line_thickness;
set(gca,'XTick',0:4:24);
set(gca,'box','off')
set(gca,'color','none')
xlabel('TIME [H]')
ylabel('Average Episode Duration (s)')
title('SWS')
% plot(time,10*SWS_bout_durations_v_time,'LineWidth',line_thickness)
% ha=gca;
% ha.FontSize = fontsize;
% ha.LineWidth = line_thickness;
% set(gca,'XTick',0:4:24);
% set(gca,'box','off')
% set(gca,'color','none')
% xlabel('TIME [H]')
% ylabel('Average Episode Duration (s)')
% title('SWS')

figure
h=plot(time,10*Wake_bout_durations_v_time,time,10*Wake_bout_durations_v_time,'o','MarkerSize',markersize);
hold on 
h2=errorbar(time,10*Wake_bout_durations_v_time,10*Wake_bout_durations_v_time_std,'Color',line_color);
%plot(time,10*REMS_bout_durations_v_time,'LineWidth',line_thickness)
hold off
set(h,'LineWidth',line_thickness)
set(h,'Color',line_color)
set(h2,'MarkerFaceColor',line_color)
set(h2,'MarkerEdgeColor','none')
ha=gca;
ha.FontSize = fontsize;
ha.LineWidth = line_thickness;
set(gca,'XTick',0:4:24);
set(gca,'box','off')
set(gca,'color','none')
xlabel('TIME [H]')
ylabel('Average Episode Duration (s)')
title('Wake')

% plot(time,10*Wake_bout_durations_v_time,'LineWidth',line_thickness)
% ha=gca;
% ha.FontSize = fontsize;
% ha.LineWidth = line_thickness;
% set(gca,'XTick',0:4:24);
% set(gca,'box','off')
% set(gca,'color','none')
% xlabel('TIME [H]')
% ylabel('Average Episode Duration (s)')
% title('Wake')

