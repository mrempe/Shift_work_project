function [input_paramsAW,input_paramsRW] = set_simulation_param_values(K_optimized_for_AW_during_work_1_5,K_optimized_for_RW_during_work_1_5)


input_paramsAW.taui_baseline  = 17.159;
input_paramsAW.taud_baseline  = 2.18 ; 
input_paramsAW.taui_work = K_optimized_for_AW_during_work_1_5.values(1);
input_paramsAW.taud_work = K_optimized_for_AW_during_work_1_5.values(2);

input_paramsAW.alertness_duration_scale_factor_B       = 0.6;  
input_paramsAW.sleepiness_duration_scale_factor_SWS_B  = 1.133; 
input_paramsAW.sleepiness_duration_scale_factor_REMS_B = 1.1;  
input_paramsAW.alertness_duration_scale_factor_W       = 0.7; 
input_paramsAW.sleepiness_duration_scale_factor_SWS_W  = K_optimized_for_AW_during_work_1_5.values(4);  
input_paramsAW.sleepiness_duration_scale_factor_REMS_W = K_optimized_for_AW_during_work_1_5.values(5);  

input_paramsRW.taui_baseline = 17.159; 
input_paramsRW.taud_baseline = 2.18; 
input_paramsRW.taui_work = K_optimized_for_RW_during_work_1_5.values(1);
input_paramsRW.taud_work = K_optimized_for_RW_during_work_1_5.values(2);

input_paramsRW.alertness_duration_scale_factor_B       = 0.6;  
input_paramsRW.sleepiness_duration_scale_factor_SWS_B  = 1.133;  
input_paramsRW.sleepiness_duration_scale_factor_REMS_B = 1.1;  
input_paramsRW.alertness_duration_scale_factor_W       = 0.7;  
input_paramsRW.sleepiness_duration_scale_factor_SWS_W  = K_optimized_for_AW_during_work_1_5.values(4);  
input_paramsRW.sleepiness_duration_scale_factor_REMS_W = K_optimized_for_AW_during_work_1_5.values(5);  
