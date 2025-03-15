% T-test testing


% load some sample data raw data  (W1 SWS bout durations)
%x = [24.3821   24.8241   22.6619   13.4639   19.3536   40.0702   19.8759   27.8587   28.2995   24.3571   17.8642   12.9545];
x = [32.1811   20.6529   22.1971   18.0329   26.3291   35.2443   29.5244   32.9253   28.5254   32.1811   25.2583 17.9819];
y = [ 18.4331   20.5382   28.6367   18.9542   18.6370   23.7147   20.6098   18.4331   25.9081   30.8052   27.9768 18.3460   16.6443   25.7817   21.4428 ];


% compute t statistic using formula
xbar = mean(x);
ybar = mean(y);
sx = std(x);
sy = std(y);
nx=length(x);
ny=length(y);

sp = sqrt(( (nx-1)*sx^2 + (ny-1)*sy^2)/(nx+ny-2));
t = (xbar-ybar)/(sp*sqrt((1/nx)+(1/ny)))

%t=(xbar-ybar)/(sqrt((sx^2/nx)+(sy^2/ny)));

v = length(x) + length(y) -2;  %d.f.  

tdist2T = @(t,v) (1-betainc(v/(v+t^2),v/2,0.5));    % 2-tailed t-distribution

tdist2T(t,v)


% and using built-in function 
[H,P,CI,stats]=ttest2(x,y)
