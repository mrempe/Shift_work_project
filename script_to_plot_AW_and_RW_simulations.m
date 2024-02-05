% script to run the two_process_model_with_markov_chain once for the AW case and once for the RW 
% case and make three figures:  1) plot wake duration vs day for both AW and RW
%								2) SWS episode duration for AW and RW
%								3) REMS episode duration for AW and RW


%addpath '\\FS1\WisorData\MATLAB\Rempe\Matlab_utilities\panel'

load 'all_experimental_data.mat'

load 'p_vals_experimental_data.mat'

load 'optimized_values_baseline_and_work_1.5.mat'  % for K_optimized_for_AW_during_work_1_5 and K_optimized_for_RW_during_work_1_5 

compute_transitions = 0;  % flag to call code to make a table of state transitions
only_make_plots = 0;

if (only_make_plots == 0)





input_paramsAW.taui_baseline  = 17.159;%K_taui_taud_gamma_baseline_AW.values(1);
input_paramsAW.taud_baseline  =2.18 ; %K_taui_taud_gamma_baseline_AW.values(2); %K_optimized_using_AW.values(taudA_idx);  %4.5;
input_paramsAW.taui_work = K_optimized_for_AW_during_work_1_5.values(1);
input_paramsAW.taud_work = K_optimized_for_AW_during_work_1_5.values(2);
%input_paramsAW.gamma = K_optimized_for_AW_during_work.values(3);
input_paramsAW.gamma = 1;  % unused. remove


input_paramsAW.alertness_duration_scale_factor_B = 0.6;  %0.6 is optimized value for baseline
input_paramsAW.sleepiness_duration_scale_factor_SWS_B = 1.133; %1.133 is optimized value for baseline
input_paramsAW.sleepiness_duration_scale_factor_REMS_B = 1.1;  %1.1 is optimized value for baseline
input_paramsAW.alertness_duration_scale_factor_W = 0.7; %K_optimized_for_AW_during_work_1_5.values(3);  %0.88;  %0.6 is optimized value for baseline
input_paramsAW.sleepiness_duration_scale_factor_SWS_W = K_optimized_for_AW_during_work_1_5.values(4);  %1.2117; %1.133 is optimized value for baseline
input_paramsAW.sleepiness_duration_scale_factor_REMS_W = K_optimized_for_AW_during_work_1_5.values(5);  %1.3697;  %1.1 is optimized value for baseline

input_paramsRW.taui_baseline = 17.159; %K_taui_taud_gamma_baseline_AW.values(1);
input_paramsRW.taud_baseline = 2.18; %K_taui_taud_gamma_baseline_AW.values(2); 
input_paramsRW.taui_work = K_optimized_for_RW_during_work_1_5.values(1);
input_paramsRW.taud_work = K_optimized_for_RW_during_work_1_5.values(2);
%input_paramsRW.gamma = K_optimized_for_RW_during_work.values(3);
input_paramsRW.gamma = 1;  %unused.  remove.  

input_paramsRW.alertness_duration_scale_factor_B = 0.6;  %0.6 is optimized value for baseline
input_paramsRW.sleepiness_duration_scale_factor_SWS_B = 1.133;  % 1.133 is optimized value for baseline
input_paramsRW.sleepiness_duration_scale_factor_REMS_B = 1.1;  %1.1 is optimized value for baseline
input_paramsRW.alertness_duration_scale_factor_W = 0.7; %K_optimized_for_AW_during_work_1_5.values(3);  %0.6 is optimized value for baseline
input_paramsRW.sleepiness_duration_scale_factor_SWS_W = K_optimized_for_AW_during_work_1_5.values(4);  % 1.133 is optimized value for baseline
input_paramsRW.sleepiness_duration_scale_factor_REMS_W = K_optimized_for_AW_during_work_1_5.values(5);  %1.1 is optimized value for baseline



