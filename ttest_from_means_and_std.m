function [t,p] = ttest_from_means_and_std(xbar,ybar,stdx,stdy,nx,ny);
%
% USAGE:  [t,p] = ttest_from_means_and_std(xbar,ybar,ex,ey);
%
%
% Carry out a two sample t-test to test if the means from the two samples
% are equal.  This is equivalent to matlab's built-in ttest2.m with the 
% advantage that you don't need the raw data.  You only need the following:
%
% xbar: mean of first group   
% ybar: mean of second group
% stdx: standard deviation of first group
% stdy: standard deviation of the second group
% nx:  number of samples in first group
% ny:  number of samples in second group
% 
%
% returns:
%  t:  the value of the test statistic
% p:  the p-value
%
% Note:
% SEM = std/sqrt(N) so std = SEM*sqrt(N);

%xbar = mean(x);
%ybar = mean(y);
sx = stdx; %std(x);
sy = stdy; %std(y);
%nx=length(x);
%ny=length(y);

sp = sqrt(( (nx-1)*sx^2 + (ny-1)*sy^2)/(nx+ny-2));
t = (xbar-ybar)/(sp*sqrt((1/nx)+(1/ny)));

%t=(xbar-ybar)/(sqrt((sx^2/nx)+(sy^2/ny)));

v = nx + ny -2;  %d.f.  

tdist2T = @(t,v) (1-betainc(v/(v+t^2),v/2,0.5));    % 2-tailed t-distribution

p=1-tdist2T(t,v);

