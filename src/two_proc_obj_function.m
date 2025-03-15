function errorout = two_proc_obj_function(p)

% p(1) is circadian amplitude
% p(2) is distance between circadian curves

[S,Polyphasic_Sleep_State,sleep_percentage,length_sleep,length_wake]=two_process_model(120,8.6,3.2,p(1),p(2));

errorout = norm(abs([length_sleep length_wake]-[12 12]));
