% script to plot the time constants of the 3state model using shift work data (AW and RW)

load ('FiveStateVsThreeStateVariableSWA.mat')


TauiAW_baseline = [9.860642897
9.317454509
12.07623013
10.64899271
7.283726437
31.6099145
10.59525125
8.742273145
11.3576581
12.36400719
13.37240958
12.47532368];

TauiRW_baseline = [18.34166932
19.03040886
12.97898826
12.40708657
4.417695905
14.02596945
20.27157033
8.495184377
16.06140476
10.16249179
8.111545354
17.48198391
12.58692177
16.35236112
13.62323441];

TauiAW_4dayswork = [9.666499607
10.84954014
7.798206582
8.962852896
11.13135827
12.64015849
13.45664195
9.482555555
10.60865745
9.675856801
13.94979236
10.85556205];


TauiRW_4dayswork = [9.917519889
13.45980618
7.962909539
7.549055805
8.341981402
8.352915886
7.406807964
7.240965043
8.792658948
12.40669792
14.60331158
9.817314891
9.654328754];

TaudAW_baseline = [4.327937918
2.375265427
3.835107131
4.530377832
2.255774643
10.54269258
2.831370898
2.227640444
4.100929119
4.516048154
4.224772958
4.160719737];

TaudRW_baseline = [6.807770413
5.144776225
3.364995368
4.475526456
0.831674269
3.500099021
5.104345979
6.454728919
3.208318189
6.771378975
4.594372185
2.286026525
4.107203985
4.129249399
5.488545889
4.37866771];

TaudAW_4dayswork = [3.224716223
2.440774229
1.785807648
2.11873825
2.899442352
3.030987034
3.128897318
1.905244011
2.205551951
2.44290787
2.93373913
2.556073274];

TaudRW_4dayswork = [1.919422171
2.290102736
1.471055055
1.512483604
1.715916132
8.755876545
2.264166582
2.150434505
1.895525435
2.578820522
2.815666209
3.339552003
1.854364757
2.65872202];


all_data = [mean(TauiAW_baseline) mean(TauiRW_baseline); mean(TaudAW_baseline) mean(TaudRW_baseline); ...
			mean(TauiAW_4dayswork) mean(TauiRW_4dayswork); mean(TaudAW_4dayswork) mean(TaudRW_4dayswork)];
model_error = [std(TauiAW_baseline)/length(TauiAW_baseline) std(TauiRW_baseline)/length(TauiRW_baseline); ... 
				std(TaudAW_baseline)/length(TaudAW_baseline) std(TaudRW_baseline)/length(TaudRW_baseline);
				std(TauiAW_4dayswork)/length(TauiAW_4dayswork) std(TauiRW_4dayswork)/length(TauiRW_4dayswork); ... 
				std(TaudAW_4dayswork)/length(TaudAW_4dayswork) std(TaudRW_4dayswork)/length(TaudRW_4dayswork)];
figure
h=bar([1 2 4 5],all_data./max(max((all_data))));
lh=legend('AW','RW');
legend(gca,'boxoff')
set(lh,'FontSize',14)
ax=gca;
set(gca,'box','off')
set(gca,'color','none')
h(1).EdgeColor = 'none';
h(2).EdgeColor = 'none';
h(3).EdgeColor = 'none';
h(4).EdgeColor = 'none';
h(1).FaceColor = [19,109,238] ./ 255;  % blue
color_teal = [19 153 150] ./ 255;   % green 
h(2).FaceColor = color_teal;
h(3).FaceColor = [19,109,238] ./ 255;  % blue
h(4).FaceColor = color_teal;
ax.LineWidth = 1.5;
ax.FontSize = 12;
ax.XTick = [1 2 4 5];
%ax.XTickLabel = {'AW', 'RW'};
%ax.YLabel.String = 'Normalized RMS residuals';
%ax.YLabel.FontSize = 14;
set(ax,'FontSize',14);
set(h,'BarWidth',0.85);    % The bars will now touch each other
%set(gca,'YGrid','on')
%set(gca,'GridLineStyle','-')
%set(gca,'XTicklabel','Modelo2|Modelo3')
%set(get(gca,'YLabel'),'String','U')
%set(lh,'Location','BestOutside','Orientation','horizontal')
hold on;
numgroups = size(all_data, 1); 
numbars = size(all_data, 2); 
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
      % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
      x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
      eb=errorbar(x, all_data(:,i)./max(max((all_data))), model_error(:,i), 'k', 'linestyle', 'none');
      set(eb,'linewidth',1)
end

