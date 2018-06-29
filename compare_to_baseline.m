function significance = compare_to_baseline(averagesAW,stdAW,averagesRW,stdRW)
%
% USAGE:  significance = compare_to_baseline(averagesAW,stdAW,averagesRW,stdRW)
%
% this function statistically compares values during workdays W1, W2, W3, W4 to the baseline 
% and returns a vector  with 4 elements [2 1 3 3] each element indicating the number 
% of pound signs to draw over that data point.  Possible values are 0-3.  