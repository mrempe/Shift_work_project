function [S,state,avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time,...
		  std_wake_episodes_vs_time,std_SWS_episode_duration_vs_time,std_REMS_episode_duration_vs_time]=two_process_model_with_markov_chain(total_time,taui,taud,shift,makeplots)
% USAGE: [S,state,avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time]=two_process_model_with_markov_chain(total_time,taui,taud,shift,makeplots)
%
% This function simulates the changes in sleep state using a markov chain model similar to Kemp and Kamphuisen SLEEP 1986
% The markov chain generates sleep states based on the values of the ahat terms that derive their values
% from the level of the homeostat and the Circadian curve.  The homeostat goes up with time constant taui when the 
% sleep state is W or R and goes down with time constant taud when the sleep state is S.
% 
% 
% The ahat_j_i parameters below refer to the transition rates.  these are the probability that at one step the state will be j 
% given that the previous state was i.
% 
% The W terms below are the wait times; the time spent in each state 
% Sample usage using taui and taud from Franken's paper for rats:
% two_process_model_with_markov_chain(120,8.6,3.2)
% 
% for the AW case:
%  [S,num_wake_episodes,mean_SWS_length,mean_REM_length]=two_process_model_with_markov_chain(134,8.6,3.2,'AW',1)	
%
% for the RW case:
%  [S,num_wake_episodes,mean_SWS_length,mean_REM_length]=two_process_model_with_markov_chain(134,8.6,3.2,'RW',1)
%

%AW: [38 46 62 70 86 94 110 118]
%RW: [26 34 50 58 74 82 98 106]

if nargin == 3
	sleep_dep_start_stop_times = [];
	makeplot = 0;
end 

if nargin == 4
	makeplot = 0;
end



% --- Set up the time vector (with increments of 10 seconds)
t=0:10/60/60:total_time;
dt=10/60/60;
num_days = total_time/24;
% -----------------------------------------------------------


% --- Set up the sleep deprivation, if applied
if strcmp(shift,'AW')
	sleep_dep_start_stop_times = [38 46 62 70 86 94 110 118];
elseif strcmp(shift,'RW')
	sleep_dep_start_stop_times = [26 34 50 58 74 82 98 106];
else
	sleep_dep_start_stop_times =[];
end 
sleep_dep = zeros(size(t));
if ~isempty(sleep_dep_start_stop_times)
	if mod(length(sleep_dep_start_stop_times),2) ~= 0
		error('sleep_dep_start_stop_times must have an even number of elements')
	end 

	sleep_dep_start_times = sleep_dep_start_stop_times(1:2:end-1);
	sleep_dep_end_times	  = sleep_dep_start_stop_times(2:2:end);

	for i=1:length(sleep_dep_start_times)
		ind_sleep_dep_start(i) = find(abs(t-sleep_dep_start_times(i))<1e-6);
		ind_sleep_dep_end(i)   = find(abs(t-sleep_dep_end_times(i))<1e-6);
		sleep_dep(ind_sleep_dep_start(i):ind_sleep_dep_end(i)) = 1;  % 23-25 hours
	end 

end
% -----------------------------------------------------------



% below are the estimates for the transition probabilities in units of 1/s
% ahat_W_S =0.0033*10;


% ahat_S_W =0.0114*10;


% ahat_W_R =0.0039*10;


% ahat_R_W =0;


% ahat_S_R =0.0030*10;


% ahat_R_S =0.0015*10;

ahat_W_S = 0.0023;


ahat_S_W = 0.0075;


ahat_W_R = 0.0022;


ahat_R_W = 3.1024e-04;


ahat_S_R = 0.0047;


ahat_R_S = 0.0019;


% these estimates were developed using the first 12 hours of baseline, with both RW and AW. These are averages over all recordings.
ahat_W_S=0.0028;
ahat_S_W=0.0095;
ahat_W_R=0.0046;
ahat_R_W=3.6982e-04;
ahat_S_R=0.0043;
ahat_R_S=0.0022;

