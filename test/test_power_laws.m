clear b c D f r1 output Xbins 


%lower limit (for main sampler)
b = 1;

c=0.9997222222;

%D = 1/12.8;
D=1/1.3;   % 1/1.3 since -1-1/D=-2.3, the value shown in Lo PNAS 2004
%D=1/2;

f=60;
f=1.548342698988603;  % 11.16.17 found from setting total integral of 
G = 1/2;  % 1/2 since -1-1/G=-1, a shallow slope to sort of match data in Lo PNAS 2004 figure 2 for t values 10^1 and larger


r1 = rand(1e7,1);
%output = b.*r1.^(-D);

for i=1:length(r1)
	%r1=rand;
	%if r1(i)<c
		output(i) = b*r1(i)^(-D);
	%else
	%	output(i) = f*r1(i)^(-G);
	%end
end


figure
Xbins = 1:600;
[N,X]=hist(output,Xbins);
loglog(X./6,N./sum(N))
xlabel('Duration t (min)')
grid on 



