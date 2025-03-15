
D=2;

tic
for i=1:10000
	x=rand(2,1);
	W_RW = x(1)^(-D)/3;
	W_SW = x(2)^(-D)/4;
end
toc

tic
for i=1:10000
	W_RW = rand^(-D)/3;
	W_SW = rand^(-D)/4;
end
toc


tic
x=rand(2,10000);
for i=1:10000
	W_RW = x(1,i)^(-D)/3;
	W_SW = x(2,i)^(-D)/4;
end
toc

