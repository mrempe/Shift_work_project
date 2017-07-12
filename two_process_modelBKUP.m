function S=two_process_model(total_time,taui,taud,circ_amp,circ_dist)
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
% good starting values: two_process_model(48,18.2,4.2,0.1,0.1)  (rodent sleep)
% or                    two_process_model(48,18.2,4.2,0.2,0.3)  (human sleep)
% 
% I am nondimensionalizing S, so U=1 and L=0.  S remains between 0 and 1. 
%

% set up a time vector (with increments of 2 seconds)
t=0:2/60/60:total_time;
dt=2/60/60;
length(t)


% set up the circadian curves
% include a negative sign for all the tc terms if you want a right-skewed sine curve (like Achermann)
% remove the negative sign if you want a left-skewed sine curve (like Daan et al and our J Math Bio paper)
circshift = 2.5;   % If you want to shift the circadian curve by some time (in hours)
tc=t+circshift-2.5;
xc=(0.97*sin((pi/12)*-tc)+0.22*sin(2*(pi/12)*-tc)+0.07*sin(3*(pi/12)*-tc)+0.03*sin(4*(pi/12)*-tc)+0.001*sin(5*(pi/12)*-tc));

circ_curve = circ_amp*xc;

lower_circ_curve = circ_curve + circ_amp;   % add the amplitude so you don't get anything negative
upper_circ_curve = lower_circ_curve + circ_dist;

% Homeostat
S(1) = upper_circ_curve(1);
sleep_state = -1;   % sleep state = 1 for wake, -1 for sleep

justswitched = 1;  % this is a variable keeps track of the epochs at which the state changes

for i=1:length(t)-1
	if sleep_state == 1
		S(i+1) = 1-(1-S(i))*exp(-dt/taui);
	elseif sleep_state == -1
		S(i+1) = S(i)*exp(-dt/taud);
	end

	% if S reaches a C curve, change sleep state
	%if abs(S(i+1)-upper_circ_curve(i+1))<0.001 | abs(S(i+1)-lower_circ_curve(i+1))<0.001
	if (S(i+1) <= lower_circ_curve(i+1) | S(i+1) >= upper_circ_curve(i+1)) & justswitched ~= i
		sleep_state = -1*sleep_state;
		justswitched = i+1;
	end
end


figure
plot(t,lower_circ_curve,'k--',t,upper_circ_curve,'k--')
hold on 
plot(t,S,'LineWidth',2)
hold off




