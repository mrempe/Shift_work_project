% script to load temperature data from shift work experiments
% and smoothe the data for each recording 
% the results are written to a new .xls file

addpath '\\FS1\WisorData\MATLAB\Brennecke\matlab-pipeline\Matlab\etc\matlab-utils'


filename = 'AWDD individual raw data.xlsx'

window_width = 60;		% width of window (in data points)
reject 		 = 5;				% replace a data point with the mean of the previous window_width if it is more than "reject" standard deviations from that mean

% determine how many sheets are in the workbook
[status,sheets] = xlsfinfo(filename);
numOfSheets 	= numel(sheets);


% load in the .xls file (perhaps go one sheet at a time)
for i=1:numOfSheets
	[NUM{i},TXT{i}] = xlsread(filename,i);
end

disp('Finished loading the excel file into Matlab.......')

% Find the column with label 'Temp' in each sheet
for i=1:numOfSheets
	Temp_column(i) = find(strcmp(TXT{i}(1,:),'Temp'));
end


% Set up a cell array for the temperature data in each sheet
for i=1:numOfSheets
	temp_data{i} = NUM{i}(:,Temp_column(i));
end


% find the first and last row of the temperature data (the first and last indices of non-NaN entries)
for i=1:numOfSheets
	validIndices{i} = find(~isnan(temp_data{i}));
	firstnonNan(i) = validIndices{i}(1);
	lastnonNan(i) = validIndices{i}(end);
end



disp('STarting to smoothe the data..........')
% make a loop here that calls smootheLactate_variable_width.m for each recording.
for i=1:numOfSheets
		[numchanged,SmoothedData{i}]=SmootheLactate_variable_width(temp_data{i}(firstnonNan:lastnonNan),window_width,reject);
end

% put the NaNs back into the
for i=1:numOfSheets
	SmoothedData_withNaN{i} = temp_data{i}
	SmoothedData_withNaN{i}(firstnonNan(i):lastnonNan(i)) = SmoothedData{i}; 
end



disp('Done smoothing, now time to write a new excel file')
% write them all back into the new .xls file
 % copy the .xls file first
newfilename = 'AWDD_individual_raw_data_smoothed.xlsx'
copyfile(filename,newfilename,'f');
xl = XL(newfilename);

for i=1:numOfSheets
	sheet(i) = xl.Sheets.Item(i);
	xl.setCells(sheet(i),[2,Temp_column(i)],SmoothedData_withNaN{i},'FFEE00');
end



