function make_shaded_state_percentages_plot_AW_RW_with_exp_data(t,sleep_stateAW_sim,sleep_stateRW_sim,sleep_state_percentages_expAW,sleep_state_percentages_expRW)

% makes one gigantic figure showing shaded plots of sleep state: 2 for experimental data (AW and RW) and 
% 2 for simulation output (AW and RW).  

% this needs to read in several runs of the model and plot the average percentages in each
% 2 hour window


% parameters for appearance of panels
panel_label_fontsize = 18;
axFontSize = 11;
axlinewidth = 2;
linewidth = 1.5;
title_fontsize = 12;
text_fontsize = 12;
exp_sim_label_fontsize = 14;

window_length_in_hours = 2;  % Janne uses 2 hour windows in the figure in the paper

window_length_in_elements = find(abs(t-window_length_in_hours)<1e-15);
window_times = t(ceil(window_length_in_elements/2)):window_length_in_hours:t(end-ceil(window_length_in_elements/2));
sleep_dep_start_stop_timesAW = [38 46 62 70 86 94 110 118];
sleep_dep_start_stop_timesRW = [26 34 50 58 74 82 98 106];


sleep_dep_start_timesAW = sleep_dep_start_stop_timesAW(1:2:end-1);
sleep_dep_end_timesAW	= sleep_dep_start_stop_timesAW(2:2:end);
sleep_dep_start_timesRW = sleep_dep_start_stop_timesRW(1:2:end-1);
sleep_dep_end_timesRW	= sleep_dep_start_stop_timesRW(2:2:end);


 % --- Set up figure and panels  -------------------------
FigHandle = figure;
set(FigHandle,'Position',[300 230 1094 700]);
p=panel();
p.pack('v',{0.6 0.4});
%p.pack(2,1);
p(1).pack({.35 .65});
p(2).pack(2,1);


%%p.pack(2,1);
%p(1,1).pack(2,1);
%%p(1).pack({1/3 2/3});
%%p(1,1).pack(2,1);
%%p(2,1).pack(2,1);
p_11 = p(1,1);
p_21 = p(2,1);
p.fa.margin = 12;
p(2).margintop = 15;
p.fa.marginleft = 28;
p.fa.marginright = 40; 

% ---------------------------------------------------------------------------------------------------------------
% ------ AW EXPERIMENTAL DATA -----------------------------------------------------------------------------------
W_row = find(strcmp(sleep_state_percentages_expAW.labels,'WAKE'));
S_row = find(strcmp(sleep_state_percentages_expAW.labels,'SWS'));
R_row = find(strcmp(sleep_state_percentages_expAW.labels,'REMS'));


wake_percentage_meansAW_exp = sleep_state_percentages_expAW.data(W_row,:)./100;  
SWS_percentage_meansAW_exp  = sleep_state_percentages_expAW.data(S_row,:)./100;
REM_percentage_meansAW_exp  = sleep_state_percentages_expAW.data(R_row,:)./100;


