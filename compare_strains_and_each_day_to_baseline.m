function significance = compare_strains_and_each_day_to_baseline(averagesAW,stdAW,averagesRW,stdRW,panel,row,col,ax)

% p is the panel object
% row and col set the location of the particular subpanel within p
% ax is the current axes, from ax=gca

hash_label_fontsize = 14;
star_label_fontsize = 30;

% call ttest_from_means_and_std for each of the four workdays
% determine significant differences between AW and RW during each of the 4 workdays 
for i=1:4
	[t(i),p(i)] = ttest_from_means_and_std(averagesAW(i+1),averagesRW(i+1),stdAW(i+1),stdRW(i+1),50,50);
	if p(i) < 0.001
		significance.between(i) = 3;
	elseif p(i) > 0.001 & p(i) < 0.01
		significance.between(i) = 2;
	elseif p(i) >0.01 & p(i) < 0.05
		significance.between(i) = 1;
	else
		significance.between(i) = 0;
	end

end
clear t p
% determine significant difference between work days and baseline
% AW
baselineAW_value = averagesAW(1);
baselineAW_std = stdAW(1);

for i=1:4
	[t(i),p(i)] = ttest_from_means_and_std(baselineAW_value,averagesAW(i+1),baselineAW_std,stdAW(i+1),50,50);
	if p(i) < 0.001
		significance.AW_to_baseline(i) = 3;
	elseif p(i) > 0.001 & p(i) < 0.01
		significance.AW_to_baseline(i) = 2;
	elseif p(i) >0.01 & p(i) < 0.05
		significance.AW_to_baseline(i) = 1;
	else
		significance.AW_to_baseline(i) = 0;
	end
end
clear t p

% RW (workdays and baseline)
baselineRW_value = averagesRW(1);
baselineRW_std = stdRW(1);

for i=1:4
	[t(i),p(i)] = ttest_from_means_and_std(baselineRW_value,averagesRW(i+1),baselineRW_std,stdRW(i+1),50,50);
	if p(i) < 0.001
		significance.RW_to_baseline(i) = 3;
	elseif p(i) > 0.001 & p(i) < 0.01
		significance.RW_to_baseline(i) = 2;
	elseif p(i) >0.01 & p(i) < 0.05
		significance.RW_to_baseline(i) = 1;
	else
		significance.RW_to_baseline(i) = 0;
	end
end
clear t p






% Now add # or * to the correct panel in the correct locations to indicate statistical significance
panel(row,col).select();

% # symbols for differences from baseline
% AW 
% draw ## symbols about 1/8 of total height above or below data points
% first I will need to get the upper and lower bounds of the current figure
total_heigth = ax.YLim(2)-ax.YLim(1);
hdist = total_heigth/8;  % the relative distance above or below the datapoints to draw the ###


for i=1:4
	if significance.AW_to_baseline(i) >0
		if averagesAW(i+1) > averagesRW(i+1)
			vert_loc = averagesAW(i+1) + hdist;
		else
			vert_loc = averagesAW(i+1) - hdist;
		end

		if significance.AW_to_baseline(i) == 1
			symbol = '#';
			horiz_loc = i+0.95;
		elseif significance.AW_to_baseline(i) == 2
			symbol = '##';
			horiz_loc = i+0.9;
		elseif significance.AW_to_baseline(i) == 3
			symbol = '###';
			horiz_loc = i+0.8;
		else
			error('significance did not equal 1,2,or 3')
		end

		tA=text(horiz_loc,vert_loc,symbol);
		tA.FontSize = hash_label_fontsize;
	end
end


for i=1:4
	if significance.RW_to_baseline(i) >0
		if averagesRW(i+1) > averagesAW(i+1)
			vert_loc = averagesRW(i+1) + hdist;
		else
			vert_loc = averagesRW(i+1) - hdist;
		end

		if significance.RW_to_baseline(i) == 1
			symbol = '#';
			horiz_loc = i+0.95;
		elseif significance.RW_to_baseline(i) == 2
			symbol = '##';
			horiz_loc = i+0.9;
		elseif significance.RW_to_baseline(i) == 3
			symbol = '###';
			horiz_loc = i+0.8;
		else
			error('significance did not equal 1,2,or 3')
		end

		tR=text(horiz_loc,vert_loc,symbol);
		tR.FontSize = hash_label_fontsize;
	end
end

% Now add * where there is a significant difference between the strains
for i=1:4
	if significance.between(i) >0
		if averagesRW(i+1) > averagesAW(i+1)
			vert_loc = averagesAW(i+1) - 2*hdist;
		else
			vert_loc = averagesRW(i+1) - 2*hdist;
		end

		if significance.between(i) == 1
			symbol = '*';
			horiz_loc = i+0.9;
		elseif significance.between(i) == 2
			symbol = '**';
			horiz_loc = i+0.825;
		elseif significance.between(i) == 3
			symbol = '***';
			horiz_loc = i+0.725;
		else
			error('significance between did not equal 1,2,or 3')
		end

		tb=text(horiz_loc,vert_loc,symbol);
		tb.FontSize = star_label_fontsize;
	end
end