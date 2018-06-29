FigHandle = figure;
set(FigHandle,'Position',[300 230 1094 700]);
p=panel();
p.pack(2,1);
%p(1,1).pack(2,1);
p(1,1).pack({1/2 1/2},{4/5 1/5});
p(2,1).pack(2,1);
p_11 = p(1,1);
p_21 = p(2,1);
p.fa.margin = 3;
p(2).margintop = 30;
p.margin = [25 20 5 5];

p.select('all');
p.identify();