% These estimates were developed using the first 24 hours of the recordings (baseline), with both RW and AW.  these are averages over all recordings.

ahat_W_S=0.0035;
ahat_S_W=0.0045;
ahat_W_R=0.0057;
ahat_R_W=1.2374e-04;
ahat_S_R=0.0047;
ahat_R_S=0.0023;
% --------------------------------------------------------------

% These are estimates that I developed to match baseline episode duration.  I modified the numbers found using first 24 hours with both AW and RW
ahat_W_S=0.004;
ahat_S_W=0.006;
ahat_W_R=0.007;
ahat_R_W=1.2374e-04;
ahat_S_R=0.007;
ahat_R_S=0.0035;

ahat_W_S_base=0.004;
ahat_W_S_base=0.003;
ahat_S_W_base=0.006;
ahat_W_R_base=0.007;
ahat_R_W_base=1.2374e-04;
ahat_S_R_base=0.007;
ahat_R_S_base=0.001;
% Now make the ahat values for SWS depend on S-C, a measure of sleepiness from Achermann 2004.  Wake depends on 1-S+C, a measure of alertness from Achermann 2004
% REMS ahat value depends on 1-C, only on the circadian curve.    
% *****  ahat_R_S = alpha*(S-C)
% *****  ahat_R_W = beta*(S-C)
% *****  ahat_S_W = gamma*(S-C)
% *****  ahat_S_R = delta*(S-C)
% *****  ahat_W_S = sigma*(1-S+C)  wake percentages prop. to C-S not S-C
% *****  ahat_W_R = mu*(1-S+C)
alpha = 0.0035/0.73;
alpha = .0015/0.73;
%alpha=alpha*.75;    % I'm using 1.1 because that is the value of 1-C when REMS percentage should be about at what you get when you use ahat_R_S_base
beta  = 1.2e-4/0.73;
gamma = 0.007/0.3;
delta = 0.007/0.3;
sigma = 0.004/0.65;
mu    = 0.007/0.65;


% -----  Circadian curve -----
circ_amp = 0.25; %0.128;
circ_curve = circ_amp*sin((pi/12)*-t);
C = circ_curve;
% ----------------------------
taui_work = 3;
taui_work = taui;


num_simulations = 20;
% ----- Initialize S, state and C
state(1,:) = char(repmat('S',1,num_simulations));   % initialize the first row of state matrix to S
S=zeros(length(t),num_simulations);
S(1,:) = 0.3;					% starting value for S, the homeostat
% -------------------------------


% ----- Tau values that depend on time based on our simple two-process modeling -----
if strcmp(shift,'AW')
	%taui = zeros(size(t));
	taud = zeros(size(t));
	%taui(1:8640) = 12.47;
	%taui(8641:end) = 10.855;
	taud(1:16560) = 3.2;
	taud(16561:end) = 5.4;
	%taui_work = taui;
end 
if strcmp(shift,'RW')
	%taui=zeros(size(t));
	taud=zeros(size(t));
	%taui(1:8640) = 13.62;
	%taui(8641:end) = 9.65;
	taud(1:12240) = 3.2;
	taud(12241:end) = 5.4;
	%taui_work = taui;
end 
taui = taui*ones(size(t));
%taud = taud*ones(size(t));;
taui_work = taui;


% new version of ahat_W_S and ahat_W_R
% instead of a linear function of alertness (1-S+C) make them 
% nonlinear functions that nearly match the linear form for
% values of alertness in the normal range, but then get more extreme
% farther from that range.
% ahat_W_S = c1*(alertness-0.7)^3+0.006*(alertness-0.7)+0.0042;
% where c1 can be varied. 
% c1=0.8;
% c2=0.8;
% c3=0.8;
c1=0.01;
c2=0.01;
c3=0.01;


