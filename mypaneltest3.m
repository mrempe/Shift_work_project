figure
clear p
p=panel()
p.pack('v',{0.6 0.4})
%p.pack(2,1);
p(1).pack({1/3 2/3})
p(2).pack(2,1)


%%p.pack(2,1);
%p(1,1).pack(2,1);
%%p(1).pack({1/3 2/3});
%%p(1,1).pack(2,1);
%%p(2,1).pack(2,1);
p_11 = p(1,1);
p_21 = p(2,1);
p.fa.margin = 12;
p(2).margintop = 15;
p.fa.marginleft = 28;
p.fa.marginright = 15; 