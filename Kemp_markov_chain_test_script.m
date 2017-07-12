% script to test the Markov Chain method of Kemp SLEEP 1986
%
% 
% aahat_W_S =0.0033*10;


% ahat_S_W =0.0114*10;


% ahat_W_R =0.0039*10;


% ahat_R_W =0;


% ahat_S_R =0.0030*10;


% ahat_R_S =0.0015*10;

ahat_W_S =0.0023


ahat_S_W =0.0075


ahat_W_R =0.0022


ahat_R_W =3.1024e-04


ahat_S_R =0.0047


ahat_R_S =0.0019


% these estimates were developed using the first 12 hours of baseline, with both RW and AW. These are averages over all recordings.
ahat_W_S=0.0028
ahat_S_W=0.0095
ahat_W_R=0.0046
ahat_R_W=3.6982e-04
ahat_S_R=0.0043
ahat_R_S=0.0022

% These estimates were developed using the first 24 hours of the recordings (baseline), with both RW and AW.  these are averages over all recordings.

ahat_W_S=0.0035
ahat_S_W=0.0045
ahat_W_R=0.0057
ahat_R_W=1.2374e-04
ahat_S_R=0.0047
ahat_R_S=0.0023

clear state i 


state(1) = 'S';

num_steps = 4320;  %10-second epochs in 12 hours

i=1;
while i<num_steps
	if state(i)=='W'
		x=rand(2,1);
		W_RW = -log(x(1))/ahat_R_W;
		W_SW = -log(x(2))/ahat_S_W;
		Wshortest_epochs = round(min([W_RW W_SW])/10);
		if W_RW < W_SW
			next_state = 'R';
		else
			next_state = 'S';
		end
		state(i+1:i+Wshortest_epochs)='W';
		state(i+Wshortest_epochs+1)=next_state;  % after the run of W is finished set the next state depending on which W was shortest
	
	elseif state(i)=='S'
		x=rand(2,1);
		W_RS = -log(x(1))/ahat_R_S;
		W_WS = -log(x(2))/ahat_W_S;
		Wshortest_epochs = round(min([W_RS W_WS])/10);
		if W_RS < W_WS
			next_state = 'R';
		else
			next_state = 'W';
		end
		state(i+1:i+Wshortest_epochs)='S';
		state(i+Wshortest_epochs+1)=next_state;  % aft
	
	elseif state(i)=='R'
		x=rand(2,1);
		W_WR = -log(x(1))/ahat_W_R;
		W_SR = -log(x(2))/ahat_S_R;
		Wshortest_epochs = round(min([W_WR W_SR])/10);
		if W_WR < W_SR
			next_state = 'W';
		else
			next_state = 'S';
		end
		state(i+1:i+Wshortest_epochs)='R';
		state(i+Wshortest_epochs+1)=next_state;  %
	end
	i=i+Wshortest_epochs+1;
end

wake_percentage = length(find(state=='W'))/length(state)
SWS_percentage  = length(find(state=='S'))/length(state)
REM_percentage  = length(find(state=='R'))/length(state)




runs = contiguous(state,['W' 'S' 'R']);

wake_runs  = runs{1,2};
sleep_runs = runs{2,2};
REM_runs   = runs{3,2};

disp(['Number of wake episodes: ', num2str(size(wake_runs,1))])

for i=1:size(wake_runs,1)
    w_episode_length(i) = wake_runs(i,2)-wake_runs(i,1)+1;
end

for i=1:size(sleep_runs,1)
    s_episode_length(i) = sleep_runs(i,2)-sleep_runs(i,1)+1;
    
end

for i=1:size(REM_runs,1)
	r_episode_length(i) = REM_runs(i,2)-REM_runs(i,1)+1;
end


mean_SWS_length = mean(s_episode_length) * 10
mean_wake_length = mean(w_episode_length) * 10
mean_REM_length = mean(r_episode_length) *10