[S_AW,sleepstateAW,long_wake_timingsAW,sleep_averagesAW,sleep_stdAW] = two_process_model_with_markov_chain(134,input_paramsAW,'AW',1);
[S_RW,sleepstateRW,long_wake_timingsRW,sleep_averagesRW,sleep_stdRW] = two_process_model_with_markov_chain(134,input_paramsRW,'RW',1);


if compute_transitions
	latexAW = generate_transition_tables(sleep_averagesAW,sleep_stdAW,'AW');
	latexRW = generate_transition_tables(sleep_averagesRW,sleep_stdRW,'RW');
end


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


end 
% some parameters for all the panels: linewidth, font sizes, etc. 
markersize = 12;
legend_fontsize = 14;
axFontSize = 14;
axlinewidth = 2;
linewidth = 1.5;
title_fontsize = 16;
panel_label_fontsize = 22;


% --------------------------------------------------------------------------
% ------- first figure, number of wake episodes, SWS episodes, REMS episodes
figure
set(gcf,'Position',[50, 50, 1110, 950]);
p=panel();
p.pack(3,2);
p.fontsize = axFontSize;
% p.de.margin = 2;
% p.fa.margintop = 10;
% p.fa.marginbottom = 10;
% p(1,2).marginleft = 30;
% p(2,2).marginleft = 30;
% p(3,2).marginleft = 30;

% p.pack(3,2);
% %p.pack('h',{1/3 })
% %p.pack({0.4 []},{0.2 []},{0.4 []});
% p.fontsize = axFontSize;
% % set spacing between panels
p.fa.margin = 2;
p.fa.marginleft = 28;
p.fa.margintop = 15;
p.fa.marginbottom = 10;
p(1,2).marginleft = 30;
p(2,2).marginleft = 30;
p(3,2).marginleft = 30;

