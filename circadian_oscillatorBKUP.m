function dydt = circadian_oscillator(t,y,It,I,sleep_state)
	% USAGE: dydt = circadian_oscillator(t,y,It,I,sleep_state)
	% 
	% This function defines the ODEs for the St. Hilaire et al 2007 model of the circadian pacemaker
	%
	%  Call it in MATLAB like this:
	% It = linspace(0,total_time,total_time*60*60/2);  % time vector for I, the light profile in lux
	% I =  zeros(size(It))    % whatever you want the light profile to look like ( vector that is same length It)
	% I(1:end/2) = 0;
	% I(end/2:end) = 200;
	% ycircic = [0 0.5 0.5]      % initial conditions??
	% [tcirc(i+1),ycirc()] = ode45(@(t,y),circadian_oscillator(t,y,It,I,sleep_state(i)),[t(i) t(i+1)],y(:,end));

dydt = zeros(3,1);   % the three dependent variables are x, xc and n

% y(1) is x  (in the St. Hilaire et al. model)
% y(2) is xc (in the St. Hilaire et al. model)
% y(3) is n  (in the St. Hilaire et al. model)


% it would be better to read these in
p 		= 0.5;
I0 		= 9500;
I1 		= 100;
alpha0 	= 0.1/60;
beta 	= 0.007/60;
rho 	= 0.032;
Omega 	= 2*pi/(24*3600);  % Hz
k 		= 0.55;
q 		= 1/3;
gamma 	= 0.13;
G 		= 37;
delta 	= (24*3600)/(0.99729);
tauc 	= 24.2*3600;
epsilon = 0.4;

I = interp1(It,I,t);
alpha = alpha0*(I/I0)^p*(I/(I+I1));

dydt(3) = alpha*(1-y(3))-beta*y(3);  % this is n, the photoreceptors
B = G*alpha*(1-y(3))*(1-epsilon*y(1))*(1-epsilon*y(2));
Ns = rho*(1/3-sleep_state)*(1-tanh(10*y(1)));
dydt(2) = Omega*( q*B*y(2) -y(1)*((delta/tauc)^2+k*B) );
dydt(1) = Omega*( y(2)+gamma*((1/3)*y(1)+(4/3)*(y(1))^3-(256/105)*(y(1))^7) + B +Ns);



