% testing script for circadian oscillator

 %t=0:2/60/60:24;
 %dt=2/60/60;
  % t=0:2:86400;  % in seconds, not hours
  % dt=2; 			% in seconds, not hours
  t=0:1/30:5760;  % in minutes
  dt=1/30;


I =  zeros(size(t));    % whatever you want the light profile to look like 
I(1800:2425)=200;
I(3200:3850)=200;
%I(:) = 200;
   %I(1:end/4) =200;
   %I(end/4:end/2)=200;
 % I(end/2:3*end/4)=0;
 % I(3*end/4:end)=0;
%I=800;

 % I(1:14401) = 0;
 % I(14402:43201) = 200;
 % I(43202:57601) = 0;
 % I(57602:86401) = 200;

sleep_state = zeros(size(t));
%sleep_state(end/2:end)=1;  
%sleep_state(1:14401) = 1;
%sleep_state(14402:43201) = 0;
% sleep_state(43202:57601) = 0;
% sleep_state(57602:86401) = 1;
 
 ycirc=[-0.3 -1.13 0.5]';
 C(1) = (1+0)/2;

% for i=1:length(t)-1
% 	[tcirc,ycirc] = ode45(@(t,ycirc) circadian_oscillator(t,ycirc,I(i),sleep_state(i)),[t(i) t(i+1)],[ycirc(end,1) ycirc(end,2) ycirc(end,3)]);
% 	C(i+1) = (1+ycirc(end,1))/2;
% end
% [tcirc,ycirc] = ode45(@(t,ycirc) circadian_oscillator(t,ycirc,I,sleep_state(i)),[0 86400],[-0.3 -1.13 0.5]);
% figure
% plot(tcirc,ycirc(:,1))




% --- Try again, using my home-cooked RK4 update step ----
for i=1:length(t)-1
	k1 = circadian_oscillator(t(i),ycirc(:,i),I(i),sleep_state(i));
	k2 = circadian_oscillator(t(i)+dt/2,ycirc(:,i)+0.5*dt*k1,I(i),sleep_state(i));
	k3 = circadian_oscillator(t(i)+dt/2,ycirc(:,i)+0.5*dt*k2,I(i),sleep_state(i));
	k4 = circadian_oscillator(t(i)+dt,ycirc(:,i)+dt*k3,I(i),sleep_state(i));
	ycirc(:,i+1) = ycirc(:,i) + (dt/6)*(k1+2*k2+2*k3+k4);
end

figure
plot(t,ycirc(1,:))

