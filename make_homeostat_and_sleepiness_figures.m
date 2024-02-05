function make_homeostat_and_sleepiness_figures(S_AW,S_RW,t,longW_ep_timingsAW,longW_ep_timingsRW)
%
% this script makes a figure with 2 panels, each with 2 subpanels.  Panel A shows traces of the homeostat for AW and RW cases. 
% Panel B shows sleepiness and alertness on the same graph for AW and RW cases.  


% -----  Circadian curve -----
circ_amp = 0.25; %0.128;
circ_curve = circ_amp*sin((pi/12)*-t);
C = circ_curve;
% ----------------------------
panel_label_fontsize = 18;
axFontSize = 11;
axlinewidth = 2;
linewidth = 1.5;
title_fontsize = 12;
text_fontsize = 12;






sleep_dep_start_stop_timesAW = [38 46 62 70 86 94 110 118];
sleep_dep_start_stop_timesRW = [26 34 50 58 74 82 98 106];


sleep_dep_start_timesAW = sleep_dep_start_stop_timesAW(1:2:end-1);
sleep_dep_end_timesAW	= sleep_dep_start_stop_timesAW(2:2:end);
sleep_dep_start_timesRW = sleep_dep_start_stop_timesRW(1:2:end-1);
sleep_dep_end_timesRW	= sleep_dep_start_stop_timesRW(2:2:end);

% Remove the locations of long wake episodes that are predicted during a shift
% since the animal is forced to be awake then anyway. 


longw_locsAW = find(longW_ep_timingsAW);
longw_locsRW = find(longW_ep_timingsRW);



for i=1:length(sleep_dep_start_timesAW)
	start_ind_for_t(i) = find(abs(t-sleep_dep_start_timesAW(i))<1e-6);
	end_ind_for_t(i)   = find(abs(t-sleep_dep_end_timesAW(i))<1e-6);

	ind_to_remove = find((longw_locsAW>start_ind_for_t(i) & longw_locsAW<end_ind_for_t(i)));
	longw_locsAW(ind_to_remove) = [];

end

for i=1:length(sleep_dep_start_timesRW)
	start_ind_for_t(i) = find(abs(t-sleep_dep_start_timesRW(i))<1e-6);
	end_ind_for_t(i)   = find(abs(t-sleep_dep_end_timesRW(i))<1e-6);

	ind_to_remove = find((longw_locsRW>start_ind_for_t(i) & longw_locsRW<end_ind_for_t(i)));
	longw_locsRW(ind_to_remove) = [];
end





% --------------------------------------------------------------------------------------
FigHandle = figure;
set(FigHandle,'Position',[300 230 1094 700]);
p=panel();
p.pack(2,1);
%p(1,1).pack(2,1);
p(1,1).pack({1/2 1/2},{.84 .16});
p(2,1).pack(2,1);
p_11 = p(1,1);
p_21 = p(2,1);
p.fa.margin = 3;
p(2).margintop = 30;
p.margin = [25 20 5 5];

% p.fa.marginbottom = 10;
% p.fa.marginleft = 28;
% p.fa.marginright = 15; 




