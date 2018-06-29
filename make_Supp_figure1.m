% script to make Supp Fig 1:  probability density curves and episode durations vs time for all 3 sleep states

% Load saved figures
c=hgload('power_law_fit_REMS_episodes_cumulative.fig');
k=hgload('power_law_fit_SWS_episodes_cumulative.fig');


% Prepare subplots
figure
h(1)=subplot(2,2,1);
h(2)=subplot(2,2,3);


% Paste figures on the subplots
copyobj(allchild(c),h(1));
copyobj(allchild(k),h(2));


% Add legends
l(1)=legend(h(1),'LegendForFirstFigure')
l(2)=legend(h(2),'LegendForSecondFigure')