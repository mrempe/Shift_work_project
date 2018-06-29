function cleaned_runs=remove_short_runs(gross_runs)
%
% USAGE: cleaned_runs=remove_short_runs(gross_runs)
%
% this function removes runs of wake and SWS that are shorter than 3 epochs, and 
% runs of REMS that are shorter than 2 epochs.  


 % wake
try 
	too_short_run_indices_wake = find(gross_runs{1,2}(:,2) < gross_runs{1,2}(:,1) + 2);
	gross_runs{1,2}(too_short_run_indices_wake,:) = [];
	cleaned_runs{1,2} = gross_runs{1,2};

catch
	cleaned_runs{1,2} = [];
end


% SWS
try 
	too_short_run_indices_sws = find(gross_runs{2,2}(:,2) < gross_runs{2,2}(:,1) + 2);
	gross_runs{2,2}(too_short_run_indices_sws,:) = [];
	cleaned_runs{2,2} = gross_runs{2,2};

catch
	cleaned_runs{2,2} = [];
end


% REMS
try 
	too_short_run_indices_rems = find(gross_runs{3,2}(:,2) < gross_runs{3,2}(:,1) + 1);
	gross_runs{3,2}(too_short_run_indices_rems,:) = [];
	cleaned_runs{3,2} = gross_runs{3,2};

catch
	cleaned_runs{3,2} = [];
end