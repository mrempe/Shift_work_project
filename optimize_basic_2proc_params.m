% script to optimize the choice of amplitude and spacing for the circadian
% curves in the basic 2-process model to get about 12 hours 
% of "wake" and 12 hours of "sleep"
% I will use this as a starting point to then code in polyphasic sleep so the likelihood of a particular state depends on
% S and C.




[bestparams,best_error] = fminsearch(@(p) two_proc_obj_function(p),[0.15 0.4],optimset('TolX',1e-3));