%p_11(1,1).select();
p(1,1).select();
%set(FigHandle,'Position',[300 50 941, 216]);
%pbaspect([1 0.2142 0.2142])
plot(window_times,REM_percentage_meansAW_exp(1:length(window_times)),window_times,REM_percentage_meansAW_exp(1:length(window_times))+SWS_percentage_meansAW_exp(1:length(window_times)))
yl=ylim;
%pbaspect([1.0000    0.4625    0.4625])
hold on 
% h1 = fill(window_times([1 1:end end]),[0 REM_percentage_means 0],'r','EdgeColor','none');
% h2 = fill(window_times([1 1:end end]),[REM_percentage_means(1) REM_percentage_means+SWS_percentage_means REM_percentage_means(1)],'b','EdgeColor','none');
% h3 = fill(window_times([1 1:end end]),[1 REM_percentage_means+SWS_percentage_means+wake_percentage_means 1],'g','EdgeColor','none');
Y = [REM_percentage_meansAW_exp' SWS_percentage_meansAW_exp' wake_percentage_meansAW_exp' ];
h=area(window_times,Y(1:length(window_times),:),'LineStyle','none');
h(1).FaceColor = [0.2863 0 0.5725];       % purple
h(2).FaceColor = [0.4275 0.7137 1]; %light blue
h(3).FaceColor = [0.8588 0.4275 0];  %orange

% t_sleep_dep_indices = find(t==sleep_dep_start_stop_times);
% h2=area(window_times(t_sleep_dep_indices),Y(t_sleep_dep_indices,:),'LineStyle','none')
% h2(1).FaceColor = [1 0 0];
% h2(2).FaceColor = [0 0.45 0.74];
% h2(3).FaceColor = [0 0.4 0];



% set(h1,'FaceAlpha',0.5)
% set(h2,'FaceAlpha',0.5)
if ~isempty(sleep_dep_start_stop_timesAW)
	gray = [0.31 0.31 0.31];
	for i=1:length(sleep_dep_start_timesAW)
		ptch = patch([sleep_dep_start_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_start_timesAW(i)],[0 0 1 1],[0.5725 0.2863 0]);
		ptch.EdgeColor='none';
		%p.FaceAlpha = 0.9;
	end 
end 

hold off 
set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
set(gca,'YTick',0:0.1:1);
if sleep_dep_start_timesAW(1)==26
	V=axis;
	axis([0 120 V(3) V(4)])
end 
ha=gca;
ha.XAxis.MinorTick = 'on';
ha.XAxis.MinorTickValues = ha.XAxis.Limits(1):8:ha.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
ha.TickDir = 'out';
ha.TickLength = [0.02 0.02];
ha.LineWidth = 1.5;
ha.FontSize = 12;
ha.YTick = 0:0.2:1;
ha.YTickLabel = {'0%','20%','40%','60%','80%','100%'};
set(gca,'box','off')
set(gca,'color','none')
yl=ylabel('% of total time');
yl.FontSize = axFontSize; 
ylim([0 1.1])
% Add the yellow and black bars at the top to indicate light/dark cycle
%rectangle('Position',[xlowerleft ylowerleft width height ])
hold on
rectangle('Position',[0 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[12 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[24 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[36 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[48 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[60 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[72 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[84 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[96 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[108 1 12 0.1],'EdgeColor','none','FaceColor','k')
if t(end)>120
	rectangle('Position',[120 1 12 0.1],'EdgeColor','none','FaceColor','y')
end
hold off

% Add the labels of Baseline 'Day1', 'Day2', etc.  
text(8.5,-0.15,{'Baseline'},'FontSize',12)
text(34,-0.15,{'Day1'},'FontSize',12)
text(58,-0.15,{'Day2'},'FontSize',12)
text(82,-0.15,{'Day3'},'FontSize',12)
text(106,-0.15,{'Day4'},'FontSize',12)
if t(end)>120
	text(127,-0.15,{'Day5'},'FontSize',12)
end
te=text(-14,1.3,'A');
te.FontSize = panel_label_fontsize; 

tb=text(136,0.5,'Experimental Data');
tb.FontSize = exp_sim_label_fontsize;

% -----------------------------------------------------------------------------------------------------
% ----- END OF AW EXPERIMENTAL DATA -------------------------------------------------------------------



% ---------------------------------------------------------------------------------------------------------------
% ------ RW EXPERIMENTAL DATA -----------------------------------------------------------------------------------
W_row = find(strcmp(sleep_state_percentages_expRW.labels,'WAKE'));
S_row = find(strcmp(sleep_state_percentages_expRW.labels,'SWS'));
R_row = find(strcmp(sleep_state_percentages_expRW.labels,'REMS'));


wake_percentage_meansRW_exp = sleep_state_percentages_expRW.data(W_row,:)./100;  
SWS_percentage_meansRW_exp  = sleep_state_percentages_expRW.data(S_row,:)./100;
REM_percentage_meansRW_exp  = sleep_state_percentages_expRW.data(R_row,:)./100;
RW_length = length(wake_percentage_meansRW_exp);

p(2,1,1).select();
%p_21(1,1).select();
%set(FigHandle,'Position',[300 50 941, 216]);
%pbaspect([1 0.2142 0.2142])
plot(window_times(1:RW_length),REM_percentage_meansRW_exp,window_times(1:RW_length),REM_percentage_meansRW_exp+SWS_percentage_meansRW_exp)
yl=ylim;

%pbaspect([1.0000    0.4625    0.4625])
hold on 
% h1 = fill(window_times([1 1:end end]),[0 REM_percentage_means 0],'r','EdgeColor','none');
% h2 = fill(window_times([1 1:end end]),[REM_percentage_means(1) REM_percentage_means+SWS_percentage_means REM_percentage_means(1)],'b','EdgeColor','none');
% h3 = fill(window_times([1 1:end end]),[1 REM_percentage_means+SWS_percentage_means+wake_percentage_means 1],'g','EdgeColor','none');
Y = [REM_percentage_meansRW_exp' SWS_percentage_meansRW_exp' wake_percentage_meansRW_exp' ];
h=area(window_times(1:RW_length),Y,'LineStyle','none');
h(1).FaceColor = [0.2863 0 0.5725];       % purple
h(2).FaceColor = [0.4275 0.7137 1]; %light blue
h(3).FaceColor = [0.8588 0.4275 0];  %orange

% t_sleep_dep_indices = find(t==sleep_dep_start_stop_times);
% h2=area(window_times(t_sleep_dep_indices),Y(t_sleep_dep_indices,:),'LineStyle','none')
% h2(1).FaceColor = [1 0 0];
% h2(2).FaceColor = [0 0.45 0.74];
% h2(3).FaceColor = [0 0.4 0];



% set(h1,'FaceAlpha',0.5)
% set(h2,'FaceAlpha',0.5)
if ~isempty(sleep_dep_start_stop_timesRW)
	gray = [0.31 0.31 0.31];
	for i=1:length(sleep_dep_start_timesRW)
		ptch = patch([sleep_dep_start_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_start_timesRW(i)],[0 0 1 1],[0.5725 0.2863 0]);
		ptch.EdgeColor='none';
		%p.FaceAlpha = 0.9;
	end 
end 

hold off 
set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
set(gca,'YTick',0:0.1:1);
axis([0 140 0 1.1])
% if sleep_dep_start_timesAW(1)==26
% 	V=axis;
% 	axis([0 120 V(3) V(4)])
% end 
ha=gca;
ha.XAxis.MinorTick = 'on';
ha.XAxis.MinorTickValues = ha.XAxis.Limits(1):8:ha.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
ha.TickDir = 'out';
ha.TickLength = [0.02 0.02];
ha.LineWidth = 1.5;
ha.FontSize = 12;
ha.YTick = 0:0.2:1;
ha.YTickLabel = {'0%','20%','40%','60%','80%','100%'};
set(gca,'box','off')
set(gca,'color','none')
yl=ylabel('% of total time');
yl.FontSize = axFontSize;
ylim([0 1.1])
% Add the yellow and black bars at the top to indicate light/dark cycle
%rectangle('Position',[xlowerleft ylowerleft width height ])
hold on
rectangle('Position',[0 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[12 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[24 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[36 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[48 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[60 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[72 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[84 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[96 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[108 1 12 0.1],'EdgeColor','none','FaceColor','k')

hold off

% Add the labels of Baseline 'Day1', 'Day2', etc.  
text(8.5,-0.15,{'Baseline'},'FontSize',12)
text(34,-0.15,{'Day1'},'FontSize',12)
text(58,-0.15,{'Day2'},'FontSize',12)
text(82,-0.15,{'Day3'},'FontSize',12)
text(106,-0.15,{'Day4'},'FontSize',12)
 
pbaspect = [1 0.1306 0.1306]; 
te=text(-14,1.3,'B');
te.FontSize = panel_label_fontsize; 
tb=text(136,0.5,'Experimental Data');
tb.FontSize = exp_sim_label_fontsize;




% ----------------------------------------------------------------------------------------------------------------
%  --------    first do AW simulation output  --------------------------------------------------------------------



for j=1:size(sleep_stateAW_sim,2)
	index = 1;
	for i=1:window_length_in_elements:length(t)-window_length_in_elements
		window_indices = i:i+window_length_in_elements -1;
		wake_percentageAW_sim(index,j)= length(find(sleep_stateAW_sim(window_indices,j)=='W'))/window_length_in_elements;
		SWS_percentageAW_sim(index,j) = length(find(sleep_stateAW_sim(window_indices,j)=='S'))/window_length_in_elements;
		REM_percentageAW_sim(index,j) = length(find(sleep_stateAW_sim(window_indices,j)=='R'))/window_length_in_elements;
		index = index+1;
	end
end

% Now average over the trials
wake_percentage_meansAW_sim = mean(wake_percentageAW_sim,2)';
SWS_percentage_meansAW_sim = mean(SWS_percentageAW_sim,2)';
REM_percentage_meansAW_sim = mean(REM_percentageAW_sim,2)';




%p_11(2,1).select();
%p(1,1,2).select();
p(1,2).select();
%set(FigHandle,'Position',[300 50 941, 216]);
%pbaspect([1 0.2142 0.2142])
plot(window_times,REM_percentage_meansAW_sim,window_times,REM_percentage_meansAW_sim+SWS_percentage_meansAW_sim)
yl=ylim;
%pbaspect([1.0000    0.4625    0.4625])
hold on 
% h1 = fill(window_times([1 1:end end]),[0 REM_percentage_means 0],'r','EdgeColor','none');
% h2 = fill(window_times([1 1:end end]),[REM_percentage_means(1) REM_percentage_means+SWS_percentage_means REM_percentage_means(1)],'b','EdgeColor','none');
% h3 = fill(window_times([1 1:end end]),[1 REM_percentage_means+SWS_percentage_means+wake_percentage_means 1],'g','EdgeColor','none');
Y = [REM_percentage_meansAW_sim' SWS_percentage_meansAW_sim' wake_percentage_meansAW_sim' ];
h=area(window_times,Y,'LineStyle','none');
h(1).FaceColor = [0.2863 0 0.5725]; % purple
h(2).FaceColor = [0.4275 0.7137 1]; %light blue
h(3).FaceColor = [0.8588 0.4275 0]; %orange

% t_sleep_dep_indices = find(t==sleep_dep_start_stop_times);
% h2=area(window_times(t_sleep_dep_indices),Y(t_sleep_dep_indices,:),'LineStyle','none')
% h2(1).FaceColor = [1 0 0];
% h2(2).FaceColor = [0 0.45 0.74];
% h2(3).FaceColor = [0 0.4 0];



% set(h1,'FaceAlpha',0.5)
% set(h2,'FaceAlpha',0.5)
if ~isempty(sleep_dep_start_stop_timesAW)
	gray = [0.31 0.31 0.31];
	for i=1:length(sleep_dep_start_timesAW)
		ptch = patch([sleep_dep_start_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_start_timesAW(i)],[0 0 1 1],[0.5725 0.2863 0]);
		ptch.EdgeColor='none';
		%p.FaceAlpha = 0.9;
	end 
end 

hold off 
set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
set(gca,'YTick',0:0.1:1);
if sleep_dep_start_timesAW(1)==26
	V=axis;
	axis([0 120 V(3) V(4)])
end 
ha=gca;
ha.XAxis.MinorTick = 'on';
ha.XAxis.MinorTickValues = ha.XAxis.Limits(1):8:ha.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
ha.TickDir = 'out';
ha.TickLength = [0.02 0.02];
ha.LineWidth = 1.5;
ha.FontSize = 12;
ha.YTick = 0:0.2:1;
ha.YTickLabel = {'0%','20%','40%','60%','80%','100%'};
set(gca,'box','off')
set(gca,'color','none')
yl = ylabel('% of total time');
yl.FontSize = axFontSize;
ylim([0 1.1])
% Add the yellow and black bars at the top to indicate light/dark cycle
%rectangle('Position',[xlowerleft ylowerleft width height ])
hold on
rectangle('Position',[0 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[12 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[24 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[36 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[48 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[60 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[72 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[84 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[96 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[108 1 12 0.1],'EdgeColor','none','FaceColor','k')
if t(end)>120
	rectangle('Position',[120 1 12 0.1],'EdgeColor','none','FaceColor','y')
end
hold off

% Add the labels of Baseline 'Day1', 'Day2', etc.  
text(8.5,-0.15,{'Baseline'},'FontSize',12)
text(34,-0.15,{'Day1'},'FontSize',12)
text(58,-0.15,{'Day2'},'FontSize',12)
text(82,-0.15,{'Day3'},'FontSize',12)
text(106,-0.15,{'Day4'},'FontSize',12)
if t(end)>120
	text(127,-0.1,{'Day5'},'FontSize',12)
end

% % add legend showing what each color represents
% rec_height = 0.2;
% rec_width = 4;
% r1 = rectangle('Position',[48 -0.4 rec_width rec_height],'EdgeColor','none','FaceColor',[0.8588 0.4275 0]);  % Wake
% legend_text1 = text(55,-0.4,'Wake');
% legend_text1.FontSize = 18;
% r2 = rectangle('Position',[64 -0.4 rec_width rec_height],'EdgeColor','none','FaceColor',[0.4275 0.7137 1]);  % SWS
% legend_text2 = text(71,-0.4,'SWS');
% legend_text2.FontSize = 18;
% r3 = rectangle('Position',[80 -0.4 rec_width rec_height],'EdgeColor','none','FaceColor',[0.2863 0 0.5725 ]);  % REMS
% legend_text3 = text(87,-0.4,'REMS');
% legend_text3.FontSize = 18;
l=legend([h(3) h(2) h(1)],'Wake','SWS','REMS');
l.Orientation='horizontal';
l.Location='southoutside';
l.FontSize = 12;
legend('boxoff')

tb=text(136,0.5,'Simulation Output');
tb.FontSize = exp_sim_label_fontsize;


% --------------------------------------------------------------------------------------------------
% ---- END OF PLOTTING SIMULATION DATA FOR AW CASE -------------------------------------------------

% -------------------------------------------------------------------------------------------------\
% ----- PLOT DATA FOR SIMULATION RW CASE  ----------------------------------------------------------

for j=1:size(sleep_stateRW_sim,2)
	index = 1;
	for i=1:window_length_in_elements:length(t)-window_length_in_elements
		window_indices = i:i+window_length_in_elements -1;
		wake_percentageRW_sim(index,j)= length(find(sleep_stateRW_sim(window_indices,j)=='W'))/window_length_in_elements;
		SWS_percentageRW_sim(index,j) = length(find(sleep_stateRW_sim(window_indices,j)=='S'))/window_length_in_elements;
		REM_percentageRW_sim(index,j) = length(find(sleep_stateRW_sim(window_indices,j)=='R'))/window_length_in_elements;
		index = index+1;
	end
end

% Now average over the trials
wake_percentage_meansRW_sim = mean(wake_percentageRW_sim,2)';
SWS_percentage_meansRW_sim = mean(SWS_percentageRW_sim,2)';
REM_percentage_meansRW_sim = mean(REM_percentageRW_sim,2)';



p(2,2,1).select();
%p_21(2,1).select();
%set(FigHandle,'Position',[300 50 941, 216]);
%pbaspect([1 0.2142 0.2142])
plot(window_times,REM_percentage_meansRW_sim,window_times,REM_percentage_meansRW_sim+SWS_percentage_meansRW_sim)
yl=ylim;
%pbaspect([1.0000    0.4625    0.4625])
hold on 
% h1 = fill(window_times([1 1:end end]),[0 REM_percentage_means 0],'r','EdgeColor','none');
% h2 = fill(window_times([1 1:end end]),[REM_percentage_means(1) REM_percentage_means+SWS_percentage_means REM_percentage_means(1)],'b','EdgeColor','none');
% h3 = fill(window_times([1 1:end end]),[1 REM_percentage_means+SWS_percentage_means+wake_percentage_means 1],'g','EdgeColor','none');
Y = [REM_percentage_meansRW_sim' SWS_percentage_meansRW_sim' wake_percentage_meansRW_sim' ];
h=area(window_times,Y,'LineStyle','none');
h(1).FaceColor = [0.2863 0 0.5725];       % purple
h(2).FaceColor = [0.4275 0.7137 1]; %light blue
h(3).FaceColor = [0.8588 0.4275 0];  %orange

% t_sleep_dep_indices = find(t==sleep_dep_start_stop_times);
% h2=area(window_times(t_sleep_dep_indices),Y(t_sleep_dep_indices,:),'LineStyle','none')
% h2(1).FaceColor = [1 0 0];
% h2(2).FaceColor = [0 0.45 0.74];
% h2(3).FaceColor = [0 0.4 0];



% set(h1,'FaceAlpha',0.5)
% set(h2,'FaceAlpha',0.5)
if ~isempty(sleep_dep_start_stop_timesRW)
	gray = [0.31 0.31 0.31];
	for i=1:length(sleep_dep_start_timesRW)
		ptch = patch([sleep_dep_start_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_start_timesRW(i)],[0 0 1 1],[0.5725 0.2863 0]);
		ptch.EdgeColor='none';
		%p.FaceAlpha = 0.9;
	end 
end 

hold off 
set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
set(gca,'YTick',0:0.1:1);
if sleep_dep_start_timesAW(1)==26
	V=axis;
	axis([0 120 V(3) V(4)])
end 
ha=gca;
ha.XAxis.MinorTick = 'on';
ha.XAxis.MinorTickValues = ha.XAxis.Limits(1):8:ha.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
ha.TickDir = 'out';
ha.TickLength = [0.02 0.02];
ha.LineWidth = 1.5;
ha.FontSize = 12;
ha.YTick = 0:0.2:1;
ha.YTickLabel = {'0%','20%','40%','60%','80%','100%'};
set(gca,'box','off')
set(gca,'color','none')
yl=ylabel('% of total time');
yl.FontSize = axFontSize;
ylim([0 1.1])
% Add the yellow and black bars at the top to indicate light/dark cycle
%rectangle('Position',[xlowerleft ylowerleft width height ])
hold on
rectangle('Position',[0 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[12 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[24 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[36 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[48 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[60 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[72 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[84 1 12 0.1],'EdgeColor','none','FaceColor','k')
rectangle('Position',[96 1 12 0.1],'EdgeColor','none','FaceColor','y')
rectangle('Position',[108 1 12 0.1],'EdgeColor','none','FaceColor','k')
if t(end)>120
	rectangle('Position',[120 1 12 0.1],'EdgeColor','none','FaceColor','y')
end
hold off

% Add the labels of Baseline 'Day1', 'Day2', etc.  
text(8.5,-0.15,{'Baseline'},'FontSize',12)
text(34,-0.15,{'Day1'},'FontSize',12)
text(58,-0.15,{'Day2'},'FontSize',12)
text(82,-0.15,{'Day3'},'FontSize',12)
text(106,-0.15,{'Day4'},'FontSize',12)
% if t(end)>120
% 	text(127,-0.1,{'Day5'},'FontSize',12)
% end
% te=text(-14,1.3,'D');
% te.FontSize = panel_label_fontsize;
pbaspect = [1 0.1306 0.1306];  % set the aspect ratio to match panel B

tb=text(136,0.5,'Simulation Output');
tb.FontSize = exp_sim_label_fontsize;
 % ---------------------------------------------------------------------------------------------------
 %  ----  End of RW simulation colored plot  ---------------------------------------------------------
