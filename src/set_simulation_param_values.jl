function set_simulation_param_values(K_optimized_for_AW, K_optimized_for_RW)
    
    # Initialize structs for the parameters
    input_paramsAW = Dict{Symbol, Float64}()
    input_paramsRW = Dict{Symbol, Float64}()
    
    # Set AW parameters
    input_paramsAW[:taui_baseline] = 17.159
    input_paramsAW[:taud_baseline] = 2.18
    input_paramsAW[:taui_work] = K_optimized_for_AW["values"][1]
    input_paramsAW[:taud_work] = K_optimized_for_AW["values"][2]
    
    input_paramsAW[:alertness_duration_scale_factor_B] = 0.6
    input_paramsAW[:sleepiness_duration_scale_factor_SWS_B] = 1.133
    input_paramsAW[:sleepiness_duration_scale_factor_REMS_B] = 1.1
    input_paramsAW[:alertness_duration_scale_factor_W] = 0.7
    input_paramsAW[:sleepiness_duration_scale_factor_SWS_W]  = K_optimized_for_AW["values"][4]
    input_paramsAW[:sleepiness_duration_scale_factor_REMS_W] = K_optimized_for_AW["values"][5]
    
    # Set RW parameters
    input_paramsRW[:taui_baseline] = 17.159
    input_paramsRW[:taud_baseline] = 2.18
    input_paramsRW[:taui_work] = K_optimized_for_RW["values"][1]
    input_paramsRW[:taud_work] = K_optimized_for_RW["values"][2]
    
    input_paramsRW[:alertness_duration_scale_factor_B] = 0.6
    input_paramsRW[:sleepiness_duration_scale_factor_SWS_B] = 1.133
    input_paramsRW[:sleepiness_duration_scale_factor_REMS_B] = 1.1
    input_paramsRW[:alertness_duration_scale_factor_W] = 0.7
    input_paramsRW[:sleepiness_duration_scale_factor_SWS_W] = K_optimized_for_AW["values"][4]
    input_paramsRW[:sleepiness_duration_scale_factor_REMS_W] = K_optimized_for_AW["values"][5]
    
    return input_paramsAW, input_paramsRW
end
