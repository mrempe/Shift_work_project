function y = multiobjective(params)

y=zeros(2,1);

[y(1),y(2)]= compute_all_errors(params);