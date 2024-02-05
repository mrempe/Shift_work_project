function latex= generate_transition_tables(sleep_averages,sleep_std,shift)
% this script is to test latexTable.m 
% averages is a matrix with 6 rows and  5 columns.  rows correspond to the 6 different transitions:
% W-> SWS
% W -> REMS
% SWS -> W
% SWS -> REMS
% REMS -> SWS
% REMS -> W
% and columns corresponds to the days of the experiment: baseline, W1, W2, W3, W4

load 'transition_data.mat'  % this .mat file has the experimental transition data
addpath 'latexTable-master' % this is where latexTable lives

averages_experimental_AW = [transition_averagesAW.W2S; transition_averagesAW.W2R; transition_averagesAW.S2W; transition_averagesAW.S2R; transition_averagesAW.R2W; transition_averagesAW.R2S];
std_experimental_AW = [transition_stdAW.W2S; transition_stdAW.W2R; transition_stdAW.S2W; transition_stdAW.S2R; transition_stdAW.R2W; transition_stdAW.R2S];


averages_experimental_RW = [transition_averagesRW.W2S; transition_averagesRW.W2R; transition_averagesRW.S2W; transition_averagesRW.S2R; transition_averagesRW.R2W; transition_averagesRW.R2S];
std_experimental_RW = [transition_stdRW.W2S; transition_stdRW.W2R; transition_stdRW.S2W; transition_stdRW.S2R; transition_stdRW.R2W; transition_stdRW.R2S];


averages_simulation = [sleep_averages.W2S_transitions; sleep_averages.W2R_transitions;sleep_averages.S2W_transitions; ...
					   sleep_averages.S2R_transitions;sleep_averages.R2W_transitions;sleep_averages.R2S_transitions];
std_simulation = [sleep_std.W2S_transitions; sleep_std.W2R_transitions;sleep_std.S2W_transitions; ...
				  sleep_std.S2R_transitions;sleep_std.R2W_transitions;sleep_std.R2S_transitions];

if strcmp(shift,'AW')
	averages_simulation_AW = averages_simulation;
	std_simulation_AW      = std_simulation;
elseif strcmp(shift,'RW')
	averages_simulation_RW = averages_simulation;
	std_simulation_RW      = std_simulation;
end 



clear input* 
clear latex 

