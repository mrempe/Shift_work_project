function add_hashtags_and_stars_to_figure(p_vals_vecAW,p_vals_vecRW,p_vals_vecBETWEEN,averagesAW,averagesRW,panel,row,col,ax)

% input is the 4-element vector of p-values

% p is the panel object
% row is the row in the panel object that we are modifying
% col is the column

hash_label_fontsize = 14;
star_label_fontsize = 30;



for i=1:4
	if p_vals_vecBETWEEN(i) < 0.001
		significance.between(i) = 3;
	elseif p_vals_vecBETWEEN(i) > 0.001 & p_vals_vecBETWEEN(i) < 0.01
		significance.between(i) = 2;
	elseif p_vals_vecBETWEEN(i) >0.01 & p_vals_vecBETWEEN(i) < 0.05
		significance.between(i) = 1;
	else
		significance.between(i) = 0;
	end

end

% AW to baseline
for i=1:4
	
	if p_vals_vecAW(i) < 0.001
		significance.AW_to_baseline(i) = 3;
	elseif p_vals_vecAW(i) > 0.001 & p_vals_vecAW(i) < 0.01
		significance.AW_to_baseline(i) = 2;
	elseif p_vals_vecAW(i) >0.01 & p_vals_vecAW(i) < 0.05
		significance.AW_to_baseline(i) = 1;
	else
		significance.AW_to_baseline(i) = 0;
	end

end


for i=1:4
	
	if p_vals_vecRW(i) < 0.001
		significance.RW_to_baseline(i) = 3;
	elseif p_vals_vecRW(i) > 0.001 & p_vals_vecRW(i) < 0.01
		significance.RW_to_baseline(i) = 2;
	elseif p_vals_vecRW(i) >0.01 & p_vals_vecRW(i) < 0.05
		significance.RW_to_baseline(i) = 1;
	else
		significance.RW_to_baseline(i) = 0;
	end
end


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