% Run the MC simulation for several different runs, each column corresponds to a different run
for run = 1:num_simulations
	%clear ahat_*
	i=1;
	while i<length(t)
		
		% first update the transition rates
		 ahat_R_S(i) = alpha*(1-1.4*C(i));
		% ahat_R_W(i) = beta *(1-C(i));
		%ahat_R_S(i) = alpha*(1-S(i,run));
		 % ahat_R_S(i) = c1*(1-S(i,run)-0.7)*(1-S(i,run)-0.7)*(1-S(i,run)-0.7)+0.00479*(1-S(i,run)-0.7)+0.003356;
		 % if ahat_R_S(i) <= 0
		 % 	ahat_R_S(i) = ahat_R_S_base/10;
		 % end 
		%ahat_R_S(i) = ahat_R_S_base;

		%ahat_R_S(i) = ahat_R_S_base;
		%ahat_R_W(i) = beta *(1-S(i,run));
		ahat_R_W(i) = ahat_R_W_base;
		ahat_S_W(i) = gamma*(S(i,run)-C(i))-0.0010;
		%ahat_S_R(i) = delta*(S(i,run)-C(i));
		sleepiness = S(i,run)-C(i);
		ahat_S_R(i) = c3*(sleepiness-0.3)*(sleepiness-0.3)*(sleepiness-0.3)+0.0233*(sleepiness-0.3)+0.007;
		ahat_S_R(i) = ahat_S_R(i)-.001;
		if ahat_S_R(i) <= 0
			ahat_S_R(i) = ahat_S_R_base/10;
		end 
		%ahat_S_R(i) = ahat_S_R_base;
		%ahat_W_S(i) = sigma*(1-S(i,run)+C(i));  
		% ahat_W_R(i) = mu   *(1-S(i,run)+C(i));
		alertness = 1-S(i,run)+C(i);
		%ahat_W_S(i) = sigma*alertness;
		ahat_W_S(i) = c1*(alertness-0.7)*(alertness-0.7)*(alertness-0.7)+0.006*(alertness-0.7)+0.0042;
		ahat_W_S(i) = ahat_W_S(i)+ 0.002;% + .0025;
		if ahat_W_S(i) <=0
		ahat_W_S(i) =   ahat_W_S_base/10;  % don't let ahat be negative. limit its minimum to be 1/10 of the base value
		end
		%ahat_W_R(i) = mu *(1-S(i,run)+C(i));
		ahat_W_R(i) = c2*(alertness-0.7)*(alertness-0.7)*(alertness-0.7)+0.01*(alertness-0.7)+0.007;
		ahat_W_R(i) = ahat_W_R(i) - 0.0005;
		if ahat_W_R(i) <= 0
			ahat_W_R(i) = ahat_W_R_base/10;
		end



		if state(i,run)=='W'
			x=rand(2,1);
			W_RW = -log(x(1))/ahat_R_W(i);
			W_SW = -log(x(2))/ahat_S_W(i);
			Wshortest_epochs = ceil(min([W_RW W_SW])/10);  % divide by 10 to get epochs, not seconds.
			if Wshortest_epochs < 0 
				error('Wshortest_epochs<0 in W') 
			end 
			if i+Wshortest_epochs > length(t) 
				Wshortest_epochs = length(t)-i; 
				
			end % truncate if the wait time puts you past the end of t
			if W_RW < W_SW
				next_state = 'R';
			else
				next_state = 'S';
			end
			state(i+1:i+Wshortest_epochs,run)='W';
			state(i+Wshortest_epochs+1,run)=next_state;  % after the run of Wake is finished set the next state depending on which W was shortest
			for j=1:Wshortest_epochs				 % update the homeostat
				S(i+j,run)=1-(1-S(i+j-1,run))*exp(-dt/taui(i));
			end


		elseif state(i,run)=='S'
			x=rand(2,1);
			W_RS = -log(x(1))/ahat_R_S(i);
			W_WS = -log(x(2))/ahat_W_S(i);
			Wshortest_epochs = ceil(min([W_RS W_WS])/10);
			if Wshortest_epochs < 0 
				error('Wshortest_epochs<0 in S') 
			end 
			if i+Wshortest_epochs > length(t) 
				Wshortest_epochs = length(t)-i; 
			end % truncate if the wait time puts you past the end of t
			if W_RS < W_WS
				next_state = 'R';
			else
				next_state = 'W';
			end
			state(i+1:i+Wshortest_epochs,run)='S';
			state(i+Wshortest_epochs+1,run)=next_state;  % after the run of S is finished set the next state depending on which W was shortest
			for j=1:Wshortest_epochs
				S(i+j,run) = S(i+j-1,run)*exp(-dt/taud(i));
			end

	

		elseif state(i,run)=='R'
			x=rand(2,1);
			W_WR = -log(x(1))/ahat_W_R(i);
			W_SR = -log(x(2))/ahat_S_R(i);
			Wshortest_epochs = ceil(min([W_WR W_SR])/10);
			if Wshortest_epochs < 0 
				error('Wshortest_epochs<0 in R') 
			end 
			if i+Wshortest_epochs > length(t) 
				Wshortest_epochs = length(t)-i; 
			end % truncate if the wait time puts you past the end of t
			if W_WR < W_SR
				next_state = 'W';
			else
				next_state = 'S';
			end
			state(i+1:i+Wshortest_epochs,run)='R';
			state(i+Wshortest_epochs+1,run)=next_state;  % after the run of REMS is finished set the next state depending on which W was shortest
			for j=1:Wshortest_epochs				 % update the homeostat
				S(i+j,run)=1-(1-S(i+j-1,run))*exp(-dt/taui(i));
			end

		end
		if strcmp(next_state,'W') | strcmp(next_state,'R')
			S(i+Wshortest_epochs+1,run) = 1-(1-S(i+Wshortest_epochs,run))*exp(-dt/taui(i));
		else
			S(i+Wshortest_epochs+1,run) = S(i+Wshortest_epochs,run)*exp(-dt/taud(i)); 
		end

		% Finally, override the Markov Chain sleep state if sleep deprivation is turned on
		if i+Wshortest_epochs+1 < length(t)
			if sum(find(sleep_dep(i+1:i+Wshortest_epochs+1)))>0
				sleep_dep_locs_this_cycle = find(sleep_dep(i+1:i+Wshortest_epochs+1));
				for j=sleep_dep_locs_this_cycle
					state(i+1+j-1,run) = 'W';
					S(i+1+j-1,run) = 1-(1-S(i+1+j-2,run))*exp(-dt/taui_work(i));
				end
			end
		end

		% update the ahat values, since S has been updated
		for j=1:Wshortest_epochs				 % update the homeostat
			ahat_S_W(i+j) = gamma*(S(i+j,run)-C(i));
			ahat_S_R(i+j) = delta*(S(i+j,run)-C(i));
			%ahat_W_S(i+j) = sigma*(1-S(i+j,run)+C(i));  
			alertness = 1-S(i+j,run)+C(i);
			ahat_W_S(i+j) = c1*(alertness-0.7)*(alertness-0.7)*(alertness-0.7)+0.006*(alertness-0.7)+0.0042;
			ahat_W_R(i+j) = mu   *(1-S(i+j,run)+C(i));
		end



		i=i+Wshortest_epochs+1;
	end
