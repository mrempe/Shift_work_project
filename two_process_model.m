function [S,Polyphasic_Sleep_State,sleep_percentage,length_sleep,length_wake]=two_process_model(total_time,taui,taud,circ_amp,circ_dist,sleep_dep_start_stop_times)
%
% USAGE: S=two_process_model(total_time,taui,taud,circ_amp,circ_dist)
%
%
% This function runs the basic two-process model of Borbely and 
% Achermann with the following input parameters:
%
% total_time: 	the total time you wish to run the simulation (in hours)
%
% taui:			the rising time constant (with units of hours)
%
% taud: 		the falling time constant (units of hours)
%
% circ_amp: 	the amplitude of both circadian curves (dimensionless because we normalized the SWA power)
%
% circ_dist: 	the distance between the upper and lower circadian curves
%
% sleep_dep_start_stop_times:  a vector of starting and stopping times for sleep deprivation (due to work in shift workers, etc.)
%								format is like this:	sleep_dep_start
%														sleep_dep_end
%														sleep_dep_start
%														sleep_dep_end
%														    etc.
% The sleep_dep_start_stop_times for the Resting phase (RW) workers looks like this:
%								[26 34 50 58 74 82 98 106]
%
% The sleep_dep_start_stop_times for the Active phase (AW) workers looks like this:
%						[38 46 62 70 86 94 110 118]				
%				
% OUTPUTS:
% S:   The variable representing the homeostat (nondimensionalized)
% 
% Polyphasic_Sleep_State:	-1 (sleep) or 1 (wake) where the state is determined stochastically using sleepiness as the input
%
% sleep_percentage:			the percentage of each 2-hour window that is made up of sleep. 
%
%
% good starting values: two_process_model(48,8,1.8,0.22,0.1)  (rodent sleep,)
% or                    two_process_model(48,18.2,4.2,0.22,0.3)  (human sleep) (or rodent sleep if you turn on polyphasic and shift work polyphasic)
% 						two_process_model(120,8.6,3.2,xx,xx) (rat sleep, taui and taud were found from Franken_Tobler_Borbely_1991)
%optimized values for rat sleep : two_process_model(120,8.6,3.2,0.1288,0.4747) 
% I am nondimensionalizing S, so U=1 and L=0.  S remains between 0 and 1. 
%
%


if nargin == 5
	sleep_dep_start_stop_times = [];
end 


% set up a time vector (with increments of 10 seconds)
t=0:10/60/60:total_time;
dt=10/60/60;



% set up the circadian curves
% include a negative sign for all the tc terms if you want a right-skewed sine curve (like Achermann)
% remove the negative sign if you want a left-skewed sine curve (like Daan et al and our J Math Bio paper)
circshift = 2.5;   % If you want to shift the circadian curve by some time (in hours)
tc=t+circshift-2.5;
xc=(0.97*sin((pi/12)*-tc)+0.22*sin(2*(pi/12)*-tc)+0.07*sin(3*(pi/12)*-tc)+0.03*sin(4*(pi/12)*-tc)+0.001*sin(5*(pi/12)*-tc));

%circ_curve = circ_amp*xc;
circ_curve = circ_amp*sin((pi/12)*-tc);

lower_circ_curve = circ_curve + circ_amp;   % add the amplitude so you don't get anything negative
upper_circ_curve = lower_circ_curve + circ_dist;

% -----  Homeostat --------------
S(1) = upper_circ_curve(1)
sleep_state = zeros(size(t));
sleep_state(1) = 0;   % sleep state = 1 for wake, 0 for sleep

% ------ sleep deprivation, a vector of 0's and 1's. 1 if sleep deprivation is on, 0 if not.  -------  
sleep_dep = zeros(size(t));

% light intensity, for the circadian model
It = linspace(0,total_time,total_time*60*60/2);  % time vector for I, the light profile in lux
I =  zeros(size(It));    % whatever you want the light profile to look like ( vector that is same length It)
I(1:end/2) = 0;
I(end/2:end) = 200;

% --- Initial conditions for the ODEs in the circadian model
n(1)  = 0.5;
xc(1) = 0.5;
x(1)  = 0;
ycirc = [x(1) xc(1) n(1)];
C(1)  = (1+x(1))/2;

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

for i=1:length(t)-1
	
	% Normal state changes due to reaching one of the circadian curves -----------------
	if sleep_state(i) == 1		% wake
		S(i+1) = 1-(1-S(i))*exp(-dt/taui);
		if S(i+1) >= upper_circ_curve(i+1)  % change state if you reach the upper curve
			sleep_state(i+1) = 0;
		else
			sleep_state(i+1) = 1; 			% Set the sleep state even if you don't change states
		end	
	end

	if sleep_state(i) == 0	% Sleep
		S(i+1) = S(i)*exp(-dt/taud);
		if S(i+1) <= lower_circ_curve(i+1)  % change state if you reach the lower curve
			sleep_state(i+1) = 1;
		else
			sleep_state(i+1) = 0;
		end
	end


	% Override the normal state changes if sleep deprivation is turned on
	if sleep_dep(i) == 1
		sleep_state(i+1) = 1;
	end 

 % 	% TESTING: circadian model from St. Hilaire et al.
 % 	[tcirc,ycirc] = ode45(@(t,ycirc) circadian_oscillator(t,ycirc,I(i),sleep_state(i)),[t(i) t(i+1)],[ycirc(end,1) ycirc(end,2) ycirc(end,3)]);
	% C(i+1) = (1+ycirc(end,1))/2;


end


