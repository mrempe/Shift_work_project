function significance = compare_strains_and_each_to_baseline(averagesAW,stdAW,averagesRW,stdRW)



% call ttest_from_means_and_std for each of the four workdays
% determine significant differences between AW and RW during each of the 4 workdays 
for i=1:4
	[t(i),p(i)] = ttest_from_means_and_std(averagesAW(i+1),averagesRW(i+1),stAW(i+1),stdRW(i+1),50,50);
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


% RW
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