% ------- TOP LEFT PANEL ---------------
%subplot(3,2,1)  
p(1,1).select();
dataAW = num_wake_episodes_AW_averages;
dataRW = num_wake_episodes_RW_averages;
stdAW = num_wake_episodes_AW_SEM;
stdRW = num_wake_episodes_RW_SEM;
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');
h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = axlinewidth;
set(gca,'LineWidth',linewidth);
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
%pbaspect(ax,[3 1 1])
yl=p(1,1).ylabel({'Wake episodes';'(numbers)'});
yl.FontWeight = 'bold';
tle = p(1,1).title('Experimental Data');
tle.FontSize = title_fontsize;
t2 = text(1.8,146.5,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = axFontSize;
t3 = text(1.8,89.9,'###');
t3.FontSize = axFontSize;
t4 = text(2.8,160,'###'); 
t4.FontSize = axFontSize;
t5 = text(2.8,89.7,'###');
t5.FontSize = axFontSize;
t6 = text(3.8,153.5,'###'); 
t6.FontSize = axFontSize;
t7 = text(3.8,95,'###');
t7.FontSize = axFontSize;
t8 = text(4.8,165,'###'); 
t8.FontSize = axFontSize;
t9 = text(4.8,97.3,'###');
t9.FontSize = axFontSize;
t10 = text(-1.2,265,'A');
t10.FontSize = panel_label_fontsize;
 
% --- TOP RIGHT PANEL ---------------
%subplot(3,2,2)
p(1,2).select();
dataAW = num_wake_episodesAWsim;
dataRW = num_wake_episodesRWsim;
stdAW  = std_wake_episode_duration_vs_timeRWsim./sqrt(50);  % divide by sqrt of # of simulations to get SEM, not std
stdRW  = std_wake_episode_duration_vs_timeAWsim./sqrt(50);
h5=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h5(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h6=errorbar([1:5],dataRW,stdRW,'k');
h7=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
h8=errorbar([1:5],dataAW,stdAW,'k');
h5(1).LineWidth = linewidth;
h5(2).LineWidth = linewidth;
h6.LineWidth = linewidth;
h7(1).LineWidth = linewidth;
h7(2).LineWidth = linewidth;
h8.LineWidth = linewidth;
axis([0 5.5 80 250])
set(get(get(h5(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h6,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h7(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h8,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend=legend('RW','AW');
legend boxoff
set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
%pbaspect(ax,[3 1 1])
yl = p(1,2).ylabel({'Wake episodes'; '(numbers)'});
yl.FontWeight = 'bold';
tle=p(1,2).title('Simulation Output');
tle.FontSize = title_fontsize;
significance_num_w_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num_wake_episodes_AW_averages,num_wake_episodes_AW_SEM*sqrt(50),...
							   num_wake_episodes_RW_averages,num_wake_episodes_RW_SEM*sqrt(50),p,1,2,ax)
hold off




% ------- MIDDLE LEFT PANEL ---------------
%subplot(3,2,3)
p(2,1).select();
dataAW = num_sws_episodes_AW_averages;
dataRW = num_sws_episodes_RW_averages;
stdAW  = num_sws_episodes_AW_SEM;
stdRW  = num_sws_episodes_RW_SEM;

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');
h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=p(2,1).ylabel({'SWS episodes';'(numbers)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
add_hashtags_and_stars_to_figure(p_vals_SWS_num_ep_to_baseline_AW,p_vals_SWS_num_ep_to_baseline_RW, ...
								 p_vals_SWS_num_ep_strains,dataAW,dataRW,p,2,1,ax);
t10 = text(-1.2,265,'B');
t10.FontSize = panel_label_fontsize;
hold off
 

% ---- MIDDLE RIGHT PANEL --------------
%subplot(3,2,4)
p(2,2).select();
dataAW = num_sws_episodesAWsim;
dataRW = num_sws_episodesRWsim;
stdAW  = std_sws_episodes_vs_timeAWsim./sqrt(50);
stdRW  = std_sws_episodes_vs_timeRWsim./sqrt(50);

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');
h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 80 250])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80:20:240];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=p(2,2).ylabel({'SWS episodes';'(numbers)'});
yl.FontWeight = 'bold';
significance_num_sws_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num_sws_episodes_AW_averages,num_sws_episodes_AW_SEM*sqrt(50),...
							   num_sws_episodes_RW_averages,num_sws_episodes_RW_SEM*sqrt(50),p,2,2,ax)
hold off

% ------- BOTTOM LEFT PANEL ---------------
%subplot(3,2,5)
p(3,1).select();
dataAW = num_REMS_episodes_AW_averages;
dataRW = num_REMS_episodes_RW_averages;
stdAW  = num_REMS_episodes_AW_SEM;
stdRW  = num_REMS_episodes_RW_SEM;
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 30 110])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30 50 70 90 110];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl=p(3,1).ylabel({'REMS episodes';'(numbers)'});
yl.FontWeight = 'bold';
add_hashtags_and_stars_to_figure(p_vals_REMS_num_ep_to_baseline_AW,p_vals_REMS_num_ep_to_baseline_RW, ...
								 p_vals_REMS_num_ep_strains,dataAW,dataRW,p,3,1,ax);
t10 = text(-1.2,114,'C');
t10.FontSize = panel_label_fontsize;
hold off 


% ------- BOTTOM RIGHT PANEL ---------------
%subplot(3,2,6)
p(3,2).select();
dataAW = num_rems_episodesAWsim;
dataRW = num_rems_episodesRWsim;
stdAW  = std_rems_episodes_vs_timeAWsim./sqrt(50);
stdRW  = std_rems_episodes_vs_timeRWsim./sqrt(50);
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 30 110])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend=legend('RW','AW');
% legend boxoff
% set(h_legend,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30 50 70 90 110];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl =p(3,2).ylabel({'REMS episodes';'(numbers)'});
yl.FontWeight = 'bold';
significance_num_r_ep_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),p,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),num_REMS_episodes_AW_averages,num_REMS_episodes_AW_SEM*sqrt(50),...
							   num_REMS_episodes_RW_averages,num_REMS_episodes_RW_SEM*sqrt(50),p,3,2,ax)