% To get polyphasic sleep out of this model, use a simple model of sleepiness from Achermann 2004
% Sleepiness = S-C + Inertia  (I'm leaving out sleep inertia for now)
% And I'm interpreting sleepiness as a percent chance that the mouse is actually sleeping at time t
% 1 - Polyphasic_Sleep_State_percentage is the percentage of time spent in awake states
% To determine the actual sleep state (stochastically) generate a uniform random variable between 
% 0 and 1 and if it is larger than Polyphasic_Sleep_State_percentage that means that epoch is wake,
% otherwise it is classified as Sleep. 
sleep_state_percentage_scaling = 5/3;
sleep_state_percentage_shift = 0.5;
Polyphasic_Sleep_State_percentage = (sleep_state_percentage_scaling*((S - circ_curve)-mean(S-circ_curve)))+sleep_state_percentage_shift;
wake_locs = rand(size(Polyphasic_Sleep_State_percentage)) > Polyphasic_Sleep_State_percentage;     
% Force the system to be awake during working hours
wake_locs(find(sleep_dep)) = 1;
Polyphasic_Sleep_State=wake_locs;
%Polyphasic_Sleep_State = 2*(wake_locs-0.5);    % this makes it a vector of 1's and -1's.  

% If you don't want polyphasic sleep output from this model (using a stochastic variable), uncomment this line
Polyphasic_Sleep_State = sleep_state;



% Jonathan's random walk idea:  Choose a uniform random variable.  Then randomly walk up or down.  If you are above S-C it is wake, if below, it is sleep
% unit = 0.1;  % the amount you can walk up or down in one time step
% walk(1,1)=rand;
% for j=1:1000
% 	for i=1:length(sleep_state)-1
% 		r=rand;
% 		if r>0.5
% 			walk(j,i+1) = walk(i)+unit;
% 		else
% 			walk(j,i+1) = walk(i)-unit;
% 		end 
% 	end
% end  
% averaged_random_walk = mean(walk,1);
% Polyphasic_Sleep_State_random_walk = averaged_random_walk > Polyphasic_Sleep_State_percentage;  % 0 or 1 for sleep or wake, respectively
% Polyphasic_Sleep_State=Polyphasic_Sleep_State_random_walk;



% --- Check percentages of each state in the light and dark phases ---
twelve_hr_index = find(abs(t-12)<1e-8);
SWS_percent_light	= length(find(sleep_state(1:twelve_hr_index)==0))/twelve_hr_index;
wake_percent_light	= length(find(sleep_state(1:twelve_hr_index)==1))/twelve_hr_index;
SWS_percent_dark	= length(find(sleep_state(twelve_hr_index:end)==0))/twelve_hr_index;
wake_percent_dark	= length(find(sleep_state(twelve_hr_index:end)==1))/twelve_hr_index;


% --- Compute the average SWS episode length ---
[mean_SWS_length,mean_wake_length] = calculate_SWS_episode_length(Polyphasic_Sleep_State,dt);
% -------------------------------------------------------------------
length_sleep = mean_SWS_length;
length_wake  = mean_wake_length;
mean_SWS_length_in_seconds = mean_SWS_length*60*60;



figure
plot(t,lower_circ_curve,'k--',t,upper_circ_curve,'k--')
hold on 
plot(t,S,'LineWidth',2)
yl=ylim;

if ~isempty(sleep_dep_start_stop_times)
	gray = [0.8 0.8 0.8];
	for i=1:length(sleep_dep_start_times)
		p = patch([sleep_dep_start_times(i) sleep_dep_end_times(i) sleep_dep_end_times(i) sleep_dep_start_times(i)],[yl(1) yl(1) yl(2) yl(2)],gray);
		p.EdgeColor='none';
		p.FaceAlpha = 0.5;
	end 
end
%set(gca,'XTick',0:24:t(end)); 
hold off


% Figure showing percentages in each state 
% (maybe add this as a panel to the previous figure?)
figure

window_length_in_hours = 2;  % Janne uses 2 hour windows in the figure in the paper

window_length_in_elements = find(abs(t-window_length_in_hours)<1e-15)
window_times = t(ceil(window_length_in_elements/2)):window_length_in_hours:t(end-ceil(window_length_in_elements/2));
size(window_times)

index = 1;
for i=1:window_length_in_elements:length(t)-window_length_in_elements
	window_indices = i:i+window_length_in_elements -1;
	wake_percentage(index)	=	length(find(Polyphasic_Sleep_State(window_indices)==1))/window_length_in_elements;
	index = index+1;
end 

sleep_percentage = 1 - wake_percentage;

size(window_times)
size(sleep_percentage)
plot(window_times,sleep_percentage)
yl=ylim;
pbaspect([1.0000    0.4625    0.4625])
hold on 
h1 = fill(window_times([1 1:end end]),[0 sleep_percentage 0],'b','EdgeColor','none');
h2 = fill(window_times([1 1:end end]),[1 sleep_percentage 1],'g','EdgeColor','none');
% set(h1,'FaceAlpha',0.5)
% set(h2,'FaceAlpha',0.5)
if ~isempty(sleep_dep_start_stop_times)
	gray = [0.8 0.8 0.8];
	for i=1:length(sleep_dep_start_times)
		p = patch([sleep_dep_start_times(i) sleep_dep_end_times(i) sleep_dep_end_times(i) sleep_dep_start_times(i)],[0 0 1 1],gray);
		p.EdgeColor='none';
		p.FaceAlpha = 0.6;
	end 
end 
hold off 
set(gca,'XTick',0:24:t(end));	% set major tick marks at 24 hour intervals
set(gca,'YTick',0:0.2:1);
ha=gca;
ha.XAxis.MinorTick = 'on';
ha.XAxis.MinorTickValues = ha.XAxis.Limits(1):8:ha.XAxis.Limits(2);  % set minor tick marks at 8 hour intervals
set(gca,'box','off')


figure
plot(t,S-circ_curve,'LineWidth',2)