if strcmp(shift,'AW')
	% --- AW table, with simulation and experimental data in same table --- 
	inputAW.makeCompleteLatexDocument = 1;
	inputAW.data = {[num2str(averages_experimental_AW(1,1)) '$\pm$' num2str(std_experimental_AW(1,1))],[num2str(averages_experimental_AW(1,2)) '$\pm$' num2str(std_experimental_AW(1,2))],[num2str(averages_experimental_AW(1,3)) '$\pm$' num2str(std_experimental_AW(1,3))], ...
			  [num2str(averages_experimental_AW(1,4)) '$\pm$'   num2str(std_experimental_AW(1,4))],[num2str(averages_experimental_AW(1,5)) '$\pm$' num2str(std_experimental_AW(1,5))] ; ...  %first row (data)
			  [num2str(averages_simulation_AW(1,1))   '$\pm$'   num2str(std_simulation_AW(1,1))],  [num2str(averages_simulation_AW(1,2)) '$\pm$'   num2str(std_simulation_AW(1,2))],  [num2str(averages_simulation_AW(1,3))   '$\pm$' num2str(std_simulation_AW(1,3))], ...
			  [num2str(averages_simulation_AW(1,4))   '$\pm$'   num2str(std_simulation_AW(1,4))],  [num2str(averages_simulation_AW(1,5)) '$\pm$'   num2str(std_simulation_AW(1,5))] ; ...  %first row (model)
              [num2str(averages_experimental_AW(2,1)) '$\pm$'   num2str(std_experimental_AW(2,1))],[num2str(averages_experimental_AW(2,2)) '$\pm$' num2str(std_experimental_AW(2,2))],[num2str(averages_experimental_AW(2,3)) '$\pm$' num2str(std_experimental_AW(2,3))], ...
			  [num2str(averages_experimental_AW(2,4)) '$\pm$'   num2str(std_experimental_AW(2,4))],[num2str(averages_experimental_AW(2,5)) '$\pm$' num2str(std_experimental_AW(2,5))] ; ...  %second row (data)
			  [num2str(averages_simulation_AW(2,1)) '$\pm$'     num2str(std_simulation_AW(2,1))],  [num2str(averages_simulation_AW(2,2)) '$\pm$'   num2str(std_simulation_AW(2,2))],  [num2str(averages_simulation_AW(2,3))   '$\pm$' num2str(std_simulation_AW(2,3))], ...
			  [num2str(averages_simulation_AW(2,4)) '$\pm$'     num2str(std_simulation_AW(2,4))],  [num2str(averages_simulation_AW(2,5)) '$\pm$'   num2str(std_simulation_AW(2,5))]; ...  %second row (model)
              [num2str(averages_experimental_AW(3,1)) '$\pm$'   num2str(std_experimental_AW(3,1))],[num2str(averages_experimental_AW(3,2)) '$\pm$' num2str(std_experimental_AW(3,2))],[num2str(averages_experimental_AW(3,3)) '$\pm$' num2str(std_experimental_AW(3,3))], ...
			  [num2str(averages_experimental_AW(3,4)) '$\pm$'   num2str(std_experimental_AW(3,4))],[num2str(averages_experimental_AW(3,5)) '$\pm$' num2str(std_experimental_AW(3,5))]; ...  %third row (data)
			  [num2str(averages_simulation_AW(3,1)) '$\pm$'     num2str(std_simulation_AW(3,1))],  [num2str(averages_simulation_AW(3,2)) '$\pm$'   num2str(std_simulation_AW(3,2))] , [num2str(averages_simulation_AW(3,3)) '$\pm$'   num2str(std_simulation_AW(3,3))], ...
			  [num2str(averages_simulation_AW(3,4)) '$\pm$'     num2str(std_simulation_AW(3,4))],  [num2str(averages_simulation_AW(3,5)) '$\pm$'   num2str(std_simulation_AW(3,5))] ; ...  %third row (model)
              [num2str(averages_experimental_AW(4,1)) '$\pm$'   num2str(std_experimental_AW(4,1))],[num2str(averages_experimental_AW(4,2)) '$\pm$' num2str(std_experimental_AW(4,2))],[num2str(averages_experimental_AW(4,3)) '$\pm$' num2str(std_experimental_AW(4,3))], ...
			  [num2str(averages_experimental_AW(4,4)) '$\pm$'   num2str(std_experimental_AW(4,4))],[num2str(averages_experimental_AW(4,5)) '$\pm$' num2str(std_experimental_AW(4,5))] ; ...  %fourth row (data)
			  [num2str(averages_simulation_AW(4,1)) '$\pm$'     num2str(std_simulation_AW(4,1))],  [num2str(averages_simulation_AW(4,2)) '$\pm$'   num2str(std_simulation_AW(4,2))] , [num2str(averages_simulation_AW(4,3)) '$\pm$'   num2str(std_simulation_AW(4,3))], ...
			  [num2str(averages_simulation_AW(4,4)) '$\pm$'     num2str(std_simulation_AW(4,4))],  [num2str(averages_simulation_AW(4,5)) '$\pm$'   num2str(std_simulation_AW(4,5))] ; ...  %fourth row (model)
              [num2str(averages_experimental_AW(5,1)) '$\pm$'   num2str(std_experimental_AW(5,1))],[num2str(averages_experimental_AW(5,2)) '$\pm$' num2str(std_experimental_AW(5,2))],[num2str(averages_experimental_AW(5,3)) '$\pm$' num2str(std_experimental_AW(5,3))], ...
			  [num2str(averages_experimental_AW(5,4)) '$\pm$'   num2str(std_experimental_AW(5,4))],[num2str(averages_experimental_AW(5,5)) '$\pm$' num2str(std_experimental_AW(5,5))] ; ...  %fifth row (data) 
			  [num2str(averages_simulation_AW(5,1)) '$\pm$'     num2str(std_simulation_AW(5,1))],  [num2str(averages_simulation_AW(5,2)) '$\pm$'   num2str(std_simulation_AW(5,2))],  [num2str(averages_simulation_AW(5,3)) '$\pm$'   num2str(std_simulation_AW(5,3))], ...
			  [num2str(averages_simulation_AW(5,4)) '$\pm$'     num2str(std_simulation_AW(5,4))],  [num2str(averages_simulation_AW(5,5)) '$\pm$'   num2str(std_simulation_AW(5,5))] ; ...  %fifth row  (model)
              [num2str(averages_experimental_AW(6,1)) '$\pm$'   num2str(std_experimental_AW(6,1))],[num2str(averages_experimental_AW(6,2)) '$\pm$' num2str(std_experimental_AW(6,2))],[num2str(averages_experimental_AW(6,3)) '$\pm$' num2str(std_experimental_AW(6,3))], ...
			  [num2str(averages_experimental_AW(6,4)) '$\pm$'   num2str(std_experimental_AW(6,4))],[num2str(averages_experimental_AW(6,5)) '$\pm$' num2str(std_experimental_AW(6,5))] ; ... %sixth row (data) 
			  [num2str(averages_simulation_AW(6,1)) '$\pm$'     num2str(std_simulation_AW(6,1))],  [num2str(averages_simulation_AW(6,2)) '$\pm$'   num2str(std_simulation_AW(6,2))],  [num2str(averages_simulation_AW(6,3)) '$\pm$'   num2str(std_simulation_AW(6,3))], ...
			  [num2str(averages_simulation_AW(6,4)) '$\pm$'     num2str(std_simulation_AW(6,4))],  [num2str(averages_simulation_AW(6,5)) '$\pm$'   num2str(std_simulation_AW(6,5))] }; %sixth row (model)

	inputAW.tableColLabels = {'Baseline','W1','W2','W3','W4'};
	% % Set row labels (use empty string for no label):
	inputAW.tableRowLabels = {'W $\rightarrow$ SWS (experiment)','W $\rightarrow$ SWS (simulation)', ...
						  'W $\rightarrow$ REMS (experiment)','W $\rightarrow$ REMS (simulation)', ...
						  'SWS $\rightarrow$ W (experiment)','SWS $\rightarrow$ W (simulation)', ...
						  'SWS $\rightarrow$ REMS (experiment)','SWS $\rightarrow$ REMS (simulation)', ...
						  'REMS $\rightarrow$ W (experiment)','REMS $\rightarrow$ W (simulation)', ...
						  'REMS $\rightarrow$ SWS (experiment)', 'REMS $\rightarrow$ SWS (simulation)'};
	inputAW.dataFormat = {'%.2f',5}; % two digits precision 
	%input.tableColumnAlignment = {'c'};
	inputAW.tableCaption = 'AW';
	% AW table 
	latex = latexTable(inputAW);
