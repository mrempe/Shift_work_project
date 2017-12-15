% main optimization script
%
%
% This script optimally chooses parameter values to minimize error between
% model output and experimental data.  Starting with number of wake episodes 
% and duration of SWS episodes. 


% ---------------------------------------------------------------------------
% Set up actual (experimental) values. These are what I am comparing simulation output to
% actual{1} = [];  % experimental Wake episode data
% actual{2} = [];  % experimental SWS duration data 
 % NEED to make sure multiobjective is reading in actual somehow. 
%load('FIG6_Experimental_Data.mat','wake_episodes_AW_averages','SWS_episode_duration_AW_averages');
load('all_experimental_data.mat');
clear actual 
actual.wake_episode_duration = wake_episode_duration_RW_averages ;   % this variable is in the FIG6_Experimental_Data.mat workspace
actual.sws_episode_duration  = SWS_episode_duration_RW_averages;
actual.rems_episode_duration = REMS_episode_duration_RW_averages;

actual.num_wake_episodes = num_wake_episodes_RW_averages;
actual.num_sws_episodes  = num_sws_episodes_RW_averages;
actual.num_rems_episodes = num_REMS_episodes_RW_averages;

actual.percent_in_wake = daily_percent_in_wake_RW_averages;
actual.percent_in_sws  = daily_percent_in_sws_RW_averages;
actual.percent_in_rems = daily_percent_in_REMS_RW_averages;

%actual{3} = REMS_episode_duration_AW_averages;



% ---------------------------------------------------------------------------
% ---- Set up optimization --------------------------------------------------
FitnessFunction = @(x)multiobjective(x,actual);
num_variables = 8;
lb = [8.5,3.1,1e-5,1e-5,1e-5,1e-5,1e-5,1e-5];   % lower bounds.  check these
ub = [8.7,3.3,0.1,0.1,0.1,0.1,0.1,0.1];       % upper bounds.  check these
%lb = [8.5,3.1];   % lower bounds.  check these
%ub = [8.7,3.3];       % upper bounds.  check these
A = [];
b = [];
Aeq = [];
beq = [];
% options=optimoptions(@fmincon,'TolX',1e-5);
% oldoptions = optimoptions(@fmincon);
% options = optimoptions(oldoptions,'PlotFcn',@gaplotpareto);
% options = gaoptimset('Display','iter','PlotFcns',@gaplotpareto,'TimeLimit',500);
% options = gaoptimset('TimeLimit',20000,'TolFun',10,'FitnessLimit',1);
% [K,Fval,exitFlag,Output,population,scores] = gamultiobj(FitnessFunction,num_variables,A,b,Aeq,beq,lb,ub,options);
% ---------------------------------------------------------------------------
% ---------------------------------------------------------------------------
% Re-do using multiobjective goal attainment, rather than genetic algorithm
goal=[0.5, 0.5, 0.5, 0.5, 0.5, 0.5];  % how small I want the errors to be
weight = abs(goal);
%K0 = [8.6, 3.25, 0.003, 0.006, 0.007, 1.2374e-04,0.007,0.001];  %initial guesses for the parameters I'm trying to optimize
%K0 = [8.6, 3.25, 0.005, 0.01, 0.007, 1.2374e-04,0.007,0.01];  %initial guesses for the parameters I'm trying to optimize
% K0 = [10, 4, 0.005, 0.01, 0.007, 1.2374e-04,0.007,0.01];  %initial guesses for the parameters I'm trying to optimize

%K0 = [3.25, 1, 0.007, 1.2374e-04, 0.007, 0.001];
%K0 = [8.6, 3.25];  %initial guesses for the parameters I'm trying to optimize
 % new version 11.30.17: optimize using taud, gamma, mu, c1,c2,WS_offset, SR_offset not any of the ahat base variables.
%K0 = [3.25, 3, 0.007/0.65, 0.5, 1, 0.01, 0.006]; %K0 = [3.25, 3, 0.007/0.65, 0.5, 0.1, 0.0042, 0.006];

% version 12.13: optimize using taud,gamma,mu,delta,c1,c2,WS_offset, SR_offset
K0 = [ 3.25, 3, 0.015, 0.002,0.5,0.1,0.0042,0.006];

% options for fgoalattain
%  options = optimoptions('fgoalattain','Display','iter');
%  %options = optimoptions('fmincon','GoalsExactAchieve',0,'FunValCheck','on','Display','iter-detailed','TolFun',1e-2,'TolX',1e-6,'TolCon',1e-2,'PlotFcns',@optimplotfval);
%  options = optimoptions('fgoalattain','Display','iter-detailed','TolFun',1e-2,'TolX',1e-2,'TolCon',1e-2,'PlotFcns',@optimplotfval);

% [K,fval,attainfactor,exitflag,output]=fgoalattain(FitnessFunction,K0,goal,weight,[],[],[],[],lb,ub,[],options);


% options for fmincon
%options = optimoptions('fminimax','PlotFcn',@optimplotfval,'Display','iter-detailed');
%[K,Fval,maxfval,exitFlag,Output,lambda] = fminimax(FitnessFunction,K0,A,b,Aeq,beq,lb,ub,[],options);  % produced errors in group_and_plot script


% fminsearch
options = optimset('Display','iter','PlotFcns',@optimplotfval);
[K,fval,exitflag,output]=fminsearch(FitnessFunction,K0,options);