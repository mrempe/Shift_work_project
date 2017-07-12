function[numchanged,SmoothedData]=SmootheLactate_variable_width(InputVector,window_width,reject);
%this function was made to work with a 1-dimensional matrix (a vector called InputVector) that contains
%only the lactate data of interest. 
% window_width:  width of the window (in data)  
% reject:        number of standard deviations that a point must be away from the mean to be replaced by the average 



SmoothedData(:,1)=InputVector;                  %Establish column 1 of matrix; this is the raw data.
SmoothedData(1:window_width,2)=InputVector(1:window_width);         %For first ten values of smoothed data, must output raw data because they lack ten previous values to compare to.

MatrixforMeanSEM=zeros(size(SmoothedData,1)-window_width,window_width+1); %create a matrix with ten fewer rows than original vector has rows.  We will subject to smoothing every value after the first ten.

for matrixcolumns=1:window_width+1  %create each column from the original vector shifted one point to the left per row. This aligns consecutive values in columns of ten.   
    MatrixforMeanSEM(:,matrixcolumns)=SmoothedData(matrixcolumns:length(SmoothedData)-(window_width+1-matrixcolumns),1); %  matrix row 1 now has values 1-11 in a row, row 2 has values 2-12 in a row, etc
end

FlipMatrix=MatrixforMeanSEM';  % Each column now represents one input row (ten consecutive values for calculating mean + SEM) from row 11 through to last row.

numchanged=abs(FlipMatrix(window_width+1,:)-mean(FlipMatrix(1:window_width,:)))./((std(FlipMatrix(1:window_width,:))/sqrt(window_width))*reject)>1; %Does absolute value of ((value minus mean of previous five)/five*SEM of previous ten) exceed 1?
FlipMatrix(window_width+1,find(numchanged>0))=mean(FlipMatrix(1:window_width,find(numchanged>0))); %if yes, reset means in flipped Matrix
SmoothedData(window_width+1:end,2)=FlipMatrix(window_width+1,:)';  %now replace values in row 2 with flipped matrix values.
numchanged=sum(numchanged); %sums the values in numchanged to tally total number of changes.
return
