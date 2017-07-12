% script to test the basic Markov Chain model that I came up with

p1=0.028673;  % SWS -> Wake

p2=0.096756;

p3=1-(p8+p6); %0.050049;
p4=1-(p7+p2);   %0.0049155;

p5=1-(p9+p1);%0.020594;

p6=0.039685;

p7=0.8976;

p8=0.90814;
p9=0.94631;



state(1) = 'S';

num_steps = 4320;  %10-second epochs in 12 hours

for i=1:num_steps
	if state(i)=='W'
		r=rand;
		if r<p7
			state(i+1) = 'W';
		elseif r>=p7 & r<p7+p2
			state(i+1) = 'S';
		elseif r>=p7+p2 
			state(i+1) = 'R';
		end
	elseif state(i)=='S'
		r=rand;
		if r<p9
			state(i+1) = 'S';
		elseif r>=p9 & r<p9+p1
			state(i+1) = 'W';
		elseif r>=p9+p1
			state(i+1) = 'R';
		end
	elseif state(i)=='R'
		r=rand;
		if r<p8
			state(i+1) = 'R';
		elseif r>=p8 & r<p8+p6
			state(i+1) = 'S';
		elseif r>=p8+p6
			state(i+1) = 'W';
		end
	end
end

wake_percentage = length(find(state=='W'))/length(state)
SWS_percentage  = length(find(state=='S'))/length(state)
REM_percentage  = length(find(state=='R'))/length(state)




runs = contiguous(state,['W' 'S' 'R']);

wake_runs  = runs{1,2};
sleep_runs = runs{2,2};
REM_runs   = runs{3,2};

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