hold off



%-----------------------------------------------------------------------------
%---- END OF FIGURES SHOWING NUMBER OF EPISODES
% -----------------------------------------------------------------------------

% --- FIGURE SHOWING AVERAGE EPISODE DURATION FOR EACH SLEEP STATE
% ------ TOP PANEL -----------------
figure
set(gcf,'Position',[50, 50, 1110 950]);
pa=panel();
pa.pack(3,2);
pa.fontsize = axFontSize;
% pa.de.margin = 2;
% pa.fa.margintop = 10;
% pa.fa.marginbottom = 10;
% pa(1,2).marginleft = 30;
% pa(2,2).marginleft = 30;
% pa(3,2).marginleft = 30;

% pa.pack(3,2);
% %p.pack('h',{1/3 })
% %p.pack({0.4 []},{0.2 []},{0.4 []});
% pa.fontsize = axFontSize;
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
dataAW = wake_episode_duration_AW_averages;
dataRW = wake_episode_duration_RW_averages;
stdRW = wake_episode_duration_AW_SEM;
stdAW = wake_episode_duration_RW_SEM;
%subplot(3,1,1)
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 100 500])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400 500];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(1,1).ylabel({'Wake'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
tle = title('Experimental Data');
tle.FontSize = title_fontsize;
add_hashtags_and_stars_to_figure(p_vals_W_ep_duration_to_baseline_AW,p_vals_W_ep_duration_to_baseline_RW, ...
								 p_vals_W_ep_duration_strains,dataAW,dataRW,pa,1,1,ax);
ta = text(-1.2,540,'A');
ta.FontSize = panel_label_fontsize;

% ------- TOP RIGHT PANEL ---------------
%subplot(3,2,1)  
pa(1,2).select();
dataAW = mean_wake_lengthAWsim;
dataRW = mean_wake_lengthRWsim;
stdRW = std_wake_episode_duration_vs_timeRWsim./sqrt(50);
stdAW = std_wake_episode_duration_vs_timeAWsim./sqrt(50);
%subplot(3,1,1)
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 100 500])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 200 300 400 500];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(1,2).ylabel({'Wake'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
tle = pa(1,2).title('Simulation Output');
tle.FontSize = title_fontsize;
significance_w_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),wake_episode_duration_AW_averages,wake_episode_duration_AW_SEM*sqrt(50),...
							   wake_episode_duration_RW_averages,wake_episode_duration_RW_SEM*sqrt(50),pa,1,2,ax)

% --------
% ------ MIDDLE LEFT PANEL -----------------
%subplot(3,1,2)
pa(2,1).select();
dataAW = SWS_episode_duration_AW_averages;
dataRW = SWS_episode_duration_RW_averages;
stdRW = SWS_episode_duration_AW_SEM;
stdAW = SWS_episode_duration_RW_SEM;

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(2,1).ylabel({'SWS'; 'episode duration, (s)'});
yl.FontWeight = 'bold';

