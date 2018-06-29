FigHandle = figure;
set(FigHandle,'Position',[300 230 1094 700]);
p=panel();
p.pack(2,1);
p(1,1).pack(2,1);
p(2,1).pack(2,1);
p_11 = p(1,1);
p_21 = p(2,1);
p.de.margin = 5;

p(2).marginbottom = 20;

p.select('all');



%% (d)

% whilst we're here, we can get all the axes within a
% particular panel like this. there are three "groups"
% associated with a panel: (fa)mily, (de)scendants, and
% (ch)ildren. see "help panel/descendants", for instance, to
% see who's in them. they're each useful in different
% circumstances. here, we use (de)scendants.
h_axes = p.de.axis;

% so then we might want to set something on them.
set(h_axes, 'color', [0.5 0.5 0.5]);

p.select('all')
p.identify()