end  % looping over num_simulations


 


for j=1:num_simulations
	wake_percentage(j) = length(find(state(:,j)=='W'))/size(state,1);
	SWS_percentage(j)  = length(find(state(:,j)=='S'))/size(state,1);
	REM_percentage(j)  = length(find(state(:,j)=='R'))/size(state,1);
end

av_wake_percentage = mean(wake_percentage);
av_SWS_percentage  = mean(SWS_percentage);
av_REM_percentage  = mean(REM_percentage);



% ---- Compute average episode length -----
[avg_wake_episodes_vs_time,avg_SWS_episode_duration_vs_time,avg_REMS_episode_duration_vs_time,...
 std_wake_episodes_vs_time,std_SWS_episode_duration_vs_time,std_REMS_episode_duration_vs_time] = group_and_plot_Wepisodes_SWS_REMS_duration(shift,state,num_simulations);



% for j=1:num_simulations
% 	runs = contiguous(state(:,j),['W' 'S' 'R']);

% 	wake_runs{j}  = runs{1,2};
% 	sleep_runs{j} = runs{2,2};
% 	REM_runs{j}   = runs{3,2};

% 	num_wake_episodes(j) = size(wake_runs{j},1);


	

% 	for i=1:size(wake_runs{j},1)
%     	w_episode_length{j}(i) = wake_runs{j}(i,2)-wake_runs{j}(i,1)+1;
% 	end