t2 = text(1.8,187.4,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = axFontSize;
t3 = text(1.8,297,'###');
t3.FontSize = axFontSize;
t4 = text(2.8,302,'###'); 
t4.FontSize = axFontSize;
t5 = text(2.8,175.5,'###');
t5.FontSize = axFontSize;
t6 = text(3.8,177,'###'); 
t6.FontSize = axFontSize;
t7 = text(3.8,258,'###');
t7.FontSize = axFontSize;
t8 = text(4.8,272,'###'); 
t8.FontSize = axFontSize;
t9 = text(4.8,150,'###');
t9.FontSize = axFontSize;
t10 = text(1.9,152.4,'*');
t10.FontSize = 30;
t11 = text(2.9,140.5,'*');
t11.FontSize = 30;
t12 = text(4.9,115,'*');
t12.FontSize = 30;
tb = text(-1.2,320,'B');
tb.FontSize = panel_label_fontsize;

% ------ MIDDLE RIGHT PANEL -----------------
%subplot(3,1,2)
pa(2,2).select();
dataAW = mean_sws_lengthAWsim;
dataRW = mean_sws_lengthRWsim;
stdAW  = std_sws_episode_duration_vs_timeAWsim./sqrt(50);
stdRW  = std_sws_episode_duration_vs_timeRWsim./sqrt(50);
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

axis([0 5.5 100 300])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [100 150 200 250 300];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl = pa(2,2).ylabel({'SWS'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_sws_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),SWS_episode_duration_AW_averages,SWS_episode_duration_AW_SEM*sqrt(50),...
							   SWS_episode_duration_RW_averages,SWS_episode_duration_RW_SEM*sqrt(50),pa,2,2,ax)
% --------
% ------- BOTTOM LEFT PANEL ----------------
%subplot(3,1,3)
pa(3,1).select();
dataAW = REMS_episode_duration_AW_averages;
dataRW = REMS_episode_duration_RW_averages;
stdRW = REMS_episode_duration_AW_SEM;
stdAW = REMS_episode_duration_RW_SEM;

h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend3=legend('RW','AW');
% legend boxoff
% set(h_legend3,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pa(3,1).ylabel({'REM sleep'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
t2 = text(1.8,105,'###');  % labels for ### symbol, differences from baseline
t2.FontSize = axFontSize;
t3 = text(1.8,136,'###');
t3.FontSize = axFontSize;
t4 = text(2.8,128.7,'###'); 
t4.FontSize = axFontSize;
t5 = text(2.8,103,'###');
t5.FontSize = axFontSize;
t6 = text(3.8,127,'###'); 
t6.FontSize = axFontSize;
t7 = text(3.8,103.5,'###');
t7.FontSize = axFontSize;
t8 = text(4.8,136,'###'); 
t8.FontSize = axFontSize;
t9 = text(4.8,95,'###');
t9.FontSize = axFontSize;
t10 = text(4.9,85,'*');
t10.FontSize = 30;
tc = text(-1.2,142,'C');
tc.FontSize = panel_label_fontsize;

% ------- BOTTOM RIGHT PANEL ----------------
%subplot(3,1,3)
pa(3,2).select();
dataAW = mean_rems_lengthAWsim;
dataRW = mean_rems_lengthRWsim;
stdAW  = std_rems_episodes_vs_timeAWsim./sqrt(50);
stdRW  = std_rems_episodes_vs_timeRWsim./sqrt(50); 
h1=plot([1:5],dataRW,'k',[1:5],dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],dataRW,stdRW,'k');

h3=plot([1:5],dataAW,'k',[1:5],dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],dataAW,stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 80 140])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend3=legend('RW','AW');
% legend boxoff
% set(h_legend3,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [80 90 100 110 120 130 140];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl=pa(3,2).ylabel({'REM sleep'; 'episode duration, (s)'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_rems_dur_sim = compare_strains_and_each_day_to_baseline(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),pa,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),REMS_episode_duration_AW_averages,REMS_episode_duration_AW_SEM*sqrt(50),...
							   REMS_episode_duration_RW_averages,REMS_episode_duration_RW_SEM*sqrt(50),pa,3,2,ax)





% ----------------------------------------------------------------
% --- FIGURE SHOWING AVERAGE DAILY PERCENTAGE OF TIME SPENT IN EACH SLEEP STATE

figure
set(gcf,'Position',[50, 50, 1110, 950]);
pb=panel();
pb.pack(3,2);
pb.fontsize = axFontSize;

pb.fa.margin = 2;
pb.fa.marginleft = 28;
pb.fa.margintop = 15;
pb.fa.marginbottom = 10;

pb(1,2).marginleft = 30;
pb(2,2).marginleft = 30;
pb(3,2).marginleft = 30;


% ------ TOP LEFT PANEL -----------------
pb(1,1).select();
dataAW = daily_percent_in_wake_AW_averages;
dataRW = daily_percent_in_wake_RW_averages;
stdAW = daily_percent_in_wake_AW_SEM;
stdRW = daily_percent_in_wake_RW_SEM;
%subplot(3,1,1)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 30 80])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30:10:80];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=ylabel({'% of time'; 'spent in Wake'});
yl.FontWeight = 'bold';
tle = pb(1,1).title('Experimental Data');
tle.FontSize = title_fontsize;
significance_w_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,1,1,ax);
ta=text(-1.2,84,'A');
ta.FontSize = panel_label_fontsize;


