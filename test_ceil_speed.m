W_RW = 27;
W_SW = 15;

tic
for i=1:1000
	Wshortest_epochs = ceil(min([W_RW W_SW])/10);
end
toc


tic
for i=1:1000
	s = min([W_RW, W_SW]);
	Wshortest_epochs = ceil(s/10);
end
toc
