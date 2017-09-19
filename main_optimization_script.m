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
load('FIG6_Experimental_Data.mat','wake_episodes_AW_averages','SWS_episode_duration_AW_averages');
actual{1} = wake_episodes_AW_averages;   % this variable is in the FIG6_Experimental_Data.mat workspace
actual{2} = SWS_episode_duration_AW_averages;



% ---------------------------------------------------------------------------
% ---- Set up optimization --------------------------------------------------
FitnessFunction = @multiobjective;
num_variables = 2;
lb = [8,3];   % lower bounds.  check these
ub = [9,4];       % upper bounds.  check these
A = [];
b = [];
Aeq = [];
beq = [];

[x,Fval,exitFlag,Output] = gamultiobj(FitnessFunction,num_variables,A,b,Aeq,beq,lb,ub);
% ---------------------------------------------------------------------------
% ---------------------------------------------------------------------------