% 	for i=1:size(sleep_runs{j},1)
%     	s_episode_length{j}(i) = sleep_runs{j}(i,2)-sleep_runs{j}(i,1)+1;
    
% 	end

% 	for i=1:size(REM_runs{j},1)
% 		r_episode_length{j}(i) = REM_runs{j}(i,2)-REM_runs{j}(i,1)+1;
% 	end


% 	mean_SWS_length(j)  = mean(s_episode_length{j}) * 10;
% 	mean_wake_length(j) = mean(w_episode_length{j}) * 10;
% 	mean_REM_length(j)  = mean(r_episode_length{j}) * 10;
% end

% global_av_SWS_length  = mean(mean_SWS_length)
% global_av_wake_length = mean(mean_wake_length)
% global_av_REM_length  = mean(mean_REM_length)
% global_av_wake_episodes_per24hr = mean(num_wake_episodes)/num_days


if makeplots
	
	% ---- first make a shaded plot showing average trace of the homeostat ----
	if length(S) > length(t)
		difflength = length(S)- length(t);
		tnew = [t t(end)+dt:dt:t(end)+difflength*dt];
		circ_curvenew = circ_amp*sin((pi/12)*-tnew);
	else
		tnew = t;
		circ_curvenew = circ_curve;
	end 

	figure
	err = std(S,0,2);
	% hold on
	% plot(t,mean(S,2))
	% size(t)
	% size(mean(S,2))
	% size(err)
	% patch([t' fliplr(t')],[mean(S,2)+err fliplr(mean(S,2)-err)],[0.7 0.7 0.7]);
	fill([tnew';flipud(tnew')],[mean(S,2)-err;flipud(mean(S,2)+err)],[0.9 0.9 0.9],'linestyle','none');
	line(tnew',mean(S,2))
	ax=gca;
	ax.XTick = 0:12:t(end);

	figure
	plot(tnew',mean(S,2)-0.5*circ_curvenew')
	legend('S-0.5*C')


	figure
	plot(tnew',mean(S,2)-circ_curvenew',tnew',1-mean(S,2)+circ_curvenew','r')
	ax=gca;
	ax.XTick = 0:12:t(end);
	legend('Sleepiness','Alertness')

	figure
	%plot(tnew',circ_curvenew'./mean(S,2)+1)
	plot(tnew',1-mean(S,2))
	ax=gca;
	ax.XTick = 0:12:t(end);
	title('1-S')
	grid on
	
	% TEST: plot the ahat values over time
 	% figure
 	% size(ahat_R_S)
 	% size(ahat_W_S)
 	% size(t)
 	% plot(tnew,ahat_R_S,tnew,ahat_W_S,'r',tnew,ahat_W_R,'y',tnew,ahat_S_R,'k')
 	% legend('ahatRS','ahatWS','ahatWR','ahatSR')



	% ---- Then make a colored shaded plot of percentages of states, like Figure 5 in the experimental manuscript
	% compute sleep state percentages of each two-hour window (averaged for each window over all runs of the simulation) 
	make_shaded_state_percentages_plot(t,state,sleep_dep_start_stop_times)

end