% ------ TOP RIGHT PANEL -----------------
pb(1,2).select();
dataAW = daily_percent_in_wake_AWsim;
dataRW = daily_percent_in_wake_RWsim;
stdAW = std_daily_percent_in_wake_AWsim./sqrt(50);
stdRW = std_daily_percent_in_wake_RWsim./sqrt(50);

%subplot(3,1,1)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW ,100*stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 30 80])
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h_legend2=legend('RW','AW');
legend boxoff
set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [30 40 50 60 70 80];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(1,2).ylabel({'% of time'; 'spent in Wake'});
yl.FontWeight = 'bold';
tle = pb(1,2).title('Simulation Output');
tle.FontSize = title_fontsize;
significance_w_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,1,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent_in_wake_AW_averages,daily_percent_in_wake_AW_SEM*sqrt(50),...
							   daily_percent_in_wake_RW_averages,daily_percent_in_wake_RW_SEM*sqrt(50),pb,1,2,ax)

% ------ MIDDLE LEFT PANEL -----------------
pb(2,1).select();
dataAW = daily_percent_in_sws_AW_averages;
dataRW = daily_percent_in_sws_RW_averages;
stdAW =daily_percent_in_sws_AW_SEM;
stdRW =daily_percent_in_sws_RW_SEM;


%subplot(3,1,2)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;
axis([0 5.5 20 60]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [20 30 40 50 60];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(2,1).ylabel({'% of time'; 'spent in SWS'});
yl.FontWeight = 'bold';
significance_sws_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,2,1,ax);
tb = text(-1.2,62.5,'B');
tb.FontSize = panel_label_fontsize;


% ------ MIDDLE RIGHT PANEL -----------------
pb(2,2).select();
dataAW = daily_percent_in_sws_AWsim;
dataRW = daily_percent_in_sws_RWsim;
stdAW = std_daily_percent_in_sws_AWsim./sqrt(50);
stdRW = std_daily_percent_in_sws_RWsim./sqrt(50);


%subplot(3,1,2)
h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

axis([0 5.5 20 60]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [20 30 40 50 60];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
ax.XColor = 'none';
set(gca,'box','off')
set(gca,'color','none')
yl=pb(2,2).ylabel({'% of time'; 'spent in SWS'});
yl.FontWeight = 'bold';
%title('Simulation Output')
significance_sws_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,2,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent_in_sws_AW_averages,daily_percent_in_sws_AW_SEM*sqrt(50),...
							   daily_percent_in_sws_RW_averages,daily_percent_in_sws_RW_SEM*sqrt(50),pb,2,2,ax)

% --- BOTTOM LEFT PANEL ----------------------------------------------
%subplot(3,1,3)
pb(3,1).select();
dataAW = daily_percent_in_REMS_AW_averages;
dataRW = daily_percent_in_REMS_RW_averages;
stdAW =daily_percent_in_REMS_AW_SEM;
stdRW =daily_percent_in_REMS_RW_SEM;


h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

