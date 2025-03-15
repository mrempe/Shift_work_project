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


averages_experimental_AW = [transition_averagesAW.W2S; transition_averagesAW.W2R; transition_averagesAW.S2W; transition_averagesAW.S2R; transition_averagesAW.R2W; transition_averagesAW.R2S];
std_experimental_AW = [transition_stdAW.W2S; transition_stdAW.W2R; transition_stdAW.S2W; transition_stdAW.S2R; transition_stdAW.R2W; transition_stdAW.R2S];


averages_experimental_RW = [transition_averagesRW.W2S; transition_averagesRW.W2R; transition_averagesRW.S2W; transition_averagesRW.S2R; transition_averagesRW.R2W; transition_averagesRW.R2S];
std_experimental_RW = [transition_stdRW.W2S; transition_stdRW.W2R; transition_stdRW.S2W; transition_stdRW.S2R; transition_stdRW.R2W; transition_stdRW.R2S];


averages_simulation_AW = [zeros(6,5)];
std_simulation_AW = [zeros(6,5)];


averages_simulation_RW = zeros(6,5);
std_simulation_RW = zeros(6,5);

clear input* 
clear latex 


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
inputAW.tableRowLabels = {'W $\rightarrow$ SWS (data)','W $\rightarrow$ SWS (simulation)', ...
						  'W $\rightarrow$ REMS (data)','W $\rightarrow$ REMS (simulation)', ...
						  'SWS $\rightarrow$ W (data)','SWS $\rightarrow$ W (simulation)', ...
						  'SWS $\rightarrow$ R (data)','SWS $\rightarrow$ R (simulation)', ...
						  'R $\rightarrow$ W (data)','R $\rightarrow$ W (simulation)', ...
						  'R $\rightarrow$ SWS (data)', 'R $\rightarrow$ SWS (simulation)'};
inputAW.dataFormat = {'%.3f',5}; % three digits precision 
%input.tableColumnAlignment = {'c'};
inputAW.tableCaption = 'AW';
% AW table 
latexAW = latexTable(inputAW);



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
inputRW.tableRowLabels = {'W $\rightarrow$ SWS (data)','W $\rightarrow$ SWS (simulation)', ...
						  'W $\rightarrow$ REMS (data)','W $\rightarrow$ REMS (simulation)', ...
						  'SWS $\rightarrow$ W (data)','SWS $\rightarrow$ W (simulation)', ...
						  'SWS $\rightarrow$ R (data)','SWS $\rightarrow$ R (simulation)', ...
						  'R $\rightarrow$ W (data)','R $\rightarrow$ W (simulation)', ...
						  'R $\rightarrow$ SWS (data)', 'R $\rightarrow$ SWS (simulation)'};
inputRW.dataFormat = {'%.3f',5}; % three digits precision 
%input.tableColumnAlignment = {'c'};
inputRW.tableCaption = 'RW';
% AW table 
latexRW = latexTable(inputRW);