save('AW_transition_data.mat','averages_simulation_AW','std_simulation_AW')

elseif strcmp(shift,'RW')
	% ---------------------------------------------------------------------------------------------
	% ---- RW table with simulation and experimental data in same table --- 
	inputRW.makeCompleteLatexDocument = 1;
	inputRW.data = {[num2str(averages_experimental_RW(1,1)) '$\pm$' num2str(std_experimental_RW(1,1))],[num2str(averages_experimental_RW(1,2)) '$\pm$' num2str(std_experimental_RW(1,2))],[num2str(averages_experimental_RW(1,3)) '$\pm$' num2str(std_experimental_RW(1,3))], ...
			  [num2str(averages_experimental_RW(1,4)) '$\pm$'   num2str(std_experimental_RW(1,4))],[num2str(averages_experimental_RW(1,5)) '$\pm$' num2str(std_experimental_RW(1,5))] ; ...  %first row (data)
			  [num2str(averages_simulation_RW(1,1))   '$\pm$'   num2str(std_simulation_RW(1,1))],  [num2str(averages_simulation_RW(1,2)) '$\pm$'   num2str(std_simulation_RW(1,2))],  [num2str(averages_simulation_RW(1,3))   '$\pm$' num2str(std_simulation_RW(1,3))], ...
			  [num2str(averages_simulation_RW(1,4))   '$\pm$'   num2str(std_simulation_RW(1,4))],  [num2str(averages_simulation_RW(1,5)) '$\pm$'   num2str(std_simulation_RW(1,5))] ; ...  %first row (model)
              [num2str(averages_experimental_RW(2,1)) '$\pm$'   num2str(std_experimental_RW(2,1))],[num2str(averages_experimental_RW(2,2)) '$\pm$' num2str(std_experimental_RW(2,2))],[num2str(averages_experimental_RW(2,3)) '$\pm$' num2str(std_experimental_RW(2,3))], ...
			  [num2str(averages_experimental_RW(2,4)) '$\pm$'   num2str(std_experimental_RW(2,4))],[num2str(averages_experimental_RW(2,5)) '$\pm$' num2str(std_experimental_RW(2,5))] ; ...  %second row (data)
			  [num2str(averages_simulation_RW(2,1)) '$\pm$'     num2str(std_simulation_RW(2,1))],  [num2str(averages_simulation_RW(2,2)) '$\pm$'   num2str(std_simulation_RW(2,2))],  [num2str(averages_simulation_RW(2,3))   '$\pm$' num2str(std_simulation_RW(2,3))], ...
			  [num2str(averages_simulation_RW(2,4)) '$\pm$'     num2str(std_simulation_RW(2,4))],  [num2str(averages_simulation_RW(2,5)) '$\pm$'   num2str(std_simulation_RW(2,5))]; ...  %second row (model)
              [num2str(averages_experimental_RW(3,1)) '$\pm$'   num2str(std_experimental_RW(3,1))],[num2str(averages_experimental_RW(3,2)) '$\pm$' num2str(std_experimental_RW(3,2))],[num2str(averages_experimental_RW(3,3)) '$\pm$' num2str(std_experimental_RW(3,3))], ...
			  [num2str(averages_experimental_RW(3,4)) '$\pm$'   num2str(std_experimental_RW(3,4))],[num2str(averages_experimental_RW(3,5)) '$\pm$' num2str(std_experimental_RW(3,5))]; ...  %third row (data)
			  [num2str(averages_simulation_RW(3,1)) '$\pm$'     num2str(std_simulation_RW(3,1))],  [num2str(averages_simulation_RW(3,2)) '$\pm$'   num2str(std_simulation_RW(3,2))] , [num2str(averages_simulation_RW(3,3)) '$\pm$'   num2str(std_simulation_RW(3,3))], ...
			  [num2str(averages_simulation_RW(3,4)) '$\pm$'     num2str(std_simulation_RW(3,4))],  [num2str(averages_simulation_RW(3,5)) '$\pm$'   num2str(std_simulation_RW(3,5))] ; ...  %third row (model)
              [num2str(averages_experimental_RW(4,1)) '$\pm$'   num2str(std_experimental_RW(4,1))],[num2str(averages_experimental_RW(4,2)) '$\pm$' num2str(std_experimental_RW(4,2))],[num2str(averages_experimental_RW(4,3)) '$\pm$' num2str(std_experimental_RW(4,3))], ...
			  [num2str(averages_experimental_RW(4,4)) '$\pm$'   num2str(std_experimental_RW(4,4))],[num2str(averages_experimental_RW(4,5)) '$\pm$' num2str(std_experimental_RW(4,5))] ; ...  %fourth row (data)
			  [num2str(averages_simulation_RW(4,1)) '$\pm$'     num2str(std_simulation_RW(4,1))],  [num2str(averages_simulation_RW(4,2)) '$\pm$'   num2str(std_simulation_RW(4,2))] , [num2str(averages_simulation_RW(4,3)) '$\pm$'   num2str(std_simulation_RW(4,3))], ...
			  [num2str(averages_simulation_RW(4,4)) '$\pm$'     num2str(std_simulation_RW(4,4))],  [num2str(averages_simulation_RW(4,5)) '$\pm$'   num2str(std_simulation_RW(4,5))] ; ...  %fourth row (model)
              [num2str(averages_experimental_RW(5,1)) '$\pm$'   num2str(std_experimental_RW(5,1))],[num2str(averages_experimental_RW(5,2)) '$\pm$' num2str(std_experimental_RW(5,2))],[num2str(averages_experimental_RW(5,3)) '$\pm$' num2str(std_experimental_RW(5,3))], ...
			  [num2str(averages_experimental_RW(5,4)) '$\pm$'   num2str(std_experimental_RW(5,4))],[num2str(averages_experimental_RW(5,5)) '$\pm$' num2str(std_experimental_RW(5,5))] ; ...  %fifth row (data) 
			  [num2str(averages_simulation_RW(5,1)) '$\pm$'     num2str(std_simulation_RW(5,1))],  [num2str(averages_simulation_RW(5,2)) '$\pm$'   num2str(std_simulation_RW(5,2))],  [num2str(averages_simulation_RW(5,3)) '$\pm$'   num2str(std_simulation_RW(5,3))], ...
			  [num2str(averages_simulation_RW(5,4)) '$\pm$'     num2str(std_simulation_RW(5,4))],  [num2str(averages_simulation_RW(5,5)) '$\pm$'   num2str(std_simulation_RW(5,5))] ; ...  %fifth row  (model)
              [num2str(averages_experimental_RW(6,1)) '$\pm$'   num2str(std_experimental_RW(6,1))],[num2str(averages_experimental_RW(6,2)) '$\pm$' num2str(std_experimental_RW(6,2))],[num2str(averages_experimental_RW(6,3)) '$\pm$' num2str(std_experimental_RW(6,3))], ...
			  [num2str(averages_experimental_RW(6,4)) '$\pm$'   num2str(std_experimental_RW(6,4))],[num2str(averages_experimental_RW(6,5)) '$\pm$' num2str(std_experimental_RW(6,5))] ; ... %sixth row (data) 
			  [num2str(averages_simulation_RW(6,1)) '$\pm$'     num2str(std_simulation_RW(6,1))],  [num2str(averages_simulation_RW(6,2)) '$\pm$'   num2str(std_simulation_RW(6,2))],  [num2str(averages_simulation_RW(6,3)) '$\pm$'   num2str(std_simulation_RW(6,3))], ...
			  [num2str(averages_simulation_RW(6,4)) '$\pm$'     num2str(std_simulation_RW(6,4))],  [num2str(averages_simulation_RW(6,5)) '$\pm$'   num2str(std_simulation_RW(6,5))] }; %sixth row (model)

	inputRW.tableColLabels = {'Baseline','W1','W2','W3','W4'};
	% % Set row labels (use empty string for no label):
	inputRW.tableRowLabels = {'W $\rightarrow$ SWS (experiment)','W $\rightarrow$ SWS (simulation)', ...
						  'W $\rightarrow$ REMS (experiment)','W $\rightarrow$ REMS (simulation)', ...
						  'SWS $\rightarrow$ W (experiment)','SWS $\rightarrow$ W (simulation)', ...
						  'SWS $\rightarrow$ R (experiment)','SWS $\rightarrow$ R (simulation)', ...
						  'R $\rightarrow$ W (experiment)','R $\rightarrow$ W (simulation)', ...
						  'R $\rightarrow$ SWS (experiment)', 'R $\rightarrow$ SWS (simulation)'};
	inputRW.dataFormat = {'%.2f',5}; % two digits precision 
	%input.tableColumnAlignment = {'c'};
	inputRW.tableCaption = 'RW';
	% RW table 
	latex = latexTable(inputRW);
save('RW_transition_data.mat','averages_simulation_RW','std_simulation_RW')
end 