axis([0 5.5 0 15]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 5 10 15];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pb(3,1).ylabel({'% of time'; 'spent in REMS'});
yl.FontWeight = 'bold';
significance_rems_per_exp = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,3,1,ax);
tc = text(-1.2,16,'C');
tc.FontSize = panel_label_fontsize;


% --- BOTTOM RIGHT PANEL ----------------------------------------------
%subplot(3,1,3)
pb(3,2).select();
dataAW = daily_percent_in_rems_AWsim;
dataRW = daily_percent_in_rems_RWsim;
stdAW = std_daily_percent_in_rems_AWsim./sqrt(50);
stdRW = std_daily_percent_in_rems_RWsim./sqrt(50);

h1=plot([1:5],100*dataRW,'k',[1:5],100*dataRW,'ko','MarkerSize',markersize);
set(h1(2),'MarkerEdgeColor','none','MarkerFaceColor','k')
hold on 
h2=errorbar([1:5],100*dataRW,100*stdRW,'k');

h3=plot([1:5],100*dataAW,'k',[1:5],100*dataAW,'ko','MarkerSize',markersize);
 
h4=errorbar([1:5],100*dataAW,100*stdAW,'k');
axis([0 5.5 0 15]);
set(get(get(h1(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h3(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h4,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

h1(1).LineWidth = linewidth;
h1(2).LineWidth = linewidth;
h2.LineWidth = linewidth;
h3(1).LineWidth = linewidth;
h3(2).LineWidth = linewidth;
h4.LineWidth = linewidth;

% h_legend2=legend('RW','AW');
% legend boxoff
% set(h_legend2,'FontSize',legend_fontsize)
ax=gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'B', 'W1', 'W2', 'W3','W4'};
ax.YTick = [0 5 10 15 ];
ax.LineWidth = axlinewidth;
ax.FontSize = axFontSize;
set(gca,'box','off')
set(gca,'color','none')
yl = pb(3,2).ylabel({'% of time'; 'spent in REMS'});
yl.FontWeight = 'bold';
significance_rems_per_sim = compare_strains_and_each_day_to_baseline(100*dataAW,100*stdAW,100*dataRW,100*stdRW,pb,3,2,ax);
compare_simulation_to_exp_data(dataAW,stdAW*sqrt(50),dataRW,stdRW*sqrt(50),daily_percent_in_REMS_AW_averages,daily_percent_in_REMS_AW_SEM*sqrt(50),...
							   daily_percent_in_REMS_RW_averages,daily_percent_in_REMS_RW_SEM*sqrt(50),pb,3,2,ax)

% ----------------------------------------------------------------------------------------------------------------
% ----------  Figure showing state percentages with colors -------------------------------------------------------
% ----------------------------------------------------------------------------------------------------------------
load 'experimental_data_for_colored_state_plots.mat'  % this is where the experimental data are for the colored state plots


%make_shaded_state_percentages_plot(0:10/60/60:134,sleepstateAW,[38 46 62 70 86 94 110 118])


make_shaded_state_percentages_plot_AW_RW_with_exp_data(0:10/60/60:134,sleepstateAW,sleepstateRW,Colored_state_per_exp_data_AW,Colored_state_per_exp_data_RW);
% -----------------------------------------------------------------------------------------------------------------
% ----------------------------------------------------------------------------------------------------------------



% ---------------------------------------------------------------------------------------------------------------
% ----------- Figure showing homeostat and sleepiness and alertness (output from model) -------------------------
% ---------------------------------------------------------------------------------------------------------------
make_homeostat_and_sleepiness_figures(S_AW,S_RW,0:10/60/60:134,long_wake_timingsAW,long_wake_timingsRW)








%  Use this code to print these figures to files
% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 7 10];  % 7 inches wide by 10 inches tall
% print -dpdf -r0 num_episodes_figure.pdf

% use export_fig instead.  It seems to be the only one that doesn't mess up text placement
