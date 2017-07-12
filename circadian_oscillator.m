function dydt = circadian_oscillator(t,y,I,sleep_state)
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
% I converted all of these parameters to hours, not seconds
% --- OLD (WORKS) ---
% p 		= 0.5;
% I0 		= 9500;
% I1 		= 100;
% alpha0 	= 0.1/60;
% beta 	= 0.007/60;
% rho 	= 0; %0.032;
% Omega 	= 2*pi/(24*3600);  % Hz
% k 		= 0.55;
% q 		= 1/3;
% gamma 	= 0.13;
% G 		= 37;
% delta 	= (24*3600)/(0.99729);
% tauc 	= 24.2*3600;
% epsilon = 0.4;

% --- NEW (in units of seconds, but fixing the typo in Postnova et al 2012---
% p 		= 0.5;
% I0 		= 9500;
% I1 		= 100;
% alpha0 	= 0.1; 		
% beta 	= 0.007;
% rho 	= 0.032;
% Omega 	= 2*pi/(24*3600);  	
% k 		= 0.55;
% q 		= 1/3;
% gamma 	= 0.13;
% G 		= 37;
% delta 	= (24*3600)/(0.99729); 
% tauc 	= 24.2*3600;   			
% epsilon = 0.4;

% % --- with fixed typo and in minutes? hours, not seconds
p 		= 0.5;
I0 		= 9500;
I1 		= 100;
alpha0 	= 0.1;%0.1*60; 		% 1/hr
beta 	= 0.007; %0.007*60;
rho 	= 0.032;
Omega 	= 2*pi/(24)/60;  	% 1/hr
k 		= 0.55;
q 		= 1/3;
gamma 	= 0.13;
G 		= 37; %37/60/60;
delta 	= (24)/(0.99729); 	% hr
tauc 	= 24.2;   			% hr
epsilon = 0.4;%0.4/60/60;

%I = interp1(It,I,t);
alpha = alpha0*((I/I0)^p)*(I/(I+I1));


%dydt(3) = (alpha0*((I/I0)^p)*(I/(I+I1)))*(1-y(3))-beta*y(3);
dydt(3) = 60*(alpha*(1-y(3))-beta*y(3));  % this is n, the photoreceptors
B = @(a,m,xb,xbc) (G*a*(1-m)*(1-epsilon*xb)*(1-epsilon*xbc));
Ns = @(sl_st,xn) (rho*(1/3-sl_st)*(1-tanh(10*xn)));
dydt(2) = Omega*( q*B(alpha,y(3),y(1),y(2))*y(2)-y(1)*((delta/tauc)^2+k*B(alpha,y(3),y(1),y(2))) );
dydt(1) = Omega*( y(2)+gamma*((1/3)*y(1)+(4/3)*(y(1))^3-(256/105)*(y(1))^7) + B(alpha,y(3),y(1),y(2)) +Ns(sleep_state,y(1)));
%B(y(3),y(1),y(2))
% disp(['n=', num2str(y(3))])
%pause
% dydt(2) = Omega*( q*(G*alpha*(1-y(3))*(1-epsilon*y(1))*(1-epsilon*y(2)))*y(2)- ... 
% 		y(1)*((delta/tauc)^2+k*(G*alpha*(1-y(3))*(1-epsilon*y(1))*(1-epsilon*y(2))) ) );
% dydt(1) = Omega*( y(2)+gamma*((1/3)*y(1)+(4/3)*(y(1))^3-(256/105)*(y(1))^7) +(G*alpha*(1-y(3))*(1-epsilon*y(1))*(1-epsilon*y(2))) );


%dydt(1) = (pi/12)*( y(2) + B(y(3),y(1),y(2)) );
%dydt(2) = (pi/12)*(gamma*(y(2)-((4*y(2)^3)/3) ) - y(1)*(24/(0.99669*24.2))^2);