p_11(1,1).select();
	% ---- first make a shaded plot showing average trace of the homeostat  for AW  ----
	if length(S_AW) > length(t)
		% disp('S is longer than t')
		% difflength = length(S)- length(t);
		% tnew = [t t(end)+dt:dt:t(end)+difflength*dt];
		% circ_curvenew = circ_amp*sin((pi/12)*-tnew);
		S_AW = S_AW(1:length(t),:);
		tnew = t;
		circ_curvenew = circ_curve;
	else
		tnew = t;
		circ_curvenew = circ_curve;
	end 

	
	err = std(S_AW,0,2);
	%set(hfig1,'Position',[200 700 1400 275])
	% hold on
	% plot(t,mean(S,2))
	% size(t)
	% size(mean(S,2))
	% size(err)
	% patch([t' fliplr(t')],[mean(S,2)+err fliplr(mean(S,2)-err)],[0.7 0.7 0.7]);
	fill([tnew';flipud(tnew')],[mean(S_AW,2)-err;flipud(mean(S_AW,2)+err)],[0.9 0.9 0.9],'linestyle','none');
	l=line(tnew',mean(S_AW,2));
	set(l,'linewidth',1.5)
	ax=gca;
	ax.XTick = 0:12:t(end);
	set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
	set(gca,'YTick',0:0.2:1);
	ax.XAxis.MinorTick = 'on';
	ax.XAxis.MinorTickValues = ax.XAxis.Limits(1):8:ax.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
	ax.TickDir = 'out';
	ax.TickLength = [0.02 0.02];
	ax.LineWidth = 1.5;
	ax.FontSize = axFontSize;
	ax.XColor = 'none';
	set(gca,'box','off')
	set(gca,'color','none')
	ylabel('Homeostat')

	% add gray bars indicating work periods
	hold on
	if ~isempty(sleep_dep_start_stop_timesAW)
		gray = [0.31 0.31 0.31];
		for i=1:length(sleep_dep_start_timesAW)
			p = patch([sleep_dep_start_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_start_timesAW(i)],[0 0 0.8 0.8],gray);
			p.EdgeColor='none';
			p.FaceAlpha = 0.6;
		end 
	end
	rectangle('Position',[0 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[12 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[24 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[36 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[48 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[60 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[72 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[84 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[96 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[108 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	if t(end)>120
		rectangle('Position',[120 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	end
	te=text(-12,1,'A');
	te.FontSize = panel_label_fontsize;
	tAW = text(136,0.5,'AW');
	tAW.FontSize = panel_label_fontsize;
	hold off 
	% figure
	% plot(tnew',mean(S,2)-0.5*circ_curvenew')
	% legend('S-0.5*C')


% -------------------------------------------------------------------------------------------
% -------------  panel showing homeostat in RW case -----------------------------------------

p_11(2,1).select();
	% ---- first make a shaded plot showing average trace of the homeostat  for AW  ----
	if length(S_RW) > length(t)
		% disp('S is longer than t')
		% difflength = length(S)- length(t);
		% tnew = [t t(end)+dt:dt:t(end)+difflength*dt];
		% circ_curvenew = circ_amp*sin((pi/12)*-tnew);
		S_RW = S_RW(1:length(t),:);
		tnew = t;
		circ_curvenew = circ_curve;
	else
		tnew = t;
		circ_curvenew = circ_curve;
	end 

	
	err = std(S_RW,0,2);
	%set(hfig1,'Position',[200 700 1400 275])
	% hold on
	% plot(t,mean(S,2))
	% size(t)
	% size(mean(S,2))
	% size(err)
	% patch([t' fliplr(t')],[mean(S,2)+err fliplr(mean(S,2)-err)],[0.7 0.7 0.7]);
	fill([tnew';flipud(tnew')],[mean(S_RW,2)-err;flipud(mean(S_RW,2)+err)],[0.9 0.9 0.9],'linestyle','none');
	l=line(tnew',mean(S_RW,2));
	set(l,'linewidth',1.5)
	ax=gca;
	ax.XTick = 0:12:136; %t(end);
	set(gca,'XTick',0:24:136); %t(end));	% set major tick marks at 24 hour intervals
	set(gca,'YTick',0:0.2:1);
	ax.XAxis.MinorTick = 'on';
	ax.XAxis.MinorTickValues = ax.XAxis.Limits(1):8:ax.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
	ax.TickDir = 'out';
	ax.TickLength = [0.02 0.02];
	ax.LineWidth = 1.5;
	ax.FontSize = axFontSize;
	set(gca,'box','off')
	set(gca,'color','none')
	ylabel('Homeostat')
	xl=xlabel('TIME (H)');

	% add gray bars indicating work periods
	hold on
	if ~isempty(sleep_dep_start_stop_timesRW)
		gray = [0.31 0.31 0.31];
		for i=1:length(sleep_dep_start_timesRW)
			p = patch([sleep_dep_start_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_start_timesRW(i)],[0 0 0.8 0.8],gray);
			p.EdgeColor='none';
			p.FaceAlpha = 0.6;
		end 
	end
	rectangle('Position',[0 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[12 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[24 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[36 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[48 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[60 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[72 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[84 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[96 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[108 0.8 12 0.1],'EdgeColor','none','FaceColor','k')
	if t(end)>120
		rectangle('Position',[120 0.8 12 0.1],'EdgeColor','none','FaceColor','y')
	end
	hold off
	tRW = text(136,0.5,'RW');
	tRW.FontSize = panel_label_fontsize;

	text(8.5,-0.15,{'Baseline'},'FontSize',12)
	text(34,-0.15,{'Day1'},'FontSize',12)
	text(58,-0.15,{'Day2'},'FontSize',12)
	text(82,-0.15,{'Day3'},'FontSize',12)
	text(106,-0.15,{'Day4'},'FontSize',12)


	% figure
	% plot(tnew',mean(S,2)-0.5*circ_curvenew')
	% legend('S-0.5*C')

% ----------------------------------------------------------------------------------------------------------
% --------  LOWER PANEL:  SLEEPINESS AND ALERTNESS FOR AW AND RW CASES -------------------------------------
p_21(1,1).select();
	

	p=plot(t',mean(S_AW,2)-circ_curve',t',1-mean(S_AW,2)+circ_curve','r');
	hold on
	%longw_locsAW = find(longW_ep_timingsAW);
	
	plot(t(longw_locsAW),1.15*longW_ep_timingsAW(longw_locsAW),'.','MarkerSize',16)
	hold off
	set(p,'linewidth',1.5)
	ax=gca;
	ax.XTick = 0:12:t(end);
	h_legend=legend('Sleepiness','Alertness');
	legend(ax,'boxoff')
	set(h_legend,'FontSize',14)
	set(h_legend,'Location','northeastoutside')
	ax=gca;
	ax.XTick = 0:12:t(end);
	set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
	set(gca,'YTick',0:0.2:1);
	ax.XAxis.MinorTick = 'on';
	ax.XAxis.MinorTickValues = ax.XAxis.Limits(1):8:ax.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
	ax.TickDir = 'out';
	ax.TickLength = [0.02 0.02];
	ax.LineWidth = 1.5;
	ax.FontSize = axFontSize;
	ax.XColor = 'none';
	set(gca,'box','off')
	set(gca,'color','none')
	xlabel('TIME (H)')
	axis([0 140 -0.1 1.35])

	% add gray bars indicating work periods
	hold on
	if ~isempty(sleep_dep_start_stop_timesAW)
		gray = [0.31 0.31 0.31];
		for i=1:length(sleep_dep_start_timesAW)
			p = patch([sleep_dep_start_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_end_timesAW(i) sleep_dep_start_timesAW(i)],[-0.1 -0.1 1.3 1.3],gray);
			p.EdgeColor='none';
			p.FaceAlpha = 0.6;
		end 
	end
	rectangle('Position',[0  1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[12 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[24 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[36 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[48 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[60 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[72 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[84 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[96 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[108 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	if t(end)>120
		rectangle('Position',[120 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	end
	
	te=text(-14,1.3,'B');
	te.FontSize = panel_label_fontsize;hold off 
	tAW = text(134,0.5,'AW');
	tAW.FontSize = panel_label_fontsize;

% ---------------------------------------------------------------------------------------------
p_21(2,1).select();
	

	p=plot(t',mean(S_RW,2)-circ_curve',t',1-mean(S_RW,2)+circ_curve','r');
	hold on
	%longw_locsRW = find(longW_ep_timingsRW);
	
	plot(t(longw_locsRW),1.15*longW_ep_timingsRW(longw_locsRW),'.','MarkerSize',16)
	hold off
	set(p,'linewidth',1.5)
	ax=gca;
	ax.XTick = 0:12:t(end);
	h_legend=legend('Sleepiness','Alertness');
	legend(ax,'boxoff')
	set(h_legend,'FontSize',14)
	set(h_legend,'Location','northeastoutside')
	ax=gca;
	ax.XTick = 0:12:t(end);
	set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
	set(gca,'YTick',0:0.2:1);
	ax.XAxis.MinorTick = 'on';
	ax.XAxis.MinorTickValues = ax.XAxis.Limits(1):8:ax.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
	ax.TickDir = 'out';
	ax.TickLength = [0.02 0.02];
	ax.LineWidth = 1.5;
	ax.FontSize = axFontSize;
	set(gca,'box','off')
	set(gca,'color','none')
	xlabel('TIME (H)')
	axis([0 140 -0.1 1.35])

	% add gray bars indicating work periods
	hold on
	if ~isempty(sleep_dep_start_stop_timesRW)
		gray = [0.31 0.31 0.31];
		for i=1:length(sleep_dep_start_timesRW)
			p = patch([sleep_dep_start_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_end_timesRW(i) sleep_dep_start_timesRW(i)],[-0.1 -0.1 1.3 1.3],gray);
			p.EdgeColor='none';
			p.FaceAlpha = 0.6;
		end 
	end
	rectangle('Position',[0  1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[12 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[24 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[36 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[48 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[60 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[72 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[84 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	rectangle('Position',[96 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	rectangle('Position',[108 1.25 12 0.1],'EdgeColor','none','FaceColor','k')
	if t(end)>120
		rectangle('Position',[120 1.25 12 0.1],'EdgeColor','none','FaceColor','y')
	end
	tRW = text(134,0.5,'RW');
	tRW.FontSize = panel_label_fontsize;

	text(8.5,-0.3,{'Baseline'},'FontSize',12)
	text(34,-0.3,{'Day1'},'FontSize',12)
	text(58,-0.3,{'Day2'},'FontSize',12)
	text(82,-0.3,{'Day3'},'FontSize',12)
	text(106,-0.3,{'Day4'},'FontSize',12)





