function compare_simulation_to_exp_data(averagesAW_sim,stdAW_sim,averagesRW_sim,stdRW_sim,averagesAW_exp,stdAW_exp,averagesRW_exp,stdRW_exp,panel,row,col,ax)

% p is the panel object
% row and col set the location of the particular subpanel within p
% ax is the current axes, from ax=gca

triangle_label_fontsize = 9;

% call ttest_from_means_and_std for each of the five days (baseline + 4 workdays)
% determine significant differences between simulation output and experimental data
% AW  
for i=1:5
	[t(i),p(i)] = ttest_from_means_and_std(averagesAW_sim(i),averagesAW_exp(i),stdAW_sim(i),stdAW_exp(i),50,12);
	if p(i) < 0.001
		significance.between_exp_simAW(i) = 3;
	elseif p(i) > 0.001 & p(i) < 0.01
		significance.between_exp_simAW(i) = 2;
	elseif p(i) >0.01 & p(i) < 0.05
		significance.between_exp_simAW(i) = 1;
	else
		significance.between_exp_simAW(i) = 0;
	end

end
clear t p

significance.between_exp_simAW;



% RW  
for i=1:5
	[t(i),p(i)] = ttest_from_means_and_std(averagesRW_sim(i),averagesRW_exp(i),stdRW_sim(i),stdRW_exp(i),50,15);
	if p(i) < 0.001
		significance.between_exp_simRW(i) = 3;
	elseif p(i) > 0.001 & p(i) < 0.01
		significance.between_exp_simRW(i) = 2;
	elseif p(i) >0.01 & p(i) < 0.05
		significance.between_exp_simRW(i) = 1;
	else
		significance.between_exp_simRW(i) = 0;
	end

end
clear t p

significance.between_exp_simRW;



% Now add # or * to the correct panel in the correct locations to indicate statistical significance
panel(row,col).select();

% # symbols for differences from baseline
% AW 
% draw ## symbols about 1/8 of total height above or below data points
% first I will need to get the upper and lower bounds of the current figure
total_heigth = ax.YLim(2)-ax.YLim(1);
hdist = 0.05*total_heigth;  % the relative distance above or below the datapoints to draw the ###
open_triangle = char(9651);
filled_triangle = char(9650);


for i=1:5
	if significance.between_exp_simAW(i) >0
		
		vert_loc = ax.YLim(2);
		

		if significance.between_exp_simAW(i) == 1
			symbol = open_triangle;
			horiz_loc = i-0.065;
		elseif significance.between_exp_simAW(i) == 2
			symbol = [open_triangle open_triangle];
			horiz_loc = i-0.135;
		elseif significance.between_exp_simAW(i) == 3
			symbol = [open_triangle open_triangle open_triangle];
			horiz_loc = i-0.215;
		else
			error('significance did not equal 1,2,or 3')
		end

		tA=text(horiz_loc,vert_loc,symbol);
		tA.FontSize = triangle_label_fontsize;
		
	end
end


for i=1:5
	if significance.between_exp_simRW(i) >0
		
			vert_loc = ax.YLim(2)-hdist;
		

		if significance.between_exp_simRW(i) == 1
			symbol = filled_triangle;
			horiz_loc = i-0.065;
		elseif significance.between_exp_simRW(i) == 2
			symbol = [filled_triangle filled_triangle];
			horiz_loc = i-0.135;
		elseif significance.between_exp_simRW(i) == 3
			symbol = [filled_triangle filled_triangle filled_triangle];
			horiz_loc = i-0.215;
		else
			error('significance did not equal 1,2,or 3')
		end

		tR=text(horiz_loc,vert_loc,symbol);
		tR.FontSize = triangle_label_fontsize;
	end
end
