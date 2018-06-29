% test REM Runs

for j=1:num_simulations
	baseline_runs = contiguous(sleepstateAW(1:8641,j),['W' 'S' 'R']);
	B_rems_runs{j}  = baseline_runs{3,2};
	for i=1:size(B_rems_runs{j},1)
		B_r_episode_length{j}(i) = B_rems_runs{j}(i,2)-B_rems_runs{j}(i,1)+1;
	end
	B_mean_REM_length(j)  = mean(B_r_episode_length{j}) * 10; 
end


for j=1:num_simulations
	[b,n]=RunLength(sleepstateAW(1:8641,j));
	R_locs = find(b=='R');
	B_mean_REM_length2(j) = mean(n(R_locs)) * 10;
end

